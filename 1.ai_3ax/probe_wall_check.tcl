##############################################################################
#  probe_wall_check.tcl
#  Handler for UDE "probe_wall_check" (see probe_wall_check.cdl)
#  Fanuc 0i-MF Plus + Hexagon probe macros O9101 / O9102 / O9103.
#
#  Output example (Y-, P1=(-97,80), P2=(97,80), Zt=15, Zs=50, T20, G54):
#    G90 G40 G80 G17
#    G00 G90 G53 Z0.
#    T20 M06
#    G00 G90 G54 X-97. Y80.
#    G43 H20 Z50.
#    G65 P9101 A1.
#    #190=#0
#    #191=#0
#    #192=#0
#    G65 P9102 Z15.
#    G65 P9103 A91. Y-20.
#    #190=#102 (Y1)
#    G65 P9102 Z50.
#    G65 P9102 X97. Y80.
#    G65 P9102 Z15.
#    G65 P9103 A91. Y-20.
#    #191=#102 (Y2)
#    G65 P9102 Z50.
#    G65 P9101 A0.
#    #192=ABS[#191-#190]
#    G00 G90 G53 Z0.
#    #3006=-1 (Y1=&#190& Y2=&#191& RAZN=&#192&)
#    IF[#192GT0.1]THEN#3000=99(STENKA RAZNICA BOLSHE 0.1)
#
#  Optional "Feed override" (TOGGLE): On -> "#170=<feed>. (PODACHA PODVODA)"
#  after the first line and " F#170" on every G65 P9102 (single touch P9103 never has F); Off -> as above.
#
#  Never X/Y and Z in one block. After the event the next operation gets
#  full G90 + X/Y/Z, and if no tool change follows (same tool as before the
#  probe) the tool change is forced so the probe never stays in the spindle.
#
#  Rules: touch result X->#101, Y->#102 (Z->#103 not used here);
#         free vars #152..#199 only; no GOTO; no M60.
#
#  Hook: source this file from the post's main .tcl (or a PB custom command
#        executed in Start of Program), see README_RU.txt.
#
#  Created 2026-10-31 for Max Alen (WhiteM93).
##############################################################################

# --- Settings (can be overridden in the post before/after sourcing) ---------
# Point coordinate handling:
#   AS_IS      - use UDE point values as delivered by NX (assumed MCS).
#   ABS_TO_MCS - transform from absolute (ACS) to MCS using mom_csys_matrix
#                (use only if the test output shows ABS coordinates).
if { ![info exists ::pwc_point_mode] } { set ::pwc_point_mode "AS_IS" }
# 1 = print found UDE point variables to the NX listing window (debug)
if { ![info exists ::pwc_debug] }      { set ::pwc_debug 0 }
# How the "&#nnn&" text of the #3006 message is written.
# Verified 31.10.2026 with a real headless NX2506 postprocess: MOM writes
# "&#190&" to the .ptp file unchanged. The "3/4" sign seen in NX is only the
# NX Information window rendering "&#190" as an HTML entity - the file on
# disk is correct (check it in Notepad).
#   LITERAL - unchanged text via MOM_output_literal               [default]
#   TEXT    - unchanged text via MOM_output_text (same result in the file)
#   AMP38   - "&#" written as "&#38#"   (NOT for the machine: file gets &#38#)
#   AMPENT  - "&#" written as "&amp;#"  (NOT for the machine: file gets &amp;#)
if { ![info exists ::pwc_amp_mode] }   { set ::pwc_amp_mode "LITERAL" }
# 1 = force a tool change on the next motion if no tool change came after
#     the probe event (probe must never stay in the spindle)
if { ![info exists ::pwc_force_tool_back] } { set ::pwc_force_tool_back 1 }


