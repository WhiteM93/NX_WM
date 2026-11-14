##############################################################################
#  probe_omp.tcl  -  On Machine Probing (NX CAM type "probing") -> Max macros
#  Post: 1.ai_3ax (merged 2026-11-03), Fanuc 0i-MF Plus + Hexagon probe.
#  Loaded by the probing loader at the end of ai_3ax.tcl.
#
#  Macros:  G65 P9101 A1./A0.  probe on/off  (::prb_probe_switch)
#           G65 P9102 X/Y/Z F#170          protected positioning (F#172 in UDE prb_center_axis)
#           G65 P9103 X/Y/Z (no F) or D F#170  measuring touch
#  Results: X->#101 Y->#102 Z->#103 D->#100
#  UDEs (probe_omp.cdl): prb_center_axis (center by 2 points), prb_z_point (Z top touch, 2026-11-14)
#  Own vars: #152-#199 (#190-192 reserved wall check), #170 feed, #171 W, #172 move feed (UDE prb_center_axis).
#  M60 before G65 P9101 A1. / M61 after A0. (G01 without spindle inside O9101,
#  Fanuc alarm 2301), switch ::prb_m60_enable / UDE field prb_ca_m60.
#  Rules: no GOTO, M60/M61 only around probe on/off, never XY and Z in one block, G90 after G91,
#         #3006 text <= 26 chars, offsets via G91 G10 L2/L20 Pn ... G90.
#
#  NX events handled (NX2506 mom_vars_csv "Probing Event"):
#    MOM_probe_change, MOM_probe_on, MOM_probe_off, MOM_probe_protected_move,
#    MOM_probe_single_direction_point, MOM_probe_angled_surface_point,
#    MOM_probe_three_point_bore/boss, MOM_probe_four_point_bore/boss,
#    MOM_calibrate_* (comment only), MOM_probe_multi_stylus_* (comment only)
#  New python OMP cycles (probing_cycles\*.pye, libcams.dll):
#    MOM_omp_cycle_start / MOM_omp_cycle_end  (key=value text, unverified)
#
#  Created 2026-11-02 for Max Alen.  ASCII only.
##############################################################################

#---------------- settings (can be pre-set by another file) ------------------
# DEBUG dump (DBG comments): 1 = on, 0 = off
if {![info exists ::prb_omp_debug]}    {set ::prb_omp_debug 0}
if {![info exists ::prb_probe_switch]} {set ::prb_probe_switch 1}
# M60 before probe on, M61 after probe off (alarm 2301: G01 with spindle
# stopped inside O9101). 1 = output, 0 = never. UDE prb_center_axis overrides.
if {![info exists ::prb_m60_enable]}   {set ::prb_m60_enable 1}
# per-operation override of prb_probe_switch from UDE ("" = none, 0/1);
# reset at start_of_path and after probe-off at end_of_path
set ::prb_sw_override "" ; set ::prb_wcs_override ""
proc PRB_sw { } {
   if {$::prb_sw_override ne ""} {return $::prb_sw_override}
   return $::prb_probe_switch
}
# per-operation override of prb_m60_enable from UDE ("" = none, 0/1);
# ::prb_m60_state 1 = M60 output, M61 still pending
set ::prb_m60_override "" ; set ::prb_m60_state 0
proc PRB_m60_en { } {
   if {$::prb_m60_override ne ""} {return $::prb_m60_override}
   return $::prb_m60_enable
}
proc PRB_m60 { } {
   if {[PRB_m60_en] && !$::prb_m60_state} { PRB_out "M60" ; set ::prb_m60_state 1 }
}
proc PRB_m61 { } {
   if {$::prb_m60_state} { PRB_out "M61" ; set ::prb_m60_state 0 }
}
if {![info exists ::prb_tool]}         {set ::prb_tool 20}
if {![info exists ::prb_h]}            {set ::prb_h 20}
if {![info exists ::prb_ball_r]}       {set ::prb_ball_r 3.0}
if {![info exists ::prb_feed]}         {set ::prb_feed 1000.0}
# side touch Z: 1 = NX point is contact height -> probe tip goes to Z-R
if {![info exists ::prb_side_z_minus_r]} {set ::prb_side_z_minus_r 1}
# ASP walls: 0 = touch at NX contact Z, 1 = lower by ::prb_ball_r (old)
if {![info exists ::prb_omp_wall_dropR]} {set ::prb_omp_wall_dropR 0}
# #3006 message after each measurement (1/0)
if {![info exists ::prb_msg]}          {set ::prb_msg 1}

# message "&#nnn" output: AMPENT (&amp;#) | LITERAL | TEXT
if {![info exists ::prb_amp_mode]}     {set ::prb_amp_mode "AMPENT"}
# expected touch distance if NX gives no explicit target point
if {![info exists ::prb_expect]}       {set ::prb_expect 5.0}
# shift work offset after 2-wall center / cylinder (1/0)
if {![info exists ::prb_center_shift]} {set ::prb_center_shift 1}
# pair two opposite side touches of one operation into a center (1/0)
if {![info exists ::prb_center_pair]}  {set ::prb_center_pair 1}
# clearance Z for the init block if no motion came before the first probe event
if {![info exists ::prb_zsafe]}        {set ::prb_zsafe 50.0}
# standoff for Z touches when NX gives 0
if {![info exists ::prb_standoff]}     {set ::prb_standoff 5.0}
# cylinder nominal diameter override ("" = take from NX / UDE mom_prb_nominal_d)
if {![info exists ::prb_cyl_d_override]} {set ::prb_cyl_d_override ""}
# cylinder top Z for the bottom check ("" = unknown, check skipped)
if {![info exists ::prb_cyl_top_z]}  {set ::prb_cyl_top_z ""}
# full dump of all mom_* globals (DBG CYLALL): 1 = on, 0 = off
if {![info exists ::prb_dump_all]}   {set ::prb_dump_all 0}
# Z touch (SDP): write G91 G10 L2 Pn Z#152 (1/0)
if {![info exists ::prb_write_z]}      {set ::prb_write_z 1}
# single wall: write G91 G10 ... #152 (1) or only measure (0)
if {![info exists ::prb_write_single]} {set ::prb_write_single 0}

set ::prb_on_state  0
set ::prb_need_g43  0
# 1 = WCS + G43 already output in this operation (reset at start_of_path)
set ::prb_g43_done  0
set ::prb_pending_on 0
set ::prb_side_prev ""
set ::prb_omp_active 0
set ::prb_clear_z ""
array set ::prb_wall {}
set ::prb_last(x) "" ; set ::prb_last(y) "" ; set ::prb_last(z) ""

#---------------- helpers ----------------------------------------------------
proc PRB_fmt { v } {
   set s [format "%.3f" $v]
   set s [string trimright $s 0]
   if {$s == "-0."} {set s "0."}
   return $s
}

# "#a-<t>" safe for negative t
proc PRB_sub { t } {
   if {$t < 0} {return "+[PRB_fmt [expr {-$t}]]"}
   return "-[PRB_fmt $t]"
}

proc PRB_out { txt } { MOM_output_literal $txt }

# W from mom_fixture_offset_value: 0/1->1, 2..6, -n -> G54.1 Pn
# returns {L P}  (L2 P1..6 or L20 Pn)
# ::prb_wcs_override {L P W}: move CS chosen in UDE prb_center_axis (reset per op)
proc PRB_wcs { } {
   if {$::prb_wcs_override ne ""} {return $::prb_wcs_override}
   set w 1
   if {[info exists ::mom_fixture_offset_value] && \
       [string is double -strict $::mom_fixture_offset_value]} {
      set w [expr {int($::mom_fixture_offset_value)}]
   }
   if {$w == 0} {set w 1}
   if {$w < 0} { return [list 20 [expr {-$w}] $w] }
   if {$w > 6} {set w 6}
   return [list 2 $w $w]
}

# Renishaw-style S from NX probe dialog: 1..6 G54-59, 101.. G54.1 P(S-100)
proc PRB_target_wcs { } {
   set s 0
   foreach {o v} {mom_probe_work_offset_number_output mom_probe_work_offset_number \
                  mom_probe_work_offset_output mom_probe_work_offset} {
      if {[info exists ::$o] && [set ::$o] == 1 && [info exists ::$v]} {set s [expr {int([set ::$v])}]; break}
   }
   if {$s != 0} {
      if {$s >= 1 && $s <= 6}  { return [list 2 $s $s] }
      if {$s > 100}            { return [list 20 [expr {$s-100}] [expr {100-$s}]] }
      if {$s < 0}              { return [list 20 [expr {-$s}] $s] }
   }
   return ""
}

