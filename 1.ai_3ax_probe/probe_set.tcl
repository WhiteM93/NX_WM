##############################################################################
#  probe_set.tcl
#  Handlers for UDEs probe_set_z_top / probe_set_boss_center /
#  probe_set_hole_center (see probe_set.cdl).
#  Fanuc 0i-MF Plus + Hexagon probe macros O9101 / O9102 / O9103.
#  Uses the helpers of probe_wall_check.tcl (PWC_fmt, PWC_get_point,
#  PWC_num, PWC_out_amp, probe-in-spindle protection) - loaded below if the
#  post has not loaded it yet.
#
#  Output example, boss: X0 Y0, D50, Zdepth -10, Zsafe 50, Zappr 10,
#  F1000, W1, T20:
#    G90 G40 G80 G17
#    #170=1000. (PODACHA PODVODA)
#    #171=1. (NOL W)
#    G00 G90 G53 Z0.
#    T20 M06
#    G00 G90 G54 X0. Y0.
#    G43 H20 Z50.
#    G65 P9101 A1.
#    G65 P9102 Z10. F#170
#    G65 P9103 D-50. Z-10. W#171 F#170
#    G65 P9102 Z50. F#170
#    G65 P9101 A0.
#    G00 G90 G53 Z0.
#    #3006=-1 (BOBYSHKA X=&#101& Y=&#102& D=&#100&)
#
#  Feed override is optional (TOGGLE, default Off). Off: no #170 line and no
#  F#170 (the macros use their default feed #111). On: as in the example.
#  W (zero number): 1..6 = G54..G59, -n = G54.1 Pn (n 1..300); #171=W.
#  Variables used: #170 (feed), #171 (W) only. Never X/Y and Z in one block.
#  After each event the next operation gets full G90 + X/Y/Z (+G43 H), and
#  the tool change is forced if NX does not generate one.
#
#  Created 2026-10-31 for Max Alen.
##############################################################################

if { ![llength [info commands PWC_fmt]] } {
   source [file join [file dirname [info script]] probe_wall_check.tcl]
}

proc PST_error { ev msg } {
   set txt "$ev: $msg"
   catch { MOM_output_to_listing_device $txt }
   MOM_abort $txt
}

proc PST_int { ev pname def } {
   set n [PWC_num $pname $def]
   if { ![string is integer -strict $n] } {
      if { $n == int($n) } { set n [expr {int($n)}] } else {
         PST_error $ev "parameter '$pname' must be an integer: $n"
      }
   }
   return $n
}

proc PST_inactive { } {
   if { [info exists ::mom_command_status] && \
        [string match -nocase "Inactive" $::mom_command_status] } {
      PWC_forget "mom_pst_point*" ; PWC_forget "mom_pst_feed*"
      return 1
   }
   return 0
}

#-----------------------------------------------------------------------------
# Common parameters -> dict-like array in caller: x y zs za feed w tool wcs
#-----------------------------------------------------------------------------
proc PST_common { ev arrname } {
   upvar 1 $arrname a
   set p [PWC_get_point pst_point]
   if { [string match -nocase "ABS_TO_MCS" $::pwc_point_mode] } { set p [PWC_abs_to_mcs $p] }
   # Z of the picked point is ignored
   set a(x)    [lindex $p 0]
   set a(y)    [lindex $p 1]
   set a(zs)   [PWC_num pst_z_safe  50.0]
   set a(za)   [PWC_num pst_z_appr  10.0]
   set a(feed) [PWC_opt_feed pst_feed [list PST_error $ev]]
   set a(w)    [PST_int $ev pst_w    1]
   set a(tool) [PST_int $ev pst_tool 20]

   if { $a(tool) < 1 || $a(tool) > 999 } { PST_error $ev "tool number T$a(tool) out of range 1-999" }
   if { $a(w) >= 1 && $a(w) <= 6 } {
      set a(wcs) "G5[expr {3 + $a(w)}]"
   } elseif { $a(w) <= -1 && $a(w) >= -300 } {
      set a(wcs) "G54.1 P[expr {-$a(w)}]"
   } else {
      PST_error $ev "zero number W=$a(w) invalid (1..6 = G54..G59, -1..-300 = G54.1 P1..P300)"
   }
   if { $a(zs) <= $a(za) } { PST_error $ev "Z safe ($a(zs)) must be above Z approach ($a(za))" }
}