#-----------------------------------------------------------------------------
# Fanuc number format: always decimal point, trailing zeros trimmed.
#   97 -> "97."   -97 -> "-97."   80.5 -> "80.5"   0.1 -> "0.1"   0 -> "0."
#-----------------------------------------------------------------------------
proc PWC_fmt { v {dec 3} } {
   set v [expr {double($v)}]
   set lim [expr {0.5 * pow(10, -$dec)}]
   if { abs($v) < $lim } { set v 0.0 }
   set s [format "%.${dec}f" $v]
   set s [string trimright $s "0"]
   if { [string index $s end] != "." && [string first "." $s] < 0 } {
      append s "."
   }
   return $s
}


#-----------------------------------------------------------------------------
# Error helper: message to listing + abort postprocessing.
#-----------------------------------------------------------------------------
proc PWC_error { msg } {
   set txt "probe_wall_check: $msg"
   catch { MOM_output_to_listing_device $txt }
   MOM_abort $txt
}


#-----------------------------------------------------------------------------
# Read a UDE point parameter robustly.
# NX converts every UDE parameter to a MOM variable mom_<param_name>.
# For TYPE p the exact layout is not documented on this machine, so all
# plausible layouts are tried:
#   mom_<p>(0..2)  |  mom_<p>_pos(0..2)  |  mom_<p>_x/_y/_z  |
#   mom_<p>_point(0..2)  |  mom_<p> as a 3-element list "x y z"
# Returns a list {x y z}.
#-----------------------------------------------------------------------------
proc PWC_get_point { pname } {
   set base "mom_$pname"

   if { $::pwc_debug } {
      foreach g [lsort [info globals "${base}*"]] {
         if { [array exists ::$g] } {
            catch { MOM_output_to_listing_device "PWC debug: $g = [array get ::$g]" }
         } else {
            catch { MOM_output_to_listing_device "PWC debug: $g = [set ::$g]" }
         }
      }
   }

   # array layouts: mom_<p>(0..2), mom_<p>_pos(0..2), ...
   foreach arr [list $base ${base}_pos ${base}_point ${base}_pnt] {
      if { [array exists ::$arr] && [info exists ::${arr}(0)] && [info exists ::${arr}(1)] } {
         set z 0.0
         if { [info exists ::${arr}(2)] } { set z [set ::${arr}(2)] }
         return [list [set ::${arr}(0)] [set ::${arr}(1)] $z]
      }
   }

   # separate scalars: mom_<p>_x / _y / _z
   if { [info exists ::${base}_x] && [info exists ::${base}_y] } {
      set z 0.0
      if { [info exists ::${base}_z] } { set z [set ::${base}_z] }
      return [list [set ::${base}_x] [set ::${base}_y] $z]
   }

   # one scalar with "x y z" or "x,y,z"
   if { [info exists ::$base] && ![array exists ::$base] } {
      set l [regexp -all -inline {[-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?} [set ::$base]]
      if { [llength $l] >= 2 } {
         set z 0.0
         if { [llength $l] >= 3 } { set z [lindex $l 2] }
         return [list [lindex $l 0] [lindex $l 1] $z]
      }
   }

   set found [lsort [info globals "${base}*"]]
   PWC_error "point parameter '$pname' not found (globals: $found). Pick the point in the UDE dialog or set ::pwc_debug 1."
}


#-----------------------------------------------------------------------------
# Optional ABS -> MCS conversion using mom_csys_matrix
# (elements 0..8 = MCS X/Y/Z axis vectors in ABS, 9..11 = MCS origin).
#-----------------------------------------------------------------------------
proc PWC_abs_to_mcs { p } {
   if { ![info exists ::mom_csys_matrix(11)] } { return $p }
   upvar #0 mom_csys_matrix m
   set dx [expr {[lindex $p 0] - $m(9)}]
   set dy [expr {[lindex $p 1] - $m(10)}]
   set dz [expr {[lindex $p 2] - $m(11)}]
   set x [expr {$dx*$m(0) + $dy*$m(1) + $dz*$m(2)}]
   set y [expr {$dx*$m(3) + $dy*$m(4) + $dz*$m(5)}]
   set z [expr {$dx*$m(6) + $dy*$m(7) + $dz*$m(8)}]
   return [list $x $y $z]
}


#-----------------------------------------------------------------------------
# Read a numeric UDE parameter with default.
#-----------------------------------------------------------------------------
proc PWC_num { pname def } {
   upvar #0 mom_$pname v
   if { ![info exists v] || [string trim $v] == "" } { return $def }
   if { ![string is double -strict [string trim $v]] } {
      PWC_error "parameter '$pname' is not a number: '$v'"
   }
   return [string trim $v]
}

proc PWC_var { pname def } {
   set n [PWC_num $pname $def]
   if { ![string is integer -strict $n] } {
      if { [expr {$n == int($n)}] } { set n [expr {int($n)}] } else {
         PWC_error "variable number '$pname' must be integer: $n"
      }
   }
   # Free common variables on this machine: #152..#199 only
   # (#31-#33 and everything outside 152..199 are forbidden)
   if { $n < 152 || $n > 199 } {
      PWC_error "variable #$n ($pname) out of allowed range #152-#199"
   }
   return $n
}


#-----------------------------------------------------------------------------
# Optional feed (UDE param with TOGGLE Off/On, label "Feed override").
# Verified in real NX2506 postprocess (UDE on an operation, 31.10.2026):
#   toggle On : mom_<param>=<value>  and  mom_<param>_defined=1
#   toggle Off: mom_<param> is NOT sent, only mom_<param>_defined=0
# Both signs are checked (plus a _toggle variable, just in case). "" = off.
# The variable is unset after each event (see PWC_forget) so a value from an
# earlier event can never switch the feed on.
#-----------------------------------------------------------------------------
proc PWC_opt_feed { pname errproc } {
   upvar #0 mom_$pname v mom_${pname}_toggle tg mom_${pname}_defined df
   if { [info exists df] && [string trim $df] == "0" } { return "" }
   if { [info exists tg] && [regexp -nocase {^(off|0|no|false)$} [string trim $tg]] } { return "" }
   if { ![info exists v] || [string trim $v] == "" } { return "" }
   set f [string trim $v]
   if { ![string is double -strict $f] } { {*}$errproc "feed is not a number: '$f'" }
   if { $f <= 0.0 } { {*}$errproc "feed must be > 0 (got $f)" }
   return $f
}

proc PWC_forget { pattern } {
   foreach g [info globals $pattern] { catch { unset ::$g } }
}


#-----------------------------------------------------------------------------
# Output a line that contains "&#nnn" according to ::pwc_amp_mode.
#-----------------------------------------------------------------------------
proc PWC_out_amp { line } {
   switch -exact -- [string toupper $::pwc_amp_mode] {
      "TEXT"    { MOM_output_text $line }
      "AMPENT"  { MOM_output_literal [string map {"&#" "&amp;#"} $line] }
      "AMP38"   { MOM_output_literal [string map {"&#" "&#38#"} $line] }
      default   { MOM_output_literal $line }
   }
}


#-----------------------------------------------------------------------------
# Work offset text: G54..G59 or G54.1 Pn
#-----------------------------------------------------------------------------
proc PWC_wcs { } {
   set w "G54"
   if { [info exists ::mom_pwc_wcs] && [string trim $::mom_pwc_wcs] != "" } {
      set w [string toupper [string trim $::mom_pwc_wcs]]
   }
   switch -exact -- $w {
      "G54" - "G55" - "G56" - "G57" - "G58" - "G59" { return $w }
      "G54.1" {
         set p [PWC_num pwc_wcs_p 1]
         if { ![string is integer -strict $p] } {
            if { $p == int($p) } { set p [expr {int($p)}] } else { PWC_error "G54.1 P must be integer: $p" }
         }
         if { $p < 1 || $p > 300 } { PWC_error "G54.1 P$p out of range 1-300" }
         return "G54.1 P$p"
      }
      default { PWC_error "unknown work offset '$w' (G54..G59, G54.1)" }
   }
}


#-----------------------------------------------------------------------------
# Probe-in-spindle protection.
# MOM_tool_change / MOM_first_tool clear the flag; MOM_initial_move /
# MOM_first_move force the tool change of the current operation if the flag
# is still set (operation uses the same tool as before the probe -> NX does
# not generate a tool change event).
#-----------------------------------------------------------------------------
proc PWC_restore_tool { } {
   if { ![info exists ::pwc_probe_in_spindle] } { return }
   set pt $::pwc_probe_in_spindle
   unset ::pwc_probe_in_spindle
   if { !$::pwc_force_tool_back } { return }
   if { ![info exists ::mom_tool_number] } {
      PWC_error "probe T$pt is in the spindle and the next tool is unknown"
   }
   catch { MOM_output_to_listing_device "probe_wall_check: probe T$pt still in spindle - tool change to T$::mom_tool_number forced" }
   MOM_output_literal "G00 G90 G53 Z0."
   catch { MOM_force Once T M H G_adjust }
   MOM_tool_change
   catch { MOM_force Once G_mode G_motion X Y Z G_adjust H }
}

proc PWC_install_wrappers { } {
   if { [llength [info commands PWC_orig_MOM_tool_change]] } { return }
   foreach p {MOM_tool_change MOM_first_tool} {
      if { [llength [info commands $p]] } {
         rename $p PWC_orig_$p
         proc $p { args } "catch { unset ::pwc_probe_in_spindle } ; uplevel 1 \[list PWC_orig_$p\] \$args"
      }
   }
   foreach p {MOM_initial_move MOM_first_move} {
      if { [llength [info commands $p]] } {
         rename $p PWC_orig_$p
         proc $p { args } "PWC_restore_tool ; uplevel 1 \[list PWC_orig_$p\] \$args"
      }
   }
}
PWC_install_wrappers


#=============================================================================
proc MOM_probe_wall_check { } {
#=============================================================================
   global mom_command_status mom_pwc_direction

   if { [info exists mom_command_status] && \
        [string match -nocase "Inactive" $mom_command_status] } {
      PWC_forget "mom_pwc_point*" ; PWC_forget "mom_pwc_feed*"
      return
   }

   # ---- parameters ---------------------------------------------------------
   set p1 [PWC_get_point pwc_point1]
   set p2 [PWC_get_point pwc_point2]
   if { [string match -nocase "ABS_TO_MCS" $::pwc_point_mode] } {
      set p1 [PWC_abs_to_mcs $p1]
      set p2 [PWC_abs_to_mcs $p2]
   }

   set z_touch [PWC_num pwc_z_touch    15.0]
   set z_safe  [PWC_num pwc_z_safe     50.0]
   set dist    [PWC_num pwc_touch_dist 20.0]
   set tol     [PWC_num pwc_tolerance   0.1]
   set v1      [PWC_var pwc_var1  190]
   set v2      [PWC_var pwc_var2  191]
   set vd      [PWC_var pwc_var_diff 192]
   set tool    [PWC_num pwc_tool 20]
   if { ![string is integer -strict $tool] } {
      if { $tool == int($tool) } { set tool [expr {int($tool)}] } else { PWC_error "tool number must be integer: $tool" }
   }
   # own range (the post's mom_sys_tool_number_max is only 10, probe is T20)
   if { $tool < 1 || $tool > 999 } { PWC_error "tool number T$tool out of range 1-999" }
   set wcs [PWC_wcs]
   set feed [PWC_opt_feed pwc_feed PWC_error]

   set dir "Y-"
   if { [info exists mom_pwc_direction] && [string trim $mom_pwc_direction] != "" } {
      set dir [string toupper [string trim $mom_pwc_direction]]
   }

   # ---- validation ---------------------------------------------------------
   if { $v1 == $v2 || $v1 == $vd || $v2 == $vd } {
      PWC_error "variables must be different: #$v1 #$v2 #$vd"
   }
   if { $feed != "" && ($v1 == 170 || $v2 == 170 || $vd == 170) } {
      PWC_error "#170 is used for the feed - choose other result variables"
   }
   if { $dist <= 0.0 } { PWC_error "touch distance must be > 0 (got $dist)" }
   if { $tol  <= 0.0 } { PWC_error "tolerance must be > 0 (got $tol)" }
   if { $z_safe <= $z_touch } {
      PWC_error "Z safe ($z_safe) must be above Z touch ($z_touch)"
   }

   # ---- direction: axis letter, sign, result variable, label ---------------
   switch -exact -- $dir {
      "X+" { set ax X ; set sgn  1.0 ; set res 101 }
      "X-" { set ax X ; set sgn -1.0 ; set res 101 }
      "Y+" { set ax Y ; set sgn  1.0 ; set res 102 }
      "Y-" { set ax Y ; set sgn -1.0 ; set res 102 }
      default { PWC_error "unknown direction '$dir' (allowed X+ X- Y+ Y-)" }
   }
   set touch "${ax}[PWC_fmt [expr {$sgn * $dist}]]"

   set x1 [PWC_fmt [lindex $p1 0]] ; set y1 [PWC_fmt [lindex $p1 1]]
   set x2 [PWC_fmt [lindex $p2 0]] ; set y2 [PWC_fmt [lindex $p2 1]]
   set zs [PWC_fmt $z_safe]
   set zt [PWC_fmt $z_touch]
   set tl [PWC_fmt $tol]
   set L1 "${ax}1"
   set L2 "${ax}2"

   # ---- output -------------------------------------------------------------
   # safe start: absolute, no comp/cycle, XY plane, Z home, probe, P1 at Zsafe
   MOM_output_literal "G90 G40 G80 G17"
   set F ""
   if { $feed != "" } {
      MOM_output_literal "#170=[PWC_fmt $feed] (PODACHA PODVODA)"
      set F " F#170"
   }
   MOM_output_literal "G00 G90 G53 Z0."
   MOM_output_literal "T${tool} M06"
   MOM_output_literal "G00 G90 ${wcs} X${x1} Y${y1}"
   MOM_output_literal "G43 H${tool} Z${zs}"
   set ::pwc_probe_in_spindle $tool

   MOM_output_literal "G65 P9101 A1."
   MOM_output_literal "#${v1}=#0"
   MOM_output_literal "#${v2}=#0"
   MOM_output_literal "#${vd}=#0"

   # point 1 (already at P1 XY, Zsafe)
   MOM_output_literal "G65 P9102 Z${zt}${F}"
   MOM_output_literal "G65 P9103 A91. ${touch}"
   MOM_output_literal "#${v1}=#${res} (${L1})"
   MOM_output_literal "G65 P9102 Z${zs}${F}"

   # point 2 (XY at Zsafe, then Z down - never XY and Z in one block)
   MOM_output_literal "G65 P9102 X${x2} Y${y2}${F}"
   MOM_output_literal "G65 P9102 Z${zt}${F}"
   MOM_output_literal "G65 P9103 A91. ${touch}"
   MOM_output_literal "#${v2}=#${res} (${L2})"
   MOM_output_literal "G65 P9102 Z${zs}${F}"

   MOM_output_literal "G65 P9101 A0."
   MOM_output_literal "#${vd}=ABS\[#${v2}-#${v1}\]"
   MOM_output_literal "G00 G90 G53 Z0."
   PWC_out_amp "#3006=-1 (${L1}=&#${v1}& ${L2}=&#${v2}& RAZN=&#${vd}&)"
   MOM_output_literal "IF\[#${vd}GT${tl}\]THEN#3000=99(STENKA RAZNICA BOLSHE ${tl})"

   # The post still holds G91 / old X Y Z / old H in its modal memory:
   # force full G90 + X Y Z (+ G43 H) on the next motion block.
   catch { MOM_force Once G_mode G_motion X Y Z }
   catch { MOM_force Once G_adjust H }

   # forget picked points so a later event can never reuse stale values
   PWC_forget "mom_pwc_point*"
   PWC_forget "mom_pwc_feed*"
}