# ::prb_move_fvar: feed var of protected moves (170, or 172 inside UDE prb_center_axis)
if {![info exists ::prb_move_fvar]} {set ::prb_move_fvar 170}
if {![info exists ::prb_move_feed]} {set ::prb_move_feed 3000.0}
proc PRB_on { } {
   if {$::prb_need_g43} { set ::prb_pending_on 1 ; return }
   lassign [PRB_wcs] L P W
   if {$::prb_move_fvar == 170} {
      PRB_out "#170=[PRB_fmt $::prb_feed] (PODACHA)"
   } else {
      PRB_out "#170=[PRB_fmt $::prb_feed] (PODACHA KASANIYA)"
      PRB_out "#$::prb_move_fvar=[PRB_fmt $::prb_move_feed] (PODACHA PEREMESHCHENIYA)"
   }
   PRB_out "#171=[PRB_fmt $W] (NOL W)"
   PRB_m60
   if {[PRB_sw]} {
      PRB_out "G65 P9101 A1."
   } else {
      PRB_out "(SHCHUP VKLYUCHEN POSTOYANNO)"
   }
   set ::prb_on_state 1
}

proc PRB_off { } {
   set ::prb_pending_on 0
   if {[PRB_sw]} {
      PRB_out "G65 P9101 A0."
   } else {
      PRB_out "(SHCHUP VKLYUCHEN POSTOYANNO)"
   }
   PRB_m61
   set ::prb_on_state 0
}

# init block if needed (at x y z), then probe on
proc PRB_ensure_on { {x ""} {y ""} {z ""} } {
   if {$::prb_need_g43 && $x != ""} { PRB_first_pos $x $y $z ; return }
   if {!$::prb_on_state && !$::prb_need_g43} { PRB_on }
}

# protected move, never XY and Z in one block
proc PRB_move { x y z } {
   PRB_track_z $z
   set lz $::prb_last(z)
   set up [expr {$lz == "" || $z >= $lz}]
   set xy ""
   if {$::prb_last(x) == "" || abs($x-$::prb_last(x)) > 0.0005} {append xy " X[PRB_fmt $x]"}
   if {$::prb_last(y) == "" || abs($y-$::prb_last(y)) > 0.0005} {append xy " Y[PRB_fmt $y]"}
   set zb ""
   if {$lz == "" || abs($z-$lz) > 0.0005} {set zb " Z[PRB_fmt $z]"}
   if {$up} {
      if {$zb != ""} {PRB_out "G65 P9102$zb F#$::prb_move_fvar"}
      if {$xy != ""} {PRB_out "G65 P9102$xy F#$::prb_move_fvar"}
   } else {
      if {$xy != ""} {PRB_out "G65 P9102$xy F#$::prb_move_fvar"}
      if {$zb != ""} {PRB_out "G65 P9102$zb F#$::prb_move_fvar"}
   }
   set ::prb_last(x) $x ; set ::prb_last(y) $y ; set ::prb_last(z) $z
}

proc PRB_movez { z } {
   PRB_track_z $z
   if {$::prb_last(z) == "" || abs($z-$::prb_last(z)) > 0.0005} {
      PRB_out "G65 P9102 Z[PRB_fmt $z] F#$::prb_move_fvar"
      set ::prb_last(z) $z
   }
}

proc PRB_track_z { z } {
   if {$::prb_clear_z == "" || $z > $::prb_clear_z} {set ::prb_clear_z $z}
}

proc PRB_clear { args } {
   set s ""
   foreach v $args { append s "#$v=#0 " }
   PRB_out [string trim $s]
}

proc PRB_msg { txt } {
   if {!$::prb_msg} return
   set txt [string range [string toupper $txt] 0 25]
   set line "#3006=-1 ($txt)"
   switch -exact -- [string toupper $::prb_amp_mode] {
      TEXT    { MOM_output_text $line }
      LITERAL { MOM_output_literal $line }
      default { MOM_output_literal [string map {"&#" "&amp;#"} $line] }
   }
}

# offset shift: axes list of {axis var}
proc PRB_shift { tw pairs } {
   if {$tw == ""} return
   lassign $tw L P
   set s "G91 G10 L$L P$P"
   foreach pr $pairs { append s " [lindex $pr 0]#[lindex $pr 1]" }
   PRB_out $s
   PRB_out "G90"
   PRB_force_mode
}

# literal G90/G91 lines do not update the post modal state:
# force G_mode so the next G28 block always carries G91 explicitly
proc PRB_force_mode { } { catch {MOM_force Once G_mode} }

proc PRB_tag { t } {
   if {!$::prb_omp_debug} return
   PRB_out "(DBG [string map {( [ ) ] & + # N} $t])"
   catch {MOM_output_to_listing_device "probe_omp: $t"}
}
proc PRB_opname { } { if {[info exists ::mom_operation_name]} {return $::mom_operation_name} ; return ? }

proc PRB_pos { } {
   set r {}
   foreach k {0 1 2} a {x y z} {
      if {[info exists ::mom_pos($k)]} {lappend r $::mom_pos($k)} \
      elseif {$::prb_last($a) != ""} {lappend r $::prb_last($a)} else {lappend r 0.0}
   }
   return $r
}