proc PST_head { arrname } {
   upvar 1 $arrname a
   MOM_output_literal "G90 G40 G80 G17"
   set a(F) ""
   if { $a(feed) != "" } {
      MOM_output_literal "#170=[PWC_fmt $a(feed)] (PODACHA PODVODA)"
      set a(F) " F#170"
   }
   MOM_output_literal "#171=[PWC_fmt $a(w)] (NOL W)"
   MOM_output_literal "G00 G90 G53 Z0."
   MOM_output_literal "T$a(tool) M06"
   MOM_output_literal "G00 G90 $a(wcs) X[PWC_fmt $a(x)] Y[PWC_fmt $a(y)]"
   MOM_output_literal "G43 H$a(tool) Z[PWC_fmt $a(zs)]"
   set ::pwc_probe_in_spindle $a(tool)
   MOM_output_literal "G65 P9101 A1."
   MOM_output_literal "G65 P9102 Z[PWC_fmt $a(za)]$a(F)"
}

proc PST_tail { arrname msg } {
   upvar 1 $arrname a
   MOM_output_literal "G65 P9102 Z[PWC_fmt $a(zs)]$a(F)"
   MOM_output_literal "G65 P9101 A0."
   MOM_output_literal "G00 G90 G53 Z0."
   PWC_out_amp "#3006=-1 ($msg)"
   # post still holds G91 / old X Y Z / old H: force full output next block
   catch { MOM_force Once G_mode G_motion X Y Z }
   catch { MOM_force Once G_adjust H }
   PWC_forget "mom_pst_point*"
   PWC_forget "mom_pst_feed*"
}

#=============================================================================
proc MOM_probe_set_z_top { } {
#=============================================================================
   if { [PST_inactive] } { return }
   set ev probe_set_z_top
   PST_common $ev a
   set zn [PWC_num pst_z_nom 0.0]
   if { $a(za) <= $zn } { PST_error $ev "Z approach ($a(za)) must be above Z nominal ($zn)" }
   PST_head a
   MOM_output_literal "G65 P9103 Z[PWC_fmt $zn] W#171$a(F)"
   PST_tail a "Z NOL ZAPISAN. Z=&#103&"
}

#=============================================================================
proc MOM_probe_set_boss_center { } {
#=============================================================================
   if { [PST_inactive] } { return }
   set ev probe_set_boss_center
   PST_common $ev a
   set d  [PWC_num pst_d 50.0]
   set zd [PWC_num pst_z_depth -10.0]
   if { $d <= 0.0 } { PST_error $ev "diameter D must be > 0 (got $d)" }
   if { $a(za) <= $zd } { PST_error $ev "Z approach ($a(za)) must be above Z depth ($zd)" }
   PST_head a
   MOM_output_literal "G65 P9103 D-[PWC_fmt $d] Z[PWC_fmt $zd] W#171$a(F)"
   PST_tail a "BOBYSHKA X=&#101& Y=&#102& D=&#100&"
}

#=============================================================================
proc MOM_probe_set_hole_center { } {
#=============================================================================
   if { [PST_inactive] } { return }
   set ev probe_set_hole_center
   PST_common $ev a
   set d  [PWC_num pst_d 50.0]
   set zd [PWC_num pst_z_depth -10.0]
   if { $d <= 0.0 } { PST_error $ev "diameter D must be > 0 (got $d)" }
   if { $a(za) <= $zd } { PST_error $ev "Z approach ($a(za)) must be above Z depth ($zd)" }
   PST_head a
   MOM_output_literal "G65 P9102 Z[PWC_fmt $zd]$a(F)"
   MOM_output_literal "G65 P9103 D[PWC_fmt $d] W#171$a(F)"
   PST_tail a "OTVERSTIE X=&#101& Y=&#102& D=&#100&"
}