#---------------- debug dump ------------------------------------------------
proc PRB_dbg { tag } {
   if {!$::prb_omp_debug} return
   foreach v [lsort [concat [info globals mom_probe*] [info globals mom_omp*] \
         {mom_pos mom_prev_pos mom_feed_rate mom_tool_axis mom_contact_point mom_trigger_alarm}]] {
      if {![info exists ::$v]} continue
      upvar #0 $v val
      if {[array exists val]} {
         set s ""
         foreach k [lsort [array names val]] { append s " $k=$val($k)" }
      } else { set s " $val" }
      set s [string map {( [ ) ] & + # N} $s]
      PRB_out "(DBG $tag $v:$s)"
   }
}

#---------------- start/end of operation ------------------------------------
proc PRB_op_settings { } {
   if {[info exists ::mom_prb_center_pair]} {set ::prb_center_pair $::mom_prb_center_pair}
}

proc PRB_is_probe_tool { } {
   foreach v {mom_tool_type mom_tool_name mom_template_subtype mom_operation_type} {
      if {[info exists ::$v] && [string match -nocase "*prob*" [set ::$v]]} {return 1}
   }
   return 0
}

proc PRB_wcs_text { } {
   lassign [PRB_wcs] L P W
   if {$L == 20} {return "G54.1 P$P"}
   return "G5[expr {3+$P}]"
}

proc PRB_first_pos { x y z } {
   if {!$::prb_need_g43} {return 0}
   PRB_out "G90 G00 [PRB_wcs_text] X[PRB_fmt $x] Y[PRB_fmt $y]"
   PRB_out "G43 H$::prb_h_cur Z[PRB_fmt $z]"
   set ::prb_need_g43 0
   set ::prb_g43_done 1
   set ::prb_last(x) $x ; set ::prb_last(y) $y ; set ::prb_last(z) $z
   set ::prb_pending_on 0
   if {!$::prb_on_state} { PRB_on }
   return 1
}

proc PRB_tool_check { } {
   if {[info exists ::mom_tool_number] && $::mom_tool_number != $::prb_tool} {
      if {[info exists ::prb_warned_tool] && $::prb_warned_tool == $::mom_tool_number} return
      set ::prb_warned_tool $::mom_tool_number
      set w "probe_omp WARNING: probe tool T$::mom_tool_number, expected T$::prb_tool"
      catch {MOM_output_to_listing_device $w}
      PRB_out "(VNIMANIE: SHCHUP T$::mom_tool_number NE T$::prb_tool)"
   }
}

proc PRB_arm { } {
   set h $::prb_h
   if {[info exists ::mom_tool_number] && [string is integer -strict $::mom_tool_number] && $::mom_tool_number > 0} {set h $::mom_tool_number}
   foreach v {mom_tool_adjust_register mom_tool_length_adjust_register} {
      if {[info exists ::$v] && [string is double -strict [set ::$v]] && [set ::$v] > 0} {set h [expr {int([set ::$v])}]}
   }
   PRB_tool_check
   set ::prb_on_state 0
   set ::prb_h_cur $h
   set ::prb_need_g43 1
   PRB_walls_reset
   set ::prb_clear_z ""
   set ::prb_last(x) "" ; set ::prb_last(y) "" ; set ::prb_last(z) ""
   PRB_op_settings
}

#---------------- NX probing events -----------------------------------------
proc MOM_probe_change { } {
   PRB_tag ENTER_PROBE_CHANGE
   set t $::prb_tool
   if {[info exists ::mom_tool_number] && $::mom_tool_number > 0} {set t $::mom_tool_number}
   PRB_out "G00 G90 G53 Z0."
   PRB_out "T$t M06"
   PRB_arm
}

proc MOM_probe_on  { } { PRB_tag ENTER_PROBE_ON ; PRB_dbg ON ; PRB_on }
proc MOM_probe_off { } { PRB_tag ENTER_PROBE_OFF ; PRB_off }

proc MOM_probe_protected_move { } {
   PRB_tag ENTER_PROTECTED_MOVE
   lassign [PRB_pos] x y z
   if {[PRB_first_pos $x $y $z]} return
   PRB_ensure_on
   PRB_move $x $y $z
}

# explicit target point candidates, else mom_pos if it is beyond approach
proc PRB_target { } {
   foreach v {mom_probe_contact_pos mom_probe_point mom_probe_target mom_probe_surface_point mom_probe_contact_point mom_contact_point} {
      if {[info exists ::$v] && [array exists ::$v] && [info exists ::${v}(2)]} {
         upvar #0 $v a
         return [list $a(0) $a(1) $a(2) $v]
      }
   }
   lassign [PRB_pos] x y z
   return [list $x $y $z mom_pos]
}

# unit vector of touch direction: explicit vector, angle, or approach->target
proc PRB_dir { tx ty tz } {
   foreach v {mom_probe_vector mom_probe_direction_vector mom_probe_normal} {
      if {[info exists ::${v}(2)]} {
         upvar #0 $v a
         return [list $a(0) $a(1) $a(2) $v]
      }
   }
   if {[info exists ::mom_probe_axis_type] && $::mom_probe_axis_type == 1 \
         && [info exists ::mom_probe_angle_of_measurement]} {
      set r [expr {$::mom_probe_angle_of_measurement*acos(-1)/180.0}]
      return [list [expr {cos($r)}] [expr {sin($r)}] 0.0 angle_of_measurement]
   }
   if {[info exists ::mom_probe_type] && $::mom_probe_type == 0 && [info exists ::mom_probe_angle]} {
      set r [expr {$::mom_probe_angle*acos(-1)/180.0}]
      return [list [expr {cos($r)}] [expr {sin($r)}] 0.0 mom_probe_angle]
   }
   set dx 0.0; set dy 0.0; set dz 0.0
   if {$::prb_last(x) != ""} {set dx [expr {$tx-$::prb_last(x)}]}
   if {$::prb_last(y) != ""} {set dy [expr {$ty-$::prb_last(y)}]}
   if {$::prb_last(z) != ""} {set dz [expr {$tz-$::prb_last(z)}]}
   set n [expr {sqrt($dx*$dx+$dy*$dy+$dz*$dz)}]
   if {$n < 0.001} {return [list 0.0 0.0 -1.0 default]}
   return [list [expr {$dx/$n}] [expr {$dy/$n}] [expr {$dz/$n}] approach]
}

# wall slots for center pairing by opposite direction (not by order):
#   ::prb_wall(<axis><sign>) = nominal t; machine value in #175 (X) / #179 (Y)
proc PRB_walls_reset { } { array unset ::prb_wall ; set ::prb_side_prev "" }
proc PRB_def_wcs { tw } {
   if {$tw != ""} {return $tw}
   lassign [PRB_wcs] L P
   return [list $L $P]
}

# one touch along dominant axis of dir
proc PRB_touch { ev tx ty tz dx dy dz src } {
   set tw [PRB_target_wcs]
   set ax [expr {abs($dx)}] ; set ay [expr {abs($dy)}] ; set az [expr {abs($dz)}]
   if {$az >= $ax && $az >= $ay} {
      # Z touch. If target is not below the approach Z, use approach - prb_expect
      set so $::prb_standoff
      if {[info exists ::mom_probe_standoff_distance] && $::mom_probe_standoff_distance > 0.001} {set so $::mom_probe_standoff_distance}
      set zc $::prb_last(z)
      if {$zc == "" || $zc < $tz + $so} {set zc [expr {$tz + $so}]}
      PRB_move $tx $ty $zc
      PRB_movez [expr {$tz + $so}]
      PRB_clear 152
      PRB_out "G65 P9103 Z[PRB_fmt $tz]"
      PRB_out "#152=#103[PRB_sub $tz]"
      if {$::prb_write_z} { PRB_shift [PRB_def_wcs $tw] {{Z 152}} } else { PRB_out "(TOLKO IZMERENIE)" }
      PRB_msg "Z=&#103&"
      set ::prb_last(z) ""
      return
   }
   if {$ax >= $ay} {set A X; set s [expr {$dx<0?-1:1}]; set t $tx; set r 101; set m 175} \
   else            {set A Y; set s [expr {$dy<0?-1:1}]; set t $ty; set r 102; set m 179}
   if {$az > 0.02} {PRB_out "(UGOL: TOLKO OS $A)"}
   # wall Z: ::prb_omp_wall_dropR 0 = exactly NX contact Z (PRB_movez outputs
   # nothing if the probe is already there); 1 = old behaviour Z - ball R
   if {$::prb_omp_wall_dropR && $::prb_side_z_minus_r} {
      PRB_movez [expr {$tz - $::prb_ball_r}]
   } else {
      PRB_movez $tz
   }
   PRB_out "G65 P9103 $A[PRB_fmt $t]"
   if {$::prb_write_single} {
      PRB_clear 152
      PRB_out "#152=#$r[PRB_sub $t]"
      PRB_shift [PRB_def_wcs $tw] [list [list $A 152]]
   } else {
      PRB_out "(TOLKO IZMERENIE)"
   }
   PRB_msg "$A=&#$r&"
   set ::prb_last([string tolower $A]) ""
   set opp $A[expr {-$s}]
   if {$::prb_center_pair && [info exists ::prb_wall($opp)]} {
      # center of two opposite walls (any order, other points may be between)
      set t1 $::prb_wall($opp)
      set m1 [expr {$m+1}] ; set m2 [expr {$m+2}] ; set m3 [expr {$m+3}]
      PRB_out "#$m1=#$r"
      PRB_out "#$m2=\[#$m+#$m1\]/2"
      PRB_out "#$m3=#$m2[PRB_sub [expr {($t1+$t)/2.0}]]"
      PRB_out "(CENTR $A = #$m2, SDVIG = #$m3)"
      # NOTE: the shift is applied right away, i.e. an X center shifts the
      # work offset BEFORE the following Y touches (order as programmed in NX)
      if {$::prb_center_shift} {
         lassign [PRB_wcs] L P
         PRB_shift [list $L $P] [list [list $A $m3]]
      }
      PRB_msg "C$A=&#$m2&"
      unset ::prb_wall($opp)
   } else {
      PRB_out "#$m=#$r"
      PRB_out "#[expr {$m+1}]=#0 #[expr {$m+2}]=#0 #[expr {$m+3}]=#0"
      set ::prb_wall($A$s) $t
   }
}
proc PRB_init_at { tx ty tz } {
   if {!$::prb_need_g43} {PRB_ensure_on ; return}
   set zc $::prb_zsafe
   if {$zc < $tz + 10.0} {set zc [expr {$tz + 10.0}]}
   PRB_ensure_on $tx $ty $zc
}

proc MOM_probe_single_direction_point { } {
   PRB_tag ENTER_SDP
   PRB_dbg SDP
   lassign [PRB_target] tx ty tz src
   PRB_init_at $tx $ty $tz
   set d $::mom_probe_direction
   lassign [PRB_dir $tx $ty $tz] dx dy dz dsrc
   switch -glob -- $d {
      0 - X* {set dx [expr {$dx<0?-1.0:1.0}]; set dy 0.0; set dz 0.0}
      1 - Y* {set dy [expr {$dy<0?-1.0:1.0}]; set dx 0.0; set dz 0.0}
      default {set dx 0.0; set dy 0.0; set dz -1.0}
   }
   PRB_touch SDP $tx $ty $tz $dx $dy $dz $src
}

proc MOM_probe_angled_surface_point { } {
   PRB_tag ENTER_ASP
   PRB_dbg ASP
   lassign [PRB_target] tx ty tz src
   # guard: NX2506 sometimes sends an ASP with the retract Z, angle 0 and
   # standoff 0 (contact = approach XY). Never touch with such data.
   set so [PRB_num mom_probe_standoff_distance 0.0]
   set bad ""
   if {$so <= 0.001} {set bad "STANDOFF 0"}
   if {[info exists ::mom_prev_pos(2)] && $tz > $::mom_prev_pos(2) + 0.001} {set bad "Z VYSHE PODVODA"}
   if {$::prb_clear_z != "" && $tz >= $::prb_clear_z - 0.001} {set bad "Z NA OTVODE"}
   if {$bad != ""} {
      PRB_out "(OSHIBKA: TOCHKA NX NEVERNA - $bad)"
      PRB_out "(OSHIBKA: Z[PRB_fmt $tz] BEZ P9103)"
      catch {MOM_output_to_listing_device "probe_omp ERROR: ASP skipped ($bad) at X$tx Y$ty Z$tz"}
      return
   }
   if {$::prb_need_g43 && [info exists ::mom_prev_pos(2)]} {
      PRB_init_at $::mom_prev_pos(0) $::mom_prev_pos(1) $tz
   } else { PRB_init_at $tx $ty $tz }
   lassign [PRB_dir $tx $ty $tz] dx dy dz dsrc
   PRB_out "(TOCHKA POVERHN: $src / $dsrc)"
   PRB_touch ASP $tx $ty $tz $dx $dy $dz $src
}
proc PRB_num { names {def ""} } {
   foreach v $names {
      if {[info exists ::$v] && ![array exists ::$v] && [string is double -strict [set ::$v]]} {return [set ::$v]}
   }
   return $def
}

# NX2506 Probe_Cylinder (real run 2026-11-03):
#   mom_probing_diameter / mom_circle_diameter = cylinder D,
#   mom_probe_radius = CYLINDER radius (never the ball radius!),
#   mom_probe_geometry_type 1 + mom_probe_side 0 = hole,
#   mom_probe_cylinder_length + mom_probe_depth_type = depth,
#   mom_pos at the event = hole center XY, Z = top of the cylinder.
proc PRB_cyl_dia { } {
   if {[string is double -strict $::prb_cyl_d_override] && $::prb_cyl_d_override > 0} {
      return [list $::prb_cyl_d_override prb_cyl_d_override]
   }
   set c {}
   foreach v {mom_probing_diameter mom_circle_diameter mom_prb_nominal_d} {
      set d [PRB_num $v]
      if {$d != "" && abs($d) > 0.0001} {lappend c [list [expr {abs($d)}] $v]}
   }
   set r [PRB_num mom_probe_radius]
   if {$r != "" && abs($r) > 0.0001} {lappend c [list [expr {2.0*abs($r)}] 2*mom_probe_radius]}
   if {![llength $c]} {return {}}
   set d0 [lindex $c 0 0]
   foreach p [lrange $c 1 end] {
      if {abs([lindex $p 0] - $d0) > 0.001} {
         set w "probe_omp WARNING: D [lindex $c 0 1]=$d0 <> [lindex $p 1]=[lindex $p 0]"
         catch {MOM_output_to_listing_device $w}
         PRB_out "(VNIMANIE: RAZNYE D [PRB_fmt $d0] / [PRB_fmt [lindex $p 0]])"
      }
   }
   return [lindex $c 0]
}

proc PRB_cyl_body { bore } {
   lassign [PRB_pos] x y z
   # hole/boss from NX geometry: geometry_type 1 & side 0 = hole (verified)
   set gt [PRB_num mom_probe_geometry_type ""]
   set sd [PRB_num mom_probe_side ""]
   set hole $bore
   if {$gt != "" && $sd != ""} { set hole [expr {$gt == 1 && $sd == 0}] }
   if {!$hole} {
      PRB_out "(OSHIBKA: BOSS NE PODDERZHIVAETSYA)"
      catch {MOM_output_to_listing_device "probe_omp ERROR: boss (geometry_type=$gt side=$sd) not supported yet"}
      return
   }
   set dd [PRB_cyl_dia]
   if {![llength $dd]} {
      PRB_out "(OSHIBKA: NET DIAMETRA CILINDRA)"
      catch {MOM_output_to_listing_device "probe_omp ERROR: cylinder diameter unknown"}
      return
   }
   set dia [lindex $dd 0]
   # touch Z = event Z: NX already brings the probe to the touch depth
   # (top - Distance). No extra descent.
   set zm $z
   set len [PRB_num mom_probe_cylinder_length 0.0]
   if {[string is double -strict $::prb_cyl_top_z]} {
      set zmin [expr {$::prb_cyl_top_z - $len + $::prb_ball_r}]
      PRB_tag "CYL D=[PRB_fmt $dia] SRC=[lindex $dd 1] ZT=[PRB_fmt $zm] TOP=[PRB_fmt $::prb_cyl_top_z] L=[PRB_fmt $len] ZMIN=[PRB_fmt $zmin]"
      if {$zm < $zmin - 0.0005} {
         PRB_out "(OSHIBKA: SHCHUP NIZHE DNA)"
         catch {MOM_output_to_listing_device "probe_omp ERROR: touch Z $zm below bottom+ball ($zmin)"}
         return
      }
   } else {
      PRB_tag "CYL D=[PRB_fmt $dia] SRC=[lindex $dd 1] ZT=[PRB_fmt $zm] L=[PRB_fmt $len] TOP UNKNOWN - NO BOTTOM CHECK"
   }
   PRB_init_at $x $y $zm
   set tw [PRB_target_wcs]
   if {$tw == "" && $::prb_center_shift} {lassign [PRB_wcs] L P; set tw [list $L $P]}
   # protected moves only if not already at the center / touch Z (no duplicates)
   PRB_move $x $y $zm
   PRB_ensure_on
   PRB_clear 152 153
   PRB_out "G65 P9103 D[PRB_fmt $dia] F#170"
   PRB_out "#152=#101[PRB_sub $x]"
   PRB_out "#153=#102[PRB_sub $y]"
   PRB_shift $tw {{X 152} {Y 153}}
   PRB_msg "D=&#100&"
   set ::prb_side_prev ""
}
proc PRB_dbg_all { tag } {
   if {!$::prb_dump_all} return
   foreach v [lsort [info globals mom_*]] {
      if {[string match mom_probe* $v] || [string match mom_sys_* $v] || [string match mom_kin_* $v]} continue
      upvar #0 $v val
      if {[array exists val]} {
         set s ""
         foreach k [lsort [array names val]] { append s " $k=$val($k)" }
      } elseif {[info exists val]} { set s " $val" } else continue
      set s [string range [string map {( [ ) ] & + # N} $s] 0 200]
      PRB_out "(DBG $tag $v:$s)"
   }
}

proc PRB_cyl { bore } {
   PRB_tag "ENTER_CYL BORE=$bore EV=[lindex [info level -1] 0]"
   catch {PRB_dbg_all CYLALL}
   catch {PRB_dbg CYL}
   set ::prb_abort_msg ""
   if {[catch {PRB_cyl_body $bore} err]} {
      PRB_out "(OSHIBKA CILINDR: [string map {( [ ) ]} [string range $err 0 60]])"
      catch {MOM_output_to_listing_device "probe_omp PRB_cyl: $err"}
      set ::prb_abort_msg "probe_omp cylinder: $err"
   }
   # no MOM_abort: error is already in NC and listing, output continues
}

proc MOM_probe_three_point_bore { } { PRB_cyl 1 }
proc MOM_probe_four_point_bore  { } { PRB_cyl 1 }
proc MOM_probe_three_point_boss { } { PRB_cyl 0 }
proc MOM_probe_four_point_boss  { } { PRB_cyl 0 }

foreach ev {calibrate_probe_length calibrate_sphere calibrate_stylus_offsets \
            calibrate_stylus_radius probe_multi_stylus_load probe_multi_stylus_store} {
   proc MOM_$ev { } "PRB_dbg [string toupper [string range $ev 0 5]] ; PRB_out \"(NX $ev - NE PODDERZHIVAETSYA)\""
}

proc MOM_omp_cycle_start { } { PRB_tag ENTER_OMP_START ; set ::prb_omp_active 1 ; PRB_ensure_on ; PRB_dbg OMPS }
proc MOM_omp_cycle_end   { } { PRB_tag ENTER_OMP_END ; PRB_dbg OMPE ; set ::prb_omp_active 0 }

#---------------- wrappers of main post handlers ----------------------------
if {[llength [info commands MOM_tool_change]] && ![llength [info commands PRB_orig_MOM_tool_change]]} {
   rename MOM_tool_change PRB_orig_MOM_tool_change
   proc MOM_tool_change { } { PRB_orig_MOM_tool_change ; if {[PRB_is_probe_tool]} {PRB_arm} }
}
if {[llength [info commands MOM_start_of_path]] && ![llength [info commands PRB_orig_MOM_start_of_path]]} {
   rename MOM_start_of_path PRB_orig_MOM_start_of_path
   proc MOM_start_of_path { } { set ::prb_g43_done 0 ; set ::prb_sw_override "" ; set ::prb_wcs_override "" ; set ::prb_m60_override "" ; PRB_tag "START_OF_PATH [PRB_opname] PROBE_TOOL=[PRB_is_probe_tool]" ; PRB_orig_MOM_start_of_path ; if {[PRB_is_probe_tool]} {PRB_arm} }
}
if {[llength [info commands MOM_end_of_path]] && ![llength [info commands PRB_orig_MOM_end_of_path]]} {
   rename MOM_end_of_path PRB_orig_MOM_end_of_path
   proc MOM_end_of_path { } {
      PRB_tag "END_OF_PATH [PRB_opname]"
      if {$::prb_on_state} {PRB_off}
      PRB_m61
      set ::prb_sw_override "" ; set ::prb_wcs_override "" ; set ::prb_m60_override ""
      set ::prb_pending_on 0 ; set ::prb_need_g43 0 ; PRB_walls_reset ; set ::prb_clear_z ""
      PRB_force_mode
      PRB_orig_MOM_end_of_path
   }
}
foreach ev {MOM_rapid_move MOM_linear_move} {
   if {[llength [info commands $ev]] && ![llength [info commands PRB_orig_$ev]]} {
      rename $ev PRB_orig_$ev
      proc $ev { } "
         if {\$::prb_omp_active || \$::prb_on_state || \$::prb_need_g43} {
            lassign \[PRB_pos\] x y z
            if {!\[PRB_first_pos \$x \$y \$z\]} { PRB_ensure_on ; PRB_move \$x \$y \$z }
            return
         }
         PRB_orig_$ev
      "
   }
}

if {[llength [info commands MOM_end_of_program]] && ![llength [info commands PRB_orig_MOM_end_of_program]]} {
   rename MOM_end_of_program PRB_orig_MOM_end_of_program
   proc MOM_end_of_program { } { PRB_force_mode ; PRB_orig_MOM_end_of_program }
}

#---------------- event tracing (debug) -------------------------------------
# NX calls MOM_before_each_event (if defined) before every event handler;
# log every event name to the listing, probe-like names also to the NC.
set ::prb_ev_seen {}
if {[llength [info commands MOM_before_each_event]] && ![llength [info commands PRB_orig_MOM_before_each_event]]} {
   rename MOM_before_each_event PRB_orig_MOM_before_each_event
} else { proc PRB_orig_MOM_before_each_event { } {} }
proc MOM_before_each_event { } {
   catch {PRB_orig_MOM_before_each_event}
   if {!$::prb_omp_debug || ![info exists ::mom_event_name]} return
   set e $::mom_event_name
   catch {MOM_output_to_listing_device "probe_omp EVENT: $e handler=[llength [info commands MOM_$e]]"}
   if {[string match -nocase "*prob*" $e] || [string match -nocase "*omp*" $e] || [string match -nocase "*bore*" $e] \
         || [string match -nocase "*boss*" $e] || [string match -nocase "*cyl*" $e] || [string match -nocase "*measur*" $e] \
         || ![llength [info commands MOM_$e]]} {
      PRB_out "(DBG EVENT $e HANDLER=[llength [info commands MOM_$e]])"
   }
}
# calls of undefined MOM_* commands (if NX goes through the Tcl unknown)
if {[llength [info commands unknown]] && ![llength [info commands PRB_orig_unknown]]} {
   rename unknown PRB_orig_unknown
   proc unknown { args } {
      set c [lindex $args 0]
      if {[string match MOM_* $c] && $::prb_omp_debug} {
         catch {MOM_output_to_listing_device "probe_omp UNKNOWN: $c"}
         catch {PRB_out "(DBG UNKNOWN $c)"}
      }
      uplevel 1 [list PRB_orig_unknown {*}$args]
   }
}

#---------------- end of program: G28 Z always with G91 ---------------------
# end_of_program_3 has G_mode modal (91 already active from the header block,
# probe ops output only literals, so no G90 template resets the modal state)
# -> G91 is suppressed. Emit the block as a literal, nothing else changes.
if {[llength [info commands MOM_do_template]] && ![llength [info commands PRB_orig_MOM_do_template]]} {
   rename MOM_do_template PRB_orig_MOM_do_template
   proc MOM_do_template { args } {
      if {[lindex $args 0] == "end_of_program_3"} {
         MOM_output_literal "G91 G28 Z0."
         return
      }
      uplevel 1 [list PRB_orig_MOM_do_template {*}$args]
   }
}
#---------------- UDE prb_center_axis (probe_omp.cdl) ----------------------
# two points + probing vectors on one axis -> center, optional G10 shift.
# Machine vars: #183 wall 1, #184 wall 2, #185 center, #186 shift.
# Point/vector layout of UDE TYPE p / v in Tcl is read robustly:
#   mom_<n>(0..2) | mom_<n>_pos(0..2) | mom_<n>_x/_y/_z | mom_<n>_i/_j/_k
proc PRB_ude_xyz { n } {
   foreach a [list mom_$n mom_${n}_pos mom_${n}_point mom_${n}_vec] {
      if {[info exists ::${a}(0)] && [info exists ::${a}(1)] && [info exists ::${a}(2)]} {
         upvar #0 $a v
         return [list $v(0) $v(1) $v(2)]
      }
   }
   foreach sfx {{_x _y _z} {_i _j _k}} {
      lassign $sfx a b c
      if {[info exists ::mom_$n$a] && [info exists ::mom_$n$b] && [info exists ::mom_$n$c]} {
         return [list [set ::mom_$n$a] [set ::mom_$n$b] [set ::mom_$n$c]]
      }
   }
   return {}
}

# vector -> {axis sign} or "" if not along X or Y
proc PRB_ude_axis { v } {
   lassign $v i j k
   set n [expr {sqrt($i*$i+$j*$j+$k*$k)}]
   if {$n < 1e-6} {return ""}
   set i [expr {$i/$n}] ; set j [expr {$j/$n}]
   if {abs($i) > 0.999} {return [list X [expr {$i<0?-1:1}]]}
   if {abs($j) > 0.999} {return [list Y [expr {$j<0?-1:1}]]}
   return ""
}

# option value check without Cyrillic in this file: the Russian CDL option
# text is given as \u escapes and compared as unicode, cp1251 bytes and
# utf-8 bytes (whatever NX passes). Unknown value = 0 (safe side).
proc PRB_opt_is { val ascii ru } {
   set val [string trim $val]
   if {[string equal -nocase $val $ascii]} {return 1}
   foreach f [list $ru [encoding convertto cp1251 $ru] [encoding convertto utf-8 $ru]] {
      if {$val eq $f} {return 1}
   }
   return 0
}

proc PRB_ude_err { txt } {
   PRB_out "(OSHIBKA: $txt)"
   catch {MOM_output_to_listing_device "probe_omp UDE prb_center_axis ERROR: $txt"}
}

# --- UDE option -> offset {L P W} (W as #171: 1..6, -n = G54.1 Pn)
# ASCII options G54..G59 / G54.1 arrive unchanged (uppercased is fine).
# returns "" if the value is not one of them, "ERRP" if P out of 1..48
proc PRB_ca_cs { val pvar } {
   set g [string toupper [string trim $val]]
   if {$g == "G54.1"} {
      set pn [expr {int([PRB_num $pvar 1])}]
      if {$pn < 1 || $pn > 48} {return ERRP}
      return [list 20 $pn [expr {-$pn}]]
   }
   if {[regexp {^G5([4-9])$} $g -> d]} {return [list 2 [expr {$d-3}] [expr {$d-3}]]}
   return ""
}
proc PRB_ca_cstext { tw } {
   if {[lindex $tw 0] == 20} {return "G54.1 P[lindex $tw 1]"}
   return "G5[expr {3+[lindex $tw 1]}]"
}
proc PRB_ca_spaces { s } { return [expr {[llength [split $s " "]] - 1}] }

proc MOM_prb_center_axis { } {
   PRB_tag ENTER_PRB_CENTER_AXIS
   if {$::prb_omp_debug} {
      foreach v [lsort [info globals mom_prb_ca_*]] {
         upvar #0 $v val
         if {[array exists val]} {
            set s "" ; foreach k [lsort [array names val]] {append s " $k=$val($k)"}
         } else {set s " $val"}
         PRB_out "(DBG UDE $v:[string map {( [ ) ] & + # N} $s])"
      }
   }
   if {[info exists ::mom_command_status]} {
      if {$::prb_omp_debug} {PRB_out "(DBG UDE STATUS: $::mom_command_status)"}
      if {[string match -nocase "*inactive*" $::mom_command_status]} return
   }
   # ---- checks first, no motion on any error
   # NX passes TYPE o values uppercased / cp1251 re-decoded. Detection:
   # ASCII value first (G54..G59, G54.1), then \u text (PRB_opt_is), then
   # trimmed length / space count of the Russian option:
   #   prb_ca_move_cs : "Iz operacii"   = 11 chars (1 space)  else G5x ASCII
   #   prb_ca_write_cs: "V SK dvizheniya" = 13 chars, 2 spaces
   #                    "Ne zapisyvat"    = 13 chars, 1 space  else G5x ASCII
   #   prb_ca_tol_on  : "Net" = 3, "Da" = 2
   #   prb_ca_zmode   : "Po tochkam" = 9, "Odna Z" = 6
   #   prb_ca_probe_sw: "Po stanku" = 9, "Da" = 2, "Net" = 3
   #   prb_ca_m60     : "Da" = 2, "Net" = 3
   set fo 0
   if {[info exists ::mom_fixture_offset_value] && [string is double -strict $::mom_fixture_offset_value]} {
      set fo [expr {int($::mom_fixture_offset_value)}]
   }
   # -- move CS (motion of the probe, #171)
   set mcs "" ; if {[info exists ::mom_prb_ca_move_cs]} {set mcs [string trim $::mom_prb_ca_move_cs]}
   set mcsl [string length $mcs]
   set mw [PRB_ca_cs $mcs mom_prb_ca_move_p]
   set mop 0
   if {$mw == "ERRP"} {PRB_ude_err "P G54.1 DVIZH VNE 1..48" ; return}
   if {$mw == ""} {
      if {$mcs == "" || [PRB_opt_is $mcs Operation "\u0418\u0437 \u043e\u043f\u0435\u0440\u0430\u0446\u0438\u0438"] || $mcsl == 11} {
         set mop 1
         set ::prb_wcs_override ""
         if {$fo != 0} {set mw [PRB_wcs]}
      }
   }
   # -- write target
   set wcs "" ; if {[info exists ::mom_prb_ca_write_cs]} {set wcs [string trim $::mom_prb_ca_write_cs]}
   set wcsl [string length $wcs] ; set wsp [PRB_ca_spaces $wcs]
   set tw [PRB_ca_cs $wcs mom_prb_ca_write_p]
   set wmode ""
   if {$tw == "ERRP"} {PRB_ude_err "P G54.1 ZAPIS VNE 1..48" ; return}
   if {$tw != ""} {
      set wmode CS
   } elseif {$wcs == "" || [PRB_opt_is $wcs MoveCS "\u0412 \u0421\u041a \u0434\u0432\u0438\u0436\u0435\u043d\u0438\u044f"] || ($wcsl == 13 && $wsp == 2)} {
      set wmode MOVE
   } elseif {[PRB_opt_is $wcs None "\u041d\u0435 \u0437\u0430\u043f\u0438\u0441\u044b\u0432\u0430\u0442\u044c"] || ($wcsl == 13 && $wsp == 1)} {
      set wmode NONE
   }
   # -- size check
   set ton "" ; if {[info exists ::mom_prb_ca_tol_on]} {set ton [string trim $::mom_prb_ca_tol_on]}
   set tol [expr {[PRB_opt_is $ton Yes "\u0414\u0430"] || [string length $ton] == 2}]
   set nom [PRB_num mom_prb_ca_nominal 0.0]
   set tp  [expr {abs([PRB_num mom_prb_ca_tol_plus 0.05])}]
   set tm  [expr {abs([PRB_num mom_prb_ca_tol_minus 0.05])}]
   # touch height: "Po tochkam" 9 letters, "Odna Z" 6 (Z is ASCII)
   set zm ""
   if {[info exists ::mom_prb_ca_zmode]} {set zm [string trim $::mom_prb_ca_zmode]}
   set onez [PRB_opt_is $zm OneZ "\u041e\u0434\u043d\u0430 Z"]
   if {!$onez && ([string length $zm] == 6 || [string match -nocase "* Z" $zm])} {set onez 1}
   set zt [PRB_num mom_prb_ca_ztouch 0.0]
   if {$::prb_omp_debug} {
      set hx "" ; foreach ch [split $mcs ""] {append hx [format %X [scan $ch %c]] " "}
      PRB_out "(DBG UDE MOVE_CS LEN=$mcsl OP=$mop FO=$fo MW=$mw HEX=$hx)"
      set hx "" ; foreach ch [split $wcs ""] {append hx [format %X [scan $ch %c]] " "}
      PRB_out "(DBG UDE WRITE_CS LEN=$wcsl SP=$wsp MODE=$wmode TW=$tw HEX=$hx)"
      PRB_out "(DBG UDE TOL LEN=[string length $ton] ON=$tol NOM=$nom TP=$tp TM=$tm)"
      PRB_out "(DBG UDE ZMODE LEN=[string length $zm] ONEZ=$onez ZT=$zt)"
   }
   if {$mw == ""} {
      if {$mop} {PRB_ude_err "NET SKS"} else {PRB_ude_err "NEVERNAYA SK DVIZHENIYA"}
      return
   }
   if {$wmode == ""} {PRB_ude_err "NEVERNAYA SK ZAPISI" ; return}
   if {$wmode == "MOVE"} {set tw $mw}
   set p1 [PRB_ude_xyz prb_ca_point1] ; set p2 [PRB_ude_xyz prb_ca_point2]
   set v1 [PRB_ude_xyz prb_ca_vec1]   ; set v2 [PRB_ude_xyz prb_ca_vec2]
   if {![llength $p1] || ![llength $p2]} {PRB_ude_err "NET TOCHKI" ; return}
   if {![llength $v1] || ![llength $v2]} {PRB_ude_err "NET VEKTORA" ; return}
   if {$onez} {
      set p1 [lreplace $p1 2 2 $zt] ; set p2 [lreplace $p2 2 2 $zt]
   }
   set a1 [PRB_ude_axis $v1] ; set a2 [PRB_ude_axis $v2]
   if {$a1 == "" || $a2 == ""} {PRB_ude_err "VEKTOR NE PO X/Y" ; return}
   if {[lindex $a1 0] != [lindex $a2 0] || [lindex $a1 1] != -[lindex $a2 1]} {
      PRB_ude_err "VEKTORY NE PROTIVOPOL" ; return
   }
   set A [lindex $a1 0]
   if {$A == "X"} {set ix 0 ; set r 101} else {set ix 1 ; set r 102}
   if {$tol && $nom <= 0.0} {
      set nom [expr {abs([lindex $p2 $ix] - [lindex $p1 $ix])}]
      if {$nom < 0.001} {PRB_ude_err "NOMINAL 0" ; return}
   }
   set so [PRB_num mom_prb_ca_standoff $::prb_standoff]
   if {$so <= 0.001} {set so $::prb_standoff}
   set zs [PRB_num mom_prb_ca_zsafe $::prb_zsafe]
   foreach p [list $p1 $p2] {
      if {$zs < [lindex $p 2] + 1.0} {PRB_ude_err "Z BEZOP NIZHE TOCHKI" ; return}
   }
   set f [PRB_num mom_prb_ca_feed ""]
   if {$f != "" && $f > 0} {set ::prb_feed $f}
   # move feed (protected G65 P9102 in this UDE only) -> #172
   set mf [PRB_num mom_prb_ca_move_feed 3000.0]
   if {$mf == "" || $mf <= 0} {set mf 3000.0}
   set ::prb_move_feed $mf
   set ::prb_move_fvar 172
   if {$::prb_on_state} {
      PRB_out "#170=[PRB_fmt $::prb_feed] (PODACHA KASANIYA)"
      PRB_out "#172=[PRB_fmt $mf] (PODACHA PEREMESHCHENIYA)"
   }
   # probe switch: "Po stanku" 9 letters, "Da" 2, "Net" 3 -> override
   set sw ""
   if {[info exists ::mom_prb_ca_probe_sw]} {set sw [string trim $::mom_prb_ca_probe_sw]}
   set swl [string length $sw]
   if {[PRB_opt_is $sw Yes "\u0414\u0430"] || $swl == 2} {
      set ::prb_sw_override 1
   } elseif {[PRB_opt_is $sw No "\u041d\u0435\u0442"] || $swl == 3} {
      set ::prb_sw_override 0
   } else {
      set ::prb_sw_override ""
   }
   if {$::prb_omp_debug} {PRB_out "(DBG UDE PROBE_SW LEN=$swl OVR=$::prb_sw_override EFF=[PRB_sw])"}
   # M60/M61 (no spindle): "Da" 2 letters, "Net" 3 -> override; missing = ::prb_m60_enable
   set m6 ""
   if {[info exists ::mom_prb_ca_m60]} {set m6 [string trim $::mom_prb_ca_m60]}
   if {[PRB_opt_is $m6 Yes "\u0414\u0430"] || [string length $m6] == 2} {
      set ::prb_m60_override 1
   } elseif {[PRB_opt_is $m6 No "\u041d\u0435\u0442"] || [string length $m6] == 3} {
      set ::prb_m60_override 0
   } else {
      set ::prb_m60_override ""
   }
   if {$::prb_omp_debug} {PRB_out "(DBG UDE M60 LEN=[string length $m6] OVR=$::prb_m60_override EFF=[PRB_m60_en])"}
   # ---- motion in the chosen move CS: PRB_wcs (PRB_first_pos/PRB_wcs_text,
   # PRB_on #171) returns ::prb_wcs_override until end of this operation
   set ::prb_wcs_override $mw
   # non-probe op (e.g. MILL_CONTROL): no WCS/G43 yet -> arm the init block
   # once per operation; PRB_first_pos outputs G90 G00 Gxx X Y / G43 H Z
   if {!$::prb_g43_done && !$::prb_need_g43 && !$::prb_on_state} {
      set h $::prb_h
      if {[info exists ::mom_tool_number] && [string is integer -strict $::mom_tool_number] && $::mom_tool_number > 0} {set h $::mom_tool_number}
      foreach v {mom_tool_adjust_register mom_tool_length_adjust_register} {
         if {[info exists ::$v] && [string is double -strict [set ::$v]] && [set ::$v] > 0} {set h [expr {int([set ::$v])}]}
      }
      set ::prb_h_cur $h
      set ::prb_need_g43 1
      set ::prb_last(x) "" ; set ::prb_last(y) "" ; set ::prb_last(z) ""
      PRB_tag "UDE ARM G43 H$h"
   }
   set m {183 184}
   set k 0
   foreach p [list $p1 $p2] a [list $a1 $a2] {
      lassign $p x y z
      set s [lindex $a 1]
      set sx $x ; set sy $y
      if {$A == "X"} {set sx [expr {$x - $s*$so}] ; set t $x} else {set sy [expr {$y - $s*$so}] ; set t $y}
      if {![PRB_first_pos $sx $sy $zs]} {
         PRB_ensure_on
         PRB_movez $zs
         if {$k == 0} {
            # init block already done in this op: switch to the move CS here
            PRB_out "G90 G00 [PRB_ca_cstext $mw]"
            PRB_out "#171=[PRB_fmt [lindex $mw 2]] (NOL W)"
            set ::prb_last(x) "" ; set ::prb_last(y) "" ; set ::prb_last(z) ""
         }
         PRB_move $sx $sy $zs
      }
      if {$k == 0} {
         foreach v {183 184 185 186} {PRB_out "#$v=#0"}
      }
      if {$::prb_omp_wall_dropR && $::prb_side_z_minus_r} {
         PRB_movez [expr {$z - $::prb_ball_r}]
      } else {
         PRB_movez $z
      }
      PRB_out "G65 P9103 $A[PRB_fmt $t]"
      PRB_out "#[lindex $m $k]=#$r"
      # retract along the touch axis only to the approach position (point - vec*standoff)
      if {$A == "X"} {set rb $sx} else {set rb $sy}
      PRB_out "G65 P9102 $A[PRB_fmt $rb] F#$::prb_move_fvar"
      set ::prb_last([string tolower $A]) ""
      PRB_movez $zs
      set c($k) $t
      incr k
   }
   PRB_out "#185=\[#183+#184\]/2"
   PRB_out "#186=#185[PRB_sub [expr {($c(0)+$c(1))/2.0}]]"
   PRB_out "(CENTR $A = #185, SDVIG = #186)"
   # ---- size check BEFORE writing: alarm stops the program, nothing written
   # O9103 returns the compensated surface position -> size = ABS[#184-#183]
   if {$tol} {
      PRB_out "#188=ABS\[#184-#183\]"
      PRB_out "#189=#188[PRB_sub $nom]"
      PRB_out "(RAZMER = #188, OTKLONENIE = #189, NOM [PRB_fmt $nom] +[PRB_fmt $tp] -[PRB_fmt $tm])"
      PRB_out "IF\[#189GT[PRB_fmt $tp]\]#3000=1(RAZMER BOLSHE DOPUSKA)"
      PRB_out "IF\[#189LT-[PRB_fmt $tm]\]#3000=2(RAZMER MENSHE DOPUSKA)"
   }
   if {$wmode == "NONE"} {
      PRB_out "(TOLKO IZMERENIE)"
   } elseif {[lrange $tw 0 1] ne [lrange $mw 0 1]} {
      # target offset != move offset: #185/#186 are in move CS, so set
      # target absolutely: target_A = move_A + #186 (machine value, #187)
      lassign $mw mL mP
      if {$mL == 20} {set sv [expr {7001+20*($mP-1)+$ix}]} else {set sv [expr {5221+20*($mP-1)+$ix}]}
      PRB_out "#187=#$sv (SKS DVIZHENIYA $A)"
      PRB_out "G90 G10 L[lindex $tw 0] P[lindex $tw 1] $A\[#187+#186\]"
      PRB_force_mode
   } else {
      PRB_shift [lrange $tw 0 1] [list [list $A 186]]
   }
   set ::prb_move_fvar 170
}

#---------------- UDE prb_z_point (probe_omp.cdl) --------------------------
# single Z touch from above at one NX point (top face), G10 shift of Z.
# Same style / fields / state as UDE prb_center_axis (#170 touch feed,
# #172 move feed, #171 W, M60/M61, PRB_on/PRB_off pairing per operation).
# Machine vars: #183 measured Z, #186 shift, #187 machine Z (other CS).
# Option detection (NX passes Russian TYPE o values re-decoded):
#   prb_zp_zmode   : "Po tochke" = 8 chars, "Zadat" = 6 chars
#   others         : as prb_center_axis (move_cs 11, write_cs 13/2sp|13/1sp,
#                    tol_on Net 3 / Da 2, probe_sw 9/2/3, m60 Da 2 / Net 3)
proc MOM_prb_z_point { } {
   PRB_tag ENTER_PRB_Z_POINT
   if {$::prb_omp_debug} {
      foreach v [lsort [info globals mom_prb_zp_*]] {
         upvar #0 $v val
         if {[array exists val]} {
            set s "" ; foreach k [lsort [array names val]] {append s " $k=$val($k)"}
         } else {set s " $val"}
         PRB_out "(DBG UDE $v:[string map {( [ ) ] & + # N} $s])"
      }
   }
   if {[info exists ::mom_command_status]} {
      if {[string match -nocase "*inactive*" $::mom_command_status]} return
   }
   # ---- checks first, no motion on any error
   set fo 0
   if {[info exists ::mom_fixture_offset_value] && [string is double -strict $::mom_fixture_offset_value]} {
      set fo [expr {int($::mom_fixture_offset_value)}]
   }
   # -- move CS
   set mcs "" ; if {[info exists ::mom_prb_zp_move_cs]} {set mcs [string trim $::mom_prb_zp_move_cs]}
   set mw [PRB_ca_cs $mcs mom_prb_zp_move_p]
   set mop 0
   if {$mw == "ERRP"} {PRB_ude_err "P G54.1 DVIZH VNE 1..48" ; return}
   if {$mw == ""} {
      if {$mcs == "" || [PRB_opt_is $mcs Operation "\u0418\u0437 \u043e\u043f\u0435\u0440\u0430\u0446\u0438\u0438"] || [string length $mcs] == 11} {
         set mop 1
         set ::prb_wcs_override ""
         if {$fo != 0} {set mw [PRB_wcs]}
      }
   }
   # -- write target
   set wcs "" ; if {[info exists ::mom_prb_zp_write_cs]} {set wcs [string trim $::mom_prb_zp_write_cs]}
   set wcsl [string length $wcs] ; set wsp [PRB_ca_spaces $wcs]
   set tw [PRB_ca_cs $wcs mom_prb_zp_write_p]
   set wmode ""
   if {$tw == "ERRP"} {PRB_ude_err "P G54.1 ZAPIS VNE 1..48" ; return}
   if {$tw != ""} {
      set wmode CS
   } elseif {$wcs == "" || [PRB_opt_is $wcs MoveCS "\u0412 \u0421\u041a \u0434\u0432\u0438\u0436\u0435\u043d\u0438\u044f"] || ($wcsl == 13 && $wsp == 2)} {
      set wmode MOVE
   } elseif {[PRB_opt_is $wcs None "\u041d\u0435 \u0437\u0430\u043f\u0438\u0441\u044b\u0432\u0430\u0442\u044c"] || ($wcsl == 13 && $wsp == 1)} {
      set wmode NONE
   }
   if {$mw == ""} {
      if {$mop} {PRB_ude_err "NET SKS"} else {PRB_ude_err "NEVERNAYA SK DVIZHENIYA"}
      return
   }
   if {$wmode == ""} {PRB_ude_err "NEVERNAYA SK ZAPISI" ; return}
   if {$wmode == "MOVE"} {set tw $mw}
   # -- point
   set p [PRB_ude_xyz prb_zp_point]
   if {![llength $p]} {PRB_ude_err "NET TOCHKI" ; return}
   lassign $p x y pz
   # -- nominal Z: "Po tochke" (8) = Z of the NX point, "Zadat" (6) = field
   set zm "" ; if {[info exists ::mom_prb_zp_zmode]} {set zm [string trim $::mom_prb_zp_zmode]}
   set zset [expr {[PRB_opt_is $zm Set "\u0417\u0430\u0434\u0430\u0442\u044c"] || [string length $zm] == 6}]
   if {$zset} {set nom [PRB_num mom_prb_zp_znom $pz]} else {set nom $pz}
   set off [PRB_num mom_prb_zp_offset 0.0]
   # -- size (height) check
   set ton "" ; if {[info exists ::mom_prb_zp_tol_on]} {set ton [string trim $::mom_prb_zp_tol_on]}
   set tol [expr {[PRB_opt_is $ton Yes "\u0414\u0430"] || [string length $ton] == 2}]
   set tp  [expr {abs([PRB_num mom_prb_zp_tol_plus 0.1])}]
   set tm  [expr {abs([PRB_num mom_prb_zp_tol_minus 0.1])}]
   set so [PRB_num mom_prb_zp_standoff $::prb_standoff]
   if {$so <= 0.001} {set so $::prb_standoff}
   set zs [PRB_num mom_prb_zp_zsafe $::prb_zsafe]
   set za [expr {$nom + $so}]
   if {$zs < $za + 1.0} {PRB_ude_err "Z BEZOP NIZHE PODVODA" ; return}
   if {$::prb_omp_debug} {
      PRB_out "(DBG UDE ZP MW=$mw TW=$tw MODE=$wmode ZMODE LEN=[string length $zm] SET=$zset NOM=$nom OFF=$off TOL=$tol)"
   }
   # -- feeds
   set f [PRB_num mom_prb_zp_feed ""]
   if {$f != "" && $f > 0} {set ::prb_feed $f}
   set mf [PRB_num mom_prb_zp_move_feed 3000.0]
   if {$mf == "" || $mf <= 0} {set mf 3000.0}
   set ::prb_move_feed $mf
   set ::prb_move_fvar 172
   if {$::prb_on_state} {
      PRB_out "#170=[PRB_fmt $::prb_feed] (PODACHA KASANIYA)"
      PRB_out "#172=[PRB_fmt $mf] (PODACHA PEREMESHCHENIYA)"
   }
   # -- probe switch / M60
   set sw "" ; if {[info exists ::mom_prb_zp_probe_sw]} {set sw [string trim $::mom_prb_zp_probe_sw]}
   set swl [string length $sw]
   if {[PRB_opt_is $sw Yes "\u0414\u0430"] || $swl == 2} {
      set ::prb_sw_override 1
   } elseif {[PRB_opt_is $sw No "\u041d\u0435\u0442"] || $swl == 3} {
      set ::prb_sw_override 0
   } else {
      set ::prb_sw_override ""
   }
   set m6 "" ; if {[info exists ::mom_prb_zp_m60]} {set m6 [string trim $::mom_prb_zp_m60]}
   if {[PRB_opt_is $m6 Yes "\u0414\u0430"] || [string length $m6] == 2} {
      set ::prb_m60_override 1
   } elseif {[PRB_opt_is $m6 No "\u041d\u0435\u0442"] || [string length $m6] == 3} {
      set ::prb_m60_override 0
   } else {
      set ::prb_m60_override ""
   }
   # ---- motion
   set ::prb_wcs_override $mw
   if {!$::prb_g43_done && !$::prb_need_g43 && !$::prb_on_state} {
      set h $::prb_h
      if {[info exists ::mom_tool_number] && [string is integer -strict $::mom_tool_number] && $::mom_tool_number > 0} {set h $::mom_tool_number}
      foreach v {mom_tool_adjust_register mom_tool_length_adjust_register} {
         if {[info exists ::$v] && [string is double -strict [set ::$v]] && [set ::$v] > 0} {set h [expr {int([set ::$v])}]}
      }
      set ::prb_h_cur $h
      set ::prb_need_g43 1
      set ::prb_last(x) "" ; set ::prb_last(y) "" ; set ::prb_last(z) ""
      PRB_tag "UDE ARM G43 H$h"
   }
   if {![PRB_first_pos $x $y $zs]} {
      PRB_ensure_on
      PRB_movez $zs
      PRB_out "G90 G00 [PRB_ca_cstext $mw]"
      PRB_out "#171=[PRB_fmt [lindex $mw 2]] (NOL W)"
      set ::prb_last(x) "" ; set ::prb_last(y) "" ; set ::prb_last(z) ""
      PRB_move $x $y $zs
   }
   PRB_out "#183=#0"
   PRB_out "#186=#0"
   PRB_movez $za
   PRB_out "G65 P9103 Z[PRB_fmt $nom]"
   PRB_out "#183=#103"
   set ::prb_last(z) ""
   PRB_movez $zs
   PRB_out "#186=#183[PRB_sub $nom]"
   PRB_out "(Z = #183, SDVIG = #186)"
   # ---- height check BEFORE writing: alarm stops the program, nothing written
   if {$tol} {
      PRB_out "(NOM Z [PRB_fmt $nom] +[PRB_fmt $tp] -[PRB_fmt $tm])"
      PRB_out "IF\[#186GT[PRB_fmt $tp]\]#3000=1(Z VYSHE DOPUSKA)"
      PRB_out "IF\[#186LT-[PRB_fmt $tm]\]#3000=2(Z NIZHE DOPUSKA)"
   }
   if {abs($off) > 0.0005} {
      if {$off < 0} {set os "-[PRB_fmt [expr {-$off}]]"} else {set os "+[PRB_fmt $off]"}
      PRB_out "#186=#186$os (DOP SMESHCHENIE)"
   }
   if {$wmode == "NONE"} {
      PRB_out "(TOLKO IZMERENIE)"
   } elseif {[lrange $tw 0 1] ne [lrange $mw 0 1]} {
      lassign $mw mL mP
      if {$mL == 20} {set sv [expr {7001+20*($mP-1)+2}]} else {set sv [expr {5221+20*($mP-1)+2}]}
      PRB_out "#187=#$sv (SKS DVIZHENIYA Z)"
      PRB_out "G90 G10 L[lindex $tw 0] P[lindex $tw 1] Z\[#187+#186\]"
      PRB_force_mode
   } else {
      PRB_shift [lrange $tw 0 1] {{Z 186}}
   }
   set ::prb_move_fvar 170
}
