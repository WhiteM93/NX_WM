lappend lib_config_data		[list "ctrl_template_base" "Ctrl_Template_Base-Version 191"]
set lib_controller_type 	"TEMPLATE"
set lib_controller_message	"template"
set lib_controller_display_name $lib_controller_type
####C#O#P#Y#R#I#G#H#T########################################################################
#
#	Copyright 2014-2024 Siemens Product Lifecycle Management Software Inc.
#				All Rights Reserved.
#
####S#T#A#R#T##C#H#A#N#G#E##H#I#S#T#O#R#Y####################################################
#
#	Last changes:	09.02.2019 - TJ  001 Initial Release and Installation
#			16.03.2019 - UR  002 Releaseversion 4.6.3
#			28.03.2019 - COE 003 LIB_SPF_set_initial_globals_LIB: do not set  mom_kin_linearization_tol, this is a unit dependent setting now
#			28.03.2019 - COE 004 Releaseversion 4.7
#			11.04.2019 - HES 005 Bug #1746: Circle output with radius. With mom_pos_arc_axis we dont need an MTX3_vec_multiply with oper_mcs_matrix
#			11.04.2019 - UR  006 Releaseversion 4.7.1
#			15.04.2019 - HES 007 Bug #1748 Implement a property for decompose first move in turning. Also for the order a property was defined. Default value "Y Z X" 
#					     HISTORY->Implement a property for decompose first move in turning<-
#			18.04.2019 - UR  008 Releaseversion 4.7.2
#			30.04.2019 - GB  009 Bug #1759: check lib_flag(local_namespace_output) is set to 1 when property [CONF_CTRL_setting fix_on_machine] is used
#			07.05.2019 - UR  010 Releaseversion 5.0
#			20.05.2019 - GB  011 Update LIB_CTRL_unclamp_axis with correct buffer name
#					     LIB_CTRL_polar_transmit: unclamp rotary axis when polar mode is activated
#			20.05.2019 - GB  012 Bug #1772: Fix missing parametric feedrate output when previous operation is drilling with same tool in LIB_CTRL_set_feed_parameter
#           		28.05.2019 - ET  013 Bug #1730: added new procedure for asking the x_factor LIB_SPF_check_x_factor
#           		06.06.2019 - HES 014 Bug #1775: Output F parameter definition for Engage/Retract in Drilling mode. Force F after MOM_do_template cycle_feed_mode CREATE
#           		17.06.2019 - GB  015 Bug #1796: LIB_update_tool_change_template: add call LIB_CHECK_adjust_register
#			20.05.2019 - LL  016 Fix tap cycle feed rate mode output issue in LIB_CYCLE_tap_set
#			20.06.2019 - HES 017 Bug #1786: Add new property to define the motions which are output in polar mode.
#			08.07.2019 - UR  018 Releaseversion 5.0.1
#			25.07.2019 - GB  019 Bug #924: fix problem in LIB_CTRL_nc_header
#			31.07.2019 - UR  020 Releaseversion 5.0.2
#			16.08.2019 - COE 021 Releaseversion 5.0.3
#			13.08.2019 - ZHX 022 Replace negative rapid_to by clearance_plane to keep safety distance in Cycle.
#			20.08.2019 - COE 023 'CONF_CTRL_moves polar_allowed_moves' changed default value to "ALL" (X+ was no valid option)
#			21.08.2019 - COE 024 Releaseversion 5.1.0
#			22.08.2019 - HES 025 Bug #1845: Fix Problem when Cycle parametric output is set to %CUT and when feed_mode is "MMPR"
#			06.09.2019 - LL  026 PR9554274: Fix in MOM_end_of_path_LIB, output reset simutaneous mode.
#			16.09.2019 - LL  027 PR9556171: Fix max_rpm output issue.
#			20.09.2019 - COE 028 merge library
#			20.09.2019 - COE 029 Releaseversion 5.2.0
#			10.10.2019 - GB  030 Bug #1874: Update first motion for turning (MOM_rapid_move_LIB and MOM_linear_move_LIB procedures)
#			17.10.2019 - GB  031 Bug #1881: LIB_SPINDLE_start: in milling, spindle output is done directly when it's coming from MOM_spindle_rpm event 
#			17.10.2019 - ET  032 HISTORY->Added mom_feedrate_mode in LIB_CTRL_config_turbo and mom_sys_turbo_global_add_vars_list now it is possible to switch in one operation from mmpm to mmpr<- (Bug #1906)
#			06.11.2019 - UR  033 Releaseversion 5.2.3
#			26.11.2019 - HES 034 Bug #1934: Consider new mom variable mom_spindle_startup_status in LIB_CTRL_handle_cycle_check
#			04.12.2019 - HES 035 Set variable mom_spindle_startup_status global
#			09.11.2019 - GB  036 With "3_AXIS_MILL_TURN" machine type, enable / disable Y address for transmit mode
#			10.11.2019 - GB  037 Bug #1944: MOM_start_of_program_LIB: separate LIB_SPF_program_header_comment to LIB_SPF_sub_header_comment
#					     LIB_CHECK_adjust_register: buffer added
#			25.11.2019 - LL  038 Enable mom_sys_post_output_subprogram_enabled
#			                     Change decompose_first_move_turn default value to 0
#			27.12.2019 - UR  039 Releaseversion 5.2.4
#			31.01.2020 - COE 040 Releaseversion 5.2.5
#			25.02.2020 - UR  041 Merge library form CN - remove MOM_transition_move_LIB
#			02.03.2020 - UR  042 Releaseversion 5.2.6
#			18.03.2020 - HES 043 Bug #1996: Consider new feedrate and spindle speed definition in the NCM_engage of adaptive milling
#                                            The feedrate will be output as %cut of mom_feed_engage_value.
#                                            Only needed when Parametric Feed is enabled
#                                            HISTORY->Handle additional engage feed and speed values for Adaptive Milling. 
#			03.03.2020 - GYQ 044 Fix PR#8436887
#			19.03.2020 - COE 045 Releaseversion 5.2.7
#			23.03.2020 - HES 046 For cycle feedrate definition remove %CUT in property setting (feed_cycle)
#			25.03.2020 - COE 047 Releaseversion 5.3.0
#			21.04.2020 - GB  048 Bug #1997: LIB_CTRL_polar_transmit. Check if operation is not turning
#			30.04.2020 - COE 049 Sync changes from Shanghai team (changes for NX1926 release) see LIB_CTRL_set_3P2_rotate_dir
#			01.07.2020 - COE 050 Releaseversion 5.3.1
#			25.06.2020 - LL  05x cam20048.2.3 preferred solution, update LIB_CTRL_set_3P2_rotate_dir and LIB_CSYS_plane_output_init
#			01.07.2020 - HZ  051 Remove function LIB_SPF_calc_4th5th_axis_points for local namespace in MOM_set_csys_LIB
#			09.07.2020 - COE 052 Releaseversion 5.3.2
#			12.08.2020 - HES 053 Bug #2078: Parametric feed output wrong if approach feed is not rapid
#                                            Bug #2077: Insert Tool Change in MOM_end_of_program.
#                                            HISTORY-> Trigger tool change in end of program. Switches (Off/"0"/"any Number or Name")
#			06.08.2020 - XXX 05x cam20063.4: Remove approach and retract motion for GMC under device
#			13.08.2020 - XXX 054 PR9857932: Use advanced callback function to output parameterized feed value
#			06.09.2020 - COE 055 Releaseversion 5.3.3
#			15.09.2020 - COE 056 Releaseversion 5.3.4
#			19.08.2020 - XXX 05x PR#9710865: Add LIB_SPF_last_rapid_pos
#			20.08.2020 - XXX 05x PR9861902: Output parameterized feed value if second operation changes engage and retract feed setting
#			25.09.2020 - COE 057 Merge Changes
#			26.09.2020 - COE 058 Releaseversion 5.3.5
#			05.10.2020 - LL  059 Fix LIB_SPF_first_tool_path_motion_sim for local_namespace on.
#			26.11.2020 - COE 060 Releaseversion 5.3.6
#			06.11.2020 - ET  061 add property prepos_before_transmit and additional changes in LIB_CTRL_polar_transmit, update Description on x_factor_mill 
#                                            add property subprogram_output and variables for Block Template mom_sys_start_of_subprogram mom_sys_end_of_subprogram
#                                            add commandcheck for LIB_CTRL_sub_header in MOM_start_of_program_LIB and remove double output from LIB_SPF_program_header_comment
#                                            add logic when LIB_GE_commandbuffer_is_customized in MOM_rapid_move_LIB/MOM_linear_move_LIB/MOM_circular_move_LIB with OUTPUT_SINGLE
#                                            add ENTRY Points for MOM_lathe_thread_LIB MOM_start_of_thread_LIB MOM_end_of_thread_LIB MOM_start_of_transition_path_lib MOM_end_of_transition_path_lib
#                                            add ENTRY Point MOM_lathe_thread_move_LIB @MOVE
#                                            add proc MOM_machine_axis_move_LIB
#			14.12.2020 - GB  062 Bug #2161: MOM_first_move_LIB: LIB_main_origin_call call required when mom_fixture_offset_value is different
#			14.12.2020 - ET  063 Bug #2166: call CONF_Turbo_Templates circular_template_turbo in MOM_circular_move_turbo_LIB
#			24.01.2021 - COE 064 Bug #2046: Feedrate unit issue in MillTurn Setup. Changed defautl value for 
#							mom_sys_contour_feed_mode(LINEAR) , mom_sys_rapid_feed_mode(LINEAR) and mom_sys_cycle_feed_mode to "AUTO"
#							This change is only valid for postprocessors created with lib versions starting from 5.3.7.
#							On update of existing postprocessors the values won't be changed!
#							HISTORY->Fixed a problem that caused in some cases feedrate unit inconsistency in a mill turn setup<-
#			24.01.2021 - COE 065 Releaseversion 5.3.7
#			27.01.2021 - HES 066 Bug #2184: Use Cycle parameter in the definition when machine cycle is used in Mill_hole and Mill_hole_thread
#			27.01.2021 - YD  06x PR9942355: Fix incorrect output with tcpm off and advanced turbo mode
#			27.01.2021 - HZ  06x Add LIB_SPF_check_arc_radius in LIB_CIRCLE_set
#			02.02.2021 - HZ  06x Add LOCAL_CSYS_INIT and LOCAL_CSYS_RESET buffer tags
#			02.02.2021 - LL  06x NX1980: replace mom_mcsname_attach_opr to mom_output_mcs_name for use inherited MCS, update ctrl_ini_get_mcs_info
#			06.02.2021 - COE 067 Merge Changes
#			06.02.2021 - COE 068 Releaseversion 5.3.8
#			10.02.2021 - ET  069 Bug #2155: LIB_CTRL_config_turbo when mom_kin_arc_output_mode "FULL_CIRCLE" set mom_sys_circular_turbo_command "TRUE" in any case
#			23.02.2021 - GB  070 LIB_SPF_check_cutcom_condition: check mom_cutcom_status before to generate warning message
#                       25.02.2021 - HES 071 Bug #2212: Output parameter feedrate definition after P2P operation
#                       12.03.2021 - HES 072 Bug #2217: Parametric feedrate changes in "LIB_CTRL_feed_output"
#                                                       do not calc percent if feed is equal to mom_kin_rapid_feed_rate
#					                remove global setting of varible tmp_motion_type and percent
#                                                       align all controllers
#                                            HISTORY->  Parametric feed output works now also if retract feed is changed
#			24.02.2021 - Add warning for not supported hole milling and thread milling subprograms
#			15.03.2021 - COE 073 Releaseversion 5.3.9
#			26.03.2021 - GB  074 LIB_SPF_first_tool_path_motion_sim: [CONF_CTRL_setting tcpm_output_supported] checked before to call LIB_SPF_KINEMATICS_set_simultanous_kin
#			16.03.2021 - Fix MOM_first_move_LIB for mom_output_mcs_name check.
#			16.03.2021 - Fix MOM_circular_move_turbo_LIB LIB_CIRCLE_set for full circle with local namespace on.
#			20.03.2021 - Fix polar not output when first operation is turning operation in MOM_end_of_path_LIB
#			09.04.2021 - COE 075 Merge changes
#			13.04.2021 - Compare last tool axis of current operation with first tool axis of next operation for reset rotary axis
#			13.04.2021 - COE 076 Releaseversion 5.4.0
#			15.04.2021 - COE 077 implemented 'CONF_CTRL_feed feed_crossover'
#			15.04.2021 - ET  078 Bug #2232: added option "2" in CONF_CTRL_clamp status UDE based output for clamping
#			05.05.2021 - ET  079 Bug #2251: add info exists mom_cycle_feed_rate_per_rev for turning mode
#			05.05.2021 - COE 080 Merge changes
#			07.05.2021 - HZ  081 Arc angle 360.0 and 180.0 only support arc output with IJK in LIB_CIRCLE_set
#			18.05.2021 - COE 082 PR10051724: do not allow chain specific definition of 'CONF_CTRL_setting local_ns_output'
#			25.05.2021 - HES 083 PR#10065809: Suppress LIB_CTRL_parameter_definition for subprogram
#			01.06.2021 - COE 084 Bug#2242: enhance LIB_CTRL_config_turbo in order to be able to use new command LIB_SPF_modif_turbo_block_dynamic
#						LIB_SPF_check_cutcom_condition: output warning instead of error message
#			02.06.2021 - COE 085 Releaseversion 5.4.1
#			16.06.2021 - HES 086 Bug#2282: Output of Parametric feed definition only once at the beginning of a program (Change LIB_CTRL_set_feed_parameter)
#			28.06.2021 - ET 087 #Bug2264: undo Implementation PR#10065809
#			16.06.2021 - XY 08x Support transition path in MOM_start_of_subop_path_LIB and MOM_end_of_subop_path_LIB
#			18.07.2021 - COE 088 Merge changes
#			20.07.2021 - HES 089 Bug #2301: Thread Milling Parametric Feedrates Cut Feed is missing
#			21.07.2021 - COE 090 Releaseversion 5.4.2
#			26.07.2021 - ET  091 Bug #2278: allow decimal places for feed output when tap cycle
#			13.08.2021 - XY  092 PR#10024940: calculate mom_spindle_preset_rpm for SFM in LIB_SPINDLE_start
#			31.08.2021 - GB  093 Bug #2318: Update proc LIB_CTRL_standard_path_between_rotary_motions_checking with prev_convert_mom_out_angle_pos variable
#			03.09.2021 - COE 094 Releaseversion 5.4.3
#			06.08.2021 - HES 095 Add Properties and procedures to output an initial state in the start of program
#                                            HISTORY-> add property to output an initial state in the start of program<-
#			07.09.2021 - COE 096 Releaseversion 5.4.4
#			13.09.2021 - GB  097 Add MOM_start_of_merged_path_LIB procedure with conventional entry points
#			15.09.2021 - HES 098 Bug #2333 Post does not output the correct Diff_Radius DR - LIB_calc_lib_cutcom_radius LIB_unset_variables_in_end_of_path
#                                            Bug #2334 Post abort if Feedrate output is set to Parameter and motion engage,cut or retract is set to RAPID  LIB_CTRL_feed_output
#			20.09.2021 - GB  099 Add new property [CONF_CTRL_setting cutcom_on_alone]
#			15.09.2021 - ET  100 Bug #2327 LIB_SPF_retract_to_pos overwrites mom_cycle_retract_to from previous Operation unset lib_last_rapid_pos
#			28.09.2021 - XY  10x Output csys rotation angles with spatial mode in LIB_CSYS_plane_output_init
#			29.09.2021 - COE 101 Merge Changes
#			29.09.2021 - COE 102 Releaseversion 5.5.0
#			05.10.2021 - HES 103 Bug #2327: Parametric feedrate output for traverse move is now correct
#			13.10.2021 - GB  104 Bug #2328: Add MOM_end_of_merged_path_LIB procedure with conventional entry points
#			25.10.2021 - COE 105 Releaseversion 5.5.1
#			18.11.2021 - ET  106 Bug #2354: allow to define a Custom_Value for property x_factor, add property i_factor for mill/turn 
#			24.11.2021 - COE 107 Releaseversion 5.5.2
#			17.11.2021 - XY  10x PR10206897: Check if adjust register from operation is defined in tool data
#			12.01.2022 - XY  10x MFEC-19403: change mom_sys_output_transition_path to 1 
#			18.02.2022 - COE 108 Merge Changes
#			19.02.2022 - COE 109 Releaseversion 5.5.3
#			03.03.2022 - GB  110 Bug #2318: Update proc LIB_CTRL_standard_path_between_rotary_motions_checking
#					     LIB_CTRL_KINEMATICS_set_simultanous_kin: restore previous status for arc output after : LIB_GE_copy_var_range mom_kin lib_sav_kin
#			06.03.2022 - COE 111 Bug #2364: only activate plane kinematics related 4th and 5th axis leaders if plane is really active
#					     Bug #2395: set default value of mom_sys_output_transition_path only to 1 if $pc_initial_library_release_of_post >= 50503
#			06.03.2022 - COE 112 Releaseversion 5.5.4
#			11.03.2022 - COE 113 Bug #2392: solve problem where 'CONF_CTRL_moves set return_end_of_pgm {4th5th}' did not work as expected in combination
#						with a local origin with different orientation tham main MCS (proc LIB_RETURN_move)
#			15.03.2022 - ET  114 Bug #2124: suppress M_coolant in first move when coolnt_output_before_motion == 2
#			15.02.2022 - XY  11x Add Additive group and handlers
#			21.02.2022 - XY  11x MFEC-19397 Add Additive CoolingTime handler
#			02.03.2022 - XY  11x PR10245457: Output polar rotary axis leader according to machine type in LIB_CTRL_polar_transmit
#			06.04.2022 - COE 115 Merge changes
#			08.04.2022 - COE 116 Releaseversion 5.5.5
#			07.04.2022 - XY  11x PR10296287, PR9905967, PR10168506: Fix sign of U/W and sequence numnber output in turn cycle.
#			28.04.2022 - XY  11x PR10315801: Output machine limit move subop in MOM_transition_rapid_move_LIB
#			11.05.2022 - ET  117 Bug #2424: First spindle orientation is missing during Back Counter Sinking
#			07.07.2022 - COE 118 Merge changes
#			11.07.2022 - COE 119 Bug #2364: LIB_CSYS_plane_output_init: add LIB_SPF_convert_point "real" before LIB_rotate_axis_before_plane
#			13.07.2022 - COE 120 Releaseversion 5.5.6
#			28.07.2022 - HES 121 Bug #2446: Abort message if "Rotate Axis before Plane Output"is on and "Local Namespace Output"] is off and "Preferred Solution" is on.
#                                            in MOM_convert_point "Preferred Solution" is not covered.
#			28.07.2022 - GB  122 Bug #1580: property [CONF_CTRL_spindle spindle_preset_rpm_output_always] is added
#			03.08.2022 - ET  123 Bug #2402: Option to skip LIB_SPF_check_adjust_register
#         		09.08.2022 - FSY 12x add "lib_3d_rot_method" for rotate method
#			26.08.2022 - HES 124 Bug #2285: Handle Rapid Feed in Engage or retract when output is set to parameter
#                                            Enhance mostly all motion types to work with parameter.
#                                            HISTORY-> Parameter feed output is now possible for most motion types <-
#                                            HISTORY-> Only if parameter feed output is defined for an motion type then it is output in the definition block <-
#			05.09.2022 - HES 125 Add motion type lastcut to the feed definition property
#			06.09.2022 - ET  126 Bug #2460: add missing mom_output_pos_type in LIB_ROTARY_simultaneous_init
#				   - ET  127 Bug #2467: fix problem with arc output when always_center_for_circle is 0
#			07.09.2022 - COE 128 fixed typo in LIB_CTRL_set_feed_parameter
#			07.09.2022 - COE 129 Releaseversion 5.5.7
#			08.09.2022 - ET  130 add Buffer POLAR_TRANSMIT in LIB_ROTARY_absolute_init
#			12.09.2022 - HES 131 Bug #2461: Add property for block_form
#                                            HISTORY-> Add property and an example when set Blockform to on <-
#			15.09.2022 - GB  132 Bug #2465: Fix LIB_CIRCLE_set to force output X,Y or Z addresses for circular and helix moves.
#			15.09.2022 - GB  133 Bug #2474: Option "X" added for [CONF_CTRL_moves return_before_first_tool_change_pos], [CONF_CTRL_moves return_tool_change_pos], 
#						[CONF_CTRL_moves return_safety_pos] and [CONF_CTRL_moves return_end_of_pgm]
#			23.09.2022 - COE 134 Merge changes
#			23.09.2022 - COE 135 Bug #2214: default setting 'CONF_SPF_file set ctrl_ini_location Part_NoSubProgFolder' if pc_initial_library_release_of_post > 50507
#					     Changed description of 'CONF_CTRL_setting lib_3d_rot_method'
#			24.09.2022 - COE 136 Releaseversion 5.5.8
#			30.09.2022 - XY  13x Fix typo
#			26.10.2022 - XY  13x add LIB_CTRL_check_absolute_output
#			21.11.2022 - ET  137 Bug #2491: move LIB_CHECK_tool_number to lib_standard_post_func
#			21.12.2022 - ET  138 Bug #2469: check if mom_cycle_definition_mode exists for NX12 and older version
#			08.12.2022 - XY  13x add enable_hole_making_combine_rotary, combine_tolerance
#			16.12.2022 - XY  13x MFEC-32938: Local Namespace Output should be ON as default
#			19.12.2022 - XY  13x Add property enable_polar_with_plane
#			15.01.2023 - COE 139 Merge changes
#			15.01.2023 - COE 140 Releaseversion 23.01.0
#			20.02.2023 - FSY 14x Remove mom_kin_4th_axis_point, mom_kin_5th_axis_point
#						 Add mom_kin_4th_axis_point_inch, mom_kin_4th_axis_point_metric, mom_kin_5th_axis_point_inch, mom_kin_5th_axis_point_metric
#			21.02.2023 - XY  141 MFEC-30223: Add NX version check for rotary angles output with local namespace off in LIB_CSYS_plane_output_init
#			08.03.2023 - FSY 14x modify UI strings to avoid translation errors
#			14.03.2023 - COE 142 Releaseversion 23.03.0
#			07.04.2023 - COE 143 Merge changes
#			07.04.2023 - COE 144 Releaseversion 23.04.0
#			26.04.2023 - ET  145 Bug #2522: fix param feedrate wrong comment declaration
#			09.05.2023 - FSY 14x PR#8642219, add LIB_CTRL_polar_with_local_csys
#			31.05.2023 - ET  146 Bug #2559: add property param_feed_dspa1/param_feed_dspz1 to declare leader and trailer for param feed
#						HISTORY-> Param Feed declaration is now same Value Format as without Param feedrate output <-¨
#           		14.06.2023 - XY  14x MFEC-36425 - SLED: fix Typo and against UI rules
#			14.07.2023 - COE 147 Merge Changes
#			14.07.2023 - COE 148 Releaseversion 23.07.0
#			09.08.2023 - XY  14x PR#10481348: Add LIB_CTRL_reset_csys_3d_rot_order
#			17.08.2023 - XY  149 Hide local namespace option in NC optimizer
#			18.08.2023 - Support arc radius for turbo in LIB_CTRL_configue_turbo
#			01.09.2023 - PR#10811275 using MOM_ask_group_info to get program group name in LIB_CTRL_nc_header
#                       02.09.2023 - Get turn_cycle_initial_pos from read ahead filter for turning, instead of from pretreatment
#			08.09.2023 - ET  150 Bug #1994: store the correct address expression in the correct template name
#			12.09.2023 - ET  151 Bug #2580: add more documentation to property header_name
#			14.09.2023 - COE 152 Releaseversion 23.09.0
#			14.09.2023 - COE 153 Releaseversion 23.09.0
#			21.09.2023 - HES 154 Bug #2552: Param feedrate output tooks the Cut Feed from previous Operation
#                                            Bug #2583: Output in Param Feed in MMPR even if MMPM is defined in PC
#                                                       This occurs in all controller (THN,S840,Fanuc,Okuma,Template)
#			09.10.2023 - ET  155 Bug #2551: add property rot_clamp_tolerance and check clamp status in MOM_before_motion
#			09.10.2023 - ET  156 Releaseversion 23.10.0
#			21.11.2023 - ET	 157 Bug #2294: PR#10801576 Initial rotary axis position of subsequent operation is incorrect
#			22.11.2023 - ET  158 Bug #2596: PR#10820392 add LIB_SPF_ignore_small_retract to consider safety_retract_before fourth_axis and fifth_axis change
#			04.12.2023 - ET	 159 Bug #2294: fix problem when property set to option OFF
#			06.12.2023 - FSY 15x MFEC-47593：Add linear axis limits option in PC library
#			10.12.2023 - COE 160 Releaseversion 23.12.0
#			10.01.2024 - JS  16x MFEC-46796: Add mom_sys_spindle_speed_init in global
#			16.01.2024 - ET	 161 Bug #2294: Parametric feedrate incomplete output
#			18.01.2024 - ET  162 Bug #2606: call LIB_SPF_last_rapid_pos also in linear_move when motion type is rapid	
#			19.01.2024 - COE 163 Releaseversion 24.01.0
#			19.01.2024 - FSY 16x MFEC-49222：set access($id) of "combine_tolerance" to 012
#			14.03.2024 - FSY 164 PR10809383: modify feedrate output when motion type is not "cut"
#			19.03.2024 - COE 165 Bug #2625 new default value for mom_sys_seqnum* variables to support UI properly
#			21.03.2024 - LL  166 Hide preferred solution if local namespace is off.
#			21.03.2024 - COE 167 Releaseversion 24.03.0
#			25.03.2024 - HZ  168 PR#10869250: Add option rot_axis_degenerated_sol_action to handle degenerated warning
#			23.04.2024 - QL  16x MFEC-49412: TCL enhancement in the case of 360Deg and 180Deg circles
#			30.05.2024 - QL  16x PR#12026492: When always_center_for_circle is On, the arc split options will be hided
#			03.06.2024 - ET  169 Bug #2475: change logic for rotate_before
#			04.06.2024 - ET  170 Bug #2636: add entry points for LIB_cycle_move
#			07.06.2024 - HZ  17x PR#12026680: Reset tool path motion in MOM_end_of_path_lib for NC optimizer
#			26.07.2024 - SJH 171 MFEC-55166: inconsistent M8 coolant code output :
#					unset the coolant mode in LIB_ROTARY_positioning_first_move to output coolant after motion
#					add @OUTPUT_COOLNT_TURN to TURN mode to enable before motion coolant output
#			30.07.2024 - QL  172 MFEC-56829: All library output lines use template block with output buffer
#			02.08.2024 - SJH 173 Add MOM_NC_start_of_program
#			13.08.2024 - COE 174 Releaseversion 24.08.0
#			22.08.2024 - COE 175 Releaseversion 24.08.1
#			23.08.2024 - ET  176 Bug #1927: add predeclaration of mom_sys_leader(S)
#			23.08.2024 - QL  177 PR#10748690: Reset the feed value when it exceeds the limit set in the post
#			28.08.2024 - ET  178 Bug #2648: spindle preset consider max spindle rpm depend on Operation and chain
#			29.08.2024 - ET  179 Bug #1524+2649: add custom procedure on property safety_motion_when_mcs_changes that devolpers can add his own logic
#			13.09.2024 - COE 180 MFEC-56468: Reset Rotary Axis for Each End of Path return 1 is not working
#			16.09.2024 - COE 181 Releaseversion 24.09.0
#			24.09.2024 - ET  182 MFEC-56468 change logic of Reset Rotary Axis
#			24.09.2024 - ET  183 Releaseversion 24.09.1
#			30.09.2024 - HZ  184 PR#12028813: Support MOM_post_oper_path for rough turning operation with machine cycle
#			19.11.2024 - HES 185 Bug #2669: Only for parametric feed output!.
#					     Cut feedrate is reduced to the maximum limit. The ratio to the cut feed is retained for the other motion feedrates
#					     Remove changes for PR10748690: This is done with setting the mom_sys_force_feedrate_limit_check to 1
#			08.11.2024 - LL  186 PR#11138314: move LIB_SPF_recalculate_cycle_pos in LIB_CYCLE_move
#			27.12.2024 - COE 187 Releaseversion 24.12.0
#			26.01.2025 - COE 188 Bug #2681 / PR#12054581 'CONF_CTRL_moves reset_rotary_axis_end_of_path' generate unwanted plane reset
#			19.03.2025 - ET  189 Bug #2693 Missing Plane when 2 opeartions same tool and same tool_axis but different MCS Orientation
#			20.03.2025 - ET  190 Bug #2675 wrong leader for Y Axis when polar_off_end_of_path is set to ON
#						 missing reset when next oper is drilling with same tool polar_transmit is set to "ON"
#			02.04.2025 - COE 191 Releaseversion 25.04.0
#
#
#
####E#N#D##C#H#A#N#G#E##H#I#S#T#O#R#Y########################################################

#############################################################################################
set lib_controller_file [lindex [lindex $lib_config_data end] 0]
if {[LIB_GE_lsearch_index $lib_pp_source_file 0 "${lib_controller_file}_msg"] < 0 && ![isset lib_msg(0000,$lib_controller_message,core)]} {
	set error [LIB_GE_source "${lib_controller_file}_msg"]
}

proc LIB_SPF_set_initial_globals_LIB {} {


	uplevel #0 {

		set mom_system_tolerance                      0.0000001
		set mom_sys_control_out                       "("
		set mom_sys_control_in                        ")"

		########## SYSTEM VARIABLE DECLARATIONS ##############
		set mom_sys_rapid_code                        "0"
		set mom_sys_linear_code                       "1"
		set mom_sys_circle_code(CLW)                  "2"
		set mom_sys_circle_code(CCLW)                 "3"
		set mom_sys_delay_code(SECONDS)               "4"
		set mom_sys_delay_code(REVOLUTIONS)           "4"
		set mom_sys_cutcom_plane_code(XY)             "17"
		set mom_sys_cutcom_plane_code(ZX)             "18"
		set mom_sys_cutcom_plane_code(XZ)             "18"
		set mom_sys_cutcom_plane_code(YZ)             "19"
		set mom_sys_cutcom_plane_code(ZY)             "19"
		set mom_sys_lathe_thread_advance_type(1)      "33"
		set mom_sys_lathe_thread_advance_type(2)      "34"
		set mom_sys_lathe_thread_advance_type(3)      "35"
		set mom_sys_cutcom_code(OFF)                  "40"
		set mom_sys_cutcom_code(LEFT)                 "41"
		set mom_sys_cutcom_code(RIGHT)                "42"
		set mom_sys_adjust_code                       "43"
		set mom_sys_adjust_code_minus                 "44"
		set mom_sys_adjust_cancel_code                "49"
		set mom_sys_unit_code(IN)                     "20"
		set mom_sys_unit_code(MM)                     "21"
		set mom_sys_cycle_start_code                  "79"
		set mom_sys_cycle_off                         "80"
		set mom_sys_cycle_drill_code                  "81"
		set mom_sys_cycle_drill_dwell_code            "82"
		set mom_sys_cycle_drill_deep_code             "83"
		set mom_sys_cycle_drill_break_chip_code       "73"
		set mom_sys_cycle_tap_code                    "84"
		set mom_sys_cycle_bore_code                   "85"
		set mom_sys_cycle_bore_drag_code              "86"
		set mom_sys_cycle_bore_no_drag_code           "76"
		set mom_sys_cycle_bore_dwell_code             "89"
		set mom_sys_cycle_bore_manual_code            "88"
		set mom_sys_cycle_bore_back_code              "87"
		set mom_sys_cycle_bore_manual_dwell_code      "88"
		set mom_sys_output_code(ABSOLUTE)             "90"
		set mom_sys_output_code(INCREMENTAL)          "91"
		set mom_sys_cycle_ret_code(AUTO)              "98"
		set mom_sys_cycle_ret_code(MANUAL)            "99"
		set mom_sys_reset_code                        "92"
		set mom_sys_feed_rate_mode_code(FRN)          "93"
		set mom_sys_spindle_mode_code(SFM)            "96"
		set mom_sys_spindle_mode_code(RPM)            "97"
		set mom_sys_spindle_max_rpm_code              "92"
		set mom_sys_spindle_cancel_sfm_code           "97"
		set mom_sys_return_code                       "28"
		set mom_sys_feed_rate_mode_code(DPM)          "94"
		set mom_sys_feed_rate_mode_code(IPM)          "94"
		set mom_sys_feed_rate_mode_code(IPR)          "95"
		set mom_sys_feed_rate_mode_code(MMPM)         "94"
		set mom_sys_feed_rate_mode_code(MMPR)         "95"
		set mom_sys_polar_mode(ON)                    "112"
		set mom_sys_polar_mode(OFF)                   "113"
		set mom_sys_program_stop_code                 "0"
		set mom_sys_optional_stop_code                "1"
		set mom_sys_end_of_program_code               "2"
		set mom_sys_start_of_subprogram               "98"
		set mom_sys_end_of_subprogram                 "99"
		set mom_sys_spindle_direction_code(CLW)       "3"
		set mom_sys_spindle_direction_code(CCLW)      "4"
		set mom_sys_spindle_direction_code(OFF)       "5"
		set mom_sys_spindle_orient_code               "19"
		set mom_sys_tool_change_code                  "6"
		set mom_sys_coolant_code(ON)                  "8"
		set mom_sys_coolant_code(FLOOD)               "8"
		set mom_sys_coolant_code(MIST)                "7"
		set mom_sys_coolant_code(THRU)                "26"
		set mom_sys_coolant_code(TAP)                 "27"
		set mom_sys_coolant_code(AIR)                 "7"
		set mom_sys_coolant_code(AIRTHRU)             "26"
		set mom_sys_coolant_code(OFF)                 "9"
		set mom_sys_tap_rigid_code                    "29"
		set mom_sys_rewind_code                       "30"
		set mom_sys_unclamp_code_fourth               "10"
		set mom_sys_clamp_code_fourth                 "11"
		set mom_sys_unclamp_code_fifth                "50"
		set mom_sys_clamp_code_fifth                  "51"
		set mom_sys_4th_axis_has_limits               "1"
		set mom_sys_5th_axis_has_limits               "1"
		set mom_sys_sim_cycle_drill                   "0"
		set mom_sys_sim_cycle_drill_dwell             "0"
		set mom_sys_sim_cycle_drill_deep              "0"
		set mom_sys_sim_cycle_drill_break_chip        "0"
		set mom_sys_sim_cycle_tap                     "1"
		set mom_sys_sim_cycle_bore                    "0"
		set mom_sys_sim_cycle_bore_drag               "0"
		set mom_sys_sim_cycle_bore_nodrag             "0"
		set mom_sys_sim_cycle_bore_manual             "0"
		set mom_sys_sim_cycle_bore_dwell              "0"
		set mom_sys_sim_cycle_bore_manual_dwell       "0"
		set mom_sys_sim_cycle_bore_back               "0"
		set mom_sys_cir_vector                        "Vector - Arc Start to Center"
  		set mom_sys_helix_pitch_type                  "rise_revolution"
		set mom_sys_spindle_ranges                    "9"
		set mom_sys_rewind_stop_code                  "\#"
		set mom_sys_zero                              "0"
		set mom_sys_opskip_block_leader               "/"
		set mom_sys_seqnum_start                      "-1"
		set mom_sys_seqnum_incr                       "-1"
		set mom_sys_seqnum_freq                       "-1"
		set mom_sys_seqnum_max                        "-1"
		set mom_sys_lathe_x_double                    "1"
		set mom_sys_lathe_i_double                    "1"
		set mom_sys_lathe_y_double                    "1"
		set mom_sys_lathe_j_double                    "1"
		set mom_sys_lathe_x_factor                    "1"
		set mom_sys_lathe_y_factor                    "1"
		set mom_sys_lathe_z_factor                    "1"
		set mom_sys_lathe_i_factor                    "1"
		set mom_sys_lathe_j_factor                    "1"
		set mom_sys_lathe_k_factor                    "1"
		set mom_sys_leader(N)                         "N"
		set mom_sys_leader(M)			      "M"
		set mom_sys_leader(M_spindle)                 "M"
		set mom_sys_leader(S)                         "S"
		set mom_sys_leader(G)			      "G"
		set mom_sys_leader(X)                         "X"
		set mom_sys_leader(Y)                         "Y"
		set mom_sys_leader(Z)                         "Z"
		set mom_sys_leader(fourth_axis)               "A"
		set mom_sys_leader(fifth_axis)                "B"
  		set mom_sys_leader(sixth_axis)                "C"
		set mom_sys_trailer(M)			      ""
		set mom_sys_trailer(M_spindle)                ""
		set mom_sys_trailer(S)                        ""
		set mom_sys_trailer(G)			      ""
		set mom_sys_trailer(X)                        ""
		set mom_sys_trailer(Y)                        ""
		set mom_sys_trailer(Z)                        ""
		set mom_sys_trailer(fourth_axis)              ""
		set mom_sys_trailer(fifth_axis)               ""
		set mom_sys_trailer(sixth_axis)               ""
		if {[info exists pc_initial_library_release_of_post] && $pc_initial_library_release_of_post > 50306} {
			set mom_sys_contour_feed_mode(LINEAR)         "AUTO"
			set mom_sys_rapid_feed_mode(LINEAR)           "AUTO"
			set mom_sys_cycle_feed_mode                   "AUTO"
		} else {
			set mom_sys_contour_feed_mode(LINEAR)         "MMPM"
			set mom_sys_rapid_feed_mode(LINEAR)           "MMPM"
			set mom_sys_cycle_feed_mode                   "MMPM"
		}
		set mom_sys_feed_param(IPM,format)            "Feed_IPM"
		set mom_sys_feed_param(IPR,format)            "Feed_IPR"
		set mom_sys_feed_param(FRN,format)            "Feed_INV"
		set mom_sys_vnc_rapid_dogleg                  "1"
		set mom_sys_prev_mach_head                    ""
		set mom_sys_curr_mach_head                    ""
		set mom_sys_output_cycle95                    "1"
		set mom_sys_contour_feed_mode(ROTARY)         "MMPM"
		set mom_sys_contour_feed_mode(LINEAR_ROTARY)  "MMPM"
		set mom_sys_feed_param(DPM,format)            "Feed_DPM"
		set mom_sys_rapid_feed_mode(ROTARY)           "MMPM"
		set mom_sys_rapid_feed_mode(LINEAR_ROTARY)    "MMPM"
		set mom_sys_feed_param(MMPM,format)           "Feed_MMPM"
		set mom_sys_feed_param(MMPR,format)           "Feed_MMPR"
		set mom_sys_retract_distance                  "10"
		set mom_sys_linearization_method              "angle"
		set mom_sys_post_description                  "This is a 5-Axis Milling Machine With\n\Dual Rotary Heads."
		set mom_sys_ugpadvkins_used                   "0"
		set mom_sys_post_builder_version              "9.0.1"
		set mom_sys_linear_turbo_command              "FALSE"
		set mom_sys_rapid_turbo_command               "FALSE"
		set mom_sys_circular_turbo_command            "FALSE"
		# will be added to post core later
		set mom_sys_turbo_global_add_vars_list        "mom_feedrate_mode mom_feedrate mom_motion_type mom_current_motion mom_pos_arc_center mom_pos_arc_axis oper_mcs_matrix"
		if {[info exists pc_initial_library_release_of_post] && $pc_initial_library_release_of_post >= 50503} {
			set mom_sys_output_transition_path            "1"
		} else {
			set mom_sys_output_transition_path            "0"
		}
		set mom_sys_post_output_subprogram_enabled    "1"
		if {[info exists pc_initial_library_release_of_post] && $pc_initial_library_release_of_post >= 231100} {
			set mom_sys_spindle_speed_init            "0.0"
		} else {
			set mom_sys_spindle_speed_init            "99"
		}

		####### KINEMATIC VARIABLE DECLARATIONS ##############
		set mom_kin_4th_axis_ang_offset               "0.0"
		set mom_kin_4th_axis_center_offset(0)         "0.0"
		set mom_kin_4th_axis_center_offset(1)         "0.0"
		set mom_kin_4th_axis_center_offset(2)         "0.0"
		set mom_kin_4th_axis_direction                "MAGNITUDE_DETERMINES_DIRECTION"
		set mom_kin_4th_axis_incr_switch              "OFF"
		set mom_kin_4th_axis_leader                   "A"
#		set mom_kin_4th_axis_limit_action             "Warning"
		set mom_kin_4th_axis_max_limit                "360"
		set mom_kin_4th_axis_min_incr                 "0.001"
		set mom_kin_4th_axis_min_limit                "0"
		set mom_kin_4th_axis_plane                    "YZ"
		set mom_kin_4th_axis_point_inch(0)            "0.0"
		set mom_kin_4th_axis_point_inch(1)            "0.0"
		set mom_kin_4th_axis_point_inch(2)            "0.0"
		set mom_kin_4th_axis_point_metric(0)          "0.0"
		set mom_kin_4th_axis_point_metric(1)          "0.0"
		set mom_kin_4th_axis_point_metric(2)          "0.0"
		set mom_kin_4th_axis_rotation                 "standard"
		set mom_kin_4th_axis_type                     "Head"
		set mom_kin_4th_axis_vector(0)                "1"
		set mom_kin_4th_axis_vector(1)                "0"
		set mom_kin_4th_axis_vector(2)                "0"
		set mom_kin_4th_axis_zero                     "0.0"
		set mom_kin_5th_axis_ang_offset               "0.0"
		set mom_kin_5th_axis_center_offset(0)         "0.0"
		set mom_kin_5th_axis_center_offset(1)         "0.0"
		set mom_kin_5th_axis_center_offset(2)         "0.0"
		set mom_kin_5th_axis_direction                "MAGNITUDE_DETERMINES_DIRECTION"
		set mom_kin_5th_axis_incr_switch              "OFF"
		set mom_kin_5th_axis_leader                   "B"
#		set mom_kin_5th_axis_limit_action             "Warning"
		set mom_kin_5th_axis_max_limit                "360"
		set mom_kin_5th_axis_min_incr                 "0.001"
		set mom_kin_5th_axis_min_limit                "0"
		set mom_kin_5th_axis_plane                    "ZX"
		set mom_kin_5th_axis_point_inch(0)            "0.0"
		set mom_kin_5th_axis_point_inch(1)            "0.0"
		set mom_kin_5th_axis_point_inch(2)            "0.0"
		set mom_kin_5th_axis_point_metric(0)          "0.0"
		set mom_kin_5th_axis_point_metric(1)          "0.0"
		set mom_kin_5th_axis_point_metric(2)          "0.0"
		set mom_kin_5th_axis_rotation                 "standard"
		set mom_kin_5th_axis_type                     "Head"
		set mom_kin_5th_axis_vector(0)                "0"
		set mom_kin_5th_axis_vector(1)                "1"
		set mom_kin_5th_axis_vector(2)                "0"
		set mom_kin_5th_axis_zero                     "0.0"
		set mom_kin_arc_output_mode                   "FULL_CIRCLE"
		set mom_kin_arc_valid_plane                   "XYZ"
		set mom_kin_clamp_time                        "2.0"
		set mom_kin_cycle_plane_change_per_axis       "0"
		set mom_kin_cycle_plane_change_to_lower       "0"
		set mom_kin_dependent_head                    "NONE"
		set mom_kin_flush_time                        "2.0"
		set mom_kin_helical_arc_output_mode           "FULL_CIRCLE"
		set mom_kin_ind_to_dependent_head_x           "0"
		set mom_kin_ind_to_dependent_head_z           "0"
		set mom_kin_independent_head                  "NONE"
		set mom_kin_linearization_flag                "1"
		###set mom_kin_linearization_tol                 "0.01"
		set mom_kin_machine_type                      "5_axis_dual_head"
		set mom_kin_machine_zero_offset(0)            "0.0"
		set mom_kin_machine_zero_offset(1)            "0.0"
		set mom_kin_machine_zero_offset(2)            "0.0"
		set mom_kin_max_dpm                           "1000000"
		set mom_kin_max_frn                           "1000"
		set mom_kin_min_dpm                           "0.0"
		set mom_kin_min_frn                           "0.01"
		set mom_kin_output_unit                       "MM"
		set mom_kin_pivot_gauge_offset                "0.0"
		set mom_kin_pivot_guage_offset                ""
		set mom_kin_post_data_unit                    "MM"
		set mom_kin_retract_distance                  "500"
		set mom_kin_rotary_axis_method                "PREVIOUS"
		set mom_kin_spindle_axis(0)                   "0.0"
		set mom_kin_spindle_axis(1)                   "0.0"
		set mom_kin_spindle_axis(2)                   "1.0"
		set mom_kin_tool_change_time                  "12.0"
		set mom_kin_x_axis_limit                      "1000"
		set mom_kin_y_axis_limit                      "1000"
		set mom_kin_z_axis_limit                      "1000"
      		set mom_kin_head_spindle_axis_correction      "ON"
		set mom_kin_head_gauge_point_correction       "ON"
		set mom_kin_combine_rapid_arc_motion          "Yes"
		set mom_kin_x_max_limit 					  "1000"
		set mom_kin_x_min_limit 					  "0.0"
		set mom_kin_x_soft_max_limit 				  "1000"
		set mom_kin_x_soft_min_limit			 	  "0.0"
		set mom_kin_y_max_limit   					  "1000"
		set mom_kin_y_min_limit  					  "0.0"
		set mom_kin_y_soft_max_limit 				  "1000"
		set mom_kin_y_soft_min_limit 				  "0.0"
		set mom_kin_z_max_limit 				  	  "1000"
		set mom_kin_z_min_limit 					  "0.0"
		set mom_kin_z_soft_max_limit 				  "1000"
		set mom_kin_z_soft_min_limit 				  "0.0"
        set mom_sys_split_full_circle                 "1"
        set mom_sys_split_half_circle                 "1"

		if {[info exists pc_initial_library_release_of_post] && $pc_initial_library_release_of_post > 50507} {
			CONF_SPF_file set ctrl_ini_location Part_NoSubProgFolder
		}


	}
}


if {![info exists mom_sys_leader(N)]} {
	if {[info commands LIB_SPF_set_initial_globals] != ""} {LIB_SPF_set_initial_globals}
}

if {![info exists mom_sys_control_out]} {set mom_sys_control_out ""}
if {![info exists mom_sys_control_in]} {set mom_sys_control_in ""}

if {[info commands LIB_GE_CREATE_obj] != ""} {

	LIB_GE_CREATE_obj Template_UI_tree {UI_TREE} {
		LIB_GE_property_ui_name "Template Tree Branches"
		LIB_GE_property_ui_tooltip "Template Tree Branches"

 		LIB_GE_ui	"3+2 Settings"			"NODE"	@CUI_3P2			@CUI_CtrlCap		2	1	222
		LIB_GE_ui	  "3+2 Settings"		"GROUP" @CUI_3P2Group			@CUI_3P2		-1	1	222

		LIB_GE_ui 	  "Cutter Compensation"		"GROUP"	@CUI_TemplateCutcom		@CUI_CtrlOutModeGroup	-1	1	222

		LIB_GE_ui	"Turn"				"NODE"	@CUI_CycleTurn			@CUI_CycleSettings	1	1	222
		LIB_GE_ui	  "Turn Cycle"			"GROUP"	@CUI_CycleTurnGroup		@CUI_CycleTurn		-1	1	222

		LIB_GE_ui	"Additive"			"NODE"	@CUI_Additive			root			8	1	222
		LIB_GE_ui	"Deposition Output"		"NODE"	@CUI_DepositionOutput		@CUI_Additive		1	1	222
		LIB_GE_ui	  "Deposition Output Data"	"GROUP"	@CUI_DepositionOutputData	@CUI_DepositionOutput	-1	1	222

		LIB_GE_ui	"Coolant Time"			"NODE"	@CUI_CoolantTime		@CUI_Additive		1	1	222
		LIB_GE_ui	  "Cooling Time Data"		"GROUP"	@CUI_CoolantTimeData		@CUI_CoolantTime	-1	1	222

		LIB_GE_ui 	"BLOCK FORM" 			"NODE"	@CUI_BlockForm			@CUI_GeneralSettings 	-1 	1 	222
		LIB_GE_ui 	  "BLOCK FORM"			"GROUP" @CUI_BlockFormGroup 		@CUI_BlockForm 		-1 	1 	222

	}

	LIB_GE_CREATE_obj CONF_TEMPLATE_3P2 {} {
		LIB_GE_property_ui_name "Template plane output"
		LIB_GE_property_ui_tooltip ""
		#____________________________________________________________________________________________
		# PLANE: Define/ calculating rotation direction
		# option: "0" (right handed (+)) / "1" (left handed (-))
		#____________________________________________________________________________________________
		set id "rot_direction"
		    set $id +
		    set options($id)        {right handed(+)|left handed(-)}
		    set options_ids($id)    {+|-}
		    set datatype($id)       "STRING"
		    set access($id)         222
		    set dialog($id)         {{Rotation Direction}}
		    set descr($id)          {{Define the direction of rotation. Possible value is left handed (-) or right handed (+)}}
		    set ui_parent($id)      "@CUI_3P2Group"
		    set ui_sequence($id)    -1
		#____________________________________________________________________________________________
		# PLANE: Define rotation order
		# option: XYZ/XZY/YZX/YXZ/ZXY/ZYX/XYX/XZX/YZY/YXY/ZXZ/ZYZ
		#____________________________________________________________________________________________
		set id "rot_order"
		    set $id ZXZ
		    set options($id)        {XYZ|XZY|YZX|YXZ|ZXY|ZYX|XYX|XZX|YZY|YXY|ZXZ|ZYZ}
		    set options_ids($id)    {XYZ|XZY|YZX|YXZ|ZXY|ZYX|XYX|XZX|YZY|YXY|ZXZ|ZYZ}
		    set datatype($id)       "STRING"
		    set access($id)         222
		    set dialog($id)         {{Rotation Order}}
		    set descr($id)          {{Define the order of rotation.}}
		    set ui_parent($id)      "@CUI_3P2Group"
		    set ui_sequence($id)    -1

		#____________________________________________________________________________________________
		# PLANE: Define rotation mode
		# option: spatial/euler/axial
		#____________________________________________________________________________________________
		set id "rot_mode"
		    set $id euler

		    set options($id)        {spatial|euler|axial}
		    set options_ids($id)    {spatial|euler|axial}
		    set datatype($id)       "STRING"
		    set access($id)         222
		    set dialog($id)         {{Rotation Mode}}
		    set descr($id)          {{Define the mode of rotation.\n spatial - rotation is about fixed machine axis\n euler - rotation is about the resulting axis\n axial - rotation is about the rotation axis}}

		    set ui_parent($id)      "@CUI_3P2Group"
		    set ui_sequence($id)    -1

		#____________________________________________________________________________________________
		# PLANE: Rotation about axis
		# option: "first" (rotation is about first axis in the lib_3d_rot_order if possible) / "last" (rotation is about last axis in the lib_3d_rot_order if possible)
		#____________________________________________________________________________________________
		set id "rot_address"
		    set $id last

		    set options($id)        {first|last}
		    set options_ids($id)    {first|last}
		    set datatype($id)       "STRING"
		    set access($id)         222
		    set dialog($id)         {{Rotation About Axis}}
		    set descr($id)          {{Define the rotation about axis.\\nfirst-rotation is about first axis in the lib_3d_rot_order if possible\\nlast-rotation is about last axis in the lib_3d_rot_order if possible}}

		    set ui_parent($id)      "@CUI_3P2Group"
		    set ui_sequence($id)    -1
									  
		#____________________________________________________________________________________________
		# PLANE: sign for handling the direction of plane direction
		# option: "+" / "-" / "0"(Auto) /...
		#____________________________________________________________________________________________
		set id "rotate_dir"
		set $id		"0"
				set options($id) 	{+|-|Auto}
				set options_ids($id) 	{+|-|0}
				set access($id) 	222
				set dialog($id) 	{{Rotate Direction}}
				set descr($id) 		{{Sets the sign for the direction of rotation of the master axis for the plane command. You use this option to select one of two possible solutions for the tilted working plane.}}
				set ui_parent($id) "@CUI_3P2Group"
				set ui_sequence($id) -1							 
							   
		#____________________________________________________________________________________________
		# PLANE: call proc before plane output
		# option: "0" (OFF) / "1" (ON) /  ...
		#____________________________________________________________________________________________
		set id "rotate_before"
		set $id		"0"
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Rotate Axis before Plane Output}}
				set descr($id) 		{{Generates a rotation of the 4th or 5th axis before the plane command is output.}}
				set ui_parent($id) "@CUI_3P2Group"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
																							   
		# PLANE: call proc after plane output
		# option: "0" (OFF) / "1" (ON) /  ...
		#____________________________________________________________________________________________
		set id "rotate_after"
		set $id		"0"
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Rotate Axis after Plane Output}}
				set descr($id) 		{{Generates a rotation of the 4th or 5th axis after the plane command is output.}}
				set ui_parent($id) "@CUI_3P2Group"
				set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# PLANE: Name of plane command
		# option: value
		#____________________________________________________________________________________________
		set id "plane_name"
		set $id "3P2"
		    set options($id)        {*VALUE*}
		    set options_ids($id)    {*VALUE*}
		    set datatype($id)       "STRING"
		    set access($id)         222
		    set dialog($id)         {{Plane Command Name}}
		    set descr($id)          {{Define the name of the plane command for 3+2 operations}}
		    set ui_parent($id)      "@CUI_3P2Group"
		    set ui_sequence($id)    -1
		
		#____________________________________________________________________________________________
		# PLANE: Name of cancel plane command
		# option: value
		#____________________________________________________________________________________________
		set id "cancel_plane_name"
		set $id "69"
		    set options($id)        {*VALUE*}
		    set options_ids($id)    {*VALUE*}
		    set datatype($id)       "STRING"
		    set access($id)         222
		    set dialog($id)         {{Cancellation Plane Command Name}}
		    set descr($id)          {{Define the code for cancellation of the plane command for 3+2 operations}}
		    set ui_parent($id)      "@CUI_3P2Group"
		    set ui_sequence($id)    -1
	}


	LIB_GE_CREATE_obj CONF_CTRL_drill {} {
		LIB_GE_property_ui_name "Drill Cycle"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# DELAY: Minimum value
		# option: Value
		#____________________________________________________________________________________________
		set id "min_delay"
		set $id		0.2
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"DOUBLE"
				set access($id) 	222
				set dialog($id) 	{{Min Delay}}
				set descr($id) 		{{Sets the minimum value for cycle delay. If the dwell time of the cycle is less than this value, the software outputs the minimum value instead of the programmed value for the dwell.}}
				set ui_parent($id) "@CUI_CycleDrillGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# DELAY: Maximum value
		# option: Value
		#____________________________________________________________________________________________
		set id "max_delay"
		set $id		10.0
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"DOUBLE"
				set access($id) 	222
				set dialog($id) 	{{Max Delay}}
				set descr($id) 		{{Sets the maximum value for the cycle delay. If the dwell time of the operation exceeds this value, the software outputs the maximum value instead of the programmed value for the dwell.}}
				set ui_parent($id) "@CUI_CycleDrillGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# DELAY: Default value for cycle
		# option: Value
		#____________________________________________________________________________________________
		set id "default_cycle_delay"
		set $id		0.2
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"DOUBLE"
				set access($id) 	222
				set dialog($id) 	{{Default Cycle Delay}}
				set descr($id) 		{{Sets the default value for the cycle delay. This value is used if dwell/on is set in the operation and there is no value defined for the dwell.}}
				set ui_parent($id) "@CUI_CycleDrillGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CYCLE: Default value for tap cycle
		# option: std / rigid
		#____________________________________________________________________________________________
		set id "cycle_tap"
		set $id		"std"
				set options($id) 	{Standard|Rigid}
				set options_ids($id) 	{std|rigid}
				set access($id) 	222
				set dialog($id) 	{{Cycle Tap}}
				set descr($id) 		{{Sets the default mode for the tapping cycle. Valid options are Rigid or Standard.}}
				set ui_parent($id) "@CUI_CycleDrillGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CYCLE: Check pitch tool value for tap cycle
		# option: 0 / 1 (1: default)
		# if 0, if tool pitch is not defined, feed_rate_per_rev is used
		# if 1, if tool pitch is not defined, output abort message
		#____________________________________________________________________________________________
		set id "tool_pitch_used"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Abort Message for Missing Tool Pitch}}
				set descr($id) 		{{Outputs an abort message if the tool pitch does not exist to calculate the feedrate for the tapping cycle, when set to On. Select Off to omit the check for the tool pitch.}}
				set ui_parent($id) "@CUI_CycleDrillGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CYCLE: Default feed type output for tap cycle
		# option: MMPM / IPM / MMPR / IPR
		#____________________________________________________________________________________________
		set id "cycle_tap_feed_type"
		set $id		"MMPM"
				set options($id)	{MMPM|IPM|MMPR|IPR}
				set options_ids($id) 	{MMPM|IPM|MMPR|IPR}
				set access($id) 	222
				set dialog($id) 	{{Cycle Tap: Feed Type}}
				set descr($id) 		{{Sets the default feed type for the tapping cycle. Valid options are MMPM,IPM,MMPR or IPR.}}
				set ui_parent($id) "@CUI_CycleDrillGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CYCLE: Sets the default G code for cancel cycle
		# option: G80 / G0/G1
		#____________________________________________________________________________________________
		set id "cancel_cycle"
		set $id		"G80"
				set options($id)	{G80|G0/G1}
				set options_ids($id) 	{G80|G0/G1}
				set access($id) 	222
				set dialog($id) 	{{Cancel Cycle}}
				set descr($id) 		{{Sets the default G code for cancel cycle}}
				set ui_parent($id) "@CUI_CycleDrillGroup"
				set ui_sequence($id) -1

	}

	LIB_GE_CREATE_obj CONF_CTRL_turn {} {
		LIB_GE_property_ui_name "Turn Cycle"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# DELAY: Sequence number output mode for turning cycle
		# option: Only start line and finish line / Every lines
		#____________________________________________________________________________________________
		set id "sequence_number_output_mode"
		set $id		0
				set options($id) 	{Only start line and finish line|Every lines}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Sequence Number Output Mode}}
				set descr($id) 		{{Sets the default sequence number output mode for turn cycle.}}
				set ui_parent($id) "@CUI_CycleTurnGroup"
				set ui_sequence($id) -1

	}

	LIB_GE_CREATE_obj CONF_CTRL_tool {} {
		LIB_GE_property_ui_name "Tool Change"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# TOOL_CHANGE: load manual tool_number or tool_name
		# option: tool_change / tool_change_name
		# if a list is defined each list element will be called as a template
		#____________________________________________________________________________________________
		set id "manual_change_template"
		set $id		"tool_change"
				set options($id) 	{Tool Change by Number|Custom Procedure}
				set options_ids($id) 	{tool_change|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Manual Change Template}}
				set descr($id) 		{{Outputs the manual tool change NC code based on the default block template or a custom procedure.	\\n\
							The default block template, tool_change, uses the current tool number. The custom procedure is defined as a list. Each list member can be a block template or a TCL procedure.\\n\\n\
							NOTE: Manual tool change is used if this option is selected in the tool change options of your operation.}}
				set ui_parent($id) "@CUI_ToolChangeManual"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE: preselect manual tool_number or tool_name
		# option: tool_preselect / tool_preselect_name
		# if a list is defined each list element will be called as a template
		#____________________________________________________________________________________________
		set id "manual_preselect_template"
		set $id         "tool_preselect"
				set options($id) 	{Tool Preselect by Number|Custom Procedure}
				set options_ids($id) 	{tool_preselect|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Manual Preselect Template}}
				set descr($id) 		{{Outputs the preselect tool NC code based on the default block template or a custom procedure. The default block template, tool_preselect, uses the next tool number. The custom procedure is defined as a list. Each list member can be a block template or a TCL procedure.}}
				set ui_parent($id) "@CUI_ToolChangeManual"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE: preselect last manual tool_number or tool_name
		# option: tool_preselect / tool_preselect_name
		# if a list is defined each list element will be called as a template
		#____________________________________________________________________________________________
		set id "manual_preselect_last_template"
		set $id         "tool_preselect"
				set options($id) 	{Tool Preselect by Number|Custom Procedure}
				set options_ids($id) 	{tool_preselect|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Manual Preselect Last Template}}
				set descr($id) 		{{Outputs the last preselect tool NC code based on the default block template or a custom procedure. The default block template, tool_preselect, uses the next tool number. The custom procedure is defined as a list. Each list member can be a block template or a TCL procedure.}}
				set ui_parent($id) "@CUI_ToolChangeManual"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE: load tool_number or tool_name
		# option: tool_change / tool_change_name
		# if a list is defined each list element will be called as a template
		#____________________________________________________________________________________________
		set id "auto_change_template"
		set $id		"tool_change"
				set options($id) 	{Tool Change by Number|Custom Procedure}
				set options_ids($id) 	{tool_change|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Auto Change Template}}
				set descr($id) 		{{Outputs the tool change NC code based on the default block template or a custom procedure. The default block template, tool_change, uses the current tool number. The custom procedure is defined as a list. Each list member can be a block template or a TCL procedure.}}
				set ui_parent($id) "@CUI_ToolChangeAuto"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE: preselect tool_number or tool_name
		# option: tool_preselect / tool_preselect_name
		# if a list is defined each list element will be called as a template
		#____________________________________________________________________________________________
		set id "auto_preselect_template"
		set $id		"tool_preselect"
				set options($id) 	{Tool Preselect by Number|Custom Procedure}
				set options_ids($id) 	{tool_preselect|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Auto Preselect Template}}
				set descr($id) 		{{Outputs the preselect tool NC code based on the default block template  or a custom procedure. The default block template, tool_preselect, uses the next tool number. The custom procedure is defined as a list. Each list member can be a block template or a TCL procedure.}}
				set ui_parent($id) "@CUI_ToolChangeAuto"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE: preselect last tool_number or tool_name
		# option: tool_preselect / tool_preselect_name
		# if a list is defined each list element will be called as a template
		#____________________________________________________________________________________________
		set id "auto_preselect_last_template"
		set $id		"tool_preselect"
				set options($id) 	{Tool Preselect by Number|Custom Procedure}
				set options_ids($id) 	{tool_preselect|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Auto Preselect Last Template}}
				set descr($id) 		{{Outputs the last preselect tool NC code based on the default block template or a custom procedure. The default block template, tool_preselect, uses the next tool number. The custom procedure is defined as a list. Each list member can be a block template or a TCL procedure.}}
				set ui_parent($id) "@CUI_ToolChangeAuto"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE: preselect last tool_number or tool_name
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "tool_preselect"
		set $id                 0
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Tool Preselect}}
				set descr($id) 		{{Outputs the next tool number after a tool change.}}
				set ui_parent($id) "@CUI_ToolChangeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE :  Maximum tool_number allowed
		# option: maximum_tool_number / 0 (don't check)
		#____________________________________________________________________________________________
		set id "max_tool_number"
		set $id		999999
				set options($id) 	{No Check|Custom Value}
				set options_ids($id) 	{0|*VALUE*}
				set datatype($id) 	"INT"
				set access($id) 	222
				set dialog($id) 	{{Max Tool Number}}
				set descr($id) 		{{Sets the maximum tool number allowed if tools are identified by number.}}
				set ui_parent($id) "@CUI_ToolChangeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE :  Check zero tool number
		# option: 1 (check) / 0 (don't check)
		#____________________________________________________________________________________________
		set id "check_zero_tool_number"
		set $id		1
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set datatype($id) 	"INT"
				set access($id) 	222
				set dialog($id) 	{{Check Tool Number 0}}
				set descr($id) 		{{Issue a message if a tool has no number specified?}}
				set ui_parent($id) "@CUI_ToolChangeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# LIB_CHECK_adjust_register :  Check zero adjust register
		# option: 1 (check) / 0 (don't check)
		#____________________________________________________________________________________________
		set id "check_zero_adjust_register"
		set $id		1
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set datatype($id) 	"INT"
				set access($id) 	222
				set dialog($id) 	{{Check Adjust Register 0}}
				set descr($id) 		{{Issue a message if a tool has no Adjust Register specified?}}
				set ui_parent($id) "@CUI_ToolChangeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# LIB_CHECK_adjust_register :  max D-number allowed
		# option: max D-number / 0 (don't check)
		#____________________________________________________________________________________________
		set id "max_d_number"
		set $id		0
				set options($id) 	{No Check|Custom Value}
				set options_ids($id) 	{0|*VALUE*}
				set datatype($id) 	"INT"
				set access($id) 	222
				set dialog($id) 	{{Max D Number}}
				set descr($id) 		{{Sets the maximum D-number (tool cutcom register number) allowed.}}
				set ui_parent($id) "@CUI_ToolChangeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CUTCOM: gap between radius programmed and measured
		# option: 0 / 1 (actual radius)
		#____________________________________________________________________________________________
		set id "cutcom_actual_radius"
		set $id		1
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Cutcom Actual Radius}}
				set descr($id) 		{{Computes the cutcom radius (tool diameter / 2) for operations with the cutter compensation on centerline data. This setting checks between the programmed radius and the measured radius.}}
				set ui_parent($id) "@CUI_ToolChangeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TOOL_CHANGE :  tool change in end of path
		# option: "Off" / "first_tool" / "unload_tool"
		#____________________________________________________________________________________________
		set id "tool_change_eop"
		set $id		"off"
				set options($id) 	{Off|First Tool|Unload Tool|Custom Value}
				set options_ids($id)    {off|first_tool|unload_tool|*VALUE*}
				set access($id) 	222
				set dialog($id) 	{{Tool Change in End of Program}}
				set descr($id) 		{{Output an 'TOOL CALL' in event MOM_end_of_program. OFF - do nothing.  First Tool - TOOL CALL with number or name (depends on other setting). Unload Tool - 'TOOL CALL 0'. Custom Value - TOOL CALL 'Custom Value'}}
				set ui_parent($id) "@CUI_ToolChangeGroup"
				set ui_sequence($id) -1
	}

	LIB_GE_CREATE_obj CONF_CTRL_spindle {} {
		LIB_GE_property_ui_name "General Spindle"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# SPINDLE : Spindle min
		# option: value
		#____________________________________________________________________________________________
		set id "min"
		set $id		0.0
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"DOUBLE"
				set access($id) 	222
				set dialog($id) 	{{Min}}
				set descr($id) 		{{Sets the minimum valid spindle speed. If a programmed spindle speed is less than this limit, the software ignores the programmed speed and uses the minimum speed instead.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Spindle max
		# option: value
		#____________________________________________________________________________________________
		set id "max"
		set $id		99990.0
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"DOUBLE"
				set access($id) 	222
				set dialog($id) 	{{Max}}
				set descr($id) 		{{Sets the maximum valid spindle speed. If a programmed spindle speed is greater than this limit, the software ignores the programmed speed and uses the maximum speed instead.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Spindle range auto
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "range"
		set $id                 0
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Range Output}}
				set descr($id) 		{{Allows the speed range to be set for the spindle. You must create a custom TCL procedure to output the NC codes.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Spindle 0 RPM allowed
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "no_spindle_rpm_allowed"
		set $id		1
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{No Spindle RPM Allowed}}
				set descr($id) 		{{Allows RPM with zero spindle speed. By default the postprocessor issues an error if spindle RPM is set to zero.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Spindle output alone (milling only)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "spindle_output_alone"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Spindle Output Alone}}
				set descr($id) 		{{Outputs the spindle speed on a single line for milling operations. If this setting is Off, the spindle speed is output with the first movement.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Always output Preset Spindle rpm (turning only)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "spindle_preset_rpm_output_always"
		set $id         1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Always Output Preset Spindle RPM }}
				set descr($id) 		{{Always outputs the preset spindle speed for turning operations no matter if preset RPM is toggled in CAM.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Always output Spindle max rpm (turning only)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "spindle_max_rpm_output_always"
		set $id         1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Always Output Spindle Max RPM }}
				set descr($id) 		{{Always outputs the maximum spindle speed for turning operations no matter if max RPM is toggled in CAM.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# SPINDLE : Spindle max rpm output alone (turning only)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "spindle_max_rpm_output_alone"
		set $id         1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	000
				set dialog($id) 	{{Spindle Max RPM Output Alone}}
				set descr($id) 		{{Outputs the spindle speed on a single line for turning operations. If this setting is Off, the spindle speed is output with the first movement.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Spindle Insert mount position
		# option: "+X / "+Y"  / "-X" / "-Y"
		#____________________________________________________________________________________________
		set id "spindle_insert_zero"
		set $id		"0.0"
				set options($id) 	{+X|+Y|-X|-Y}
				set options_ids($id) 	{0.0|90.0|180.0|-90.0}
				set access($id) 	222
				set dialog($id) 	{{Spindle Insert Zero Position}}
				set descr($id) 		{{Defines the zero position of the spindle in the machine coordinate system.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# SPINDLE : Spindle positive direction for for spindle position
		# option: "SPOS=" / "SPOSA="  / "SPOS=DC(" / "SPOSA=DC("
		#____________________________________________________________________________________________
		set id "spindle_positive_direction"
		set $id		"-1"
				set options($id) 	{CLW|CCLW}
				set options_ids($id) 	{-1|1}
				set access($id) 	222
				set dialog($id) 	{{Spindle Positive Direction}}
				set descr($id) 		{{Defines the positive direction for the spindle rotation.}}
				set ui_parent($id) "@CUI_SpindleGroup"
				set ui_sequence($id) -1
	}

	LIB_GE_CREATE_obj CONF_CTRL_moves {} {
		LIB_GE_property_ui_name "Motion"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# MACHINING :  Hole making combine rotary function
		# option: off / Traversal
		#____________________________________________________________________________________________
		set id "enable_hole_making_combine_rotary"
			set $id		"off"
				set options($id)	{Off|Traversal}
				set options_ids($id) 	{off|traversal}
				set datatype($id) 	"OPTION"
				set access($id) 	222
				set dialog($id) 	{{Enable hole making combine rotary}}
				set descr($id) 		{{Defined whether to combine rotary is enabled. \\n\
									Off = disable the function,\\n\
									Traversal = enable combine drilling and hole milling in traversal motions}}
				set ui_parent($id) "@CUI_MotionSettingHoleMakingCombineRotaryGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MACHINING :  Hole making combine rotary function
		# option: 1
		#____________________________________________________________________________________________
		set id "combine_tolerance"
			set $id		1
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Combine tolerance}}
				set descr($id) 		{{Tolerance for combine of rotary moves}}
				set ui_parent($id) "@CUI_MotionSettingHoleMakingCombineRotaryGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MACHINING :  To make initial motion with priority decomposition
		# (EI: XY + Z)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "decompose_first_move"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Approach Motion Splitting after Tool Change}}
				set descr($id) 		{{Sets the axis engage sequence for the first move of an operation after a tool change or plane change. If activated, the sequence is split into two moves: first the positioning axes (for example, XY) and then the tool axis (in the example, Z). If set to Off, the option moves all linear axes (XYZ) simultaneously to the first position.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalFMStd"
				set ui_sequence($id) 1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_xi"
		set $id		"{Y Z} {G_adjust X H}"
				set options($id) 	{{Y Z} {G_adjust X H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis X-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with X-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSI"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_yi"
		set $id		"{X Z} {G_adjust Y H}"
				set options($id) 	{{X Z} {G_adjust Y H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Y-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Y-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSI"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_zi"
		set $id		"{X Y} {G_adjust Z H}"
				set options($id) 	{{X Y} {G_adjust Z H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Z-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Z-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSI"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_xlu"
		set $id		"X {Y Z}"
				set options($id) 	{X {Y Z}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis X-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with X-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSUL"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_ylu"
		set $id		"Y {X Z}"
				set options($id) 	{Y {X Z}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Y-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Y-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSUL"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_zlu"
		set $id		"Z {X Y}"
				set options($id) 	{Z {X Y}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Z-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Z-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSUL"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_xul"
		set $id		"{Y Z} X"
				set options($id) 	{{Y Z} X}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis X-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with X-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSLU"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_yul"
		set $id		"{X Z} Y"
				set options($id) 	{{X Z} Y}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Y-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Y-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSLU"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_std_zul"
		set $id		"{X Y} Z"
				set options($id) 	{{X Y} Z}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Z-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Z-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSLU"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING :  To make initial motion with priority decomposition for positioning mode only
		# (EI: XY + Z)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Approach Motion Splitting for Positioning Operations}}
				set descr($id) 		{{Sets the first move after plane output in milling mode. If set to On, the option first moves the positioning axes (for example, XY) and then moves the tool axis (in the example, Z). If set to Off, the option moves all linear axes (XYZ) simultaneously to the first position.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalFMPos"
				set ui_sequence($id) 1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_xi"
		set $id		"{Y Z} {G_adjust X H}"
				set options($id) 	{{Y Z} {G_adjust X H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis X-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with X-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPI"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_yi"
		set $id		"{X Z} {G_adjust Y H}"
				set options($id) 	{{X Z} {G_adjust Y H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Y-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Y-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPI"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_zi"
		set $id		"{X Y} {G_adjust Z H}"
				set options($id) 	{{X Y} {G_adjust Z H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Z-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Z-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPI"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_lu"
		set $id		"{G_adjust Z H} {X Y}"
				set options($id) 	{{G_adjust Z H} {X Y}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Decompose the Output Order}}
				set descr($id) 		{{Decompose the output order.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPUL"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_xlu"
		set $id		"{G_adjust Z H} {X Y}"
				set options($id) 	{{G_adjust Z H} {X Y}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Tool Axis X-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with X-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPUL"
				set ui_sequence($id) -1

				set $id LINKED_LOCAL@decompose_first_move_pos_lu

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_ylu"
		set $id		"{G_adjust Z H} {X Y}"
				set options($id) 	{{G_adjust Z H} {X Y}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Tool Axis Y-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Y-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPUL"
				set ui_sequence($id) -1

				set $id LINKED_LOCAL@decompose_first_move_pos_lu

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_zlu"
		set $id		"{G_adjust Z H} {X Y}"
				set options($id) 	{{G_adjust Z H} {X Y}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Tool Axis Z-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Z-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPUL"
				set ui_sequence($id) -1

				set $id LINKED_LOCAL@decompose_first_move_pos_lu

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_ul"
		set $id		"{X Y} {G_adjust Z H}"
				set options($id) 	{{X Y} {G_adjust Z H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Decompose the Output Order}}
				set descr($id) 		{{Decompose the output order.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPLU"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_xul"
		set $id		"{X Y} {G_adjust Z H}"
				set options($id) 	{{X Y} {G_adjust Z H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Tool Axis X-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with X-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPLU"
				set ui_sequence($id) -1

				set $id LINKED_LOCAL@decompose_first_move_pos_ul

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_yul"
		set $id		"{X Y} {G_adjust Z H}"
				set options($id) 	{{X Y} {G_adjust Z H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Tool Axis Y-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Y-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPLU"
				set ui_sequence($id) -1

				set $id LINKED_LOCAL@decompose_first_move_pos_ul

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_pos_zul"
		set $id		"{X Y} {G_adjust Z H}"
				set options($id) 	{{X Y} {G_adjust Z H}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Tool Axis Z-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Z-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMPLU"
				set ui_sequence($id) -1

				set $id LINKED_LOCAL@decompose_first_move_pos_ul

		#____________________________________________________________________________________________
		# MILLING :  To make initial motion with priority decomposition for simultanious mode only
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "decompose_first_move_sim"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Approach Motion Splitting for 4/5 Axis Simultaneous}}
				set descr($id) 		{{Sets the first move in simultaneous mode. If activated, the option first moves the positioning axes and then moves the tool and rotary axes together. If set to Off, it moves all linear and rotary axes simultaneously to the first position.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalFMSim"
				set ui_sequence($id) 1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_sim_z"
		set $id		"{X Y} {Z fourth_axis fifth_axis}"
				set options($id) 	{{X Y} {Z fourth_axis fifth_axis}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Tool Axis Z-Vector Direction}}
				set descr($id) 		{{Decompose the output order of the addresses specifically for the Tool Axis with Z-vector direction.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMSO"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TURNING :  To make initial motion with priority decomposition for turning mode only
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "decompose_first_move_turn"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Approach Motion Splitting for Turning}}
				set descr($id) 		{{Sets the first move in turning mode. If set to Off, it moves all linear and rotary axes simultaneously to the first position.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalFMTurn"
				set ui_sequence($id) 1

		#____________________________________________________________________________________________
		# Controls the output order of the addresses
		#____________________________________________________________________________________________
		set id "decompose_first_move_turn_order"
		set $id		"{Y} {Z} {X}"
				set options($id) 	{{Y} {Z} {X}}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	012
				set dialog($id) 	{{Decompose the Output Order}}
				set descr($id) 		{{Decompose the output order of the addresses. Default {Y} {Z} {X} first move Y then Z then X axis.}}
				set ui_parent($id) "@CUI_MotionSettingOOrderGroupFMTO"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MACHINING :  To make initial motion with priority decomposition for each tool_path
		# specially for tool path without tool change and same configuration as previous tool path
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "decompose_first_move_for_each_tool_path"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Approach Motion Splitting without Tool Change}}
				set descr($id) 		{{Sets the axis engage sequence for the first move of an operation without a tool change or plane change. If activated, the sequence is split into two moves. If the operation starts on a higher level than the last position of the previous operation, the option first moves the tool axis (for example, Z) and then the positioning axes (in the example, XY). If the operation starts on a lower level, the option first moves the positioning axes (XY) and then the tool axis (Z). If set to Off, the option moves all linear axes (XYZ) simultaneously to the first position.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalTempl"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MACHINING: Define template name for rapid motions
		# option: string
		#____________________________________________________________________________________________
		set id "rapid_template"
		set $id		"rapid_move"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Rapid Template}}
				set descr($id) 		{{Sets the block template name for a rapid move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		set id rapid_move
		set $id LINKED_LOCAL@rapid_template
		set access($id) 	000

		#____________________________________________________________________________________________
		# MACHINING: Define template name for turning rapid motions
		# option: string
		#____________________________________________________________________________________________
		set id "rapid_template_turn"
		set $id		"rapid_move_turn"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Rapid Turning Template}}
				set descr($id) 		{{Sets the block template name for a turning rapid move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MACHINING: Define template name for linear motions
		# option: string
		#____________________________________________________________________________________________
		set id "linear_template"
		set $id 	"linear_move"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Linear Template}}
				set descr($id) 		{{Sets the block template name for a linear move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		set id linear_move
		set $id LINKED_LOCAL@linear_template
		set access($id) 	000

		#____________________________________________________________________________________________
		# MACHINING: Define template name for turning linear motions
		# option: string
		#____________________________________________________________________________________________
		set id "linear_template_turn"
		set $id 	"linear_move_turn"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Linear Turning Template}}
				set descr($id) 		{{Sets the block template name for a turning linear move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MACHINING: Define template name for circular motions
		# option: string
		#____________________________________________________________________________________________
		set id "circular_template"
		set $id 	"circular_move"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Circular Template}}
				set descr($id) 		{{Sets the block template name for a circular move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		set id circular_move
		set $id LINKED_LOCAL@circular_template
		set access($id) 	000

		#____________________________________________________________________________________________
		# MACHINING: Define template name for turning circular motions
		# option: string
		#____________________________________________________________________________________________
		set id "circular_template_turn"
		set $id 	"circular_move_turn"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Circular Turning Template}}
				set descr($id) 		{{Sets the block template name for a turning circular move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MACHINING: Define template name for rotary rapid motions
		# option: string
		#____________________________________________________________________________________________
		set id "rapid_rotary"
		set $id		"rapid_rotary"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Rapid Rotary}}
				set descr($id) 		{{Sets the block template name for a rotary rapid move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Set template name for "from" move for machining.
		# option: string
		#____________________________________________________________________________________________
		set id "from_template"
		set $id		"rapid_move"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{From Template}}
				set descr($id) 		{{Sets the block template name for a from move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		set id from_move
		set $id LINKED_LOCAL@from_template
		set access($id) 	000

		#____________________________________________________________________________________________
		# Output From Position if defined in a Operation
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "output_from_position"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Output From Position}}
				set descr($id) 		{{Outputs the From position if defined in an operation.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# Set template name for "gohome" move for machining.
		# option: string
		#____________________________________________________________________________________________
		set id "gohome_template"
		set $id		"rapid_move"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Gohome Template}}
				set descr($id)		{{Sets the block template name for a Gohome move.}}
				set ui_parent($id) "@CUI_MotionSettingTemplGroup"
				set ui_sequence($id) -1

		set id gohome_move
		set $id LINKED_LOCAL@gohome_template
		set access($id) 	000

		#____________________________________________________________________________________________
		# MILLING: Safety motion after toolchange
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "safety_motion_after_toolchange"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Safety Motion after Tool Change}}
				set descr($id) 		{{Outputs a return move after a tool change.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: Safety motion if MCS changed for next operation
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "safety_motion_when_mcs_changes"
		set $id		1
				set options($id)	{Off|On|Custom Procedure}
				set options_ids($id) 	{0|1|*VALUE*}
				set access($id) 	222
				set dialog($id) 	{{Safety Motion when MCS Changes}}
				set descr($id) 		{{Outputs a return move when MCS changes for next operation.\\n\\n\
					Custom Procedure: Define your own logic with an procedure\\n\
					Off: examine next oper mcs with same tool and same tool_axis and when it's different to actual op we return 1\\n\
					if return Value 1 Safety Motion active on MCS change\\n\
					if return Value 0 Safety Motion inactive on MCS change}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: Safety motion before fourth rotary axis
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "safety_retract_before_fourth_axis"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Safety Retract before Fourth Axis}}
				set descr($id) 		{{Outputs a safety retract motion before a rapid motion of fourth rotary axis for milling, when set to On. The postprocessor checks if there is a minimum value defined for a move in the fourth axis (Minimum Value For Safety Retract before Fourth Axis). If a minimum value is defined and the rotary axis move is greater than this value, this option outputs a retract move as configured in Return Safety Pos before the fourth axis move. Select Off to omit the check and safety move.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: Safety motion before fifth rotary axis
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "safety_retract_before_fifth_axis"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Safety Retract before Fifth Axis}}
				set descr($id) 		{{Outputs a safety retract motion before motion of fifth rotary axis for milling, when set to On. The postprocessor checks if there is a minimum value defined for a move in the fifth axis (Minimum Value For Safety Retract before Fifth Axis). If a minimum value is defined and the rotary axis move is greater than this value, this option outputs a retract move as configured in Return Safety Pos before moving the fifth axis. Select Off to omit the check and safety move.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: Minimum value for safety motion before fourth rotary axis
		# option: Value
		#____________________________________________________________________________________________
		set id "safety_retract_before_fourth_axis_minimum_value"
		set $id		0.0
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"DOUBLE"
				set access($id) 	222
				set dialog($id) 	{{Minimum Value for Safety Retract before Fourth Axis}}
				set descr($id) 		{{Sets the minimum value for the fourth axis rotary move.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: Minimum value for safety motion before fifth rotary axis
		# option: Value
		#____________________________________________________________________________________________
		set id "safety_retract_before_fifth_axis_minimum_value"
		set $id		0.0
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"DOUBLE"
				set access($id) 	222
				set dialog($id) 	{{Minimum Value for Safety Retract Before Fifth Axis}}
				set descr($id) 		{{Sets the minimum value for the fifth axis rotary move.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# RETURN: return motion value or variable
		# option: "value" / "supa"
		#____________________________________________________________________________________________
		set id "return_mode"
		set $id		"value"
				set options($id) 	{Value|Supa}
				set options_ids($id) 	{value|supa}
				set access($id) 	222
				set dialog($id) 	{{Return Mode}}
				set descr($id) 		{{Sets the desired output format for the return move after a tool change. Option Value generates a return move based on the mom_sys_home_pos values. Option Supa generates a return move based on the machine reference coordinate system (G28).}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# RETURN: return motion before first tool change
		# option: "Z XY" / "Z" / "" / ...
		# the block template name is also possible
		# e.g. "trafoof Z tool_change_return_home"
		#____________________________________________________________________________________________
		set id "return_before_first_tool_change_pos"
		set $id		"Z"
				set options($id) 	{Z XY|Z X|Z|X|None|Custom Procedure}
				set options_ids($id) 	{Z XY|Z X|Z|X||*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id)	 	222
				set dialog($id) 	{{Return before First Tool Change Pos}}
				set descr($id) 		{{Defines the return motion before the first tool change. Select Z XY, Z X, Z or X, to output the axis moves in the desired order. Select None if you do not want a retract. You can also select Custom Procedure to define a list of block templates or a TCL procedure. The custom procedure output is handled through the post configurator procedure LIB_RETURN_move_LIB_ENTRY.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# RETURN: return motion before tool change, end of program
		# option: "Z XY" / "Z" / ...
		#____________________________________________________________________________________________
		set id "return_tool_change_pos"
		set $id         "Z"
				set options($id) 	{Z XY|Z|X|None|Custom Procedure}
				set options_ids($id) 	{Z XY|Z|X||*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Return Tool Change Pos}}
				set descr($id) 		{{Defines the return motion before all tool changes except the first one, and for the end of the program. Select Z XY, Z X, Z or X, to output the axis moves in the desired order. Select None if you do not want a retract. You can also select Custom Procedure to define a list of block templates or a TCL procedure. The custom procedure output is handled through the post configurator procedure LIB_RETURN_move_LIB_ENTRY.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# RETURN: return safety position
		# option: "Z XY" / "Z" / ...
		#____________________________________________________________________________________________
		set id "return_safety_pos"
		set $id		"Z"
				set options($id) 	{Z XY|Z|X|None|Custom Procedure}
				set options_ids($id) 	{Z XY|Z|X||*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Return Safety Pos}}
				set descr($id) 		{{Defines the return motion to the safety position. Select Z XY, Z X, Z or X to output the axis moves in the desired order. Select None if you do not want a retract. You can also select Custom Procedure to output an existing block template or the name of an argument to be handled through the procedure LIB_RETURN_move_LIB_ENTRY.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# RETURN: return motion before end of program
		# option: "Z XY" / "Z" / ...
		#____________________________________________________________________________________________
		set id "return_end_of_pgm"
		set $id		"Z"
				set options($id) 	{Z XY|Z|X|4th|5th|4th5th|None|Custom Procedure}
				set options_ids($id) 	{Z XY|Z|X|4th|5th|4th5th||*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Return End of Program}}
				set descr($id) 		{{Defines the return motion to the safety position. Select Z XY, Z, X, 4th, 5th, or 4th5th to output the axis moves in the desired order. Select None if you do not want a retract. You can also select Custom Procedure to output an existing block template or the name of an argument to be handled through the procedure LIB_RETURN_move_LIB_ENTRY.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# RETURN: limit action output
		# option: "Warning" / "EngageRetract" / "UserDefined"
		#____________________________________________________________________________________________
		set id rot_limit_action
		set $id 0
			set options($id)	{Warning|Engage Retract|User Defined}
			set options_ids($id) 	{0|1|*VALUE*}
			set access($id) 	222
			set datatype($id)       "COMMANDBLOCK"
			set dialog($id) 	{{Rotary Axis Limit Action when Limit is Attained}}
			set descr($id) 	{{Sets the desired action to be taken when the rotary axis limit is reached. Select Warning to output a warning message to the log file. Select Engage Retract to output a retract move, a rotary positioning move, and an engage move back to the part. You may also select User Defined to define a list of block templates or a TCL procedure.}}
			set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
			set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# RETURN: limit action output
		# option: "only on linear moves" / "on linear and rapid moves"
		#____________________________________________________________________________________________
		set id rot_limit_action_only_linear_move
		set $id 0
			set options($id)	{on Rapid and Linear Moves|on Linear Moves Only}
			set options_ids($id) 	{0|1}
			set access($id) 	122
			set datatype($id) INT ;#INT DOUBLE STRING MULTISTRING
			set dialog($id) 	{{Rotary Axis Limit Action Output}}
			set descr($id) 	{{Specifies if a rotary axis limit action should always be output or should only be output when the limit is reached in a linear move.}}
			set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
			set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# RETURN: standard toolpath when tool_axis changes for positioning path or not
		# option: "0" / "1"
		#	"0" : return_safety_pos definition is used
		# 	"1" : the output links to standard toolpath from NX
		#	      the post recognizes automatically motions which need to switch in simultaneous
		#____________________________________________________________________________________________
		set id "standard_path_between_rotary_motions"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Use Standard Path between Rotary Motion}}
				set descr($id) 		{{Defines the logic that is used when the tool axis changes in a positioning move. If this option is set to On, it uses the NX standard path output. If this option is set to Off, the postprocessor outputs a retract move as configured in Return Safety Pos before the positioning move.}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetr"
				set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# CIRCLE: to ouput(I,J,K) or R
		# R address is ouput only if the circular motion is less than 180 degrees and turbo mode is unactivated
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "always_center_for_circle"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Circular Move Always with IJK}}
				set descr($id) 		{{Sets the output block format for circular moves. If set to On, the postprocessor outputs circular moves with center point values (IJK). If set to Off, the postprocessor outputs circular moves with radius values (R), provided the circular angle is below 180 degrees and Turbo mode is also set to Off.}}
				set ui_parent($id) "@CUI_ArcOutputGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# POLAR: to set polar status at the begining of the post
		# option: ON / OFF
		#____________________________________________________________________________________________
		set id "polar_status_start_of_prog"
		set $id		"OFF"
				set options($id)	{Off|On}
				set options_ids($id) 	{OFF|ON}
				set access($id) 	222
				set dialog($id) 	{{Polar Mode Status at Start of Program}}
				set descr($id) 		{{Sets the polar mode at the start of the program, when you select On. Rapid moves are output in polar coordinates for operations where the tool axis is perpendicular to a rotary axis. For example: On a millturn machine, the rapid move to each hole of a drilling operation on the face of a part is output in polar coordinates. Select Off to deactivate polar mode at the start of the program.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# POLAR: unactivate polar mode for each end of path
		# option: Reset / Keep
		#____________________________________________________________________________________________
		set id "polar_off_end_of_path"
		set $id		"OFF"
				set options($id)	{Reset|Keep}
				set options_ids($id) 	{OFF|ON}
				set access($id) 	222
				set dialog($id) 	{{Polar Mode Status for Each End of Path}}
				set descr($id) 		{{This influences only operations that are set to polar output. If the polar mode is active, it remains active until it is switched off in the operation. Select Reset to switch off the polar mode at each end of path. Select Keep to have no effect on the status of the polar mode.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# POLAR: set transmit mode
		# option: ON / OFF
		#____________________________________________________________________________________________
		set id "polar_transmit"
		set $id		"OFF"
				set options($id)	{Off|On}
				set options_ids($id) 	{OFF|ON}
				set access($id) 	222
				set dialog($id) 	{{Set Polar Coordinate Interpolation Mode.}}
				set descr($id) 		{{Activates the polar interpolation mode (G112 or G12.1) for the cutting moves of milling operations, when set to On. Select Off to have no effect on the output for polar mode.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# POLAR: positioning before transmit
		# option: ON / OFF
		#____________________________________________________________________________________________
		set id "prepos_before_transmit"
		set $id         "5th"
				set options($id) 	{5th|5th Z X|None|Custom Procedure}
				set options_ids($id) 	{5th|5th_Z_X||*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Approach Motion Before Interpolation Mode.}}
				set descr($id) 		{{Defines the approach motion before interpolation mode. Select fifth Z X or fifth to output the axis moves in the desired order. Select None if you do not want any motion. You can also select Custom Procedure to define a list of block templates or a TCL procedure.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1
				
		#____________________________________________________________________________________________
		# POLAR: set polar mode also for linear motions (linearization)
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "polar_feedrate"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Set Polar Mode also for Linear Motions}}
				set descr($id) 		{{Divides each cutting move of a milling path into multiple line segments when polar interpolation is not active (e.g. no G112 or G12.1) and you select On. Select Off to have no effect on the output for the polar mode.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# POLAR: reference vector for polar mode (X+ by default)
		# option: X+ / Y+ / Z+ / X- / Y- / Z-
		#____________________________________________________________________________________________
		set id "polar_vector_ref"
		set $id		"X+"
				set options($id)	{X+|Y+|Z+|X-|Y-|Z-}
				set options_ids($id) 	{X+|Y+|Z+|X-|Y-|Z-}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Set Reference Vector for Polar Mode}}
				set descr($id) 		{{Defines the direction perpendicular to the rotary axis where the current point is calculated for the polar mode.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# POLAR: defines the motion types where polar mode should be used
		# option: ALL / "RAPID CYCLE"
		#____________________________________________________________________________________________
		set id "polar_allowed_moves"
		set $id		"ALL"
				set options($id)	{ALL|RAPID CYCLE}
				set options_ids($id) 	{ALL|RAPID_CYCLE}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Set enabled Moves for Polar Mode}}
				set descr($id) 		{{Defines the motion types where polar output should be used. Select ALL then "TRAVERSAL" "RETURN" "RAPID" "ENGAGE" "DEPARTURE" "RETRACT" "APPROACH" "CYCLE" are used. Select RAPID CYCLE then only motion type "RAPID" and "CYCLE" are output as polar coordinates.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# POLAR: enable polar mode with plane output
		# option: ON / OFF
		#____________________________________________________________________________________________
		set id "enable_polar_with_plane"
		set $id		"OFF"
				set options($id)	{Off|On}
				set options_ids($id) 	{OFF|ON}
				set access($id) 	222
				set dialog($id) 	{{Enable Polar Mode with Plane Output}}
				set descr($id) 		{{Allow polar mode together with plane output.}}
				set ui_parent($id) "@CUI_MotionSettingPolarGroup"
				set ui_sequence($id) -1		
		#____________________________________________________________________________________________
		# RESET: reset current rotary axis for each end of path
		# option: ON / OFF
		#____________________________________________________________________________________________
		set id "reset_rotary_axis_end_of_path"
		set $id		"OFF"
				set options($id)  {Off with logic|On with logic|SpecificLogic}
				set options_ids($id)   {OFF|ON|*VALUE*}
				set datatype($id)   "COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Reset Rotary Axis for Each End of Path}}
				set descr($id) 		{{When there are alternative positions for the next motion, this property influences calculation. Calculation starts with the rotary axis at zero when you select On. Calculation starts with the current rotary axis positions when you select Off.\\n\\n\
					Off: When next Operation has an MCS change\\n\\n\
					On with logic: When next Operation has an Tool Axis Change\\n\
						When next Operation is an simultaneous Operation\\n\
						When next Operation has an MCS change\\n\\n\
					SpecificLogic: Define you own logic. The return Value should be 1 if reset should happen}}
				set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# RETURN: rotary axis degenerated solution action output
		# option: "Warning" / "UserDefined"
		#____________________________________________________________________________________________
		set id "rot_axis_degenerated_sol_action"
		set $id 0
			set options($id)	{Warning|User Defined}
			set options_ids($id) 	{0|*VALUE*}
			set access($id) 	222
			set datatype($id)       "COMMANDBLOCK"
			set dialog($id) 	{{Rotary Axis Degenerated Solution Action Output}}
			set descr($id) 	{{Sets the desired action to be taken when the rotary axis solution is degenerated. Select Warning to output a warning message to the log file. You may also select User Defined to define a list of block templates or a TCL procedure.}}
			set ui_parent($id) "@CUI_MotionSettingAdditionalRetrRot"
			set ui_sequence($id) -1
	}

	LIB_GE_CREATE_obj CONF_CTRL_origin {} {
		LIB_GE_property_ui_name "Coordinate System"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# ORIGIN: main origin used (G54,...)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "use_main"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Use Main}}
				set descr($id) 		{{Outputs the work coordinate system that matches the fixture offset value (1=G54, 2=G55, etc.) for each MCS, when set to On. The operation coordinates are output relative to this main coordinate system.}}
				set ui_parent($id) "@CUI_CSYSGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# ORIGIN: local origin used (TRANS,...)
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "use_local"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Use Local}}
				set descr($id) 		{{Outputs a zero point shift (G68.2) for a local MCS provided the MCS geometry structure and post configurator options for the plane output are set appropriately, when set to On. The zero point shift values are relative to the current work coordinate system. The operation coordinates are output relative to this local coordinate system.}}
				set ui_parent($id) "@CUI_CSYSGroup"
				set ui_sequence($id) -1

	}

	LIB_GE_CREATE_obj CONF_CTRL_setting {} {
		LIB_GE_property_ui_name "General Controller Settings"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# HEADER : to choose between different possibilities
		# option: output_file_basename / selected_group / ude_dnc_header (for siemens dnc_header UDE) / ude (mom_lib_header_name) / ignore
		#____________________________________________________________________________________________
		set id "header_name"
		set $id		"selected_group"
				set options($id) 	{Output File Base Name|Selected Group|UDE Dnc Header|UDE|Ignore|mom_attr_PROGRAMVIEW_PROGRAM_NUMBER|Custom Procedure}
				set options_ids($id) 	{output_file_basename|selected_group|ude_dnc_header|ude|ignore|mom_attr_PROGRAMVIEW_PROGRAM_NUMBER|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Header Name}}
				set descr($id) 		{{Sets the source for the header. The specified information source is used as header name. For Template post an O is added as a prefix to the name. You may ignore the header or call a procedure where you can create your own header. In this last case, corresponding variable to set is 'lib_nc_header_number' wich is used in Block Template 'header_program' \\n\
				'ude_dnc_header' : procedure 'LIB_CTRL_dnc_header' can be used for DNC Header output as an placeholder, corresponding variable to set is 'mom_dnc_program_name'\\n\
				'ude' : define your own UDE the corresponding variable to set is 'mom_lib_program_name'}}
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Output Diameter = 2 , Radius = 1 (only for TURNING) , Custom Value
		# option: 1 / 2 / *VALUE*
		#____________________________________________________________________________________________
		set id "x_factor"
		set $id		1
				set options($id) 	{Radius|Output Diameter|Custom Value}
				set options_ids($id) 	{1|2|*VALUE*}
				set access($id) 	222
				set dialog($id) 	{{X-Factor for Turning}}
				set descr($id) 		{{Outputs the radius or the diameter for the X-axis position values for turning operations.}}
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : i_factor for Turning Operations Normal = 1 , Negate = -1 , Custom Value
		# option: 1 / -1 / *VALUE*
		#____________________________________________________________________________________________
		set id "i_factor"
		set $id		1
				set options($id) 	{Normal|Negate|Custom Value}
				set options_ids($id) 	{1|-1|*VALUE*}
				set access($id) 	222
				set dialog($id) 	{{I-Factor for Turning}}
				set descr($id) 		{{Define i_factor for turning operations.}}
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SPINDLE : Output Diameter = 2 , Radius = 1 (only for MILLING) , Custom Value
		# option:  1 / 2 / *VALUE*
		#____________________________________________________________________________________________
		set id "x_factor_mill"
		set $id		1
				set options($id) 	{Radius|Output Diameter|Custom Value}
				set options_ids($id) 	{1|2|*VALUE*}
				set access($id) 	222
				set dialog($id) 	{{X-Factor for Milling}}
				set descr($id) 		{{Outputs the radius or the diameter for the X-axis position values for milling operations. 		\\n\
								Output Diameter X-Factor for Milling is set to 'Advanced Turbo' 				\\n\
								in LIB_SPF_check_x_factor NX11 and higher. 							\\n\
								At lower Version Turbo Mode is set to OFF												
							}}
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1
				
		#____________________________________________________________________________________________
		# SPINDLE : i_factor for Milling Operations Normal = 1 , Negate = -1 , Custom Value
		# option: 1 / -1 / *VALUE*
		#____________________________________________________________________________________________
		set id "i_factor_mill"
		set $id		1
				set options($id) 	{Normal|Negate|Custom Value}
				set options_ids($id) 	{1|-1|*VALUE*}
				set access($id) 	222
				set dialog($id) 	{{I-Factor for Milling}}
				set descr($id) 		{{Define i_factor for for milling operations. 		\\n\
								Output I-Factor for Milling is set to 'Advanced Turbo' 				\\n\
								in LIB_SPF_check_x_factor NX11 and higher. 							\\n\
								At lower Version Turbo Mode is set to OFF												
							}}								
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: positioning mode supported
		# option: "ALL" / "NO_ORTHOGONAL" / "NONE"
		#____________________________________________________________________________________________
		set id "plane_output_supported"
		set $id         "NO_ORTHOGONAL"
				set options($id) 	{All|Non Orthogonal|All Except ZM|None}
				set options_ids($id) 	{ALL|NO_ORTHOGONAL|ALL_EXCEPT_ZM|NONE}
				set access($id) 	222
				set dialog($id) 	{{Plane Output Supported}}
				set descr($id) 		{{Activates positioning mode support (G68.x) for milling operations.	                       \\n\
																                       \\n\
								All= output G68 for all planes.					                       \\n\
								Non Orthogonal= output G68 for all planes except orthogonal planes                     \\n\
								All Except ZM= output G68 for all planes except when tool axis is parallel to main ZM \\n\
								None= Do not output G68						                       \
							}}
				set ui_parent($id) "@CUI_CtrlOutModePlane"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: local namespace output
		# option: "On" / "Off"
		#____________________________________________________________________________________________
		set id "local_ns_output"
		if {[info exists ::pc_initial_library_release_of_post] && $::pc_initial_library_release_of_post > 50508} {
			set $id "1" 
		} else {
			set $id "0"
		}
				set options($id) 	{Off|On}
				set options_ids($id) 	{0|1}
			if {$::mom_sys_enable_nc_optimizer == "ON"} {
				set access($id)     000
			} else {
				set access($id) 	222
			}
				set dialog($id) 	{{Local Namespace Output}}
				set descr($id) 		{{Define a local namespace for local coordinate system established by the post or user.        \\n\
								When turned on, Related variables are mapped from global namespace to local namespace, \\n\
								and all output of current operation is relative to this local coordinate system.       \\n\
								This option is useful in NX12.0.2 and later version.                                   \\n\
								It will be automatically turned to on with advanced postprocessing.						\
							}}
				set ui_parent($id) "@CUI_CtrlOutModePlane"
				set ui_sequence($id) -1
				set allow_chain($id) 0
		
		#____________________________________________________________________________________________
		# MILLING: Rotate Method
		# option: "Vector" / "Rotary Angle"
		#____________________________________________________________________________________________
		set id "lib_3d_rot_method"
		set $id         "VECTOR"
				set options($id) 	{Vector|Rotary Angle}
				set options_ids($id) 	{VECTOR|ROTARY_ANGLE}
				set access($id) 	222
				set dialog($id) 	{{Rotate Method}}
				set descr($id) 		{{Sets the rotary methode for milling operation. This option should be used together with 'Local Namespace Output ON'.      \\n\
                                    Vector = if X or Y vector of G54 is orthogonal with tool axis vector, using tool axis vector as rotated coordinate Z axis   \\n\
                                             and keep that X or Y vector as rotated coordinate X or Y vector. Rotary Angle = using machine real rotary angles   \\n\
											 as rotation angle of rotated coordinate system.}}
				set ui_parent($id) "@CUI_CtrlOutModePlane"
				set ui_sequence($id) -1
				
		#____________________________________________________________________________________________
		# MILLING: simultaneous mode supported
		# option: "ALL" / "NONE"
		#____________________________________________________________________________________________
		set id "tcpm_output_supported"
		set $id         "ALL"
				set options($id) 	{Off|On}
				set options_ids($id) 	{NONE|ALL}
				set access($id) 	222
				set dialog($id) 	{{TCPM Output Supported}}
				set descr($id) 		{{Turns simultaneous mode support for milling operations on or off.}}
				set ui_parent($id) "@CUI_CtrlOutModeTCPM"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: simultaneous mode type
		# option: "FIX_ON_MACHINE" / "FIX_ON_TABLE"
		#____________________________________________________________________________________________
		set id "fix_on_machine"
		set $id		0
				set options($id) 	{Fix on Machine|Fix on Table}
				set options_ids($id)	{0|1}
				set access($id) 	222
				set dialog($id) 	{{TCPM Mode}}
				set descr($id) 		{{Uses a coordinate system fixed on the table or a coordinate system fixed on the machine as the programming coordinate system.}}
				set ui_parent($id)  "@CUI_CtrlOutModeTCPM"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING : to choose between axis or angle rotary output used with TCPM mode
		# option: vector / angle
		#____________________________________________________________________________________________
		set id "tcpm_output"
		set $id		"angle"
				set options($id) 	{Vector|Angle}
				set options_ids($id) 	{vector|angle}
				set access($id) 	222
				set dialog($id) 	{{TCPM Output}}
				set descr($id) 		{{Sets the block format to either tool axis vectors or rotary angles for simultaneous milling operations.}}
				set ui_parent($id) "@CUI_CtrlOutModeTCPM"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING : to activate or not Output Mode Absolute
		# option: All / None
		#____________________________________________________________________________________________
		set id "absolute_output_mode"
		set $id         "NONE"
				set options($id) 	{Off|On}
				set options_ids($id) 	{NONE|ALL}
				set access($id) 	222
				set dialog($id) 	{{Absolute Output Mode}}
				set descr($id) 		{{Turns the absolute output mode on or off for milling operations.}}
				set ui_parent($id) "@CUI_CtrlOutModeAbs"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: calculation in absolute mode
		# option: "TOOL TIP" / "TOOL MOUNT"
		#____________________________________________________________________________________________
		set id "absolute_ref_point"
		set $id         "TOOL_TIP"
				set options($id) 	{Tool Tip|Tool Mount}
				set options_ids($id) 	{TOOL_TIP|TOOL_MOUNT}
				set access($id) 	222
				set dialog($id) 	{{Absolute Output Reference Point}}
				set descr($id) 		{{Outputs points in absolute mode with or without tool length adjustment.}}
				set ui_parent($id) "@CUI_CtrlOutModeAbs"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# TURBO: status
		# option: 0 /1
		# If you like for each event a messages, you have to switch it of
		# So it's lib_spf(output_event_message) active
		#____________________________________________________________________________________________
		set id "turbo_mode"
		set $id		2
				set options($id)	{Off|Auto|On|Advanced}
				set options_ids($id) 	{0|2|1|3}
				set access($id) 	222
				set dialog($id) 	{{Turbo Mode}}
				set descr($id) 		{{Activates Turbo mode to reduce postprocessing time for simple motion output, when set to On. Turbo mode bypasses the Tcl Interpreter and directly outputs the NC code using a C routine. It does not execute Tcl code and does not output messages to the Information window. Turbo mode is not recommended for multi-axis operations before NX11.0.2. Select Advanced for the Advanced turbo mode in NX11.0.2 and later versions. Select Auto to let the postprocessor choose the mode for the best postprocessing performance. Select Off to output NC code in normal mode.}}
				set ui_parent($id) "@CUI_TurboGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CUTCOM: cutcom_on is output alone
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "cutcom_on_alone"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Single Line for Cutcom ON}}
				set descr($id) 		{{Outputs the code for cutcom on as the only code in a block.}}
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CUTCOM: cutcom_off is output alone
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "cutcom_off_alone"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Single Line for Cutcom OFF}}
				set descr($id) 		{{Outputs the code for cutcom off as the only code in a block.}}
				set ui_parent($id) "@CUI_TemplateCutcom"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CUTCOM: output cutcom register
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "cutcom_output"
		set $id		0
				set options($id)	{Standard|Always}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Output Cutcom Register}}
				set descr($id) 		{{The Standard option outputs the cutcom register word only when it is different from the tool number.  \\n\
																				\\n\
								The Always option always outputs the cutcom register word.					\\n\
																				\\n\
								NOTE: If you use the Always option, deactivate turbo_mode.					\
							}}
				set ui_parent($id) "@CUI_TemplateCutcom"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# SEQNO: sequence_number status
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "sequence_number"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Sequence Number}}
				set descr($id) 		{{Outputs sequence numbers.}}
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Output the WORKPIECE in the header of the NC output.
		# option: 0 / 1
		#____________________________________________________________________________________________
		set id "block_form"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Workpiece}}
				set descr($id) 		{{Outputs the Workpiece command (WORKPIECE) in the header of the NC output, when set to 'On'.}}
				set ui_parent($id) "@CUI_BlockFormGroup"
				set ui_sequence($id) -1
				
		#____________________________________________________________________________________________
		# Output cutcom for circular motions.
		# option: 0 not allowed / 1 allowed
		#____________________________________________________________________________________________
		set id "cutcom_on_with_circle_allowed"
		set $id         0
				set options($id)	{Allowed|Not Allowed}
				set options_ids($id) 	{1|0}
				set access($id) 	222
				set dialog($id) 	{{Cutcom ON with Circle Allowed}}
				set descr($id) 		{{Outputs the code for cutcom on with circular motions.}}
				set ui_parent($id) "@CUI_TemplateCutcom"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Output cutcom for tool axis motions.
		# option: 0 not allowed / 1 allowed
		#____________________________________________________________________________________________
		set id "cutcom_on_with_tool_axis_allowed"
		set $id		0
				set options($id)	{Allowed|Not Allowed}
				set options_ids($id) 	{1|0}
				set access($id) 	222
				set dialog($id) 	{{Cutcom ON with Tool Axis Allowed}}
				set descr($id) 		{{Outputs the code for cutcom on with tool axis motions.}}
				set ui_parent($id) "@CUI_TemplateCutcom"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# MILLING: limit_output_angle status
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "limit_output_angle"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Limit Output Angle}}
				set descr($id) 		{{Output rotation angle of the fourth and fifth axis in range of it's soft limit, when set 'On' and satisfy the follow conditions. \\n\
								a.Hard limit of rotary axis is unlimited.\\n\
								b.Soft limit of rotary axis has range equal to 360 degrees, like (0.0, 360.0).\\n\
												\\n\
								Set 'Off' to suppress limit output angle. It is used for version after NX1201.\\n\
							}}
				set ui_parent($id) "@CUI_CtrlOutModeGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Turns Subprogram Output mode support for operations on or off
		#____________________________________________________________________________________________
		set id "subprogram_output"
		set $id         0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	022
				set dialog($id) 	{{Subprogram Output Supported}}
				set descr($id) 		{{Turns Subprogram Output mode support for operations on or off. \\n\
							NOTE: The control of this option can also be controlled via the UDE Program Control.}}
				set ui_parent($id) "@CUI_CtrlOutModeSub"
				set ui_sequence($id) -1
	}

	LIB_GE_CREATE_obj CONF_CTRL_clamp {} {
		LIB_GE_property_ui_name "Clamping"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# CLAMP: clamp status for the machine : not supported or supported or Ude based output
		# option: 0 - Off / 1 - On / 2 - Ude
		#____________________________________________________________________________________________
		set id "status"
		set $id		0
				set options($id)	{Off|On|Ude}
				set options_ids($id) 	{0|1|2}
				set access($id) 	222
				set dialog($id) 	{{Clamp Status}}
				set descr($id) 		{{Sets the Clamp status for the machine.  \\n\
							Ude = Direct output when event is triggerd from MOM}}
				set ui_parent($id) "@CUI_ClampingGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CLAMP: clamp output for fourth axis
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "fourth_axis"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Clamp Fourth Axis}}
				set descr($id) 		{{Outputs the clamp status for the fourth axis if Clamp status is set to On.}}
				set ui_parent($id) "@CUI_ClampingGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# CLAMP: clamp output for fifth axis
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "fifth_axis"
		set $id		0
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Clamp Fifth Axis}}
				set descr($id) 		{{Outputs the clamp status for the fifth axis if Clamp status is set to On.}}
				set ui_parent($id) "@CUI_ClampingGroup"
				set ui_sequence($id) -1
				
		#____________________________________________________________________________________________
		# CLAMP :  Clamping tolerance for Positioning Operation
		# option: 1
		#____________________________________________________________________________________________
		set id "rot_clamp_tolerance"
			set $id		3
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Tolerance to define clamping on Positioning Operations}}
				set descr($id) 		{{Tolerance to define clamping on Positioning Operations.\\n\
									mom_rotary_delta_4th/mom_rotary_delta_5th in LIB_CTRL_clamp_status_axis_check.\\n\
									to check the deltas to react on clamping.\\n\
				}}
				set ui_parent($id) "@CUI_ClampingGroup"
				set ui_sequence($id) -1
	}

	LIB_GE_CREATE_obj CONF_CTRL_coolant {} {
		LIB_GE_property_ui_name "Coolant"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# COOLANT: coolant status used for next tools
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "coolnt_auto"
		set $id		1
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Coolant Auto}}
				set descr($id) 		{{Sets the coolant status to use for the current tool.}}
				set ui_parent($id) "@CUI_CoolantGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# COOLANT: coolant output before motion
		# option: 0 /1
		#____________________________________________________________________________________________
		set id "coolnt_output_before_motion"
		set $id		0
				set options($id)	{Off|On|After First Motion}
				set options_ids($id) 	{0|1|2}
				set access($id) 	222
				set dialog($id) 	{{Coolant Output before Motion}}
				set descr($id) 		{{Outputs the Coolant status on a single line before the next programmed motion. If this setting is OFF, the Coolant status is output with the next programmed motion.}}
				set ui_parent($id) "@CUI_CoolantGroup"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# COOLANT: default status at the beginning of nc program
		# option: ON / MIST / OFF / ...
		#____________________________________________________________________________________________
		set id "coolant_status"
		set $id		"OFF"
				set options($id) 	{On|Mist|Off|Custom Value}
				set options_ids($id) 	{ON|MIST|OFF|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Coolant Status}}
				set descr($id) 		{{Sets the default coolant status at the beginning of the NC program.}}
				set ui_parent($id) "@CUI_CoolantGroup"
				set ui_sequence($id) -1

	}

	LIB_GE_CREATE_obj CONF_CTRL_probe {} {
		LIB_GE_property_ui_name "Probing"
		LIB_GE_property_ui_tooltip ""
		#____________________________________________________________________________________________
		# PROBING: supported probing module
		# option: none / UDE / UC
		#____________________________________________________________________________________________
		set id "supported_type"
		set $id		"none"
				set options($id) 	{None|UDE|UC Adaptive Probing}
				set options_ids($id) 	{none|ude|uc}
				set access($id) 	000
				set dialog($id) 	{{Supported Probing Module}}
				set descr($id) 		{{Set supported types for probing.}}
		#____________________________________________________________________________________________
		# PROBING: tool number (mom_tool_number) for probing tool
		# option: Value
		#____________________________________________________________________________________________
		set id "toolnr"
		set $id		""
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Probing Tool Number}}
				set descr($id) 		{{Set list of tool numbers for probing tools.}}
		#____________________________________________________________________________________________
		# PROBING: tool name (mom_tool_name) for probing tool
		# option: Value
		#____________________________________________________________________________________________
		set id "toolname"
		set $id		"PROBE"
				set options($id) 	{Custom Value}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Probing Tool Name}}
				set descr($id) 		{{Set list of tool names for probing tools.}}
		#____________________________________________________________________________________________
		# PROBING: tool_change_type for probing tool
		# option: AUTO / MANUAL / IGNORE
		#____________________________________________________________________________________________
		set id "tool_change_type"
		set $id		"AUTO"
				set options($id) 	{Auto|Manual}
				set options_ids($id) 	{AUTO|MANUAL}
				set access($id) 	000
				set dialog($id) 	{{Tool Change Type for Probing Tool}}
				set descr($id) 		{{Set tool change type for probing tools.}}
	}
	LIB_GE_CREATE_obj CONF_CTRL_feed {} {
		LIB_GE_property_ui_name "Feedrate_setting"
		LIB_GE_property_ui_tooltip ""

		#____________________________________________________________________________________________
		# Output rapid motions as Value or G0.
		# option: G0 (F Maximum) , F9999 (Value)
		#____________________________________________________________________________________________
		set id "feed_max"
		set $id		"G0"
				set options($id) 	{G0|F Value}
				set options_ids($id) 	{G0|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Feed Max}}
				set descr($id) 		{{Output rapid motions with 'G1 F Value' or 'G0'.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# FEED: linear_feed motion output as AUTO or Value or Parameter
		# option: 0 (Value) , 1 (AUTO), "21 22 23 24 25" (Parameter)
		#____________________________________________________________________________________________
		set id "feed_linear"
				set $id		0
				set options($id) 	{Value|Param}
				set options_ids($id) 	{0|2}
				set access($id) 	222
				set dialog($id) 	{{Feed Linear}}
				set descr($id) 		{{Sets the cutting feed as an NX value or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1
				
		#____________________________________________________________________________________________
		# Message setting
		# message start for param feedrate
		#____________________________________________________________________________________________
		set id "param_feed_dspa1"
		set $id		{}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Param Feedarate Leader}}
				set descr($id) 		{{Sets the leader for Param Feedarate output in the NC code.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# Message setting
		# message end for param feedrate
		#____________________________________________________________________________________________
		set id "param_feed_dspz1"
		set $id		{}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Param Feedarate Trailer}}
				set descr($id) 		{{Sets the trailer for the Param Feedarate output in the NC code.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_cycle status
		# option: NX|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_cycle"
		set $id		NX
				set options($id) 	{NX Value|Parameter}
				set options_ids($id) 	{NX|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Cycle Feed}}
				set descr($id) 		{{Sets the cycle feed as an NX value or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_engage status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_engage"
		set $id		"\#21"
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Engage Feed}}
				set descr($id) 		{{Sets the engage feed as an NX value, a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_cut status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_cut"
		set $id		"\#22"
				set options($id) 	{Parameter}
				set options_ids($id) 	{*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Cut Feed}}
				set descr($id) 		{{Defines the parameter name to be output in place of the cutting feed (for example #22).}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_retract status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_retract"
		set $id		"\#23"
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Retract Feed}}
				set descr($id) 		{{Sets the retract feed as an NX value, a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_approach status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_approach"
		set $id		NX
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Approach Feed}}
				set descr($id) 		{{Sets the approach feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_lastcut status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_lastcut"
		set $id		P_CUT
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Last Cut Feed}}
				set descr($id) 		{{Sets the last cut feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_firstcut status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_firstcut"
		set $id		P_CUT
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{First Cut Feed}}
				set descr($id) 		{{Sets the first cut feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1
		#____________________________________________________________________________________________
		# feed: feed_sidecut status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_sidecut"
		set $id		P_CUT
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Side Cut Feed}}
				set descr($id) 		{{Sets the side cut feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_stepover status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_stepover"
		set $id		P_CUT
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Stepover Feed}}
				set descr($id) 		{{Sets the stepover feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_traversal status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_traversal"
		set $id		NX
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Traversal Feed}}
				set descr($id) 		{{Sets the traversal feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_return status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_return"
		set $id		NX
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Return Feed}}
				set descr($id) 		{{Sets the return feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_departure status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_departure"
		set $id		NX
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Departure Feed}}
				set descr($id) 		{{Sets the departure feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_crossover status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_crossover"
		set $id		NX
				set options($id) 	{NX Value|%Cut|Parameter}
				set options_ids($id) 	{NX|P_CUT|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	222
				set dialog($id) 	{{Crossover Feed}}
				set descr($id) 		{{Sets the crossover feed as an NX value or a percent of the cutting feed, or a parameter.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_from status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_from"
		set $id		NX
				set options($id) 	{NX Value|%Cut}
				set options_ids($id) 	{NX|P_CUT}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{From Feed}}
				set descr($id) 		{{Sets the from feed as an NX value or a percent of the cutting feed.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_gohome status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_gohome"
		set $id		NX
				set options($id) 	{NX Value|%Cut}
				set options_ids($id) 	{NX|P_CUT}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Gohome Feed}}
				set descr($id) 		{{Sets the gohome feed as an NX value or a percent of the cutting feed.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_gohome_default status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_gohome_default"
		set $id		NX
				set options($id) 	{NX Value|%Cut}
				set options_ids($id) 	{NX|P_CUT}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Gohome_default Feed}}
				set descr($id) 		{{Sets the gohome_default feed as an NX value or a percent of the cutting feed.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

		#____________________________________________________________________________________________
		# feed: feed_rapid status
		# option: NX|P_CUT|*VALUE*
		#____________________________________________________________________________________________
		set id "feed_rapid"
		set $id		NX
				set options($id) 	{Value|Parameter}
				set options_ids($id) 	{NX|*VALUE*}
				set datatype($id) 	"STRING"
				set access($id) 	000
				set dialog($id) 	{{Rapid Feed}}
				set descr($id) 		{{Sets the rapid feed as an NX value or a parameter of the cutting feed.}}
				set ui_parent($id) "@CUI_MotionSettingFeedParam"
				set ui_sequence($id) -1

	}

	LIB_GE_CREATE_obj CONF_CTRL_initial {} {
		LIB_GE_property_ui_name "Initial statues of start program"
		LIB_GE_property_ui_tooltip ""
		set property_id         "CONF_CTRL_initial"

		#____________________________________________________________________________________________
		# Set the initial status.
		# option: ON / OFF  Output of all lines disabled or enabled
		#____________________________________________________________________________________________
		set id "initial_status"
		set $id		"0"
				set options($id)	{Off|On|Custom Procedure}
				set options_ids($id) 	{0|1|*VALUE*}
				set datatype($id) 	"COMMANDBLOCK"
				set access($id) 	222
				set dialog($id) 	{{Enable Initial Status}}
				set descr($id) 		{{Enables the output of all initial values.}}
				set ui_parent($id)      "@CUI_InitialStatusGroup"
				set ui_sequence($id)    -1

		#____________________________________________________________________________________________
		# Set the machine mode of the first operation.
		# option: ON / OFF  Output the Plane reset code
		#____________________________________________________________________________________________
		set id "machine_mode"
		set $id		"0"
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	000
				set dialog($id) 	{{Machine mode}}
				set descr($id) 		{{Set the machine mode of the first operation.}}
				set ui_parent($id)      "@CUI_InitialStatusGroupSettings"
				set ui_sequence($id)    -1

		#____________________________________________________________________________________________
		# Set the swiveling plane reset status.
		# option: ON / OFF  Output the Plane reset code
		#____________________________________________________________________________________________
		set id "reset_plane"
		set $id		"1"
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Plane Reset}}
				set descr($id) 		{{Reset the Swiveling Plane mode.}}
				set ui_parent($id)      "@CUI_InitialStatusGroupSettings"
				set ui_sequence($id)    -1

		#____________________________________________________________________________________________
		# Set the reset tcpm status.
		# option: ON / OFF  Output the Tool Center Point (TCPM) code
		#____________________________________________________________________________________________
		set id "reset_tcpm"
		set $id		"1"
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{TCP Reset}}
				set descr($id) 		{{Reset the Tool Center Point mode (TRAFOOF).}}
				set ui_parent($id)      "@CUI_InitialStatusGroupSettings"
				set ui_sequence($id)    -1

		#____________________________________________________________________________________________
		# Output Zero Point.
		# option: ON / OFF  Output the Zero Point 
		#____________________________________________________________________________________________
		set id "fixture_offset"
		set $id		"0"
				set options($id)	{Off|On}
				set options_ids($id) 	{0|1}
				set access($id) 	222
				set dialog($id) 	{{Fixture Offset}}
				set descr($id) 		{{Output Fixture offset (G54...).}}
				set ui_parent($id)      "@CUI_InitialStatusGroupSettings"
				set ui_sequence($id)    -1

	}

	LIB_GE_CREATE_obj CONF_CTRL_additive {} {
		LIB_GE_property_ui_name        "Additive"
		LIB_GE_property_ui_tooltip     "Tooltip"

		set id "ADDITIVE_deposition_on"
		set $id "M74"
		set options($id)        {*VALUE*}
		set options_ids($id)    {*VALUE*}
		set datatype($id)       "STRING"
		set access($id)         222
		set dialog($id)         {{Deposition On}}
		set descr($id)          {{Defined value to switch deposition on.}}
		set ui_parent($id)      "@CUI_DepositionOutputData"
		set ui_sequence($id)    -1

		set id "ADDITIVE_deposition_off"
		set $id "M75"
		set options($id)        {*VALUE*}
		set options_ids($id)    {*VALUE*}
		set datatype($id)       "STRING"
		set access($id)         222
		set dialog($id)         {{Deposition Off}}
		set descr($id)          {{Defined value to switch deposition off.}}
		set ui_parent($id)      "@CUI_DepositionOutputData"
		set ui_sequence($id)    -1

		set id "ADDITIVE_deposition_template"
		set $id "additive_deposition"
		set options($id)        {*VALUE*}
		set options_ids($id)    {*VALUE*}
		set datatype($id)       "STRING"
		set access($id)         222
		set dialog($id)         {{Deposition Output Template Name}}
		set descr($id)          {{Name of block template called to output deposition code.}}
		set ui_parent($id)      "@CUI_DepositionOutputData"
		set ui_sequence($id)    -1

		set id "ADDITIVE_height_template"
		set $id "additive_height"
		set options($id)        {*VALUE*}
		set options_ids($id)    {*VALUE*}
		set datatype($id)       "STRING"
		set access($id)         222
		set dialog($id)         {{Height Template Name}}
		set descr($id)          {{Name of block template called to output the deposition height setting.}}
		set ui_parent($id)      "@CUI_DepositionOutputData"
		set ui_sequence($id)    -1

		set id "ADDITIVE_width_template"
		set $id "additive_width"
		set options($id)        {*VALUE*}
		set options_ids($id)    {*VALUE*}
		set datatype($id)       "STRING"
		set access($id)         222
		set dialog($id)         {{Width Template Name}}
		set descr($id)          {{Name of block template called to output the deposition width setting.}}
		set ui_parent($id)      "@CUI_DepositionOutputData"
		set ui_sequence($id)    -1

		set id "ADDITIVE_advanced_turbo_callback"
		set $id ""
		set options($id)        {*VALUE*}
		set options_ids($id)    {*VALUE*}
		set datatype($id)       "COMMANDBLOCK"
		set access($id)         222
		set dialog($id)         {{Custom Advanced Turbo Callback}}
		set descr($id)          {{Executes the specified callback code defined in start of path.}}
		set ui_parent($id)      "@CUI_DepositionOutputData"
		set ui_sequence($id)    -1
	}

	LIB_GE_CREATE_obj CONF_CTRL_additive_Coolant_Time {} {
		LIB_GE_property_ui_name        "Additive"
		LIB_GE_property_ui_tooltip     "Tooltip"

		set id "Additive_coolant_time_bool"
		set $id 1
		set options($id)        {Off|On}
		set options_ids($id)    {0|1}
		set access($id)         222
		set dialog($id)         {{Activate Coolant Time}}
		set descr($id)          {{Output Coolant time between regions.}}
		set ui_parent($id)      "@CUI_CoolantTimeData"
		set ui_sequence($id)    -1

		set id "Additive_coolant_time_template"
		set $id "delay"
		set options($id)        {*VALUE*}
		set options_ids($id)    {*VALUE*}
		set datatype($id)       "STRING"
		set access($id)         222
		set dialog($id)         {{Coolant Time Template Name}}
		set descr($id)          {{Name of called block template for cooling time output.}}
		set ui_parent($id)      "@CUI_CoolantTimeData"
		set ui_sequence($id)    -1

	}

	#____________________________________________________________________________________________
	# <Flag> MILLING : mode (default status)
	#	option: std / pos /sim
	#____________________________________________________________________________________________
	set lib_flag(mode_current_status) 			"std"

	#____________________________________________________________________________________________
	# <Flag> MACHINING :  For working with local coordinate systems
	#	option: "TRUE" / "FALSE"
	#____________________________________________________________________________________________
	set lib_flag(adv_calc_of_plane) 			"FALSE"
	# Message setting
	#____________________________________________________________________________________________
	# Line :  Maximum length
	#	option: value
	#____________________________________________________________________________________________
	CONF_SPF_file set max_line_length 			80
	#____________________________________________________________________________________________
	# MESSAGE :  Message start (visible on program)
	#	option: value
	#____________________________________________________________________________________________
	CONF_GE_msg set message_dspa1 				$mom_sys_control_out
	#____________________________________________________________________________________________
	# MESSAGE :  Message end (visible on program)
	#	option: value
	#____________________________________________________________________________________________
	CONF_GE_msg set message_dspz1 				$mom_sys_control_in
	#____________________________________________________________________________________________
	# MESSAGE :  Message start2 (visible on controller)
	#	option: value
	#____________________________________________________________________________________________
	CONF_GE_msg set message_dspa2 				"("
	#____________________________________________________________________________________________
	# MESSAGE :  Message end2 (visible on controller)
	#	option: value
	#____________________________________________________________________________________________
	CONF_GE_msg set message_dspz2 				")"
	#____________________________________________________________________________________________
	# MESSAGE :  Message start3 (visible for customer)
	#	option: value
	#____________________________________________________________________________________________
	CONF_GE_msg set message_dspa3 				"\\\\\\\\"
	#____________________________________________________________________________________________
	# MESSAGE :  Message end3 (visible for customer)
	#	option: value
	#____________________________________________________________________________________________
	CONF_GE_msg set message_dspz3 				""
	#____________________________________________________________________________________________
	# MESSAGE :  Message with seqnum
	#	option: 0 / 1
	#____________________________________________________________________________________________
	CONF_GE_msg set message_with_seqnum 			0
	#____________________________________________________________________________________________
	# MESSAGE :  Defines whether comment in uppercases
	#	option: 0 / 1
	#____________________________________________________________________________________________
	CONF_GE_msg set message_to_upper 			1
	#____________________________________________________________________________________________
	# MESSAGE :  Defines whether LIB_SPF_check_cutcom_condition should be executed
	#	option: 0 / 1
	#____________________________________________________________________________________________
	CONF_SPF_warning set cutcom_condition_warning 1
	#____________________________________________________________________________________________
	# MESSAGE : Param Feedrate Message start/end declaration used in LIB_CTRL_feed_output
	#	option: value
	#____________________________________________________________________________________________
	CONF_CTRL_feed set "param_feed_dspa1" {[}
	CONF_CTRL_feed set "param_feed_dspz1" {]}
	#____________________________________________________________________________________________
	# <Flag> ORIGIN: local origin (default value)
	#	option: 0 / 1
	#____________________________________________________________________________________________
	set lib_flag(local_origin_activated) 			0

	#____________________________________________________________________________________________
	# <Flag> defines at what position the comment from MOM_stop event should be output
	#	 options are:
	#	 "along_with_stop", "before_stop" , "after_stop"
	#____________________________________________________________________________________________
	CONF_SPF_msg set stop_comment_pos 			"before_stop"
	#____________________________________________________________________________________________
	# <Flag> Define the new value for the output file suffix
	# Overwrites the MOM variable (mom_output_file_suffix)
	# !!! The postprocessor UI have no more influence !!!
	#____________________________________________________________________________________________
	CONF_SPF_file set output_suffix 			"ptp"
	#____________________________________________________________________________________________
	# <Flag> Define the helical_arc_output_mode
	#
	# Valid values are "END_POINT","LINEAR","QUADRANT","FULL_CIRCLE"
	#  FULL_CIRCLE  -- This mode will output a helix record for each 360
	#                  degrees of the helix.
	#  QUADRANT  --    This mode will output a helix record for each 90
	#                  degrees of the helix.
	#  LINEAR  --      This mode will output the entire helix as linear gotos.
	#  END_POINT --    This mode will assume the control can define an entire
	#                  helix in a single block.
	#____________________________________________________________________________________________
	# CONF_container_arc is not needen, because this is a GlobalLink variable
	set mom_kin_helical_arc_output_mode "FULL_CIRCLE"
	#____________________________________________________________________________________________
	# <Flag> CSE: Create CSE INI file
	#	option: 0 / 1
	#____________________________________________________________________________________________
	CONF_SPF_file set create_cse_ini_file 0

	#____________________________________________________________________________________________
	# IPL conditions to change UI apperance based on some property settings
	#____________________________________________________________________________________________
	#
	LIB_GE_CONF_define_IPL_conditions CONF_CTRL_moves polar_transmit if {$propValue != "OFF"} {
		{value "CONF_CTRL_moves" "polar_feedrate" 0}
		{sensitivity "CONF_CTRL_moves" "polar_feedrate" "false"}
	} else {
		{sensitivity "CONF_CTRL_moves" "polar_feedrate" "true"}
	}
	LIB_GE_CONF_define_IPL_conditions CONF_CTRL_initial initial_status if {$propValue != "1"} {
		{visibility "General_UI_tree" "@CUI_InitialStatusGroupSettings" "false"}
	} else {
		{visibility "General_UI_tree" "@CUI_InitialStatusGroupSettings" "true"}
	}
	LIB_GE_CONF_define_IPL_conditions CONF_CTRL_feed feed_linear if {$propValue == "0"} {
		{visibility "CONF_CTRL_feed" "param_feed_dspa1" "false"}
		{visibility "CONF_CTRL_feed" "param_feed_dspz1" "false"}
	} else {	
		{visibility "CONF_CTRL_feed" "param_feed_dspa1" "true"}
		{visibility "CONF_CTRL_feed" "param_feed_dspz1" "true"}
	}
	LIB_GE_CONF_define_IPL_conditions CONF_CTRL_setting local_ns_output if {$propValue == "0"} {
		{visibility "General_UI_tree" "@CUI_MachkinPreferOutput" "false"}
	} else {
		{visibility "General_UI_tree" "@CUI_MachkinPreferOutput" "true"}
	}
    LIB_GE_CONF_define_IPL_conditions CONF_container_arc mom_kin_arc_output_mode if {$propValue != "FULL_CIRCLE"} {
        {visibility "General_UI_tree" "@CUI_ArcSplitGroup" "false"}
    } else {
        {visibility "General_UI_tree" "@CUI_ArcSplitGroup" "true"}
    }
    LIB_GE_CONF_define_IPL_conditions CONF_CTRL_moves "always_center_for_circle" if {$propValue == "1"} {
        {visibility "General_UI_tree" "@CUI_ArcSplitGroup" "false"}
    } else {
        {visibility "General_UI_tree" "@CUI_ArcSplitGroup" "true"}
    }
}
#____________________________________________________________________________________________
# G codes codes settings for plane output and TCPM mode
#____________________________________________________________________________________________

set mom_sys_tool_axis_dir_ctrl_code		53.1
set mom_sys_home_code				53

set mom_sys_tcpm_control_code(1)		43.4
set mom_sys_tcpm_control_code(2)		43.5
set mom_sys_tcpm_control_code(OFF)		49

set mom_sys_cycle_tap_rigid_code(CLW) 		84.2
set mom_sys_cycle_tap_rigid_code(CCLW) 		84.3

set mom_sys_leader(G_zero) 			"G"	; # default
#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_start_of_program_LIB {} {


	global lib_flag
	set commandcheck(MOM_start_of_program_LIB_ENTRY) [llength [info commands MOM_start_of_program_LIB_ENTRY]]
	set commandcheck(LIB_CTRL_dnc_header) [llength [info commands LIB_CTRL_dnc_header]]
	set commandcheck(LIB_CTRL_nc_header) [llength [info commands LIB_CTRL_nc_header]]
	set commandcheck(LIB_CTRL_sub_header) [llength [info commands LIB_CTRL_sub_header]]
	set commandcheck(LIB_CTRL_parameter_definition) [llength [info commands LIB_CTRL_parameter_definition]]


	LIB_GE_command_buffer MOM_start_of_program_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_program_LIB_ENTRY)} {MOM_start_of_program_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_GE_command_buffer LIB_CTRL_dnc_header
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_dnc_header)} {LIB_CTRL_dnc_header}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

	if {[string match "MOM_start_of_program" [info level -1]]} {
		LIB_GE_command_buffer LIB_CTRL_nc_header
		LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_nc_header)} {LIB_CTRL_nc_header}} @DEFAULT_ENTRY
		LIB_GE_command_buffer {if {[CONF_SPF_msg output_event_message]} {LIB_SPF_output_event_message "Start of Program"}} @EVENT_MESSAGE
		LIB_GE_command_buffer {LIB_SPF_program_header_comment} @HEADER_COMMENT
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer LIB_CTRL_sub_header
		LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_sub_header)} {LIB_CTRL_sub_header}} @DEFAULT_ENTRY
		LIB_GE_command_buffer {LIB_SPF_sub_header_comment} @HEADER_COMMENT
		LIB_GE_command_buffer_output
	}

	if {[CONF_SPF_msg output_event_message]} {LIB_SPF_output_event_message "Start of Program"}

	LIB_GE_command_buffer LIB_CTRL_parameter_definition
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_parameter_definition)} {LIB_CTRL_parameter_definition}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

	#<cam17013 new pretreatment>
	if {$lib_flag(load_pretreatment)} {
	if {[LIB_PT_get_header_var mom_sequence_mode exists]} {
		if {[LIB_PT_get_header_var mom_sequence_mode] == "OFF"} {
			MOM_set_seq_off
		} else {
			if {[CONF_CTRL_setting sequence_number] == 1} {
				MOM_set_seq_on
			} else {
				MOM_set_seq_off
			}
		}
	}
	} else {
		if {[CONF_CTRL_setting sequence_number] == 1} {
			MOM_set_seq_on
		} else {
			MOM_set_seq_off
		}
	}

    set ::mom_sys_csys_rot_code(ON)			[CONF_TEMPLATE_3P2 plane_name]
    set ::mom_sys_csys_rot_code(OFF)		[CONF_TEMPLATE_3P2 cancel_plane_name]

	# <NX1201 cam16012> new prereatment local csys
	# set global var lib_flag(plane_output_pos_type), 0 for mom_pos and 1 for mom_mcs_goto.
	if {[CONF_CTRL_setting plane_output_supported] != "NONE"} {
		set lib_flag(plane_output_pos_type) 1
	}

	LIB_GE_command_buffer PROGRAMSTART

	LIB_GE_command_buffer {LIB_GE_catch_do_template start_of_program "" 1} @START_OF_PROGRAM
	LIB_GE_command_buffer {
		if {[CONF_CTRL_setting block_form] == 1 && [string match "MOM_start_of_program" [info level -1]]} {
			LIB_SPF_start_of_program_blank
		}
	} @BLANKGEO
	LIB_GE_command_buffer {
		if {[string match "MOM_start_of_program" [info level -1]]} {
			if {[CONF_CTRL_initial initial_status] == 1} {
				LIB_CTRL_set_initial_status
			} elseif {[CONF_CTRL_initial initial_status] != 0 && [CONF_CTRL_initial initial_status] != 1} {
				LIB_CONF_do_prop_custom_proc CONF_CTRL_initial initial_status "short_template_syntax"
			}
		}
	} @INITIAL_STATUS

	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_start_of_program_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_program_LIB_ENTRY)} {MOM_start_of_program_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_start_of_path_LIB {} {

	set commandcheck(MOM_start_of_path_LIB_ENTRY) [llength [info commands MOM_start_of_path_LIB_ENTRY]]

	LIB_calc_lib_cutcom_radius

	LIB_GE_command_buffer MOM_start_of_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_path_LIB_ENTRY)} {MOM_start_of_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_SPF_additive_initial_settings

	LIB_update_tool_change_template
	# reset address expression
	if {[llength [info commands "MOM_set_address_expression"]]&&[info exists ::save_address_expression]} {
		if {[info exists ::save_address_expression(linear_move,X)]&&\
				[catch {MOM_set_address_expression $::save_address_expression(linear_move,X,template) "X" $::save_address_expression(linear_move,X)}]} {
			LIB_SPF_add_warning "Failed to reset address expression of 'X' in BLOCK_TEMPLATE 'linear_move'"
		}

		if {[info exists ::save_address_expression(linear_move,F)] && [catch {
			MOM_set_address_expression $::save_address_expression(linear_move,F,template)  "F" $::save_address_expression(linear_move,F)
			MOM_set_address_expression $::save_address_expression(circular_move,F,template) "F" $::save_address_expression(circular_move,F)
		}]} {
			LIB_SPF_add_warning "Failed to reset feed rate address expression , the feed rate address name should be 'F'"
		}
		unset ::save_address_expression
	}

	# Bug 1299 Address H is missing in operations with tool axis change but no toolchange
	if {[MOM_ask_address_value G_adjust] == $::mom_sys_adjust_cancel_code} {MOM_force once H}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_start_of_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_path_LIB_ENTRY)} {MOM_start_of_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_start_of_merged_path_LIB {} {
#@.pce@

	global lib_flag
	set commandcheck(MOM_start_of_merged_path_LIB_ENTRY) [llength [info commands MOM_start_of_merged_path_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_start_of_merged_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_merged_path_LIB_ENTRY)} {MOM_start_of_merged_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_start_of_merged_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_merged_path_LIB_ENTRY)} {MOM_start_of_merged_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_end_of_merged_path_LIB {} {
#@.pce@

	set commandcheck(MOM_end_of_merged_path_LIB_ENTRY) [llength [info commands MOM_end_of_merged_path_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_end_of_merged_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_merged_path_LIB_ENTRY)} {MOM_end_of_merged_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------


	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_end_of_merged_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_merged_path_LIB_ENTRY)} {MOM_end_of_merged_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_sync_LIB {} {


	set commandcheck(MOM_sync_LIB_ENTRY) [llength [info commands MOM_sync_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_sync_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_sync_LIB_ENTRY)} {MOM_sync_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_GE_command_buffer SYNC

	LIB_GE_command_buffer {MOM_do_template sync_call} @SYNC_CALL

	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_sync_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_sync_LIB_ENTRY)} {MOM_sync_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_set_csys_LIB {} {


	global lib_flag lib_sav_kin_machine_type mom_kin_machine_type
	global mom_init_pos plane_init_pos

	set commandcheck(MOM_set_csys_LIB_ENTRY) [llength [info commands MOM_set_csys_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_set_csys_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_set_csys_LIB_ENTRY)} {MOM_set_csys_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {![info exist lib_flag(absolute_kin)] || $lib_flag(absolute_kin) == 0} {
		# do nothing
	} else {
		LIB_SPF_calc_4th5th_axis_points
	}

	if {[CONF_CTRL_setting limit_output_angle] == 1} {
		LIB_SPF_limit_output_angle
	}
	
	# <NX1201 cam16012> new prereatment local csys
	# In new local csys mode, translate mom_pos and mom_mcs_goto from local to G54 in global namespace,
	# and get rotation matrix and origin of local coordinate system relative to G54.
	if {$lib_flag(local_namespace_output)} {
		LIB_SPF_csys_rotation_revise_output
		}

		# Move it from MOM_set_csys_LIB_ENTRY(OEM).
		if {[CONF_CTRL_setting fix_on_machine] == 0 && [LIB_SPF_get_pretreatment axis_mode] == "SIMULTANEOUS" \
		&& [CONF_CTRL_setting tcpm_output_supported] != "NONE" && [CONF_CTRL_setting tcpm_output] == "angle" \
		&& [info exists lib_sav_kin_machine_type] && [string match "*table*" $lib_sav_kin_machine_type] } {

			LIB_SPF_calc_4th5th_axis_points

		if {$lib_sav_kin_machine_type == "5_axis_head_table"} {
			global mom_kin_4th_axis_point
			global mom_kin_pivot_gauge_offset
			array set mom_kin_4th_axis_point "0 0 1 0 2 0"
			set mom_kin_pivot_gauge_offset 0
			MOM_reload_kinematics
		}
	}

	# PR9233975: mom_init_pos is set in event MOM_set_csys from core code if user defined csys exists
	# variable plane_init_pos is used in LIB_CTRL_set_3P2_rotate_dir in case mom_init_pos is changed by that function
	array set plane_init_pos "0 $mom_init_pos(0) 1 $mom_init_pos(1) 2 $mom_init_pos(2) 3 $mom_init_pos(3) 4 $mom_init_pos(4)"

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_set_csys_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_set_csys_LIB_ENTRY)} {MOM_set_csys_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_deposition_on_LIB {} {
#@.pce@
	if {[info exists ::mom_deposition_height] && [EQ_is_equal $::mom_deposition_height 0 0.0001] == 0} {
		LIB_GE_command_buffer DEPOSITION_HEIGHT_OUTPUT
		LIB_GE_command_buffer {
			MOM_force_block Once [CONF_CTRL_additive ADDITIVE_height_template]
			MOM_do_template [CONF_CTRL_additive ADDITIVE_height_template]
		} @DEPOSITION_HEIGHT_OUTPUT
		LIB_GE_command_buffer_output
	}

	if {[info exists ::mom_deposition_width] && [EQ_is_equal $::mom_deposition_width 0 0.0001] == 0} {
		LIB_GE_command_buffer DEPOSITION_WIDTH_OUTPUT
		LIB_GE_command_buffer {
			MOM_force_block Once [CONF_CTRL_additive ADDITIVE_width_template]
			MOM_do_template [CONF_CTRL_additive ADDITIVE_width_template]
		} @DEPOSITION_WIDTH_OUTPUT
		LIB_GE_command_buffer_output
	}

	LIB_GE_command_buffer DEPOSITION_ON
	LIB_GE_command_buffer {
		set ::mom_deposition_state [CONF_CTRL_additive ADDITIVE_deposition_on]
		MOM_force_block Once [CONF_CTRL_additive ADDITIVE_deposition_template]
		MOM_do_template [CONF_CTRL_additive ADDITIVE_deposition_template]
	} @DEPOSITION_ON_OUTPUT
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_deposition_off_LIB {} {
#@.pce@
	LIB_GE_command_buffer DEPOSITION_OFF
	LIB_GE_command_buffer {
		set ::mom_deposition_state [CONF_CTRL_additive ADDITIVE_deposition_off]
		MOM_force_block Once [CONF_CTRL_additive ADDITIVE_deposition_template]
		MOM_do_template [CONF_CTRL_additive ADDITIVE_deposition_template]
	} @DEPOSITION_OFF_OUTPUT
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_calc_lib_cutcom_radius {} {


	global mom_cutter_data_output_indicator mom_cut_data_type mom_cutcom_type mom_tool_diameter
	global lib_cutcom_radius mom_kin_arc_output_mode mom_sys_cutcom_code mom_cycle_definition_mode

	if {![info exists mom_cutter_data_output_indicator]} {
		set mom_cutter_data_output_indicator 0
	}
	if {![info exists mom_cutcom_type]} {
		set mom_cutcom_type 0
	}
	if {[CONF_CTRL_tool cutcom_actual_radius] == 0} {
		# no cutcom output even it is defined
		if {$mom_cutter_data_output_indicator == 1} {
			LIB_GE_abort_message "Cutcom contact not allowed"
		} else {
			set lib_cutcom_radius 0.0
		}
	} elseif {$mom_cutcom_type > 0} {
		# cutcom defined
		if {$mom_cut_data_type == "contact contour data"} {
			set lib_cutcom_radius 0.0
		} elseif {$mom_cut_data_type == "centerline data" && (![info exists mom_cycle_definition_mode] || $mom_cycle_definition_mode != 0)} {
	  		set lib_cutcom_radius [expr $mom_tool_diameter/2]
		} else {
			set lib_cutcom_radius 0.0
		}
		if {[CONF_CTRL_setting turbo_mode] == 2 && [LIB_SPF_get_pretreatment mom_kin_is_turbo_output] == "TRUE"} {
			LIB_SPF_turbo_status "enable" "advanced"
		}
	} else {
		# no cutcom defined
		if {[info exists lib_cutcom_radius] && $lib_cutcom_radius > 0.0} {
			set lib_cutcom_radius 0.0
		} else {
		  set lib_cutcom_radius 0.0
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_first_tool_LIB {} {


	global lib_flag 

	set commandcheck(MOM_first_tool_LIB_ENTRY) [llength [info commands MOM_first_tool_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_first_tool_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_first_tool_LIB_ENTRY)} {MOM_first_tool_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	set lib_flag(tool_path_motion) 0

	if {[CONF_CTRL_moves return_before_first_tool_change_pos] != ""} {
		LIB_RETURN_move CONF_CTRL_moves return_before_first_tool_change_pos
	}

	set lib_flag(first_tool_change) 1
	MOM_tool_change
	set lib_flag(first_tool_change) 0

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_first_tool_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_first_tool_LIB_ENTRY)} {MOM_first_tool_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_tool_change_LIB {{mode ""}} {


	global mom_cutcom_type mom_feed_cut_value mom_tool_number mom_tool_name mom_spindle_speed mom_cut_data_type
	global lib_prev_cutcom_type lib_prev_feed_cut_value lib_prev_tool_number lib_prev_spindle_speed_value lib_prev_cut_data_type
	global lib_flag mom_next_tool_status lib_prev_tool_name

	set commandcheck(MOM_tool_change_LIB_ENTRY) [llength [info commands MOM_tool_change_LIB_ENTRY]]
	set commandcheck(LIB_LOAD_attachment) [llength [info commands LIB_LOAD_attachment]]

	LIB_GE_command_buffer MOM_tool_change_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_tool_change_LIB_ENTRY)} {MOM_tool_change_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_GE_command_buffer LIB_LOAD_attachment
	LIB_GE_command_buffer {if {$commandcheck(LIB_LOAD_attachment)} {LIB_LOAD_attachment}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

	LIB_CHECK_adjust_register
	LIB_CHECK_tool_number

	LIB_GE_command_buffer TOOL_CHANGE

	LIB_GE_command_buffer {

		if {$mode == "IGNORE"} {
			# Ignore Toolchange
			# Maybe it is still necessary to examine the modality
		} elseif {$mode == "MANUAL"} {
			LIB_GE_command_buffer TOOL_CHANGE_MANUAL

			LIB_GE_command_buffer {

				LIB_CONF_do_prop_custom_proc CONF_CTRL_tool manual_change_template "short_template_syntax"

			} @TOOL_CHANGE_MANUAL

			LIB_GE_command_buffer {
				if {[CONF_CTRL_tool tool_preselect] == 1} {
					if {$mom_next_tool_status == "FIRST"} {
						LIB_CONF_do_prop_custom_proc CONF_CTRL_tool manual_preselect_last_template "short_template_syntax"
					} else {
						LIB_CONF_do_prop_custom_proc CONF_CTRL_tool manual_preselect_template "short_template_syntax"
					}
				}
			} @PRESELECT_MANUAL

			LIB_GE_command_buffer_output
		} else {
			LIB_GE_command_buffer TOOL_CHANGE_AUTO

			LIB_GE_command_buffer {

				LIB_CONF_do_prop_custom_proc CONF_CTRL_tool auto_change_template "short_template_syntax"

			} @TOOL_CHANGE_AUTO

			LIB_GE_command_buffer {
				if {[CONF_CTRL_tool tool_preselect] == 1} {
					if {$mom_next_tool_status == "FIRST"} {
						LIB_CONF_do_prop_custom_proc CONF_CTRL_tool auto_preselect_last_template "short_template_syntax"
					} else {
						LIB_CONF_do_prop_custom_proc CONF_CTRL_tool auto_preselect_template "short_template_syntax"
					}
				}
			} @PRESELECT_AUTO

			LIB_GE_command_buffer_output
		}

	} @TOOL_CHANGE

	LIB_GE_command_buffer {MOM_do_template tool_change_init CREATE} @TOOL_CHANGE_INIT
	LIB_GE_command_buffer {MOM_do_template spindle_init CREATE} @SPINDLE_INIT
	LIB_GE_command_buffer {LIB_CTRL_set_feed_parameter} @SET_FEED_PARAM

	LIB_GE_command_buffer_output

	if {![info exists mom_cutcom_type]} {set mom_cutcom_type 0}
	set lib_prev_cutcom_type $mom_cutcom_type
	set lib_prev_cut_data_type $mom_cut_data_type
	set lib_prev_feed_cut_value $mom_feed_cut_value
	set lib_prev_spindle_speed_value $mom_spindle_speed
	set lib_prev_tool_number $mom_tool_number
	set lib_prev_tool_name $mom_tool_name

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_tool_change_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_tool_change_LIB_ENTRY)} {MOM_tool_change_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_from_move_LIB {} {


	global feed_mode mom_feed_rate mom_kin_rapid_feed_rate

	set commandcheck(MOM_from_move_LIB_ENTRY) [llength [info commands MOM_from_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_from_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_from_move_LIB_ENTRY)} {MOM_from_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_CTRL_moves output_from_position] == 1 } {
		if {![string compare $feed_mode "IPM"] || ![string compare $feed_mode "MMPM"]} {
			if {[EQ_is_ge $mom_feed_rate $mom_kin_rapid_feed_rate]} {
				MOM_rapid_move_LIB
			} else {
				MOM_linear_move_LIB
			}
		}
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_from_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_from_move_LIB_ENTRY)} {MOM_from_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}
#____________________________________________________________________________________________
# <Internal Documentation>
#
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_update_tool_change_template {} {


	global lib_prev_feed_cut_value mom_feed_cut_value mom_tool_name

	LIB_GE_command_buffer UPDATE_TOOL

	LIB_GE_command_buffer {
			LIB_CTRL_set_feed_parameter
			set lib_prev_feed_cut_value $mom_feed_cut_value
	} @SET_FEED_PARAM
	LIB_GE_command_buffer {
			LIB_CHECK_adjust_register
	} @SET_ADJUST_REGISTER

	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_first_move_LIB {} {

	global mom_motion_event mom_operation_name mom_output_mcs_name
	global mom_motion_type

	set commandcheck(MOM_first_move_LIB_ENTRY) [llength [info commands MOM_first_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_first_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_first_move_LIB_ENTRY)} {MOM_first_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CTRL_handle_cycle_check move

	LIB_SPF_check_decompose_first_move

	if {[info exists mom_output_mcs_name([LIB_SPF_get_pretreatment mom_operation_name -1])] && $mom_output_mcs_name($mom_operation_name) != $mom_output_mcs_name([LIB_SPF_get_pretreatment mom_operation_name -1])} {
		LIB_main_origin_call
	}

	LIB_CHECK_adjust_register

	if {$mom_motion_event == "cycle_plane_change"} {
		LIB_SPF_add_warning "It is recommended to define a motion before first cycle."
	}
	catch {MOM_$mom_motion_event}
	# Handle the case user specify feed for rapid
	if {$mom_motion_type == "RAPID"} {
		LIB_SPF_last_rapid_pos
	}
	LIB_SPF_calc_abs_move_parameter
	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_first_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_first_move_LIB_ENTRY)} {MOM_first_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_initial_move_LIB {} {
	
	global lib_flag mom_programmed_feed_rate mom_motion_event
	global mom_motion_type

	set commandcheck(MOM_initial_move_LIB_ENTRY) [llength [info commands MOM_initial_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_initial_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_initial_move_LIB_ENTRY)} {MOM_initial_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CHECK_adjust_register
	LIB_SPF_spindle_set

	# <NX1201 cam17013> new prereatment local csys
	if {$lib_flag(local_namespace_output) && ([CONF_CTRL_setting tcpm_output] == "vector" ||\
	([CONF_CTRL_setting tcpm_output] == "angle" && [CONF_CTRL_setting fix_on_machine] != 0))} {
		if {[CONF_CTRL_setting turbo_mode] == 3 && [LIB_SPF_get_pretreatment axis_mode] == "SIMULTANEOUS" &&\
			[CONF_CTRL_setting tcpm_output_supported] != "NONE"} {
			LIB_SPF_set_output_pos "::" "mom_mcs_goto"
		}
	}

	LIB_CTRL_handle_cycle_check move

	if {[EQ_is_zero $mom_programmed_feed_rate]} {
		MOM_rapid_move
		set mom_motion_event "rapid_move"
	} else {
		MOM_linear_move
		set mom_motion_event "linear_move"
		# Handle the case user specify feed for rapid
		if {$mom_motion_type == "RAPID"} {
			LIB_SPF_last_rapid_pos
		}

	}
	LIB_SPF_calc_abs_move_parameter

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_initial_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_initial_move_LIB_ENTRY)} {MOM_initial_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# This function controlls the spindle rotation.
# The spindle should never be activated with the first movement if a single-lip drill is used.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_handle_cycle_check {arg} {

	global mom_cycle_type mom_spindle_status mom_spindle_startup_status

	if {([info exists mom_cycle_type] && ([string match "Exp_Deep_Drill_Breakchip" $mom_cycle_type] || [string match "Exp_Deep_Drill" $mom_cycle_type])) ||\
	([info exists mom_spindle_startup_status] && $mom_spindle_startup_status == "OFF")} {

		switch -- $arg {
			"move"		{
						if {$mom_spindle_status == "LOCK" || $mom_spindle_status == "OFF"} {MOM_disable_address S M_spindle}
					}
			"spindle"	{
						MOM_enable_address S M_spindle
					}
			default 	{
						LIB_GE_abort_message "Call LIB_CTRL_handle_cycle_check without the right arguments" "Please check"
					}
		}

	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# This procedure is executed at MOM_initial_move MOM_first_move MOM_lock_axis.
# It is used to config turbo blocks in advanced turbo mode
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_config_turbo {} {

	global lib_turbo_block_RAPID
	global lib_turbo_block_LINEAR
	global lib_turbo_block_CIRCULAR

	if {$::lib_ge_pretreatment_runtime} {return}

	if { $::mom_kin_is_turbo_output == "TRUE"} {
		if {$::mom_sys_enable_nc_optimizer == "ON" \
            || ([info exists ::mom_sys_split_full_circle] && $::mom_sys_split_full_circle == 1) \
            || ([info exists ::mom_sys_split_half_circle] && $::mom_sys_split_half_circle == 1)} {
			if {[CONF_CTRL_moves always_center_for_circle] == 1} {
				MOM_disable_address R
				MOM_enable_address I J K
			} else {
				MOM_enable_address R
				MOM_disable_address I J K
			}
		} else {
			MOM_disable_address R
		}
	}

	if {![info exists ::mom_sys_advanced_turbo_output] || $::mom_sys_advanced_turbo_output != "TRUE"} {
		return
	}

	if {[CONF_CTRL_moves always_center_for_circle] == 1} {
		MOM_disable_address R
		MOM_enable_address I J K
	} else {
		MOM_enable_address R
		#MOM_disable_address I J K
		set ::mom_sys_circular_turbo_command "TRUE"
	}

	if {$::mom_kin_arc_output_mode == "FULL_CIRCLE" } {
		set ::mom_sys_circular_turbo_command "TRUE"
	}

	if {[CONF_CTRL_feed feed_linear] == 2} {
		# Before NX1899, set MOM_linear_move_turbo_LIB at turbo block to output parameterized feed value
		# From NX1899, use advanced callback function to do the same thing
		if {$::lib_ge_env(major_version) < 1899} {
			set ::mom_sys_linear_turbo_command "TRUE"
			set ::mom_sys_circular_turbo_command "TRUE"
		} else {
			# In advanced turbo mode, LIB_SPF_feedrate_set is called in callback function, so disable feedrate setting in core code
			if {[llength [info commands MOM_set_turbo_feedrate_set]]} {
				MOM_set_turbo_feedrate_set OFF
			}
		}
	}

	if {$::mom_sys_linear_turbo_command == "TRUE" && [llength [info commands "MOM_linear_move_turbo_LIB"]]} {
		set lib_turbo_block_LINEAR [linsert [CONF_Turbo_Templates linear_template_turbo]  0 "MOM_linear_move_turbo_LIB"]
		MOM_set_turbo_blocks LINEAR $lib_turbo_block_LINEAR
	} else {
		set lib_turbo_block_LINEAR [CONF_Turbo_Templates linear_template_turbo]
		MOM_set_turbo_blocks LINEAR $lib_turbo_block_LINEAR
	}

	if {$::lib_flag(first_transmit_move) == 0} {
		if {$::mom_sys_rapid_turbo_command == "TRUE" && [llength [info commands "MOM_rapid_move_turbo_LIB"]]} {
			set lib_turbo_block_RAPID [linsert [CONF_Turbo_Templates rapid_template_turbo]  0 "MOM_rapid_move_turbo_LIB"]
			MOM_set_turbo_blocks RAPID $lib_turbo_block_RAPID
		} else {
			set lib_turbo_block_RAPID [CONF_Turbo_Templates rapid_template_turbo]
			MOM_set_turbo_blocks RAPID $lib_turbo_block_RAPID
		}
	} else {
		if {$::mom_sys_linear_turbo_command == "TRUE" && [llength [info commands "MOM_linear_move_turbo_LIB"]]} {
			set lib_turbo_block_RAPID [linsert [CONF_Turbo_Templates linear_template_turbo]  0 "MOM_linear_move_turbo_LIB"]
			MOM_set_turbo_blocks RAPID $lib_turbo_block_RAPID
		} else {
			set lib_turbo_block_RAPID [CONF_Turbo_Templates linear_template_turbo]
			MOM_set_turbo_blocks RAPID $lib_turbo_block_RAPID
		}
	}

	if {$::mom_sys_circular_turbo_command == "TRUE" && [llength [info commands "MOM_circular_move_turbo_LIB"]]} {
		set lib_turbo_block_CIRCULAR [linsert [CONF_Turbo_Templates circular_template_turbo] 0 "MOM_circular_move_turbo_LIB"]
		MOM_set_turbo_blocks CIRCULAR $lib_turbo_block_CIRCULAR
	} else {
		set lib_turbo_block_CIRCULAR [CONF_Turbo_Templates circular_template_turbo]
		MOM_set_turbo_blocks CIRCULAR $lib_turbo_block_CIRCULAR
	}

	# The address X[$mom_pos(0)*$x_factor] will slow down turbo mode, x_factor only used in turning
	if {[llength [info commands "MOM_set_address_expression"]]} {
		if {$::x_factor == 1} {
			catch {
				set ::save_address_expression(linear_move,X) [MOM_set_address_expression [CONF_CTRL_moves linear_template] "X" "\$mom_pos(0)"]
				set ::save_address_expression(linear_move,X,template) [CONF_CTRL_moves linear_template]
			}
		}
	if {[CONF_CTRL_feed feed_linear] != 2} {
		if {[catch {
			set ::save_address_expression(linear_move,F) [MOM_set_address_expression [CONF_CTRL_moves linear_template] "F" "\$mom_feedrate"]
			set ::save_address_expression(circular_move,F) [MOM_set_address_expression [CONF_CTRL_moves circular_template] "F" "\$mom_feedrate"]
			
			set ::save_address_expression(linear_move,F,template) [CONF_CTRL_moves linear_template]
			set ::save_address_expression(circular_move,F,template) [CONF_CTRL_moves circular_template]
		}]} {
			LIB_SPF_add_warning "Please use 'F' as feed rate address name in linear and circular block template"
		}
	}
		
		#when feedrate in one operation change from mmpm to mmpr we must write mom_feedrate_mode in to the advanced and set feed the mode into the G_feed Address
		set ::save_address_expression(linear_move,G_feed) [MOM_set_address_expression [CONF_CTRL_moves linear_template] "G_feed" "\$mom_sys_feed_rate_mode_code(\$mom_feedrate_mode)"]
		set ::save_address_expression(circular_move,G_feed) [MOM_set_address_expression [CONF_CTRL_moves circular_template] "G_feed" "\$mom_sys_feed_rate_mode_code(\$mom_feedrate_mode)"]
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_rapid_move_LIB {} {


	global mom_machine_mode mom_pos
	global lib_flag lib_param lib_last_rapid_pos
	global dpp_return_motion_start
	global mom_output_pos_type mom_namespace_name

	set commandcheck(MOM_rapid_move_LIB_ENTRY) [llength [info commands MOM_rapid_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_rapid_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_rapid_move_LIB_ENTRY)} {MOM_rapid_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$lib_flag(tool_path_motion) == 1} {
		if {$mom_machine_mode == "TURN"} {

			LIB_GE_command_buffer FIRST_MOVE_TURN

			LIB_GE_command_buffer {LIB_TURNING_mode start} @START_TURN_MODE
			LIB_GE_command_buffer {LIB_SPINDLE_start preset} @PRESET_SPINDLE_SPEED
			LIB_GE_command_buffer {if {[CONF_CTRL_coolant coolnt_output_before_motion] == 1} {LIB_WRITE_coolant on}} @OUTPUT_COOLNT_TURN
			LIB_GE_command_buffer {
				MOM_suppress always S
				if {$lib_flag(decompose_first_move_turn) == 1} {
					LIB_SPF_decompose_block_template [CONF_CTRL_moves decompose_first_move_turn_order] [CONF_CTRL_moves rapid_template] FORCE "X Y Z"
				} else {
					MOM_do_template [CONF_CTRL_moves rapid_template]
				}
				MOM_suppress off S
			} @MOVE
			LIB_GE_command_buffer {LIB_SPINDLE_start limit} @SPINDLE_LIMIT
			LIB_GE_command_buffer {LIB_SPINDLE_start} @START_SPINDLE
			LIB_GE_command_buffer_output

		} else {
			LIB_GE_command_buffer FIRST_MOVE_MILL

			LIB_GE_command_buffer {LIB_SPINDLE_start} @START_SPINDLE
			LIB_GE_command_buffer {
					switch -- $lib_flag(mode_current_status) {
						"std" {
							LIB_ROTARY_positioning_first_move
						}
						"pos" {
							LIB_ROTARY_positioning_first_move_pos
						}
						"sim" {
							LIB_ROTARY_positioning_first_move_sim
						}
					}
				} @MOVE
			LIB_GE_command_buffer_output
		}

		LIB_GE_command_buffer COOLANT_ON
		LIB_GE_command_buffer {LIB_WRITE_coolant on} @OUTPUT
		LIB_GE_command_buffer_output

		set lib_flag(tool_path_motion) 2
	} elseif {$lib_param(cutting_tool_axis) != "" || [LIB_GE_commandbuffer_is_customized RAPID_MOVE]} {
		if {$mom_machine_mode == "TURN"} {
			LIB_GE_command_buffer SPINDLE_LIMIT
			LIB_GE_command_buffer {LIB_SPINDLE_start limit} @OUTPUT
			LIB_GE_command_buffer_output
		}

		LIB_GE_command_buffer RAPID_MOVE
		LIB_GE_command_buffer {LIB_SPINDLE_start} @SPINDLE_START
		LIB_GE_command_buffer {LIB_WRITE_coolant on} @COOLANT_ON
		LIB_GE_command_buffer {
			if {[info exists dpp_return_motion_start] && $dpp_return_motion_start} {
				LIB_CTRL_output_return_motion_for_rough_turn_cycle
			}

		} @ROUGH_TURN_CYCLE
		LIB_GE_command_buffer {
			if {![info exists dpp_return_motion_start] || !$dpp_return_motion_start} {
				if {$lib_flag(first_transmit_move) == 0} {
					MOM_do_template [CONF_CTRL_moves rapid_template]
				} else {
					LIB_CTRL_feed_output
					MOM_do_template [CONF_CTRL_moves linear_template]
				}
			}
		} @MOVE
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer RAPID_MOVE_SINGLE
		LIB_GE_command_buffer {
			if {[info exists dpp_return_motion_start] && $dpp_return_motion_start} {
				LIB_CTRL_output_return_motion_for_rough_turn_cycle
	}

		} @ROUGH_TURN_CYCLE
		LIB_GE_command_buffer {
			if {![info exists dpp_return_motion_start] || !$dpp_return_motion_start} {
				if {$lib_flag(first_transmit_move) == 0} {
					MOM_do_template [CONF_CTRL_moves rapid_template]
				} else {
					LIB_CTRL_feed_output
					MOM_do_template [CONF_CTRL_moves linear_template]
				}
			}
		} @MOVE
		LIB_GE_command_buffer_output
	}
	LIB_SPF_last_rapid_pos

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_rapid_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_rapid_move_LIB_ENTRY)} {MOM_rapid_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command wil be executed in advanced turbo mode when mom_sys_linear_turbo_command is set
# to "TRUE"
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_linear_move_turbo_LIB {} {


	set commandcheck(MOM_linear_move_turbo_LIB_ENTRY) [llength [info commands MOM_linear_move_turbo_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_linear_move_turbo_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_linear_move_turbo_LIB_ENTRY)} {MOM_linear_move_turbo_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[llength [info commands LIB_SPF_polar_cart]]} {LIB_SPF_polar_cart}

	if {[CONF_CTRL_feed feed_linear] == 2} {
		set ::feed $::mom_feedrate
		LIB_CTRL_feed_output
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_linear_move_turbo_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_linear_move_turbo_LIB_ENTRY)} {MOM_linear_move_turbo_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command wil be executed in advanced turbo mode when mom_sys_rapid_turbo_command is set
# to "TRUE"
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_rapid_move_turbo_LIB {} {


	set commandcheck(MOM_rapid_move_turbo_LIB_ENTRY) [llength [info commands MOM_rapid_move_turbo_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_rapid_move_turbo_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_rapid_move_turbo_LIB_ENTRY)} {MOM_rapid_move_turbo_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[llength [info commands LIB_SPF_polar_cart]]} {LIB_SPF_polar_cart}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_rapid_move_turbo_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_rapid_move_turbo_LIB_ENTRY)} {MOM_rapid_move_turbo_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command wil be executed in advanced turbo mode when mom_sys_circular_turbo_command is set
# to "TRUE"
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_circular_move_turbo_LIB {} {
	

	set commandcheck(MOM_circular_move_turbo_LIB_ENTRY) [llength [info commands MOM_circular_move_turbo_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_circular_move_turbo_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_circular_move_turbo_LIB_ENTRY)} {MOM_circular_move_turbo_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_CTRL_feed feed_linear] == 2} {
		set ::feed $::mom_feedrate
		LIB_CTRL_feed_output
	}

	if {[CONF_CTRL_moves always_center_for_circle] != 1} {
		global mom_arc_radius
		set mom_arc_radius [expr abs($mom_arc_radius)]

		MOM_suppress once I J K
		switch -- $::tool_axis {
			0 {MOM_force once Y Z}
			1 {MOM_force once X Z}
			2 {MOM_force once X Y}
		}

		# Set the tolerance to 0.1 because the calculation in NX is not exact (Bug #1280)
		if {[info exists ::lib_spf(nx_version)] && $::lib_spf(nx_version) < 2412 \
        && (([EQ_is_equal $::mom_arc_angle 360 0.1] && $::mom_sys_split_full_circle == 1) \
		|| ([EQ_is_equal $::mom_arc_angle 180.0 0.1] && $::mom_sys_split_half_circle == 1))} {

			global mom_prev_pos mom_pos_arc_center mom_pos_arc_axis mom_pos oper_mcs_matrix
			global mom_namespace_name mom_output_pos_type
			if {[info exists mom_namespace_name] && [info exists mom_output_pos_type]} {
				if {$mom_namespace_name == "::"} {
					set namespace ::
				} else {
					set namespace ::LOCAL_CSYS::
				}
				if {$mom_output_pos_type == "mom_pos"} {
					VMOV 3 ${namespace}mom_prev_pos prev_pos
					VMOV 3 ${namespace}mom_pos_arc_center pos_arc_center
					VMOV 3 ${namespace}mom_pos_arc_axis pos_arc_axis
				} else {
					VMOV 3 ${namespace}mom_prev_mcs_goto prev_pos
					VMOV 3 ${namespace}mom_arc_center pos_arc_center
					VMOV 3 ${namespace}mom_arc_axis pos_arc_axis
				}
				VMOV 3 ${namespace}$mom_output_pos_type save_pos
			} else {
				set namespace ::
				set mom_output_pos_type mom_pos
				VMOV 3 mom_prev_pos prev_pos
				VMOV 3 mom_pos_arc_center pos_arc_center
				VMOV 3 mom_pos_arc_axis pos_arc_axis
				VMOV 3 mom_pos save_pos
			}
			VEC3_sub prev_pos pos_arc_center tmp_vec
			VEC3_unitize tmp_vec tmp_vec1
			VEC3_cross tmp_vec1 pos_arc_axis tmp_vec
			VEC3_scale mom_arc_radius tmp_vec tmp_vec1
			VEC3_add pos_arc_center tmp_vec1 tmp_vec
			VMOV 3 tmp_vec ${namespace}$mom_output_pos_type

			LIB_GE_command_buffer CIRCULAR_MOVE_TURBO_OUTPUT
			LIB_GE_command_buffer {MOM_do_template [CONF_Turbo_Templates circular_template_turbo]} @OUPUT
			LIB_GE_command_buffer_output

			VMOV 3 save_pos  ${namespace}$mom_output_pos_type

			MOM_suppress once I J K
			switch -- $::tool_axis {
				0 {MOM_force once Y Z}
				1 {MOM_force once X Z}
				2 {MOM_force once X Y}
			}

			set ::mom_arc_angle [expr $::mom_arc_angle - 90.0]
		}

		if {[EQ_is_gt $::mom_arc_angle 360 0.1]} {
			LIB_GE_abort_message "Variable mom_arc_angle is greater than 360 degree"
		}

		if {[EQ_is_gt $::mom_arc_angle 180.0]} {
			set mom_arc_radius [expr -1.0*$mom_arc_radius]
		}

	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_circular_move_turbo_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_circular_move_turbo_LIB_ENTRY)} {MOM_circular_move_turbo_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_rapid_move_LIB_MODIF_first_move_turn {} {


	return 0

}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the turning mode
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_TURNING_mode {{option default}} {


	global x_factor i_factor lib_flag

	switch -- $option {
		"start"	{

			set x_factor [LIB_SPF_check_x_factor TURN]
			set i_factor [LIB_SPF_check_x_factor TURN i_factor]
			
			if {![info exist lib_flag(save_rapid_template)]} {set lib_flag(save_rapid_template) [CONF_CTRL_moves rapid_template]}
			CONF_CTRL_moves set rapid_template [CONF_CTRL_moves rapid_template_turn]

			if {![info exist lib_flag(save_linear_template)]} {set lib_flag(save_linear_template) [CONF_CTRL_moves linear_template]}
			CONF_CTRL_moves set linear_template [CONF_CTRL_moves linear_template_turn]

			if {![info exist lib_flag(save_circular_template)]} {set lib_flag(save_circular_template) [CONF_CTRL_moves circular_template]}
			CONF_CTRL_moves set circular_template [CONF_CTRL_moves circular_template_turn]
		}
		"end" {
			set x_factor [LIB_SPF_check_x_factor MILL]
			set i_factor [LIB_SPF_check_x_factor MILL i_factor]
			
			if {[info exists lib_flag(save_rapid_template)]} {
				CONF_CTRL_moves set rapid_template $lib_flag(save_rapid_template)
				unset lib_flag(save_rapid_template)
			}

			if {[info exists lib_flag(save_linear_template)]} {
				CONF_CTRL_moves set linear_template $lib_flag(save_linear_template)
				unset lib_flag(save_linear_template)
			}

			if {[info exists lib_flag(save_circular_template)]} {
				CONF_CTRL_moves set circular_template $lib_flag(save_circular_template)
				unset lib_flag(save_circular_template)
			}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the spindle start conditions
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_SPINDLE_start {{option default}} {


	global mom_machine_mode mom_spindle_mode mom_spindle_preset_rpm_toggle mom_spindle_preset_rpm
	global mom_spindle_maximum_rpm mom_spindle_speed mom_mcs_goto mom_spindle_status
	global PI mom_spindle_maximum_rpm_toggle lib_flag

	if {$mom_spindle_status == "OFF"} {return}

	set commandcheck(LIB_SPINDLE_start_ENTRY) [llength [info commands LIB_SPINDLE_start_ENTRY]]

	LIB_GE_command_buffer LIB_SPINDLE_start_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_SPINDLE_start_ENTRY)} {LIB_SPINDLE_start_ENTRY start_${option}}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_GE_command_buffer SPINDLE
	switch -- $option {
		"preset" {
			# turning only
			LIB_GE_command_buffer {
				if {$mom_spindle_mode == "SFM" || $mom_spindle_mode == "SMM"} {
					if {[EQ_is_zero $mom_spindle_speed]} {
						LIB_GE_error_message "Spindle speed should not be = 0.0" "Please check"
					}
					if {$mom_spindle_preset_rpm_toggle == 0 || [EQ_is_zero $mom_spindle_preset_rpm]} {
						set rval [expr abs($mom_mcs_goto(0))]
						if {$rval < 0.1} {set rval 1}
						if {$mom_spindle_mode == "SFM"} {
							set mom_spindle_preset_rpm [expr (12 * $mom_spindle_speed) / ($PI * $rval * 2)]
						} else {
							set mom_spindle_preset_rpm [expr $mom_spindle_speed * 1000 / $PI / $rval / 2]
						}
					}

					if {([info exists mom_spindle_maximum_rpm_toggle] && $mom_spindle_maximum_rpm_toggle == 1) || [CONF_CTRL_spindle spindle_max_rpm_output_always]} {
						if {[EQ_is_zero $mom_spindle_maximum_rpm] || [EQ_is_gt $mom_spindle_maximum_rpm [CONF_CTRL_spindle max]]} {
							set tmp_spindle_max_rpm [CONF_CTRL_spindle max]
						} else {
							set tmp_spindle_max_rpm $mom_spindle_maximum_rpm
						}
					} else {
						set tmp_spindle_max_rpm [CONF_CTRL_spindle max]
					}


					if {[EQ_is_gt $mom_spindle_preset_rpm $tmp_spindle_max_rpm]} {
						set mom_spindle_preset_rpm  $tmp_spindle_max_rpm
					}

					if {[CONF_CTRL_spindle spindle_preset_rpm_output_always] || ([info exists mom_spindle_maximum_rpm_toggle] && $mom_spindle_maximum_rpm_toggle == 1)} {
						MOM_do_template spindle_rpm_preset
					} else {
						MOM_do_template spindle_rpm_preset CREATE
					}
				} else {
					MOM_do_template spindle_rpm_preset CREATE
				}
			} @PRESET
		}
		"cycle" {
			LIB_GE_command_buffer {
				switch -- $mom_machine_mode {
					"MILL" {
						if {[LIB_SPF_get_pretreatment cycle_tap] == "YES" && [CONF_CTRL_drill cycle_tap] == "rigid"} {
							MOM_do_template spindle_rpm CREATE
						} else {
							MOM_do_template spindle_rpm
						}
					}
					"TURN" {
						if {$mom_spindle_mode == "RPM"} {
							MOM_do_template spindle_rpm_turn
						} elseif {$mom_spindle_mode == "SFM" || $mom_spindle_mode == "SMM"} {
						if {[EQ_is_zero $mom_spindle_maximum_rpm] || [EQ_is_gt $mom_spindle_maximum_rpm [CONF_CTRL_spindle max]]} {
							set mom_spindle_maximum_rpm [CONF_CTRL_spindle max]
						}
							# PR9564861: Output block spindle_smm_turn only if spindle mode is SFM/SMM before cycle under turning
						MOM_do_template spindle_smm_turn
						}
					}
				}
			} @CYCLE
		}
		"limit" {
			LIB_GE_command_buffer {
				# turning only
				if {$mom_spindle_mode == "SFM" || $mom_spindle_mode == "SMM"} {
					if {([info exists mom_spindle_maximum_rpm_toggle] && $mom_spindle_maximum_rpm_toggle == 1) || [CONF_CTRL_spindle spindle_max_rpm_output_always]} {
						if {[EQ_is_zero $mom_spindle_maximum_rpm] || [EQ_is_gt $mom_spindle_maximum_rpm [CONF_CTRL_spindle max]]} {
							set mom_spindle_maximum_rpm [CONF_CTRL_spindle max]
						}
						MOM_do_template spindle_max_rpm
					}
				}
			} @LIMIT
		}
		"default" {
			switch -- $mom_machine_mode {
				"MILL" {
					LIB_GE_command_buffer {
						if {$mom_spindle_mode == "NONE" || $lib_flag(ignore_spindle_rpm)} {
							MOM_do_template spindle_rpm CREATE
						} else {
							# Always RPM output for milling
							if {[LIB_SPF_get_pretreatment cycle_tap] == "YES" && [CONF_CTRL_drill cycle_tap] == "rigid"} {
								MOM_do_template spindle_rpm CREATE
							} elseif {[CONF_CTRL_spindle spindle_output_alone] == 1 || [info level 1] == "MOM_spindle_rpm"} {
								MOM_do_template spindle_rpm
							}
						}
						set ::check_list(spindle,status) 1
					} @DEFAULTMILL
				}
				"TURN" {
					LIB_GE_command_buffer {
						if {$mom_spindle_mode == "NONE" || $lib_flag(ignore_spindle_rpm)} {
							MOM_do_template spindle_rpm_turn CREATE
						} elseif {$mom_spindle_mode == "RPM"} {
							if {[MOM_do_template spindle_rpm_turn CREATE] != ""} {
								MOM_force_block once spindle_rpm_turn
								MOM_do_template spindle_rpm_turn
							}

						} elseif {$mom_spindle_mode == "SFM" || $mom_spindle_mode == "SMM"} {
							if {[EQ_is_zero $mom_spindle_maximum_rpm] || [EQ_is_gt $mom_spindle_maximum_rpm [CONF_CTRL_spindle max]]} {
								set mom_spindle_maximum_rpm [CONF_CTRL_spindle max]
							}
							if {[CONF_CTRL_spindle spindle_max_rpm_output_alone] == 1} {
								MOM_do_template spindle_max_rpm
							}

							if {[MOM_do_template spindle_smm_turn CREATE] != ""} {
								MOM_force_block once spindle_smm_turn
								if {[CONF_CTRL_spindle spindle_max_rpm_output_alone] == 1} {MOM_do_template spindle_max_rpm CREATE}
								MOM_do_template spindle_smm_turn
							}

						}
					} @DEFAULTTURN
				}
			}
		}
	}
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_SPINDLE_start_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_SPINDLE_start_ENTRY)} {LIB_SPINDLE_start_ENTRY end_${option}}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the spindle end conditions
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_SPINDLE_end {} {


	LIB_GE_command_buffer SPINDLE_END
	LIB_GE_command_buffer {
		if {[LIB_SPF_get_pretreatment cycle_tap] == "YES" && [CONF_CTRL_drill cycle_tap] == "rigid"} {
			MOM_do_template spindle_off CREATE
		} else {
			MOM_do_template spindle_off
		}
	} @SPINDLE_OFF_1
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# It used to output spindle orient code M19 S.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_spindle_orient {} {

	global mom_machine_mode

	LIB_GE_command_buffer SPINDLE_ORIENT

	LIB_GE_command_buffer {
		if {$mom_machine_mode == "MILL"} {
			LIB_CTRL_handle_cycle_check spindle
			MOM_do_template spindle_off
			LIB_CTRL_handle_cycle_check move
		}
	} @SPINDLE_OFF

	LIB_GE_command_buffer {
		MOM_force Once M_spindle
		MOM_do_template spindle_orient
	} @M19_S

	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the output order of the addresses depending on the tool axis
# for the standard case at the positioning first move
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_ROTARY_positioning_first_move {} {


	global tool_axis lib_flag
	global mom_motion_event

	LIB_GE_command_buffer ROTARY_POSITIONING_FIRST_MOVE

	LIB_GE_command_buffer {
		if {[CONF_CTRL_coolant coolnt_output_before_motion] == 1} {
			LIB_WRITE_coolant on
		} elseif {[CONF_CTRL_coolant coolnt_output_before_motion] == 2} {
			MOM_suppress once M_coolant
			if {[info exists ::mom_coolant_mode] && $lib_flag(decompose_first_move) != 0} {
				set tmp_coolant_mode $::mom_coolant_mode
				unset ::mom_coolant_mode
			}
		}
	} @OUTPUT_COOLNT

	if {$lib_flag(decompose_first_move) == 0} {
		LIB_GE_command_buffer {
			MOM_force once X Y Z
			MOM_do_template [CONF_CTRL_moves $mom_motion_event]
		} @NODECOMPOSE
	} else {
		if {[hiset lib_flag(current_plane_upper_than_previous)]} {
			# first tool_path motion with same tool and configuration as previous operation
			if {$lib_flag(current_plane_upper_than_previous) == 1 && $lib_flag(current_safety_position) == 0} {
				switch -- $tool_axis {
					0 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_std_xlu]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEXLU
					  }

					1 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_std_ylu]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEYLU
					  }

					2 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_std_zlu]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEZLU
					  }
				}
			} else {
				switch -- $tool_axis {
					0 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_std_xul]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEXUL
					  }

					1 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_std_yul]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEYUL
					  }

					2 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_std_zul]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEZUL
					  }
				}
			}
			unset lib_flag(current_plane_upper_than_previous)
		} else {
			switch -- $tool_axis {
				0 {
					LIB_GE_command_buffer {
						set decompose [CONF_CTRL_moves decompose_first_move_std_xi]
						LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
					} @DECOMPOSESTDXI
				  }

				1 {
					LIB_GE_command_buffer {
						set decompose [CONF_CTRL_moves decompose_first_move_std_yi]
						LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
					} @DECOMPOSESTDYI
				  }

				2 {
					LIB_GE_command_buffer {
						set decompose [CONF_CTRL_moves decompose_first_move_std_zi]
						LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
					} @DECOMPOSESTDZI
				  }
			}
		}
		set lib_flag(current_safety_position) 0
	}
	
	if {[CONF_CTRL_coolant coolnt_output_before_motion] == 2 && [info exists tmp_coolant_mode]} {
		set ::mom_coolant_mode $tmp_coolant_mode
	}
	
	LIB_GE_command_buffer {
		LIB_CTRL_clamp_axis
	} @CLAMP
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the output order of the addresses depending on the tool axis
# for the case at the positioning first move
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_ROTARY_positioning_first_move_pos {} {


	global tool_axis lib_flag
	global mom_motion_event

	LIB_GE_command_buffer ROTARY_POSITIONING_FIRST_MOVE_POS

	LIB_GE_command_buffer {
		if {[CONF_CTRL_coolant coolnt_output_before_motion] == 1} {
			LIB_WRITE_coolant on
		} elseif {[CONF_CTRL_coolant coolnt_output_before_motion] == 2} {
			MOM_suppress once M_coolant
			if {[info exists ::mom_coolant_mode] && $lib_flag(decompose_first_move_pos) != 0} {
				set tmp_coolant_mode $::mom_coolant_mode
				unset ::mom_coolant_mode
			}
		}
	} @OUTPUT_COOLNT

	if {$lib_flag(decompose_first_move_pos) == 0} {
		LIB_GE_command_buffer {
			MOM_force once X Y Z H
			MOM_do_template [CONF_CTRL_moves $mom_motion_event]
		} @NODECOMPOSE
	} else {
		if {[hiset lib_flag(current_plane_upper_than_previous)]} {
			# first tool_path motion with same tool and configuration as previous operation
			if {$lib_flag(current_plane_upper_than_previous) == 1 && $lib_flag(current_safety_position) == 0} {
				switch -- $tool_axis {
					0 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_pos_xlu]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEXLU
					  }

					1 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_pos_ylu]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEYLU
					  }

					2 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_pos_zlu]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEZLU
					  }
				}
			} else {
				switch -- $tool_axis {
					0 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_pos_xul]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEXUL
					  }

					1 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_pos_yul]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEYUL
					  }

					2 {
						LIB_GE_command_buffer {
							set decompose [CONF_CTRL_moves decompose_first_move_pos_zul]
							LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
						} @DECOMPOSEZUL
					  }
				}
				unset lib_flag(current_plane_upper_than_previous)
			}
		} else {
			switch -- $tool_axis {
				0 {
					LIB_GE_command_buffer {
						set decompose [CONF_CTRL_moves decompose_first_move_pos_xi]
						LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
					} @DECOMPOSEPOSXI
				  }

				1 {
					LIB_GE_command_buffer {
						set decompose [CONF_CTRL_moves decompose_first_move_pos_yi]
						LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
					} @DECOMPOSEPOSYI
				  }

				2 {
					LIB_GE_command_buffer {
						set decompose [CONF_CTRL_moves decompose_first_move_pos_zi]
						LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
					} @DECOMPOSEPOSZI
				  }
			}
		}
		set lib_flag(current_safety_position) 0
	}
	
	if {[CONF_CTRL_coolant coolnt_output_before_motion] == 2 && [info exists tmp_coolant_mode]} {
		set ::mom_coolant_mode $tmp_coolant_mode
	}
	
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the output order of the addresses depending on the tool axis
# for the case at the positioning simultanous first move
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_ROTARY_positioning_first_move_sim {} {


	global mom_motion_event
	global lib_flag

	LIB_GE_command_buffer ROTARY_POSITIONING_FIRST_MOVE_SIM

	LIB_GE_command_buffer {
		if {[CONF_CTRL_coolant coolnt_output_before_motion] == 1} {
			LIB_WRITE_coolant on
		} elseif {[CONF_CTRL_coolant coolnt_output_before_motion] == 2} {
			MOM_suppress once M_coolant
			if {[info exists ::mom_coolant_mode] && $lib_flag(decompose_first_move_sim) != 0} {
				set tmp_coolant_mode $::mom_coolant_mode
				unset ::mom_coolant_mode
			}
		}
	} @OUTPUT_COOLNT

	if {$lib_flag(decompose_first_move_sim) == 0} {
		LIB_GE_command_buffer {
			MOM_force once X Y Z
			MOM_do_template [CONF_CTRL_moves $mom_motion_event]
		} @NODECOMPOSE
	} else {
		LIB_GE_command_buffer {
			set decompose [CONF_CTRL_moves decompose_first_move_sim_z]
			LIB_SPF_decompose_block_template $decompose [CONF_CTRL_moves $mom_motion_event] FORCE [join $decompose]
		} @DECOMPOSE
	}
	
	if {[CONF_CTRL_coolant coolnt_output_before_motion] == 2 && [info exists tmp_coolant_mode]} {
		set ::mom_coolant_mode $tmp_coolant_mode
	}
	
	LIB_GE_command_buffer_output
	set lib_flag(current_safety_position) 0
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# This allows to check the first move after cutcom is switched on or off
# This is meant to do checks like first move has not to be a circular move
# The flags lib_flag(check_cutcom_start_move) and lib_flag(check_cutcom_end_move) are triggering this check
# those flags are set in MOM_cutcom_on and MOM_cutcom_off
#
# Proc has to be moved to controller level to implement controller specific checks
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_SPF_check_cutcom_condition {} {


	global mom_kin_is_turbo_output mom_cutcom_adjust_register_defined mom_tool_cutcom_register mom_tool_number
	global mom_motion_event mom_path_name
	global mom_pos mom_prev_pos tool_axis
	global lib_flag

	if {([LIB_SPF_get_pretreatment mom_cutcom_status] == "LEFT" || [LIB_SPF_get_pretreatment mom_cutcom_status] == "RIGHT")\
		 && $mom_kin_is_turbo_output == "TRUE" && $mom_cutcom_adjust_register_defined == 0} {
		if {$mom_tool_cutcom_register != $mom_tool_number} {
			LIB_SPF_add_warning "Tool cutcom register 'INS->$mom_tool_cutcom_register<-' is different to tool number 'INS->$mom_tool_number<-' and it's not output. With turbo mode activated, Switch it to ON in the operation"
		}
	}

	if {[info exists lib_flag(check_cutcom_start_move)] && $lib_flag(check_cutcom_start_move) == 1} {
		if {$mom_motion_event == "circular_move" && [CONF_CTRL_setting cutcom_on_with_circle_allowed] == 0} {
			LIB_SPF_add_warning "CUTCOM error in Operation 'INS->$mom_path_name<-' , First move after INS->G41/G42<- has to be a linear move"

		} else {

			VEC3_sub mom_pos mom_prev_pos move_neg
			VEC3_negate move_neg move

			array set tool_vector "0 0 1 0 2 0"

			set tool_vector($tool_axis) 1.0

			if {[VEC3_mag move] > 0 && [VEC3_is_parallel move tool_vector] == 1 && [CONF_CTRL_setting cutcom_on_with_tool_axis_allowed] == 0} {
				LIB_SPF_add_warning "CUTCOM error in Operation 'INS->$mom_path_name<-' , First move after INS->G41/G42<- cannot be parallel to tool axis"
			}
		}
		set lib_flag(check_cutcom_start_move) 2
	} elseif {[info exists lib_flag(check_cutcom_end_move)] && $lib_flag(check_cutcom_end_move)} {
		if {$mom_motion_event == "circular_move" && [CONF_CTRL_setting cutcom_on_with_circle_allowed] == 0} {
			LIB_SPF_add_warning "CUTCOM error in Operation 'INS->$mom_path_name<-' , First move after INS->G40<- has to be a linear move"
		} else {

			VEC3_sub mom_pos mom_prev_pos move_neg
			VEC3_negate move_neg move

			array set tool_vector "0 0 1 0 2 0"

			set tool_vector($tool_axis) 1.0

			if {[VEC3_is_parallel move tool_vector] == 1 && [CONF_CTRL_setting cutcom_on_with_tool_axis_allowed] == 0} {
				LIB_SPF_add_warning "CUTCOM error in Operation 'INS->$mom_path_name<-' , First move after INS->G40<- cannot be parallel to tool axis"
			}
		}
		set lib_flag(check_cutcom_end_move) 0
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is used to handle turn rough and finish cycle with generic cycle enhancement.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_generic_cycle_LIB {} {


	set commandcheck(MOM_generic_cycle_LIB_ENTRY) [llength [info commands MOM_generic_cycle_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_generic_cycle_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_generic_cycle_LIB_ENTRY)} {MOM_generic_cycle_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global mom_generic_cycle_status
	global mom_sys_output_contour_motion
	global mom_from_status
	global mom_start_status
	global mom_motion_type
	global mom_operation_name
	global dpp_return_motion_list
	global dpp_return_motion_start
	global dpp_first_buffer_for_return_motion
	global mom_post_oper_path

	if {$mom_generic_cycle_status == 1} {

		# Initialize G71/G72 output at generic cycle start
		LIB_CTRL_init_rough_turn_cycle_output

		# Check whether a start point has been set
		if {([info exists mom_from_status] && $mom_from_status == 1) || \
			([info exists mom_start_status] && $mom_start_status == 1) || \
			([info exists mom_motion_type] && [string match "APPROACH" $mom_motion_type])} {

			##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			# When posting both rough and finish turning cycle operation (Scenario 2), contour data of finish operation will be used for rough.
			# So NX will use extended command MOM_post_oper_path to post the finish operation in the rough operation to get contour data
			# and mom_post_oper_path is set to 1 in subpost run by MOM_post_oper_path.
			#
			# Then NX will use NC codes between events MOM_generic_cycle as contour data.
			# Because MOM_contour_start and MOM_contour_end don't output in MOM_post_oper_path.
			#
			# In other scenarios, skip the events between MOM_generic_cycle
			# and use NC codes between events MOM_contour_start and MOM_contour_end as contour data.
			##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

			if {[info exists mom_post_oper_path] && ($mom_post_oper_path == 1)} {

				# Set start mark of finish contour data in output file
				LIB_CTRL_finish_turn_cycle_contour_start

			} else {

				# Skip to next generic which should be cycle off
				MOM_skip_handler_to_event generic_cycle
			}

		} else {

			LIB_GE_abort_message "$mom_operation_name: None of from point, start point or approach path is defined before turning cycle in this operation."
		}
	}

	if {$mom_generic_cycle_status == 0} {

		if {[info exist mom_sys_output_contour_motion] && \
			($mom_sys_output_contour_motion == 1 || $mom_sys_output_contour_motion == 2)} {

			if {[info exists mom_post_oper_path] && ($mom_post_oper_path == 1)} {

				# Set end mark of finish contour data in output file
				LIB_CTRL_finish_turn_cycle_contour_end
			}

			# Flag to indicate return motion begin
			set dpp_return_motion_start 1

			# Flag to indicate the first buffer for return motion
			set dpp_first_buffer_for_return_motion 1

			# Create a list to store the return motion NC codes
			set dpp_return_motion_list [list]
		}
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_generic_cycle_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_generic_cycle_LIB_ENTRY)} {MOM_generic_cycle_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to prepare to generate contour data and customize sequence number output mode.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_init_rough_turn_cycle_output {} {


	global mom_machine_control_motion_output
	global mom_sys_output_cycle95
	global mom_sys_output_contour_motion
	global mom_template_subtype
	global dpp_record_rough_cycle_seq
	global mom_machine_cycle_subroutine_name
	global dpp_finish_feed
	global mom_feed_cut_value
	global dpp_turn_cycle_g_code
	global mom_operation_name

	##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	# "mom_sys_output_contour_motion" can be set [ 0 | 1 | 2 ].
	#  0: No contour output
	#  1: Part contour
	#  2: Tracking path contour
	##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	# Initialize mom_sys_output_contour_motion to 0 as default.
	set mom_sys_output_contour_motion 0

	##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	# So far, machine cycle motion has been supported in following three scenarios.
	#
	# Scenario 1: single rough turning cycle operation.
	# Scenario 2: both rough and finish turning cycle operation.
	#             (The following two conditions should be fulfilled in this scenario.)
	#             Condition 1: contour data of rough and finish operations should be same.
	#                          This is checked by user when operations are created, not checked by post processor.
	#             Condition 2: subroutine name of rough operation should be same as the finish operation name.
	# Scenario 3: single finish turning cycle operation.
	##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	# When "Machine Cycle" is selected as Motion Output in Machine control and
	# post processor is equipped with the ability to output rough turning cycle, then:
	if {([info exists mom_machine_control_motion_output] && $mom_machine_control_motion_output == 2) && \
		([info exists mom_sys_output_cycle95] && $mom_sys_output_cycle95)} {

		# Check scenario 1
		# template_subtype FACE_TURN is introduced in NX2212 to replace FACING, which has been moved to the legacy template. 
		if {[string match "FACING" $mom_template_subtype] || [string match "*ROUGH*" $mom_template_subtype] || [string match "*FACE*" $mom_template_subtype]} { 

			LIB_CTRL_set_contour_motion

		# Check scenario 2 or 3
		} elseif {[string match "*FINISH*" $mom_template_subtype]} {

			# Scenario 2
			if {[info exists dpp_record_rough_cycle_seq(begin,$mom_operation_name)]} {

				# Output G70 command
				set dpp_finish_feed $mom_feed_cut_value
				set dpp_turn_cycle_g_code 70

				LIB_GE_command_buffer TURN_CYCLE_FINISHING_IN_INITIAL
				LIB_GE_command_buffer {MOM_do_template turn_cycle_finishing} @TURN_CYCLE_FINISHING_IN_INITIAL
				LIB_GE_command_buffer_output

				MOM_force once G_motion X Z

			# Scenario 3
			} else {

				LIB_CTRL_set_contour_motion
			}

		# Other scenarios
		} else {

			LIB_GE_abort_message "$mom_operation_name: The machine cycle motion has not been supported in current operation type so far."
		}

		# Don't output cutcom until rough turning cycle called
		MOM_disable_address G_cutcom
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is to set contour motion as part contour data (value 1) or tracking path data (value 2)
# depending on whether cutter compensation UDE has been set or not.
#
# This command is used in LIB_CTRL_init_rough_turn_cycle_output.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_set_contour_motion {} {


	global mom_cutcom_status
	global dpp_save_cutcom_status
	global mom_sys_output_contour_motion

	if {$mom_cutcom_status=="LEFT" || $mom_cutcom_status=="RIGHT"} {

		# If user adds cutcom UDE, save the status and notify NX/Post to process part contour data.
		set dpp_save_cutcom_status $mom_cutcom_status
		set mom_sys_output_contour_motion 1

	} else {

		# If user does not add cutcom UDE, notify NX/Post to process tracking path data.
		set mom_sys_output_contour_motion 2
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is to set start mark of finish or rough contour data in output file in subpost run by MOM_post_oper_path.
#
# This command is used in proc MOM_generic_cycle when mom_generic_cycle_status is 1.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_finish_turn_cycle_contour_start {} {


	global mom_template_subtype

	if {[string match "*FINISH*" $mom_template_subtype] || [string match "*ROUGH*" $mom_template_subtype]} {

		# Set the start mark of finish contour data
		MOM_set_seq_off

		LIB_GE_command_buffer TURN_CYCLE_CONTOUR_START
		LIB_GE_command_buffer {LIB_GE_message "CONTOUR TURN START" } @TURN_CYCLE_CONTOUR_START_TAG
		LIB_GE_command_buffer_output

		MOM_force once G_motion X Z
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is to set end mark of finish or rough contour data in output file in subpost run by MOM_post_oper_path.
#
# This command is used in proc MOM_generic_cycle when mom_generic_cycle_status is 0.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_finish_turn_cycle_contour_end {} {


	global mom_template_subtype

	if {[string match "*FINISH*" $mom_template_subtype] || [string match "*ROUGH*" $mom_template_subtype]} {

		# Set the end mark of finish contour data
		LIB_GE_command_buffer TURN_CYCLE_CONTOUR_END_TAG
		LIB_GE_command_buffer {MOM_output_literal "(CONTOUR TURN END)"} @TURN_CYCLE_CONTOUR_END_TAG
		LIB_GE_command_buffer_output

		MOM_set_seq_on
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_linear_move_LIB {} {


	global lib_flag lib_param
	global mom_machine_mode
	global mom_motion_type

	set commandcheck(MOM_linear_move_LIB_ENTRY) [llength [info commands MOM_linear_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_linear_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_linear_move_LIB_ENTRY)} {MOM_linear_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$lib_flag(tool_path_motion) == 1} {
		if {$::mom_machine_mode == "TURN"} {

			LIB_GE_command_buffer FIRST_MOVE_TURN

			LIB_GE_command_buffer {LIB_TURNING_mode start} @START_TURN_MODE
			LIB_GE_command_buffer {LIB_SPINDLE_start preset} @PRESET_SPINDLE_SPEED
			LIB_GE_command_buffer {if {[CONF_CTRL_coolant coolnt_output_before_motion] == 1} {LIB_WRITE_coolant on}} @OUTPUT_COOLNT_TURN
			LIB_GE_command_buffer {
				MOM_suppress always S
				if {$lib_flag(decompose_first_move_turn) == 1} {
					LIB_SPF_decompose_block_template [CONF_CTRL_moves decompose_first_move_turn_order] [CONF_CTRL_moves linear_template] FORCE "X Y Z"
				} else {
					MOM_do_template [CONF_CTRL_moves linear_template]
				}
				MOM_suppress off S
			} @MOVE
			LIB_GE_command_buffer {LIB_SPINDLE_start limit} @SPINDLE_LIMIT
			LIB_GE_command_buffer {LIB_SPINDLE_start} @START_SPINDLE
			LIB_GE_command_buffer_output

		} else {
			LIB_GE_command_buffer FIRST_MOVE_MILL

			LIB_GE_command_buffer {LIB_SPINDLE_start} @START_SPINDLE
			LIB_GE_command_buffer {
					switch -- $lib_flag(mode_current_status) {
						"std" {
							LIB_ROTARY_positioning_first_move
						}
						"pos" {
							LIB_ROTARY_positioning_first_move_pos
						}
						"sim" {
							LIB_ROTARY_positioning_first_move_sim
						}
					}
				} @MOVE
			LIB_GE_command_buffer_output
		}

		LIB_GE_command_buffer COOLANT_ON
		LIB_GE_command_buffer {LIB_WRITE_coolant on} @OUTPUT
		LIB_GE_command_buffer_output

		set lib_flag(tool_path_motion) 2
	} elseif {$lib_param(cutting_tool_axis) != "" || [LIB_GE_commandbuffer_is_customized OUTPUT]} {
		if {$mom_machine_mode == "TURN"} {
			LIB_GE_command_buffer TURN
			LIB_GE_command_buffer {LIB_SPINDLE_start limit} @OUTPUT
			LIB_GE_command_buffer_output
		}

		LIB_GE_command_buffer OUTPUT
		LIB_GE_command_buffer {LIB_SPINDLE_start} @SPINDLE_START
		LIB_GE_command_buffer {LIB_WRITE_coolant on} @COOLANT_ON
		LIB_GE_command_buffer {
			if {[info exists ::dpp_rough_turn_cycle_start] && $::dpp_rough_turn_cycle_start} {

				LIB_CTRL_output_contour_for_rough_turn_cycle

			} elseif {[info exists ::dpp_return_motion_start] && $::dpp_return_motion_start} {

				LIB_CTRL_output_return_motion_for_rough_turn_cycle

			} else {

				MOM_do_template [CONF_CTRL_moves linear_template]
			}
		} @MOVE
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer OUTPUT_SINGLE
		LIB_GE_command_buffer {
			if {[info exists ::dpp_rough_turn_cycle_start] && $::dpp_rough_turn_cycle_start} {

				LIB_CTRL_output_contour_for_rough_turn_cycle

			} elseif {[info exists ::dpp_return_motion_start] && $::dpp_return_motion_start} {

				LIB_CTRL_output_return_motion_for_rough_turn_cycle

			} else {

				MOM_do_template [CONF_CTRL_moves linear_template]
			}
		} @MOVE
		LIB_GE_command_buffer_output
	}

	if {$mom_motion_type == "RAPID"} {
		LIB_SPF_last_rapid_pos
	}
	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_linear_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_linear_move_LIB_ENTRY)} {MOM_linear_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_circular_move_LIB {} {

	global lib_param

	set commandcheck(MOM_circular_move_LIB_ENTRY) [llength [info commands MOM_circular_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_circular_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_circular_move_LIB_ENTRY)} {MOM_circular_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$lib_param(cutting_tool_axis) != "" || [LIB_GE_commandbuffer_is_customized OUTPUT]} {
	LIB_GE_command_buffer OUTPUT
	LIB_GE_command_buffer {LIB_WRITE_coolant on} @COOLANT_ON
	LIB_GE_command_buffer {LIB_CIRCLE_set} @CIRCLE_SET
	LIB_GE_command_buffer {
		if {[info exists ::dpp_rough_turn_cycle_start] && $::dpp_rough_turn_cycle_start} {

			LIB_CTRL_output_contour_for_rough_turn_cycle

		} elseif {[info exists ::dpp_return_motion_start] && $::dpp_return_motion_start} {

			LIB_CTRL_output_return_motion_for_rough_turn_cycle

		} else {

			MOM_do_template [CONF_CTRL_moves circular_template]
		}
	} @MOVE
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer OUTPUT_SINGLE
		LIB_GE_command_buffer {LIB_CIRCLE_set} @CIRCLE_SET
		LIB_GE_command_buffer {
			if {[info exists ::dpp_rough_turn_cycle_start] && $::dpp_rough_turn_cycle_start} {

				LIB_CTRL_output_contour_for_rough_turn_cycle

			} elseif {[info exists ::dpp_return_motion_start] && $::dpp_return_motion_start} {

				LIB_CTRL_output_return_motion_for_rough_turn_cycle

			} else {

				MOM_do_template [CONF_CTRL_moves circular_template]
			}
		} @MOVE
		LIB_GE_command_buffer_output
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_circular_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_circular_move_LIB_ENTRY)} {MOM_circular_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to output the contour data for rough turn cycle.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_output_contour_for_rough_turn_cycle {} {


	global dpp_contour_list mom_motion_event 
	global lib_flag mom_pos turn_cycle_contour_start_pos turn_cycle_contour_end_pos

	# PR10296287: turn contour start and end points come from cutting motions in last loop of cycle
	if {[info exists lib_flag(turn_contour_start)] && $lib_flag(turn_contour_start) == 1} {
		array set turn_cycle_contour_start_pos [array get mom_pos]
		set lib_flag(turn_contour_start) 0
	} elseif {[info exists lib_flag(turn_contour_end)] && $lib_flag(turn_contour_end) == 1} {
		array set turn_cycle_contour_end_pos [array get mom_pos]
		set lib_flag(turn_contour_end) 0
	}

	set o_buffer [MOM_do_template ${mom_motion_event}_rough_turn_cycle CREATE]
	lappend dpp_contour_list $o_buffer

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to output the return motion for rough turn cycle.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_output_return_motion_for_rough_turn_cycle {} {


	global dpp_return_motion_list
	global mom_motion_event
	global dpp_motion_event

	LIB_CTRL_check_first_buffer_for_return_motion

	set dpp_motion_event [string range $mom_motion_event 0 [expr [string length $mom_motion_event]-6]]

	set o_buffer [MOM_do_template [CONF_CTRL_moves ${dpp_motion_event}_template] CREATE]
	lappend dpp_return_motion_list $o_buffer

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to check whether it is the first time to buffer MOM_do_template for return motion.
# if so, then force output G_motion, X and Z.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_check_first_buffer_for_return_motion {} {


	global dpp_first_buffer_for_return_motion

	if {[info exists dpp_first_buffer_for_return_motion] && $dpp_first_buffer_for_return_motion == 1} {

		MOM_force once G_motion X Z
		set dpp_first_buffer_for_return_motion 0
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_helix_move_LIB {} {


	global mom_helix_turn_number
	global tool_axis

	set commandcheck(MOM_helix_move_LIB_ENTRY) [llength [info commands MOM_helix_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_helix_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_helix_move_LIB_ENTRY)} {MOM_helix_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_GE_command_buffer OUTPUT
	LIB_GE_command_buffer {LIB_WRITE_coolant on} @COOLANT_ON
	LIB_GE_command_buffer {LIB_CIRCLE_set} @CIRCLE_SET
	LIB_GE_command_buffer {LIB_HELIX_nturn $tool_axis} @HELIX_NTURN
	LIB_GE_command_buffer {MOM_do_template [CONF_CTRL_moves circular_template]} @MOVE
	LIB_GE_command_buffer_output

	unset mom_helix_turn_number

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_helix_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_helix_move_LIB_ENTRY)} {MOM_helix_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# Calculate number of turns
# Linked to helix_move
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_HELIX_nturn {axis} {


	global mom_prev_pos mom_pos mom_helix_pitch mom_arc_angle
	global mom_helix_turn_number mom_kin_machine_resolution

	set delta [expr abs($mom_pos($axis) - $mom_prev_pos($axis))]

	if {![EQ_is_equal $mom_helix_pitch 0 $mom_kin_machine_resolution]} {
		set mom_helix_turn_number [expr floor([LIB_SPF_round [expr $delta / [expr abs($mom_helix_pitch)]] $mom_kin_machine_resolution])]
	} elseif {![EQ_is_equal $delta 0 $mom_kin_machine_resolution]} {
		set mom_helix_turn_number 1
	} else {
		set mom_helix_turn_number 0
	}

	if {[EQ_is_le $mom_arc_angle 360.0 $mom_kin_machine_resolution]} {
		MOM_suppress once helix_turn
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is executed at the beginning and at the end of MOM_cutcom_on procedure
# depending of the argument: start or end
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_cutcom_on_ENTRY {option} {


	global mom_cutcom_adjust_register mom_tool_cutcom_register mom_tool_number
	global cutcom_adjust_register

	switch -- $option {
		"start" {
			if {[CONF_CTRL_setting cutcom_output] == 1} {
				if {$mom_tool_cutcom_register == 0} {
					set cutcom_adjust_register $mom_tool_number
				} else {
					set cutcom_adjust_register $mom_tool_cutcom_register
				}
			} else {
				set cutcom_adjust_register 0
			}
			if {[hiset mom_cutcom_adjust_register]} {set cutcom_adjust_register $mom_cutcom_adjust_register}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is executed at the beginning and at the end of MOM_cutcom_off procedure
# depending of the argument: start or end
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_cutcom_off_ENTRY {option} {


	global cutcom_adjust_register

	switch -- $option {
		"end" {
			if {[hiset cutcom_adjust_register]} {unset cutcom_adjust_register}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_opstop_LIB {mess} {

	global mom_opstop_text mom_opstop_text_defined

	set commandcheck(MOM_opstop_LIB_ENTRY) [llength [info commands MOM_opstop_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_opstop_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_opstop_LIB_ENTRY)} {MOM_opstop_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$mess == ""} {
		if {[hiset mom_opstop_text_defined] && $mom_opstop_text_defined == 1} {
			LIB_GE_command_buffer MOM_opstop_LIB_text
			LIB_GE_command_buffer {
				if {[CONF_SPF_msg opstop_comment_pos] == "along_with_stop"} {
					MOM_do_template opstop BUFFER
				} elseif {[CONF_SPF_msg opstop_comment_pos] == "after_opstop"} {
					MOM_do_template opstop
				}
			} @OUTPUT_BEFORE_MSG
			LIB_GE_command_buffer {
				LIB_GE_message "$mom_opstop_text" "output_2"
			} @MESSAGE
			LIB_GE_command_buffer {
				if {[CONF_SPF_msg opstop_comment_pos] == "before_opstop"} {
					MOM_do_template opstop
				}
			} @OUTPUT_AFTER_MSG
			LIB_GE_command_buffer_output
			set mom_opstop_text_defined 0
		} else {
			LIB_GE_command_buffer MOM_opstop_LIB
			LIB_GE_command_buffer {
				MOM_do_template opstop
			} @OUTPUT
			LIB_GE_command_buffer_output
		}
	} else {
		LIB_GE_command_buffer MOM_opstop_LIB_message
		LIB_GE_command_buffer {
			if {[CONF_SPF_msg opstop_comment_pos] == "along_with_opstop"} {
				MOM_do_template opstop BUFFER
			} elseif {[CONF_SPF_msg opstop_comment_pos] == "after_opstop"} {
				MOM_do_template opstop
			}
		} @OUTPUT_BEFORE_MSG
		LIB_GE_command_buffer {
			LIB_GE_message "$mess" "output_2"
		} @MESSAGE
		LIB_GE_command_buffer {
			if {[CONF_SPF_msg opstop_comment_pos] == "before_opstop"} {
				MOM_do_template opstop
			}
		} @OUTPUT_AFTER_MSG
	}

	LIB_GE_command_buffer MOM_opstop_LIB_INIT
	LIB_GE_command_buffer {
		MOM_do_template stop_init CREATE
	} @OUTPUT
	LIB_GE_command_buffer_output

	if {[hiset mom_opstop_text]} {unset mom_opstop_text}
	if {[hiset mom_opstop_text_defined]} {unset mom_opstop_text_defined}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_opstop_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_opstop_LIB_ENTRY)} {MOM_opstop_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_stop_LIB {mess} {

	global mom_stop_text mom_stop_text_defined

	set commandcheck(MOM_stop_LIB_ENTRY) [llength [info commands MOM_stop_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_stop_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_stop_LIB_ENTRY)} {MOM_stop_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$mess == ""} {
		if {[hiset mom_stop_text_defined] && $mom_stop_text_defined == 1} {
			LIB_GE_command_buffer MOM_stop_LIB_text
			LIB_GE_command_buffer {
				if {[CONF_SPF_msg stop_comment_pos] == "along_with_stop"} {
					MOM_do_template stop BUFFER
				} elseif {[CONF_SPF_msg stop_comment_pos] == "after_stop"} {
					MOM_do_template stop
				}
			} @OUTPUT_BEFORE_MSG
			LIB_GE_command_buffer {
				LIB_GE_message "$mom_stop_text" "output_2"
			} @MESSAGE
			LIB_GE_command_buffer {
				if {[CONF_SPF_msg stop_comment_pos] == "before_stop"} {
					MOM_do_template stop
				}
			} @OUTPUT_AFTER_MSG
			LIB_GE_command_buffer_output
			set mom_stop_text_defined 0
		} else {
			LIB_GE_command_buffer MOM_stop_LIB
			LIB_GE_command_buffer {
				MOM_do_template stop
			} @OUTPUT
			LIB_GE_command_buffer_output
		}
	} else {
		LIB_GE_command_buffer MOM_stop_LIB_message
		LIB_GE_command_buffer {
			if {[CONF_SPF_msg stop_comment_pos] == "along_with_stop"} {
				MOM_do_template stop BUFFER
			} elseif {[CONF_SPF_msg stop_comment_pos] == "after_stop"} {
				MOM_do_template stop
			}
		} @OUTPUT_BEFORE_MSG
		LIB_GE_command_buffer {
			LIB_GE_message "$mess" "output_2"
		} @MESSAGE
		LIB_GE_command_buffer {
			if {[CONF_SPF_msg stop_comment_pos] == "before_stop"} {
				MOM_do_template stop
			}
		} @OUTPUT_AFTER_MSG
	}
	LIB_GE_command_buffer MOM_stop_LIB_INIT
	LIB_GE_command_buffer {
		MOM_do_template stop_init CREATE
	} @OUTPUT
	LIB_GE_command_buffer_output

	if {[hiset mom_stop_text]} {unset mom_stop_text}
	if {[hiset mom_stop_text_defined]} {unset mom_stop_text_defined}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_stop_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_stop_LIB_ENTRY)} {MOM_stop_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_nurbs_move_LIB {} {


	set commandcheck(MOM_nurbs_move_LIB_ENTRY) [llength [info commands MOM_nurbs_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_nurbs_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_nurbs_move_LIB_ENTRY)} {MOM_nurbs_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_nurbs_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_nurbs_move_LIB_ENTRY)} {MOM_nurbs_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_contour_start_LIB {} {


	set commandcheck(MOM_contour_start_LIB_ENTRY) [llength [info commands MOM_contour_start_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_contour_start_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_contour_start_LIB_ENTRY)} {MOM_contour_start_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------
	global mom_post_oper_path

	if {[info exists mom_post_oper_path] && $mom_post_oper_path == 1} {
		LIB_CTRL_finish_turn_cycle_contour_start
	} else {
		LIB_CTRL_turn_cycle_contour_start
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_contour_start_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_contour_start_LIB_ENTRY)} {MOM_contour_start_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_contour_end_LIB {} {


	set commandcheck(MOM_contour_end_LIB_ENTRY) [llength [info commands MOM_contour_end_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_contour_end_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_contour_end_LIB_ENTRY)} {MOM_contour_end_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------
	global mom_post_oper_path

	if {[info exists mom_post_oper_path] && $mom_post_oper_path == 1} {
		LIB_CTRL_finish_turn_cycle_contour_end
	} else {
		LIB_CTRL_turn_cycle_contour_end
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_contour_end_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_contour_end_LIB_ENTRY)} {MOM_contour_end_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_cutcom_on_LIB {} {
#@.pce@

	set commandcheck(MOM_cutcom_on_LIB_ENTRY) [llength [info commands MOM_cutcom_on_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_cutcom_on_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_cutcom_on_LIB_ENTRY)} {MOM_cutcom_on_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_CTRL_setting cutcom_on_alone] == 1} {
		LIB_GE_command_buffer CUTCOM_ON_OUTPUT
		LIB_GE_command_buffer {MOM_do_template cutcom_on} @OUTPUT
		LIB_GE_command_buffer_output
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_cutcom_on_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_cutcom_on_LIB_ENTRY)} {MOM_cutcom_on_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to detect the rough turning cycle type, calculate the cycle parameters
# and create a list to store the contour datas and start tag and end tag.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_turn_cycle_contour_start {} {


	global dpp_turn_cycle_g_code
	global dpp_rough_turn_cycle_start
	global dpp_contour_list
	global dpp_return_motion_start

	# Flag to indicate return motion end
	set dpp_return_motion_start 0

	# Flag to indicate rough turning cycle contour begin
	set dpp_rough_turn_cycle_start 1

	# Set default G motion type for rough turning cycle
	set dpp_turn_cycle_g_code 71

	# Set rough turning cycle type according to the step angle
	LIB_CTRL_set_turning_cycle_type

	# Create a list to store the contour NC codes, start tag and end tag
	set dpp_contour_list [list]

	# Store the start tag
	set o_buffer [MOM_do_template turn_cycle_start_tag CREATE]

	lappend dpp_contour_list $o_buffer

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to set turning cycle type according to the step angle.
#
# This command is used in proc LIB_CTRL_turn_cycle_contour_start.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_set_turning_cycle_type {} {


	global mom_level_step_angle
	global dpp_turn_cycle_g_code
	global dpp_turn_cycle_retract
	global mom_clearance_from_faces
	global mom_clearance_from_diameters
	global dpp_turn_cycle_msg
	global mom_operation_name

	# Set rough turning cycle type according to the step angle
	if {[info exists mom_level_step_angle]} {

		if {[EQ_is_equal $mom_level_step_angle 270] || [EQ_is_equal $mom_level_step_angle 90]} {

			set dpp_turn_cycle_g_code 72
			set dpp_turn_cycle_retract $mom_clearance_from_faces
			set dpp_turn_cycle_msg "ROUGH FACE CYCLE"

		} elseif {[EQ_is_equal $mom_level_step_angle 180] || [EQ_is_equal $mom_level_step_angle 0]} {

			set dpp_turn_cycle_g_code 71
			set dpp_turn_cycle_retract $mom_clearance_from_diameters
			set dpp_turn_cycle_msg "ROUGH TURN CYCLE"

		} else {

			LIB_GE_abort_message "$mom_operation_name: Turning cycle type could not be set by variable mom_level_step_angle now."
		}
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to calculate the parameters for rough turning cycle block.
#
# This command is used in proc LIB_CTRL_turn_cycle_contour_start.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_calculate_parameters_for_turning_cycle_block {} {


	global dpp_turn_cycle_cut_feed dpp_turn_cycle_cut_speed
	global mom_feed_cut_value mom_spindle_speed
	global dpp_turn_cycle_stock_x dpp_turn_cycle_stock_z
	global mom_stock_part mom_face_stock mom_radial_stock
	global dpp_save_cutcom_status
	global mom_level_step_angle
	global mom_cutcom_status
	global turn_cycle_contour_start_pos turn_cycle_contour_end_pos dpp_turn_cycle_g_code

	# Set value for F and S.
	set dpp_turn_cycle_cut_feed $mom_feed_cut_value
	set dpp_turn_cycle_cut_speed $mom_spindle_speed

	# Calculate stocks for U and W.
	set dpp_turn_cycle_stock_x [expr [LIB_SPF_check_x_factor TURN] * ($mom_stock_part + $mom_radial_stock)]
	set dpp_turn_cycle_stock_z [expr $mom_stock_part + $mom_face_stock]

	# Adjust the sign of U and W and output tool nose radius compensation code.
	if {[info exists dpp_save_cutcom_status]} {

		if { $dpp_save_cutcom_status == "RIGHT"} {

			if {[EQ_is_equal $mom_level_step_angle 0]} {

				set dpp_turn_cycle_stock_x [expr -$dpp_turn_cycle_stock_x]
				set dpp_turn_cycle_stock_z [expr -$dpp_turn_cycle_stock_z]

			} elseif {[EQ_is_equal $mom_level_step_angle 90]} {

				set dpp_turn_cycle_stock_x [expr -$dpp_turn_cycle_stock_x]

			} elseif {[EQ_is_equal $mom_level_step_angle 270]} {

				set dpp_turn_cycle_stock_z [expr -$dpp_turn_cycle_stock_z]
			}

			set mom_cutcom_status $dpp_save_cutcom_status
			MOM_enable_address G_cutcom
			MOM_force once G_cutcom D

			LIB_GE_command_buffer TURN_CYCLE_CUTCOM_ON_RIGHT
			LIB_GE_command_buffer {MOM_do_template cutcom_on} @TURN_CYCLE_CUTCOM_ON_RIGHT
			LIB_GE_command_buffer_output
		}

		if {$dpp_save_cutcom_status == "LEFT"} {

			if {[EQ_is_equal $mom_level_step_angle 0]} {

				set dpp_turn_cycle_stock_z [expr -$dpp_turn_cycle_stock_z]

			} elseif {[EQ_is_equal $mom_level_step_angle 90]} {

				set dpp_turn_cycle_stock_x [expr -$dpp_turn_cycle_stock_x]
				set dpp_turn_cycle_stock_z [expr -$dpp_turn_cycle_stock_z]

			} elseif {[EQ_is_equal $mom_level_step_angle 180]} {

				set dpp_turn_cycle_stock_x [expr -$dpp_turn_cycle_stock_x]
			}

			set mom_cutcom_status $dpp_save_cutcom_status
			MOM_enable_address G_cutcom
			MOM_force once G_cutcom D

			LIB_GE_command_buffer TURN_CYCLE_CUTCOM_ON_LEFT
			LIB_GE_command_buffer {MOM_do_template cutcom_on} @TURN_CYCLE_CUTCOM_ON_LEFT
			LIB_GE_command_buffer_output
		}
	} else {
		# PR10296287: turn cycle initial point come from start position in first loop of cycle
		# Add mom_turn_cycle_init_pos in NX2312 by read ahead filter
		global mom_turn_cycle_initial_pos pc_initial_library_release_of_post
		if {[info exists mom_turn_cycle_initial_pos] && [info exists pc_initial_library_release_of_post] && $pc_initial_library_release_of_post > 230700} {
			array set turn_cycle_initial_pos [array get mom_turn_cycle_initial_pos]
		} else {
			array set turn_cycle_initial_pos "0 [LIB_SPF_get_pretreatment "turn_cycle_initial_pos,0"] 1 [LIB_SPF_get_pretreatment "turn_cycle_initial_pos,1"] 2 [LIB_SPF_get_pretreatment "turn_cycle_initial_pos,2"]"
		}
		if {$dpp_turn_cycle_g_code == 71} {
			if {[EQ_is_lt $turn_cycle_initial_pos(0) $turn_cycle_contour_start_pos(0)]} {
				set dpp_turn_cycle_stock_x [expr -$dpp_turn_cycle_stock_x]
			}
			if {[EQ_is_lt $turn_cycle_contour_start_pos(2) $turn_cycle_contour_end_pos(2)]} {
				set dpp_turn_cycle_stock_z [expr -$dpp_turn_cycle_stock_z]
			}
		} elseif {$dpp_turn_cycle_g_code == 72} {
			if {[EQ_is_lt $turn_cycle_initial_pos(2) $turn_cycle_contour_start_pos(2)]} {
				set dpp_turn_cycle_stock_z [expr -$dpp_turn_cycle_stock_z]
			}
			if {[EQ_is_lt $turn_cycle_contour_start_pos(0) $turn_cycle_contour_end_pos(0)]} {
				set dpp_turn_cycle_stock_x [expr -$dpp_turn_cycle_stock_x]
			}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to output the contour data and adjust the sequence number.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_turn_cycle_contour_end {} {


	global dpp_rough_turn_cycle_start
	global dpp_contour_list
	global dpp_contour_list_length
	global mom_sys_output_contour_motion
	global mom_cutcom_status
	global mom_template_subtype
	global mom_profiling
	global mom_operation_name_list
	global mom_machine_cycle_subroutine_name

	# Flag to indicate rough turning cycle contour end
	set dpp_rough_turn_cycle_start 0

	# Store the end tag in the list
	set o_buffer [MOM_do_template turn_cycle_end_tag CREATE]
	lappend dpp_contour_list $o_buffer

	##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	# When cutter compensation UDE isn't set, rough operation's contour data will be overridden
	# with associated finish operation by using extended command MOM_post_oper_path.
	# So far, NX will only override the contour data for roughing OD & ID,
	# because FACING does not have associated finishing operation.
	##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	# Override rough contour data with finish operation
	if {[string match "*ROUGH*" $mom_template_subtype] && \
		($mom_sys_output_contour_motion == 2)} {

		if {[lsearch $mom_operation_name_list $mom_machine_cycle_subroutine_name] >= 0} {

			LIB_CTRL_override_rough_contour_data_with_finish
		}
	}

	# Get the length of the list
	set dpp_contour_list_length [llength $dpp_contour_list]

	# Calculate start and end line number of contour
	LIB_CTRL_calculate_contour_line_number

	# Calculate the parameters for turning cycle block
	LIB_CTRL_calculate_parameters_for_turning_cycle_block

	# Output G70 G71 or G72 command depending on operation type
	LIB_CTRL_output_turning_cycle_command

	# Output the contour NC codes
	LIB_GE_command_buffer TURN_CYCLE_CONTOUR_END_OUTPUT
	if {[CONF_CTRL_turn sequence_number_output_mode] == 0} {
		LIB_GE_command_buffer {
			for {set i 0} {$i<$dpp_contour_list_length} {incr i} {
				# PR10168506: output sequence number for contour text line, first motion event line and last motion event line of contour 
				if {[EQ_is_le $i 1] || [EQ_is_ge $i [expr $dpp_contour_list_length-2]]} {
					MOM_force once N
					MOM_set_seq_on
				}
				set line [lindex $dpp_contour_list $i]
				MOM_output_literal $line
				MOM_set_seq_off
			}
		} @SEQOUTPUT_OFF

	} else {
		LIB_GE_command_buffer {
			MOM_force once N
			MOM_set_seq_on
			foreach line $dpp_contour_list {
				MOM_output_literal $line
			}
		} @SEQOUTPUT_ON
	}
	LIB_GE_command_buffer_output

	# Restore outputing sequence number
	if {[CONF_CTRL_setting sequence_number] == 1} {
		MOM_set_seq_on
	} else {
		MOM_set_seq_off
	}

	# Output the return motion NC codes
	global dpp_return_motion_list
	LIB_GE_command_buffer TURN_CYCLE_CONTOUR_RETURN_MOTION_OUTPUT
	LIB_GE_command_buffer {
		foreach line $dpp_return_motion_list {
			MOM_output_literal $line
		}
	} @OUTPUT
	LIB_GE_command_buffer_output

	# Additional profiling can be selected in a rough opeation and output after rough turning cycle.
	# If user adds profile in tool path, some conditions should be checked to fulfill.
	if {[info exists mom_profiling] && ($mom_profiling == 1)} {

		LIB_CTRL_output_additional_profiling
	}

	# Set NX/Post to end contour output mode
	set mom_sys_output_contour_motion 0

	# Cancle tool nose radius compensation
	if {[info exists mom_cutcom_status]} {

		if {$mom_cutcom_status=="LEFT" || $mom_cutcom_status=="RIGHT"} {

			LIB_GE_command_buffer TURN_CYCLE_CUTCOM_OFF
			LIB_GE_command_buffer {
				MOM_force once G_cutcom
				MOM_do_template cutcom_off
			} @TURN_CYCLE_CUTCOM_OFF
			LIB_GE_command_buffer_output

			set mom_cutcom_status "UNDEFINED"
		}
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to override rough contour data with corresponding finish when cutter compensation UDE is not set.
# Rough operation's subroutine name should be the same as the associated finish operation's name.
# Use MOM_post_oper_path to run a finish operation in rough operation and output the NC codes into "finish_operation_program.ptp".
# Read the contour data from this file and append into a list used for rough operation.
#
# This command is used in proc LIB_CTRL_turn_cycle_contour_end.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_override_rough_contour_data_with_finish {} {


	global mom_machine_cycle_subroutine_name
	global dpp_contour_list
	global mom_operation_name lib_spf

    set output_file_name "finish_operation_program.ptp"
    if {[info exists lib_spf(value,output_file_directory)]} {
        set output_file_full_name [LIB_GE_format_path_names "$lib_spf(value,output_file_directory)$output_file_name"]
    } else {
        set output_file_full_name $output_file_name
    }
	# Run a finish operation with MOM_post_oper_path in rough operation
	set res [MOM_post_oper_path $mom_machine_cycle_subroutine_name $output_file_full_name]

	# Flag to find the begin of contour data in output file
	global mom_finish_contour_data_start
	set mom_finish_contour_data_start 0

	# Get contour data from "finish_operation_program.ptp"
	if {$res == 1} {

		set dpp_contour_list [list]

		lappend dpp_contour_list [MOM_do_template turn_cycle_start_tag CREATE]

		# Open output file "finish_operation_program.ptp"
		if {[catch {set src [open $output_file_full_name RDONLY]} fid]} {

			LIB_GE_abort_message "$mom_operation_name: Fail to open the file finish_operation_program.ptp."
		}

		# Only capture NC codes between "(CONTOUR TURN START)" and "(CONTOUR TURN END)"
		# and append them into contour list
		while {[eof $src] == 0} {

			set line [gets $src]

			if {[string match "*(CONTOUR TURN START)*" $line]} {

				set mom_finish_contour_data_start 1
				continue

			}

			if {[string match "*(CONTOUR TURN END)*" $line]} {

				set mom_finish_contour_data_start 0
				break
			}

			if {$mom_finish_contour_data_start == 1} {

				if {[string trim $line] != ""} {
					lappend dpp_contour_list $line
				}
			}
		}

		close $src

		catch {file delete $output_file_full_name}

		lappend dpp_contour_list [MOM_do_template turn_cycle_end_tag CREATE]

	} else {

		LIB_GE_abort_message "$mom_operation_name: Fail to run the operation $mom_machine_cycle_subroutine_name with extended command MOM_post_oper_path."
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to calculate and record start and end line number of contour in NC codes.
#
# This command is used in proc LIB_CTRL_turn_cycle_contour_end.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_calculate_contour_line_number {} {


	global mom_seqnum
	global dpp_turn_cycle_seqno_begin
	global dpp_turn_cycle_seqno_end
	global mom_sys_seqnum_incr
	global dpp_record_rough_cycle_seq
	global mom_machine_cycle_subroutine_name
	global dpp_contour_list_length

	# Calculate start and end line number of contour in NC code
	# which will be output as the parameters of rough turning cycle command.

	if {[CONF_CTRL_turn sequence_number_output_mode] == 0} {
		# PR9905967: Define turn cycle sequence number start and end by line of real motion event instead of contour text
		if {[CONF_CTRL_setting sequence_number] == 0} {

			global mom_def_sequence_start
			if {[info exists dpp_turn_cycle_seqno_end]} {
				# Sequence number outputs from previous cycle end
				set dpp_turn_cycle_seqno_begin [expr $dpp_turn_cycle_seqno_end+3*$::mom_def_sequence_increment]
				set dpp_turn_cycle_seqno_end [expr $dpp_turn_cycle_seqno_end+4*$::mom_def_sequence_increment]
			} else {
				set dpp_turn_cycle_seqno_begin [expr $mom_def_sequence_start+1*$::mom_def_sequence_increment]
				set dpp_turn_cycle_seqno_end [expr $mom_def_sequence_start+2*$::mom_def_sequence_increment]
			}
		} else {

			set dpp_turn_cycle_seqno_begin [expr $mom_seqnum+3*$::mom_def_sequence_increment]
			set dpp_turn_cycle_seqno_end [expr $mom_seqnum+4*$::mom_def_sequence_increment]
		}

	} else {

		if {[CONF_CTRL_setting sequence_number] == 0} {

			global mom_def_sequence_start
			if {[info exists dpp_turn_cycle_seqno_end]} {
				# Sequence number outputs from previous cycle end
				set dpp_turn_cycle_seqno_begin [expr $dpp_turn_cycle_seqno_end+3*$::mom_def_sequence_increment]
				set dpp_turn_cycle_seqno_end [expr $dpp_turn_cycle_seqno_end+($dpp_contour_list_length)*$::mom_def_sequence_increment]
			} else {
				set dpp_turn_cycle_seqno_begin [expr $mom_def_sequence_start+1*$::mom_def_sequence_increment]
				set dpp_turn_cycle_seqno_end [expr $mom_def_sequence_start+($dpp_contour_list_length-2)*$::mom_def_sequence_increment]
			}
		} else {

			set dpp_turn_cycle_seqno_begin [expr $mom_seqnum+3*$::mom_def_sequence_increment]
			set dpp_turn_cycle_seqno_end [expr $mom_seqnum+$dpp_contour_list_length*$::mom_def_sequence_increment]
		}
	}

	# Record the rough turning cycle start seq and end seq.
	set dpp_record_rough_cycle_seq(begin,$mom_machine_cycle_subroutine_name) $dpp_turn_cycle_seqno_begin
	set dpp_record_rough_cycle_seq(end,$mom_machine_cycle_subroutine_name) $dpp_turn_cycle_seqno_end

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to output turning cycle command depending on the operation template type.
#
# This command is used in proc LIB_CTRL_turn_cycle_contour_end.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_output_turning_cycle_command {} {


	global mom_template_subtype
	global dpp_finish_feed
	global mom_feed_cut_value
	global dpp_turn_cycle_g_code

	if {[string match "FACING" $mom_template_subtype] || \
		[string match "*ROUGH*" $mom_template_subtype]} {

		# Output G71 or G72 command
		LIB_CTRL_lathe_roughing
	}

	if {[string match "*FINISH*" $mom_template_subtype]} {

		# Output G70 command

		LIB_GE_command_buffer TURN_CYCLE_FINISHING_TAG
		LIB_GE_command_buffer {MOM_output_literal "(Finish Turn Cycle)"} @TURN_CYCLE_FINISHING_TAG
		LIB_GE_command_buffer_output

		set dpp_finish_feed $mom_feed_cut_value
		set dpp_turn_cycle_g_code 70

		LIB_GE_command_buffer TURN_CYCLE_FINISHING
		LIB_GE_command_buffer {MOM_do_template turn_cycle_finishing} @TURN_CYCLE_FINISHING
		LIB_GE_command_buffer_output
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to check whether output additional profiling data or not.
# If add profile in toolpath, the following conditions should be checked to fulfill.
#
# ==>> Condition 1: Operation type is FACING or ROUGH
# ==>> Condition 2: Cutter compensation UDE has been set
# ==>> Condition 3: Strategy of path settings is Finish All
# ==>> Condition 4: Profile stock is the same with rough stock
#
# This command is used in proc LIB_CTRL_turn_cycle_contour_end.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_output_additional_profiling {} {


	global mom_operation_name
	global mom_template_subtype
	global mom_sys_output_contour_motion
	global mom_finishing_cut_method
	global mom_stock_part mom_face_stock mom_radial_stock
	global mom_finish_equidistant_stock mom_finish_face_stock mom_finish_radial_stock
	global dpp_turn_cycle_g_code
	global dpp_finish_feed
	global mom_feedrate_profile_cut

	# Check Condition 1.
	if {[string match "FACING" $mom_template_subtype] || [string match "*ROUGH*" $mom_template_subtype]} {

		# Check Condition 2.
		if {$mom_sys_output_contour_motion == 1} {

			# Check Condition 3.
			if {$mom_finishing_cut_method == 7} {

				# Check Condition 4.
				if {[EQ_is_equal $mom_finish_equidistant_stock $mom_stock_part] && \
					[EQ_is_equal $mom_finish_face_stock $mom_face_stock] && \
					[EQ_is_equal $mom_finish_radial_stock $mom_radial_stock]} {

					# Output additional profiling.
					set dpp_turn_cycle_g_code 70
					set dpp_finish_feed $mom_feedrate_profile_cut

					LIB_GE_command_buffer TURN_CYCLE_FINISHING_IN_ADDITIONAL_PROFILING
					LIB_GE_command_buffer {MOM_do_template turn_cycle_finishing} @TURN_CYCLE_FINISHING_IN_ADDITIONAL_PROFILING
					LIB_GE_command_buffer_output

				} else {

					LIB_GE_abort_message "$mom_operation_name: Profile stock should be the same with rough stock."
				}

			} else {

				LIB_GE_abort_message "$mom_operation_name: Strategy of path settings should be Finish All."
			}

		} else {

			LIB_GE_abort_message "$mom_operation_name: Additional Profiling can only be used when Cutter Compensation UDE is set."
		}

	} else {

		LIB_GE_abort_message "$mom_operation_name: Additional Profiling can only be used in FACING or ROUGH operation."
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is used to run lathe roughing cycle function.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_lathe_roughing {} {


	LIB_GE_command_buffer TURN_CYCLE_LATHE_ROUGHING
	LIB_GE_command_buffer {
		MOM_do_template lathe_roughing
		MOM_force Once G_motion
		MOM_do_template lathe_roughing_1
	} @TURN_CYCLE_LATHE_ROUGHING
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_gohome_move_LIB {} {


	global mom_motion_type

	set commandcheck(MOM_gohome_move_LIB_ENTRY) [llength [info commands MOM_gohome_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_gohome_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_gohome_move_LIB_ENTRY)} {MOM_gohome_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$mom_motion_type == "GOHOME_DEFAULT"} {
		if {[CONF_CTRL_moves return_safety_pos] != ""} {LIB_RETURN_move CONF_CTRL_moves return_safety_pos}
	} else {
		MOM_rapid_move
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_gohome_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_gohome_move_LIB_ENTRY)} {MOM_gohome_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# * store oper info (for operation list)
# * mom_next_oper_has_tool_change == "YES"
# * mom_next_oper_is_last_oper_in_program == "YES"
# * mom_next_main_mcs != mom_main_mcs
# * check rot axis change PT
# if abs
#	LIB_ROTARY_absolute_reset
# if sim
#	LIB_ROTARY_simultaneous_reset
# if pos
#	LIB_ROTARY_positioning_reset
# * retract before set axes (if needed) PT
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_end_of_path_LIB {} {


	global lib_flag
	global mom_next_oper_has_tool_change mom_current_oper_is_last_oper_in_program mom_next_main_mcs mom_main_mcs
	global mom_path_name mom_operation_name mom_machine_mode mom_out_angle_pos mom_kin_is_turbo_output mom_tool_axis
	global mom_flip_a_axis mom_tool_holder_angle_for_cutting
	global lib_pretreatment mom_tool_pitch mom_polar_status mom_coordinate_output_mode
	global mom_output_mcs_name lib_parameter nxt_oper_tool_axis
	global lib_prev_tool_name mom_next_tool_name mom_operation_is_interop
	global lib_prev_tool_adjust_register mom_tool_adjust_register

	set commandcheck(MOM_end_of_path_LIB_ENTRY) [llength [info commands MOM_end_of_path_LIB_ENTRY]]
	set commandcheck(LIB_unset_variables_in_end_of_path) [llength [info commands LIB_unset_variables_in_end_of_path]]

	LIB_GE_command_buffer MOM_end_of_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_path_LIB_ENTRY)} {MOM_end_of_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CTRL_handle_cycle_check "spindle" ;# to be sure S and M_spindle addresses are enable for next operation

	if {[CONF_CTRL_setting turbo_mode] == 1} {
		set mom_kin_is_turbo_output [LIB_SPF_get_pretreatment mom_kin_is_turbo_output]
		if {[CONF_SPF_msg output_event_message]} {LIB_SPF_output_event_message "Turbomode disable"}
		MOM_reload_kinematics_variable mom_kin_is_turbo_output
	}

	if {[info exists ::mom_sys_advanced_turbo_output] && $::mom_sys_advanced_turbo_output == "TRUE"} {
		if {[llength [info commands MOM_set_turbo_feedrate_set]]} {MOM_set_turbo_feedrate_set ON}
	}

	if {$mom_machine_mode != "TURN" && [CONF_CTRL_moves polar_off_end_of_path] == "OFF"} {
		set mom_polar_status OFF
		set mom_coordinate_output_mode OFF
	}

	if {![info exists mom_output_mcs_name($mom_operation_name)]}      {set mom_output_mcs_name($mom_operation_name) $mom_main_mcs}
	set next_operation_name [lindex $::mom_operation_name_list [expr [lsearch -exact $::mom_operation_name_list $mom_operation_name] + 1]]
	if {![info exists mom_output_mcs_name($next_operation_name)]} {set mom_output_mcs_name($next_operation_name) $mom_next_main_mcs}

	# mom_pos(3) and mom_pos(4) are not overwritten if there is an CSYS-Rotation with Toolaxis Z and parallel to TA
	# PR10021397: compare last tool axis of current operation with first tool axis of next operation,
	# because mom_tool_axis saved in pretreatment is always from last motion event.
	if {$::mom_sys_enable_nc_optimizer == "ON"} { 
		if {$next_operation_name != "" && [MOM_ask_oper_tool_path_type $next_operation_name]} {
			set init_tool_axis(0) $::mom_init_tool_axis(0)
			set init_tool_axis(1) $::mom_init_tool_axis(1)
			set init_tool_axis(2) $::mom_init_tool_axis(2)
		} else {
			set init_tool_axis(0) "";set init_tool_axis(1) "";set init_tool_axis(2) ""
		}
	} else {
		set init_tool_axis(0)  [LIB_SPF_get_pretreatment "init_tool_axis,0" 1]
		set init_tool_axis(1)  [LIB_SPF_get_pretreatment "init_tool_axis,1" 1]
		set init_tool_axis(2)  [LIB_SPF_get_pretreatment "init_tool_axis,2" 1]
		set ::mom_sys_tool_path_type($next_operation_name) [LIB_SPF_get_pretreatment axis_mode next]
	}
	if {$init_tool_axis(0) == ""} {
		array set nxt_oper_tool_axis "0 $mom_tool_axis(0) 1 $mom_tool_axis(1) 2 $mom_tool_axis(2)"
	} else {
		array set nxt_oper_tool_axis "0 $init_tool_axis(0) 1 $init_tool_axis(1) 2 $init_tool_axis(2)"
	}

	if {[CONF_CTRL_moves reset_rotary_axis_end_of_path] == "ON" || [CONF_CTRL_moves reset_rotary_axis_end_of_path] == "OFF"} {
		if {([CONF_CTRL_moves reset_rotary_axis_end_of_path] == "ON" && ![VEC3_is_equal mom_tool_axis nxt_oper_tool_axis] &&\
			$::mom_sys_tool_path_type($next_operation_name) != "SIMULTANEOUS") ||\
			($mom_output_mcs_name($mom_operation_name) != $mom_output_mcs_name($next_operation_name))} {
			LIB_SPF_reset_motions_to_zero "rot"
		}
	} elseif {[LIB_CONF_do_prop_custom_proc CONF_CTRL_moves reset_rotary_axis_end_of_path] == 1} {
			LIB_SPF_reset_motions_to_zero "rot"
	}
	
	if {[info exists mom_operation_is_interop] && $mom_operation_is_interop == 0} {
		set lib_prev_tool_adjust_register $mom_tool_adjust_register
	}

	if {[CONF_CTRL_moves safety_motion_when_mcs_changes] == 0 || [CONF_CTRL_moves safety_motion_when_mcs_changes] == 1} {
		set safety_motion_when_mcs_changes [CONF_CTRL_moves safety_motion_when_mcs_changes]
		
		if {$mom_next_oper_has_tool_change == "NO" && $safety_motion_when_mcs_changes == 0 && $next_operation_name != "" && ($mom_output_mcs_name($mom_operation_name) != $mom_output_mcs_name($next_operation_name))} { 
			set safety_motion_when_mcs_changes [LIB_SPF_csys_examine_next_oper $next_operation_name]
		}
		
	} else {
		set safety_motion_when_mcs_changes [LIB_CONF_do_prop_custom_proc CONF_CTRL_moves safety_motion_when_mcs_changes]
	}

	if {$mom_next_oper_has_tool_change == "YES" || $mom_current_oper_is_last_oper_in_program == "YES" ||\
	($mom_output_mcs_name($mom_operation_name) != $mom_output_mcs_name($next_operation_name) && $safety_motion_when_mcs_changes == 1)} {

		switch -- $mom_machine_mode {
			"TURN" {
				LIB_GE_command_buffer TOOL_OR_MCS_CHANGE,TURN
				LIB_GE_command_buffer {LIB_TURNING_mode end} @TURN_END
				LIB_GE_command_buffer_output
			}
			"MILL" {
				LIB_CTRL_polar_transmit "off"
				if {$lib_flag(tool_path_motion) > 0} {
					if {([info exists ::mom_sys_tool_path_type($mom_operation_name)] && $::mom_sys_tool_path_type($mom_operation_name)== "SIMULTANEOUS") || $lib_flag(mode_current_status) == "sim"} {
						LIB_GE_command_buffer TOOL_OR_MCS_CHANGE,MILL,SIM
						LIB_GE_command_buffer {
							if {[CONF_CTRL_setting tcpm_output_supported] == "NONE"} {
								LIB_ROTARY_absolute_reset
							} else {
								LIB_ROTARY_simultaneous_reset
							}
						} @RESET_ROTARY
						LIB_GE_command_buffer_output
					} else {
						#!!! if next op has different mom_out_angle_pos reset as well
						# (maybe compare current and next angle from Pretreatment)
						LIB_GE_command_buffer TOOL_OR_MCS_CHANGE,MILL,POS
						LIB_GE_command_buffer {
							if {[CONF_CTRL_setting plane_output_supported] == "NONE" || $::lib_sav_kin_machine_type == "3_axis_mill" || $lib_flag(tool_axis_zm) == 1} {
								LIB_ROTARY_absolute_reset
							} else {
								LIB_ROTARY_positioning_reset
							}
						} @RESET_ROTARY
						LIB_GE_command_buffer_output
					}
				}
			}
		}

		# <17013.16 Interop path> Inter-operation doesn't need postprocessor defined return NC codes.
		if {[info exists mom_operation_is_interop] && $mom_operation_is_interop == 0} {
			return
		}
		LIB_GE_command_buffer TOOL_OR_MCS_CHANGE,COMMON

		if {$::mom_oper_tool != "NONE" || ([info exist lib_prev_tool_name] && $lib_prev_tool_name != $mom_next_tool_name) } {
		LIB_GE_command_buffer {LIB_local_origin_reset} @LOCAL_ORIG_RESET
		LIB_GE_command_buffer {
			if {$mom_next_oper_has_tool_change == "YES" || $mom_current_oper_is_last_oper_in_program == "YES"} {
				LIB_WRITE_coolant off
			}
		} @COOLANT_OFF
		LIB_GE_command_buffer {
			if {$mom_next_oper_has_tool_change == "YES" || $mom_current_oper_is_last_oper_in_program == "YES"} {
				LIB_SPINDLE_end
			}
		} @SPINDLE_OFF
		LIB_GE_command_buffer {
			if {$mom_current_oper_is_last_oper_in_program == "YES"} {
				if {[CONF_CTRL_moves return_end_of_pgm] != ""} {
					LIB_RETURN_move CONF_CTRL_moves return_end_of_pgm
				}
			} else {
				if {[CONF_CTRL_moves return_tool_change_pos] != ""} {
					LIB_RETURN_move CONF_CTRL_moves return_tool_change_pos
				}
			}
		} @RETURN_MOVE
		}
		LIB_GE_command_buffer_output

		set lib_flag(tool_path_motion) 0

	} else {

		switch -- $mom_machine_mode {
			"TURN" {

				set nxt_flip_a_axis [LIB_SPF_get_pretreatment mom_flip_a_axis 1]
				set nxt_tool_holder_angle_for_cutting [LIB_SPF_get_pretreatment mom_tool_holder_angle_for_cutting 1]
				# PR9295960: Check existence of mom_flip_a_axis and mom_tool_holder_angle_for_cutting in current operation
				if {$nxt_flip_a_axis == "" && [info exists mom_flip_a_axis]} {
					set nxt_flip_a_axis $mom_flip_a_axis
				}
				if {$nxt_tool_holder_angle_for_cutting == "" && [info exists mom_tool_holder_angle_for_cutting]} {
					set nxt_tool_holder_angle_for_cutting $mom_tool_holder_angle_for_cutting
				}

				if {![info exists mom_tool_holder_angle_for_cutting] || ![EQ_is_equal $nxt_tool_holder_angle_for_cutting $mom_tool_holder_angle_for_cutting]} {

					LIB_GE_command_buffer TURN_HOLDER_ORIENT_CHANGE

					# check if B axis position change
					set lib_flag(tool_path_motion) 0
					LIB_GE_command_buffer {LIB_SPINDLE_end} @SPINDLE_STOP
					LIB_GE_command_buffer {
						if {[CONF_CTRL_moves return_safety_pos] != ""} {
							LIB_RETURN_move CONF_CTRL_moves return_safety_pos
						}
					} @RETURN_MOVE
					LIB_GE_command_buffer {MOM_do_template spindle_init CREATE} @SPINDLE_INIT

					LIB_GE_command_buffer_output

				} elseif {[info exists mom_flip_a_axis] && $nxt_flip_a_axis != $mom_flip_a_axis} {

					LIB_GE_command_buffer TURN_TOOL_FLIP_CHANGE
					# check if spindle direction change
					set lib_flag(tool_path_motion) 0
					LIB_GE_command_buffer {LIB_SPINDLE_end} @SPINDLE_STOP
					LIB_GE_command_buffer {MOM_do_template spindle_init CREATE} @SPINDLE_INIT

					LIB_GE_command_buffer_output
				}

			}
			"MILL" {
				if {$lib_flag(first_transmit_move) == 1 && ([CONF_CTRL_moves polar_off_end_of_path] == "OFF" || ![VEC3_is_equal mom_tool_axis nxt_oper_tool_axis] || $::mom_sys_tool_path_type($next_operation_name) == "SIMULTANEOUS") ||\
					 ($mom_output_mcs_name($mom_operation_name) != $mom_output_mcs_name($next_operation_name)) || ([CONF_CTRL_moves polar_transmit] == ON  && [string match "*point*" [LIB_SPF_ask_operation_type $next_operation_name]])} {
					LIB_CTRL_polar_transmit "off"
				}

				LIB_GE_command_buffer MILL_AXIS_CHANGE

				# If the variable does not exist in the query, an blank is returned

				LIB_GE_command_buffer {
					if {$::mom_sys_enable_nc_optimizer != "ON"} {
						if {[LIB_SPF_pt_exists_not_empty "out_angle_pos_last,0" 0]} {
							set out_angle_pos(0) [LIB_SPF_get_pretreatment "out_angle_pos_last,0" 0]
							set out_angle_pos(1) [LIB_SPF_get_pretreatment "out_angle_pos_last,1" 0]
						} else {
							#This is only the case if current operation has no toolpath (e.g. MILL_CONTROL Operation)
							set out_angle_pos(0) $mom_out_angle_pos(0)
							set out_angle_pos(1) $mom_out_angle_pos(1)
						}

						if {[LIB_SPF_pt_exists_not_empty "mom_out_angle_pos,0" 1]} {
							set nxt_out_angle_pos(0) [LIB_SPF_get_pretreatment "mom_out_angle_pos,0" 1]
							set nxt_out_angle_pos(1) [LIB_SPF_get_pretreatment "mom_out_angle_pos,1" 1]
						} else {
							#This is only the case if current operation has no toolpath (e.g. MILL_CONTROL Operation)
							set nxt_out_angle_pos(0) $out_angle_pos(0)
							set nxt_out_angle_pos(1) $out_angle_pos(1)
						}
						
						# PR12034428: Force Rotary Reset if customized reset_rotary_axis_end_of_path return 1
						if {[CONF_CTRL_moves reset_rotary_axis_end_of_path] != "ON" && \
								[CONF_CTRL_moves reset_rotary_axis_end_of_path] != "OFF" && [LIB_CONF_do_prop_custom_proc CONF_CTRL_moves reset_rotary_axis_end_of_path] == 1} {
							set rotary_changed 1
						} else {
							# PR#10820392 if rotary axis make a smaller move than the minimum value we can ignore this and dont output safety retract
							set rotary_changed [LIB_SPF_ignore_small_retract $out_angle_pos(0) $out_angle_pos(1) $nxt_out_angle_pos(0) $nxt_out_angle_pos(1)]
						}
					} else {
						# PR12034428: Force Rotary Reset if customized reset_rotary_axis_end_of_path return 1
						if {[CONF_CTRL_moves reset_rotary_axis_end_of_path] == "ON" || \
								([CONF_CTRL_moves reset_rotary_axis_end_of_path] != "OFF" && [LIB_CONF_do_prop_custom_proc CONF_CTRL_moves reset_rotary_axis_end_of_path] == 1) || \
								![VEC3_is_equal mom_tool_axis nxt_oper_tool_axis]} {
							set rotary_changed 1
						} else {
							set rotary_changed 0
						}
					}

					# PR#9554274 incase operation's current status is not same as axis mode. It happened if there is only rapid motions in operation like GMC operation.
					if {([info exists ::mom_sys_tool_path_type($mom_operation_name)] && $::mom_sys_tool_path_type($mom_operation_name) != $::mom_sys_tool_path_type($next_operation_name) && ($::mom_sys_tool_path_type($mom_operation_name) == "SIMULTANEOUS" || $::mom_sys_tool_path_type($next_operation_name) == "SIMULTANEOUS") )||\
					    $rotary_changed == 1 || ($lib_flag(mode_current_status) == "sim" &&  $::mom_sys_tool_path_type($mom_operation_name) == "POSITIONING")} {
						if {$mom_machine_mode == "MILL" && $lib_flag(tool_path_motion) > 0} {
							if {$::mom_sys_tool_path_type($mom_operation_name) == "SIMULTANEOUS" || $lib_flag(mode_current_status) == "sim"} {
								if {[CONF_CTRL_setting tcpm_output_supported] == "NONE"} {
									LIB_ROTARY_absolute_reset
								} else {
									LIB_ROTARY_simultaneous_reset
								}
							} else {
								#!!! if next op has different mom_out_angle_pos reset as well
								# (maybe compare current and next angle from Pretreatment)

								if {[CONF_CTRL_setting plane_output_supported] == "NONE" || $lib_flag(tool_axis_zm) == 1} {
									LIB_ROTARY_absolute_reset
								} else {
									LIB_ROTARY_positioning_reset
								}

								#PR10101257: Reset rotary axis angles to avoid affecting csys rotation matrix of next operation within positioning
								if {[CONF_CTRL_moves reset_rotary_axis_end_of_path] == "ON"} {
									LIB_SPF_reset_motions_to_zero "rot"
								} elseif {[CONF_CTRL_moves reset_rotary_axis_end_of_path] != "OFF" && [LIB_CONF_do_prop_custom_proc CONF_CTRL_moves reset_rotary_axis_end_of_path] == 1} {
									LIB_SPF_reset_motions_to_zero "rot"
								}
							}
							set lib_flag(tool_path_motion) 0
						 	if {[CONF_CTRL_moves return_safety_pos] != ""} {LIB_RETURN_move CONF_CTRL_moves return_safety_pos}
						}
					}
				} @RESET

				LIB_GE_command_buffer_output

			}
		}

	}

	# unset Variables if needed
	LIB_GE_command_buffer LIB_unset_variables_in_end_of_path
	LIB_GE_command_buffer {if {$commandcheck(LIB_unset_variables_in_end_of_path)} {LIB_unset_variables_in_end_of_path}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_end_of_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_path_LIB_ENTRY)} {MOM_end_of_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
#  Unset Variables in End_of_path
#  (link to the controller)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_unset_variables_in_end_of_path {} {


	if {[info exists ::lib_spf(do_convert_point)]} 		{unset ::lib_spf(do_convert_point)}

	set ::lib_parameter(special_cycle,name) ""

	# unset variables for hole and thread milling (this should be done in the core processor
	unset -nocomplain ::mom_vertical_pitch_value_source
	unset -nocomplain ::mom_circle_diameter_source
	unset -nocomplain ::mom_stepover_distance_source
	unset -nocomplain ::mom_axial_stepover_distance_source
	unset -nocomplain ::mom_cycle_definition_mode
	
	unset -nocomplain ::lib_last_rapid_pos
	
	if {$::mom_next_oper_has_tool_change == "YES" || $::mom_current_oper_is_last_oper_in_program == "YES"} {
		if {[info exists ::mom_tool_pitch]} {unset ::mom_tool_pitch}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_end_of_program_LIB {} {


	set commandcheck(MOM_end_of_program_LIB_ENTRY) [llength [info commands MOM_end_of_program_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_end_of_program_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_program_LIB_ENTRY)} {MOM_end_of_program_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_GE_command_buffer TOOL_CHANGE_EOP
	LIB_GE_command_buffer {
		MOM_force once T M
		switch -- [join [CONF_CTRL_tool tool_change_eop]] {
			"off" {
				# nothing
			}
			"first_tool" {
				set ::mom_tool_name $::mom_next_tool_name
				set ::mom_tool_number $::mom_next_tool_number
				LIB_CONF_do_prop_custom_proc CONF_CTRL_tool auto_change_template "short_template_syntax"
			}
			"unload_tool" {
				set ::mom_tool_number 0
				LIB_CONF_do_prop_custom_proc CONF_CTRL_tool auto_change_template "short_template_syntax"
			}
			"default" {
				if {[string is integer -strict [CONF_CTRL_tool tool_change_eop]]} {
					set ::mom_tool_number [CONF_CTRL_tool tool_change_eop]
					LIB_CONF_do_prop_custom_proc CONF_CTRL_tool auto_change_template "short_template_syntax"
				}
			}
		}
	} @TOOL_CHANGE_END_OF_PROGRAM
	LIB_GE_command_buffer_output
	LIB_GE_command_buffer END_OF_PROGRAM
	LIB_GE_command_buffer {MOM_do_template end_of_program} @END_OF_PROG
	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_end_of_program_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_program_LIB_ENTRY)} {MOM_end_of_program_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
#  Switch off absolute rotary mode
#  (link to the controller)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_ROTARY_absolute_reset {} {

	global lib_flag

	set commandcheck(LIB_ROTARY_absolute_reset_ENTRY) [llength [info commands LIB_ROTARY_absolute_reset_ENTRY]]

	LIB_GE_command_buffer LIB_ROTARY_absolute_reset_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_absolute_reset_ENTRY)} {LIB_ROTARY_absolute_reset_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$lib_flag(mode_current_status) != "std"} {
		if {[CONF_CTRL_setting tcpm_output] == "vector"} {
		 	MOM_enable_address fourth_axis fifth_axis
		 	MOM_force once fourth_axis fifth_axis
		 	MOM_disable_address X_vector Y_vector Z_vector
		}
		set lib_flag(mode_current_status) "std"
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_ROTARY_absolute_reset_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_absolute_reset_ENTRY)} {LIB_ROTARY_absolute_reset_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
#  Switch off simultaneous rotary mode
#  (link to the controller)
#
# <Internal Example>
#
#	Siemens: TRAFOOF
#	Heidenhain: M129 / TCPM
#	Fanuc: G49
#____________________________________________________________________________________________
proc LIB_ROTARY_simultaneous_reset {} {


	global lib_flag

	set commandcheck(LIB_ROTARY_simultaneous_reset_ENTRY) [llength [info commands LIB_ROTARY_simultaneous_reset_ENTRY]]

	LIB_GE_command_buffer LIB_ROTARY_simultaneous_reset_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_simultaneous_reset_ENTRY)} {LIB_ROTARY_simultaneous_reset_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$lib_flag(mode_current_status) != "std"} {
		if {[CONF_CTRL_setting tcpm_output] == "angle"} {
			LIB_GE_command_buffer SIMULTANEOUS_RESET_G434
			LIB_GE_command_buffer {
				MOM_do_template set_tcpm_off
			} @TCPM_OFF
			LIB_GE_command_buffer {
				MOM_do_template tool_length_adjust_off CREATE
			} @ADJUST_OFF
			LIB_GE_command_buffer_output
		} elseif {[CONF_CTRL_setting tcpm_output] == "vector"} {
			LIB_GE_command_buffer SIMULTANEOUS_RESET_G435
			LIB_GE_command_buffer {
				MOM_do_template set_tcpm_off
			} @TCPM_OFF
			LIB_GE_command_buffer {
				MOM_do_template tool_length_adjust_off CREATE
			} @ADJUST_OFF
			LIB_GE_command_buffer_output
		 	MOM_enable_address fourth_axis fifth_axis
		 	MOM_force once fourth_axis fifth_axis
		 	MOM_disable_address X_vector Y_vector Z_vector
		}
		# <NX1201 cam16012> new prereatment local csys
		if {$lib_flag(local_namespace_output)} {
			LIB_SPF_set_output_pos
		}
		set lib_flag(mode_current_status) "std"
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_ROTARY_simultaneous_reset_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_simultaneous_reset_ENTRY)} {LIB_ROTARY_simultaneous_reset_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Switch off positioning rotary mode
#  (link to the controller)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_ROTARY_positioning_reset {} {


	global lib_flag

	set commandcheck(LIB_ROTARY_positioning_reset_ENTRY) [llength [info commands LIB_ROTARY_positioning_reset_ENTRY]]

	LIB_GE_command_buffer LIB_ROTARY_positioning_reset_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_positioning_reset_ENTRY)} {LIB_ROTARY_positioning_reset_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {$lib_flag(mode_current_status) != "std"} {
		LIB_CSYS_plane_output_reset
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_ROTARY_positioning_reset_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_positioning_reset_ENTRY)} {LIB_ROTARY_positioning_reset_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Switch on simultaneous rotary mode
#  (link to the controller)
#
# <Internal Example>
#
#	Siemens: TRAORI
#	Heidenhain: M128 / TCPM
#	Fanuc: G43.4
#____________________________________________________________________________________________
proc LIB_ROTARY_simultaneous_init {} {


	global mom_kin_is_turbo_output mom_post_in_simulation
	global tcpm_type lib_flag

	set commandcheck(LIB_ROTARY_simultaneous_init_ENTRY) [llength [info commands LIB_ROTARY_simultaneous_init_ENTRY]]

	LIB_GE_command_buffer LIB_ROTARY_simultaneous_init_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_simultaneous_init_ENTRY)} {LIB_ROTARY_simultaneous_init_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_CTRL_setting turbo_mode] == 1 && [CONF_CTRL_setting tcpm_output] == "angle" && $mom_post_in_simulation == 0 && $lib_flag(feed_turbo_mode_disable) == 0} {
		# mom_tool_axis variable can not be used with turbo mode
		set mom_kin_is_turbo_output [LIB_SPF_get_pretreatment mom_kin_is_turbo_output]
		if {[CONF_SPF_msg output_event_message]} {LIB_SPF_output_event_message "Turbomode enable"}
		MOM_reload_kinematics_variable mom_kin_is_turbo_output
	}

	LIB_CTRL_unclamp_axis

	if {[CONF_CTRL_setting tcpm_output_supported] == "NONE"} {return}
	if {$lib_flag(mode_current_status) != "sim"} {
		if {[CONF_CTRL_setting tcpm_output] != "angle" && [CONF_CTRL_setting tcpm_output] != "vector"} {
			LIB_SPF_add_warning "The entry 'INS->[CONF_CTRL_setting tcpm_output]<-' for tcpm_output is not allowed, angles will be used"
			CONF_CTRL_setting set tcpm_output "angle"
		}
		if {[CONF_CTRL_setting tcpm_output] == "angle"} {
			set tcpm_type 1
		 	MOM_enable_address fourth_axis fifth_axis
			MOM_force once fourth_axis fifth_axis
		 	MOM_disable_address X_vector Y_vector Z_vector
		} elseif {[CONF_CTRL_setting tcpm_output] == "vector"} {
			set tcpm_type 2
		 	MOM_enable_address X_vector Y_vector Z_vector
			MOM_force once  X_vector Y_vector Z_vector
		 	MOM_disable_address fourth_axis fifth_axis
		}

		LIB_GE_command_buffer MILL,SIMULTANEOUS

		LIB_GE_command_buffer {
			MOM_do_template tool_length_adjust CREATE
			MOM_force once H
		} @TOOL_LENGTH_ADJUST
		LIB_GE_command_buffer {
			MOM_set_address_format G_csys_rot Zero_real
			MOM_do_template set_tcpm_on
			MOM_set_address_format G_csys_rot Digit_2
		} @ROTARY_SIMULTANEOUS

		LIB_GE_command_buffer_output
		# <NX1201 cam16012> new prereatment local csys
		if {$lib_flag(local_namespace_output)} {
			if {([CONF_CTRL_setting tcpm_output] == "vector" || ([CONF_CTRL_setting tcpm_output] == "angle" && [CONF_CTRL_setting fix_on_machine] != 0))} {
				LIB_SPF_set_output_pos "::" "mom_mcs_goto"
			} else {
				LIB_SPF_set_output_pos "::" "mom_pos"
			}
		}

		set lib_flag(mode_current_status) "sim"
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_ROTARY_simultaneous_init_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_simultaneous_init_ENTRY)} {LIB_ROTARY_simultaneous_init_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Switch on absolute rotary mode
#  (link to the controller)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_ROTARY_absolute_init {} {

	global mom_kin_is_turbo_output mom_post_in_simulation
	global tcpm_type lib_flag

	set commandcheck(LIB_ROTARY_absolute_init_ENTRY) [llength [info commands LIB_ROTARY_absolute_init_ENTRY]]

	LIB_GE_command_buffer LIB_ROTARY_absolute_init_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_absolute_init_ENTRY)} {LIB_ROTARY_absolute_init_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_CTRL_setting turbo_mode] == 1 && [CONF_CTRL_setting tcpm_output] == "angle" && $mom_post_in_simulation == 0 && $lib_flag(feed_turbo_mode_disable) == 0} {
		# mom_tool_axis variable can not be used with turbo mode
		set mom_kin_is_turbo_output [LIB_SPF_get_pretreatment mom_kin_is_turbo_output]
		if {[CONF_SPF_msg output_event_message]} {LIB_SPF_output_event_message "Turbomode enable"}
		MOM_reload_kinematics_variable mom_kin_is_turbo_output
	}

	if {$::lib_machine_mode == "3_AXIS_MILL_TURN"} {
		MOM_disable_address X_vector Y_vector Z_vector
	} else {
		MOM_enable_address fourth_axis fifth_axis
		MOM_force once fourth_axis fifth_axis
		MOM_disable_address X_vector Y_vector Z_vector
	}

	LIB_GE_command_buffer POLAR_TRANSMIT
	LIB_GE_command_buffer {LIB_CTRL_polar_transmit "start"} @OUTPUT
	LIB_GE_command_buffer_output


	LIB_GE_command_buffer TOOL_ADJUST
	LIB_GE_command_buffer {
		MOM_do_template tool_length_adjust CREATE
		MOM_force once G_adjust H
	} @OUTPUT
	LIB_GE_command_buffer_output

	set lib_flag(mode_current_status) "std"

	LIB_GE_command_buffer UNCLAMP
	LIB_GE_command_buffer {LIB_CTRL_unclamp_axis} @UNCLAMP
	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_ROTARY_absolute_init_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_absolute_init_ENTRY)} {LIB_ROTARY_absolute_init_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Switch on positioning rotary mode
#  (link to the controller)
#
# <Internal Example>
#
#	Siemens: AROT / CYCLE800
#	Heidenhain: CYCL DEF 19 or PLANE SPATIAL
#	Fanuc: G68 / G68.1 / G68.2
#____________________________________________________________________________________________
proc LIB_ROTARY_positioning_init {} {


	global mom_kin_is_turbo_output mom_post_in_simulation
	global lib_flag
	global mom_kin_machine_type mom_sys_leader
	global mom_init_pos mom_init_alt_pos mom_pos mom_alt_pos mom_out_angle_pos mom_prev_out_angle_pos
	global mom_kin_4th_axis_direction mom_kin_4th_axis_leader mom_kin_4th_axis_min_limit mom_kin_4th_axis_max_limit
	global mom_kin_5th_axis_direction mom_kin_5th_axis_leader mom_kin_5th_axis_min_limit mom_kin_5th_axis_max_limit
	if {[CONF_CTRL_setting plane_output_supported] == "NONE" || $lib_flag(tool_axis_zm) == 1} {return}

	set commandcheck(LIB_ROTARY_positioning_init_ENTRY) [llength [info commands LIB_ROTARY_positioning_init_ENTRY]]

	LIB_GE_command_buffer LIB_ROTARY_positioning_init_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_positioning_init_ENTRY)} {LIB_ROTARY_positioning_init_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_CTRL_setting turbo_mode] == 1 && $mom_post_in_simulation == 0 && $lib_flag(feed_turbo_mode_disable) == 0} {
		set mom_kin_is_turbo_output [LIB_SPF_get_pretreatment mom_kin_is_turbo_output]
		if {[CONF_SPF_msg output_event_message]} {LIB_SPF_output_event_message "Turbomode enable"}
		MOM_reload_kinematics_variable mom_kin_is_turbo_output
	}

	MOM_disable_address X_vector Y_vector Z_vector

	if {$lib_flag(mode_current_status) != "pos"} {
		LIB_CTRL_set_3P2_rotate_dir
		LIB_CSYS_plane_output_init
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_ROTARY_positioning_init_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_ROTARY_positioning_init_ENTRY)} {LIB_ROTARY_positioning_init_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Switch on shortest distance for simultaneous rotary mode
#  (link to the controller)
#
# <Internal Example>
#
#	Siemens: Leader "C=DC("  Trailer ")"
#	Heidenhain: M126
#____________________________________________________________________________________________
proc LIB_CTRL_KINEMATICS_set_simultanous_kin {} {


	global mom_kin_arc_output_mode mom_kin_helical_arc_output_mode
	global mom_sys_leader lib_sav_kin_4th_axis_leader lib_sav_kin_5th_axis_leader
	global lib_sav_kin_machine_type mom_kin_4th_axis_point lib_flag
	set commandcheck(LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY) [llength [info commands LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY)} {LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_SPF_sim_kin 4th_axis_has_limit] == ""} {CONF_SPF_sim_kin set 4th_axis_has_limit $::mom_sys_4th_axis_has_limits}
	if {[CONF_SPF_sim_kin 5th_axis_has_limit] == ""} {CONF_SPF_sim_kin set 5th_axis_has_limit $::mom_sys_5th_axis_has_limits}
	if {![CONF_SPF_sim_kin 4th_axis_has_limit] || ![CONF_SPF_sim_kin 5th_axis_has_limit]} {
#			set optimized rotary axis on
	}

	# Move it from LIB_SPF_KINEMATICS_set_simultanous_kin_ENTRY(OEM).
	if {($lib_flag(local_namespace_output) == 0 || [CONF_CTRL_setting fix_on_machine] == 0) && [CONF_CTRL_setting tcpm_output] == "angle"} {
        if {[string match "5_axis*" $lib_sav_kin_machine_type] && $lib_sav_kin_machine_type != "5_axis_dual_head"} {
			if {[CONF_SPF_sim_kin 4th_axis] == "real" && [CONF_SPF_sim_kin 5th_axis] == "real"} {
				set mom_sys_leader(fourth_axis) $lib_sav_kin_4th_axis_leader
				set mom_sys_leader(fifth_axis) $lib_sav_kin_5th_axis_leader
			}
			set sav_kin_arc_output_mode $mom_kin_arc_output_mode
			set sav_kin_helical_arc_output_mode $mom_kin_helical_arc_output_mode
			LIB_GE_copy_var_range mom_kin lib_sav_kin
			set mom_kin_arc_output_mode $sav_kin_arc_output_mode
			set mom_kin_helical_arc_output_mode $sav_kin_helical_arc_output_mode

			LIB_SPF_calc_4th5th_axis_points
			if {$lib_sav_kin_machine_type == "5_axis_head_table"} {
				global mom_kin_4th_axis_point
				global mom_kin_pivot_gauge_offset
				array set mom_kin_4th_axis_point "0 0 1 0 2 0"
				set mom_kin_pivot_gauge_offset 0
				MOM_reload_kinematics
			}
        } elseif { $lib_sav_kin_machine_type == "4_axis_table"} {
			if {[CONF_SPF_sim_kin 4th_axis] == "real"} {
				set mom_sys_leader(fourth_axis) $lib_sav_kin_4th_axis_leader
			}
			LIB_GE_copy_var_range mom_kin lib_sav_kin
			LIB_SPF_calc_4th5th_axis_points
        }
    }

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY)} {LIB_CTRL_KINEMATICS_set_simultanous_kin_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Documentation>
# This procedure writes the NC code for return motions to the output file. Settings for home motions [CONF_CTRL_moves return_mode]
# are taken into consideration for the output format of the return motions.
#
# <Arguments>
# Addresses
#	String with space to separate axis names that perform a return move.
#	Valid options:
#	X / Y / Z / XY / ZX / ZY or a template name
# property
#	Reserved argument.
#
# <Returnvalue>
# None.
#
# <Example>
# name: Example using axis names
# code: LIB_RETURN_move "Z XY"
# desc: Writes return moves for Z and then XY to the output file in Fanuc format.
#      Result is:
#      G0 G28 G91 Z0.
#      G0 G28 G91 X0. Y0.
# <Example>
# name: Example using template names
# code: LIB_RETURN_move "custom_return_template1 custom_return_template2"
# desc: Assuming we have two custom specific block templates custom_return_template1 and custom_return_template2,
#	you can call them in this command by their name. It's okay to mix template names and axes names (see example 1).
#____________________________________________________________________________________________
proc LIB_RETURN_move {Addresses {property ""}} {


	global mom_sys_home_pos mom_prev_pos mom_prev_out_angle_pos
	global tool_axis lib_flag mom_operation_type mom_operation_is_interop

	set commandcheck(LIB_RETURN_move_ENTRY) [llength [info commands LIB_RETURN_move_ENTRY]]

	LIB_GE_command_buffer LIB_RETURN_move_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_RETURN_move_ENTRY)} {LIB_RETURN_move_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[string match $mom_operation_type "Device Generic Motion"] ||
		([info exists mom_operation_is_interop] && $mom_operation_is_interop == 0)} {     
	    return
	}

	if {$property != ""} {
		set object $Addresses
		set Addresses [$Addresses $property]
	} else {
		set object ""
	}

	set line_nbr -1
	set break_it 0

        foreach axes $Addresses {
        	incr line_nbr

		if {[catch {foreach axis $axes {}}]} {
			set axes [list $axes]
		}

 	 	foreach axis $axes {
	        	MOM_force once G_return
	 	 	switch -- $axis {
				"Z" {
				        #WRITE_coolant off
				        if {[CONF_CTRL_moves return_mode] == "value"} {
				        	if {[hiset tool_axis] && $tool_axis == 2} {MOM_do_template tool_length_adjust_off}
			                        MOM_force once Z
						MOM_suppress once X Y
						LIB_GE_command_buffer AXIS_MOVE_Z
						LIB_GE_command_buffer {MOM_do_template return_move} @RETURN_MOVE_Z
						LIB_GE_command_buffer_output
					} else {
						LIB_GE_command_buffer AXIS_HOME_Z
						LIB_GE_command_buffer {MOM_do_template return_home_Z} @RETURN_HOME_Z
						LIB_GE_command_buffer_output
					}
					set mom_prev_pos(2) $mom_sys_home_pos(2)
				        MOM_force once Z
				}
				"Y" {
				        if {[CONF_CTRL_moves return_mode] == "value"} {
						if {[hiset tool_axis] && $tool_axis == 1} {MOM_do_template tool_length_adjust_off}
						MOM_force once Y
						MOM_suppress once X Z
						LIB_GE_command_buffer AXIS_MOVE_Y
						LIB_GE_command_buffer {MOM_do_template return_move} @RETURN_MOVE_Y
						LIB_GE_command_buffer_output
					} else {
						LIB_GE_command_buffer AXIS_HOME_Y
						LIB_GE_command_buffer {MOM_do_template return_home_Y} @RETURN_HOME_Y
						LIB_GE_command_buffer_output
					}
					set mom_prev_pos(1) $mom_sys_home_pos(1)
					MOM_force once Y
				}
				"X" {
				        if {[CONF_CTRL_moves return_mode] == "value"} {
						if {[hiset tool_axis] && $tool_axis == 0} {MOM_do_template tool_length_adjust_off}
						MOM_force once X
						MOM_suppress once Y Z
						LIB_GE_command_buffer AXIS_MOVE_X
						LIB_GE_command_buffer {MOM_do_template return_move} @RETURN_MOVE_X
						LIB_GE_command_buffer_output
					} else {
						LIB_GE_command_buffer AXIS_HOME_X
						LIB_GE_command_buffer {MOM_do_template return_home_X} @RETURN_HOME_X
						LIB_GE_command_buffer_output
					}
					set mom_prev_pos(0) $mom_sys_home_pos(0)
					MOM_force once X
				}
				"YX" -
				"XY" {
				        if {[CONF_CTRL_moves return_mode] == "value"} {
						if {[hiset tool_axis] && $tool_axis == 0 || [hiset tool_axis] && $tool_axis == 1} {MOM_do_template tool_length_adjust_off}
						MOM_force once X Y
						MOM_suppress once Z
						LIB_GE_command_buffer AXIS_MOVE_XY
						LIB_GE_command_buffer {MOM_do_template return_move} @RETURN_MOVE_XY
						LIB_GE_command_buffer_output
					} else {
						LIB_GE_command_buffer AXIS_HOME_XY
						LIB_GE_command_buffer {MOM_do_template return_home_XY} @RETURN_HOME_XY
						LIB_GE_command_buffer_output
					}
					set mom_prev_pos(0) $mom_sys_home_pos(0)
					set mom_prev_pos(1) $mom_sys_home_pos(1)
					MOM_force once X Y
				}
				"XZ" -
				"ZX" {
				        if {[CONF_CTRL_moves return_mode] == "value"} {
						if {[hiset tool_axis] && $tool_axis == 0 || [hiset tool_axis] && $tool_axis == 2} {MOM_do_template tool_length_adjust_off}
						MOM_force once X Z
						MOM_suppress once Y
						LIB_GE_command_buffer AXIS_MOVE_ZX
						LIB_GE_command_buffer {MOM_do_template return_move} @RETURN_MOVE_ZX
						LIB_GE_command_buffer_output
					} else {
						LIB_GE_command_buffer AXIS_HOME_ZX
						LIB_GE_command_buffer {MOM_do_template return_home_ZX} @RETURN_HOME_ZX
						LIB_GE_command_buffer_output
					}
					set mom_prev_pos(2) $mom_sys_home_pos(2)
					set mom_prev_pos(0) $mom_sys_home_pos(0)
					MOM_force once Z X
				}
				"YZ" -
				"ZY" {
				        if {[CONF_CTRL_moves return_mode] == "value"} {
						if {[hiset tool_axis] && $tool_axis == 1 || [hiset tool_axis] && $tool_axis == 2} {MOM_do_template tool_length_adjust_off}
						MOM_force once Y Z
						MOM_suppress once X
						LIB_GE_command_buffer AXIS_MOVE_ZY
						LIB_GE_command_buffer {MOM_do_template return_move} @RETURN_MOVE_ZY
						LIB_GE_command_buffer_output
					} else {
						LIB_GE_command_buffer AXIS_HOME_ZY
						LIB_GE_command_buffer {MOM_do_template return_home_ZY} @RETURN_HOME_ZY
						LIB_GE_command_buffer_output
					}
					set mom_prev_pos(1) $mom_sys_home_pos(1)
					set mom_prev_pos(2) $mom_sys_home_pos(2)
					MOM_force once Y Z
				}
				"4th" {
					
					if {$lib_flag(local_namespace_output) == 0 && [EQ_is_zero [MOM_ask_address_value fourth_axis]]} {
						# Is 4th axis on real machine really on 0 ?
						# Case for a local origin whit differnt orientation than Main (FixtureOffset or CsysRotation)
						LIB_SPF_convert_point real
							catch {MOM_set_address_with_value fourth_axis [expr $::mom_out_angle_pos(0) + $::mom_init_pos(3)]}
						LIB_SPF_convert_point reload
					}
					
					if {![EQ_is_zero [MOM_ask_address_value fourth_axis]]} {
						MOM_force once fourth_axis
						LIB_GE_command_buffer AXIS_HOME_4TH
						LIB_GE_command_buffer {MOM_do_template return_home_4th} @RETURN_HOME_4TH
						LIB_GE_command_buffer_output
						set mom_prev_out_angle_pos(0) 0.0
						MOM_force once fourth_axis
					}
				}
				"5th" {
					
					if {$lib_flag(local_namespace_output) == 0 && [EQ_is_zero [MOM_ask_address_value fifth_axis]]} {
						# Is 5th axis on real machine really on 0 ?
						# Case for a local origin whit differnt orientation than Main (FixtureOffset or CsysRotation)
						LIB_SPF_convert_point real
							catch {MOM_set_address_with_value fifth_axis [expr $::mom_out_angle_pos(1)+ $::mom_init_pos(4)]}
						LIB_SPF_convert_point reload
					}
					
					if {![EQ_is_zero [MOM_ask_address_value fifth_axis]]} {
						MOM_force once fifth_axis
						LIB_GE_command_buffer AXIS_HOME_5TH
						LIB_GE_command_buffer {MOM_do_template return_home_5th} @RETURN_HOME_5TH
						LIB_GE_command_buffer_output
						set mom_prev_out_angle_pos(1) 0.0
						MOM_force once fifth_axis
					}
				}
				"4th5th" {
					
					if {$lib_flag(local_namespace_output) == 0 && [EQ_is_zero [MOM_ask_address_value fourth_axis]] && [EQ_is_zero [MOM_ask_address_value fifth_axis]]} {
						# Are 4th and 5th axis on real machine really on 0 ?
						# Case for a local origin whit differnt orientation than Main (FixtureOffset or CsysRotation)
						LIB_SPF_convert_point real
							catch {MOM_set_address_with_value fourth_axis [expr $::mom_out_angle_pos(0) + $::mom_init_pos(3)]}
							catch {MOM_set_address_with_value fifth_axis [expr $::mom_out_angle_pos(1)+ $::mom_init_pos(4)]}
						LIB_SPF_convert_point reload
					}
					
					if {![EQ_is_zero [MOM_ask_address_value fourth_axis]] || ![EQ_is_zero [MOM_ask_address_value fifth_axis]]} {
						MOM_force once fourth_axis fifth_axis
						LIB_GE_command_buffer AXIS_HOME_45TH
						LIB_GE_command_buffer {MOM_do_template return_home_4th5th} @RETURN_HOME_45TH
						LIB_GE_command_buffer_output
						set mom_prev_out_angle_pos(0) 0.0
						set mom_prev_out_angle_pos(1) 0.0
						MOM_force once fourth_axis fifth_axis
					}
				}
				"" {
				        #Do Nothing
				}
				"default" {
					if {[LIB_SPF_exists_block_template $axes 1] == 1} {
						LIB_GE_command_buffer RETURN_MOVE_AXES
						LIB_GE_command_buffer {MOM_do_template $axes} @RETURN_MOVE_AXES_TAG
						LIB_GE_command_buffer_output
					} elseif {[LIB_SPF_exists_block_template $axes 1] == -1 && ![catch {set dummy [MOM_do_template $axes CREATE]}]} {
						# Thats the case when 'MOM_has_definition_element' command does not exist (older NX versions)
						#legacy
						LIB_GE_command_buffer RETURN_MOVE_LEGACY
						LIB_GE_command_buffer {MOM_output_literal $dummy} @RETURN_MOVE_LEGACY_TAG
						LIB_GE_command_buffer_output
					} else {
						if {$object == ""} {
							#when LIB_RETURN_move is not called with a conf_object as argument
							LIB_RETURN_move_LIB_ENTRY $axes
						} else {
							if {[info proc LIB_RETURN_move_LIB_ENTRY] == "LIB_RETURN_move_LIB_ENTRY"} {
								#legacy
								LIB_RETURN_move_LIB_ENTRY $axes
							} else {
								LIB_CONF_do_prop_custom_proc $object $property "no_special_syntax" $line_nbr
								set break_it 1
								break
							}
						}
					}
				}
			}
		}
		if {$break_it} {break}
	}
	set lib_flag(current_safety_position) 1

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_RETURN_move_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_RETURN_move_ENTRY)} {LIB_RETURN_move_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Documentation>
# This procedure writes the NC code for the fixture offset of the active coordinate system to the output file, when the property
# CONF_CTRL_origin use_main is set to On.
# <Arguments>
# offset_nbr
#	Reserved argument.
# create
#	Reserved argument.
# <Example>
# name: Output active origin
# code: LIB_main_origin_call
# desc: Outputs G54 when the fixture offset is set to 1.
#____________________________________________________________________________________________
proc LIB_main_origin_call {{offset_nbr ""} {create ""}} {


	global mom_fixture_offset_value mom_sys_leader
	global lib_main_zero_register lib_flag

	if {[CONF_CTRL_origin use_main] == 1} {
		if {$mom_fixture_offset_value <= 6} {
			set lib_main_zero_register [expr $mom_fixture_offset_value + 53]
			set mom_sys_leader(G_zero) "G"
		} elseif {$mom_fixture_offset_value <= 306} {
			#set leader_origin_def "G10L20P"
			set lib_main_zero_register [expr $mom_fixture_offset_value - 6]
			set mom_sys_leader(G_zero) "G54.1 P"
		} else {
			if {![hiset lib_flag(error_main_zero_register)]} {
				set error [LIB_SPF_add_warning "Fixture offset value should be < 306 : G54 is used"]
				set lib_flag(error_main_zero_register) 1
			}
			set lib_main_zero_register 1
		}
		LIB_GE_command_buffer MAIN_ZERO
		LIB_GE_command_buffer {MOM_do_template main_zero $create} @OUTPUT
		LIB_GE_command_buffer_output
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Output the local origin call
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_local_origin_call {} {


	global mom_origin mom_tool_axis mom_csys_matrix mom_sys_csys_rot_code
	global lib_flag
	global lib_coord_ref_X lib_coord_ref_Y lib_coord_ref_Z

	if {[LIB_SPF_csys_examine_local] == "default" && [EQ_is_equal $mom_tool_axis(2) 1.0]} {
		set mom_origin(0) 0.0
		set mom_origin(1) 0.0
		set mom_origin(2) 0.0
	}

	if {$lib_flag(local_namespace_output)} {
		LIB_SPF_local_csys_rotation [CONF_TEMPLATE_3P2 rot_direction][CONF_TEMPLATE_3P2 rot_order] [CONF_TEMPLATE_3P2 rot_mode] [CONF_TEMPLATE_3P2 rot_address]
	} else {
    		LIB_SPF_csys_3D_rotation [CONF_TEMPLATE_3P2 rot_direction][CONF_TEMPLATE_3P2 rot_order] [CONF_TEMPLATE_3P2 rot_mode] [CONF_TEMPLATE_3P2 rot_address]
	}
		
	set mom_origin(0) $lib_coord_ref_X
	set mom_origin(1) $lib_coord_ref_Y
	set mom_origin(2) $lib_coord_ref_Z
	
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Output the main origin reset
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_local_origin_reset {} {

	global lib_flag

	# not yet implemented
	# MOM_output_literal "TRANS"
	# set lib_flag(local_origin_activated) 0
	
}

#____________________________________________________________________________________________
# <Internal Documentation>
# output the plane
#
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CSYS_plane_output_init {} {


	global mom_sys_csys_rot_code
	global lib_flag lib_parameter lib_sav_kin_machine_type
	global lib_coord_ref_X lib_coord_ref_Y lib_coord_ref_Z lib_coord_ang_A lib_coord_ang_B lib_coord_ang_C
	global lib_coord_ang_1 lib_coord_ang_2 lib_coord_ang_3 lib_coord_ang_4
	# <NX1201 cam16012> new prereatment local csys
	# In new local csys mode, enter local namespace and switch output mode before plane init
	LIB_GE_command_buffer LOCAL_CSYS_INIT
	LIB_GE_command_buffer {if {$lib_flag(local_namespace_output)} {LIB_SPF_local_pos_set}} @LOCAL_POS_SET
	LIB_GE_command_buffer_output

	LIB_CTRL_unclamp_axis
	set lib_flag(tcpm_dir_with_std_path_btw_rot_motions) 1

	if {$lib_flag(local_namespace_output)} {
		LIB_rotate_axis_before_plane
	} else {
        if {[CONF_TEMPLATE_3P2 rotate_before] == "1"} {
            if {[CONF_SPF_setting prefer_solution_axis] != "Off"} {
                LIB_GE_abort_message "[LIB_GE_MSG "Rotate Axis before Plane Output"] does not work in case of \n -- [LIB_GE_MSG "Local Namespace Output"] is off \n -- [LIB_GE_MSG "Preferred Solution"] is on"
            }
            LIB_SPF_convert_point "real"
            LIB_rotate_axis_before_plane
            LIB_SPF_convert_point "reload"
        }
	}
	
	LIB_SPF_leader_rot_axes_plane_kin set
	
	# Output rotate angle to affect G53.1 choose solution
	if {([CONF_TEMPLATE_3P2 rotate_before] != "1" && [CONF_TEMPLATE_3P2 rotate_dir] != 0) || ([info exists ::lib_flag(preferred_solution)] && $::lib_flag(preferred_solution) != "OFF") } {
		LIB_CTRL_rotate_axis
	}
	if {[CONF_CTRL_origin use_local] == 1} {
		set lib_parameter(csys_rot,_X0) $lib_coord_ref_X; set lib_parameter(csys_rot,_Y0) $lib_coord_ref_Y; set lib_parameter(csys_rot,_Z0) $lib_coord_ref_Z
	} else {
		set lib_parameter(csys_rot,_X0) 0.0; set lib_parameter(csys_rot,_Y0) 0.0; set lib_parameter(csys_rot,_Z0) 0.
	}

	set ang_mode [CONF_TEMPLATE_3P2 rot_order]
	if {[string match "ZYX" $ang_mode] || [string match "YXZ" $ang_mode] ||
		[string match "YZX" $ang_mode] || [string match "XZY" $ang_mode] ||
		[string match "XYZ" $ang_mode] || [string match "ZXY" $ang_mode]} {
			
		for {set ii 0} {$ii < 3} {incr ii} {
			if {[string range $ang_mode $ii $ii] == "X"} {
				set [subst [subst lib_coord_ang_[expr $ii+1]]] $lib_coord_ang_A
			} elseif {[string range $ang_mode $ii $ii] == "Y"} {
				set [subst [subst lib_coord_ang_[expr $ii+1]]] $lib_coord_ang_B
			} else {
				set [subst [subst lib_coord_ang_[expr $ii+1]]] $lib_coord_ang_C
			}
		}
	}

	LIB_CTRL_reset_csys_3d_rot_order

	set lib_parameter(csys_rot,retract) 1
	MOM_disable_address fourth_axis fifth_axis
	MOM_force once X Y Z I_rot J_rot K_rot
	MOM_set_address_format G_csys_rot Zero_real
	LIB_GE_command_buffer CSYS2_ON
	LIB_GE_command_buffer {MOM_do_template set_csys_on} @OUTPUT1
	LIB_GE_command_buffer {MOM_do_template set_csys_on_2} @OUTPUT2
	LIB_GE_command_buffer_output
	MOM_set_address_format G_csys_rot Digit_2
	MOM_force once X Y Z I_rot J_rot K_rot


	LIB_rotate_axis_after_plane

	LIB_CTRL_clamp_axis

	set lib_flag(mode_current_status) "pos"
}

#____________________________________________________________________________________________
# <Internal Documentation>
# reset plane
#
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CSYS_plane_output_reset {} {


	global mom_sys_csys_rot_code
	global lib_flag lib_sav_kin_machine_type

	#OUT [LIB_SPF_csys_examine_local] mom_tool_axis(2)
	if {$lib_flag(mode_current_status) == "std"} {return}

	LIB_local_origin_reset

	LIB_CTRL_unclamp_axis

	LIB_GE_command_buffer LOCAL_CSYS_RESET
	LIB_GE_command_buffer {if {$lib_flag(local_namespace_output)} {LIB_SPF_local_pos_reset}} @LOCAL_POS_RESET
	LIB_GE_command_buffer_output

	if {[string match "*.*" $mom_sys_csys_rot_code(OFF)]} {
		MOM_set_address_format G_csys_rot Zero_real
		LIB_GE_command_buffer CSYS_OFF_REAL
		LIB_GE_command_buffer {MOM_do_template set_csys_off} @OUTPUT
		LIB_GE_command_buffer_output
		MOM_set_address_format G_csys_rot Digit_2
	} else {
		LIB_GE_command_buffer CSYS_OFF
		LIB_GE_command_buffer {MOM_do_template set_csys_off} @OUTPUT
		LIB_GE_command_buffer_output
	}
		
	if {[string match "*4_axis*" $lib_sav_kin_machine_type]} {
		MOM_enable_address fourth_axis
	} else {
		MOM_enable_address fourth_axis fifth_axis
	}
	set lib_flag(mode_current_status) "std"

	LIB_SPF_leader_rot_axes_plane_kin reset

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is called with LIB_SPF_first_tool_path_motion
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_SPF_first_tool_path_motion_pos {} {


	global mom_prev_out_angle_pos mom_out_angle_pos mom_polar_status mom_current_motion
	global lib_flag mom_operation_type

	if {[string match $mom_operation_type "Device Generic Motion"]} {
		return
	}

	if {$mom_current_motion == "initial_move"} {
		if {[CONF_CTRL_moves safety_motion_after_toolchange] == 1} {
			set lib_flag(safety_retract_status) 1
		} else {
			set lib_flag(safety_retract_status) 0
		}
	}

	if {[CONF_CTRL_moves safety_motion_after_toolchange] == 1 || $mom_current_motion != "initial_move"} {
	if {[info exists mom_prev_out_angle_pos] && $mom_polar_status != "ON" && [CONF_CTRL_moves standard_path_between_rotary_motions] == 0} {
		if {[CONF_CTRL_moves safety_retract_before_fourth_axis] == 1 && ![EQ_is_equal $mom_prev_out_angle_pos(0) $mom_out_angle_pos(0)]} {
			if {[EQ_is_gt [expr abs($mom_out_angle_pos(0) - $mom_prev_out_angle_pos(0))] [CONF_CTRL_moves safety_retract_before_fourth_axis_minimum_value]]} {
				set lib_flag(safety_retract_status) 1
			}
		}

		if {[CONF_CTRL_moves safety_retract_before_fifth_axis] == 1 && ![EQ_is_equal $mom_prev_out_angle_pos(1) $mom_out_angle_pos(1)]} {
			if {[EQ_is_gt [expr abs($mom_out_angle_pos(1) - $mom_prev_out_angle_pos(1))] [CONF_CTRL_moves safety_retract_before_fifth_axis_minimum_value]]} {
				set lib_flag(safety_retract_status) 1
			}
		}
	}

	if {[info exists lib_flag(safety_retract_status)] && $lib_flag(safety_retract_status) == 1} {
	 	if {[CONF_CTRL_moves return_safety_pos] != ""} {LIB_RETURN_move CONF_CTRL_moves return_safety_pos}
		set lib_flag(tool_path_motion) 1
		set lib_flag(safety_retract_status) 0
		}
	}
	# not possible with this controller
	# LIB_CTRL_prepos_before_plane
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This command is called with LIB_SPF_first_tool_path_motion
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_SPF_first_tool_path_motion_sim {} {

	global lib_flag

	if {[CONF_SPF_sim_kin tcpm_prepos_plane] == 1} {
		LIB_GE_command_buffer TCPM_PREPOS_PLANE
		LIB_GE_command_buffer {
			if {$lib_flag(local_namespace_output)} {
				LIB_SPF_local_csys_rotation "ZXZ" "euler"
			} else {
				LIB_SPF_convert_point "plane_no_reset"
				LIB_SPF_csys_3D_rotation "ZXZ" "euler"
				LIB_GE_snapshot LOAD_PERMANENT $::lib_spf_convert_kin_snapshot
			}			
		} @CP_PLANE
		LIB_GE_command_buffer {LIB_ROTARY_positioning_init} @INIT
		LIB_GE_command_buffer {LIB_SPINDLE_start} @START_SPINDLE
		LIB_GE_command_buffer {LIB_ROTARY_positioning_first_move_pos} @MOTION
		LIB_GE_command_buffer {LIB_ROTARY_positioning_reset} @RESET

		if {$lib_flag(local_namespace_output) == 0} {
			LIB_GE_command_buffer {LIB_SPF_convert_point "reload"} @CP_RELOAD
			LIB_GE_command_buffer {
				if {[CONF_CTRL_setting tcpm_output_supported] == "NONE"} {
					LIB_SPF_KINEMATICS_set_absolut_output_kin
				} else {
					LIB_SPF_KINEMATICS_set_simultanous_kin
				}
			} @KIN_SIM
		} else {
         		global mom_mcs_goto mom_pos
			VMOV 3 mom_mcs_goto mom_pos
		}
		LIB_GE_command_buffer_output
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is executed at the cycle event.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CYCLE_dwell_set {} {


	global mom_cycle_delay_mode ;# SECONDS, REVOLUTIONS, OFF ,ON
	global mom_cycle_delay mom_cycle_delay_revs mom_spindle_rpm

	if {$mom_cycle_delay_mode == "ON"} {set mom_cycle_delay [CONF_CTRL_drill default_cycle_delay]}

	if {$mom_cycle_delay_mode == "OFF"} {
		set mom_cycle_delay 0
		return
	}

	if {$mom_cycle_delay_mode == "REVOLUTIONS"} {
		catch {set mom_cycle_delay [expr $mom_cycle_delay_revs * (60 / $mom_spindle_rpm)]}
	}

	if {$mom_cycle_delay > [CONF_CTRL_drill max_delay]} {set mom_cycle_delay [CONF_CTRL_drill max_delay]}
	if {$mom_cycle_delay < [CONF_CTRL_drill min_delay]} {set mom_cycle_delay [CONF_CTRL_drill min_delay]}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_drill : output CYCLE81 (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_drill_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_drill_move_LIB {} {


	global lib_flag
	set commandcheck(MOM_drill_move_LIB_ENTRY) [llength [info commands MOM_drill_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_drill_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_move_LIB_ENTRY)} {MOM_drill_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------


	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_drill_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_move_LIB_ENTRY)} {MOM_drill_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_drill_dwell : output CYCLE82 (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_drill_dwell_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_drill_dwell_move_LIB {} {


	set commandcheck(MOM_drill_dwell_move_LIB_ENTRY) [llength [info commands MOM_drill_dwell_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_drill_dwell_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_dwell_move_LIB_ENTRY)} {MOM_drill_dwell_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_drill_dwell_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_dwell_move_LIB_ENTRY)} {MOM_drill_dwell_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_drill_deep : output CYCLE83_Deep (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_drill_deep_LIB {} {


	global mom_cycle_step1 mom_tool_diameter mom_cycle_feed_to

	LIB_CYCLE_set

	if {[hiset mom_cycle_step1]} {
		set mom_cycle_step1 [expr abs($mom_cycle_step1)]
	} else {
		set mom_cycle_step1 0
	}

	if {$mom_cycle_step1 == 0} {
		if {[hiset mom_tool_diameter]} {set mom_cycle_step1 [expr $mom_tool_diameter / 2]} else {set mom_cycle_step1 2}
		LIB_SPF_add_warning "With CYCLE/DEEP, STEP1 should be defined. Default value used by the post : 'INS->[format %.1f $mom_cycle_step1]<-'"
	}
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_drill_deep_move_LIB {} {


	global mom_cycle_feed_to mom_cycle_step1
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}

	set commandcheck(MOM_drill_deep_move_LIB_ENTRY) [llength [info commands MOM_drill_deep_move_LIB_ENTRY]]


	LIB_GE_command_buffer MOM_drill_deep_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_deep_move_LIB_ENTRY)} {MOM_drill_deep_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_drill_deep_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_deep_move_LIB_ENTRY)} {MOM_drill_deep_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_drill_break_chip : output CYCLE83_Break_Chip (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_drill_break_chip_LIB {} {


	global mom_cycle_step1 mom_tool_diameter mom_cycle_feed_to

	LIB_CYCLE_set

	if {[hiset mom_cycle_step1]} {
		set mom_cycle_step1 [expr abs($mom_cycle_step1)]
	} else {
		set mom_cycle_step1 0
	}

	if {$mom_cycle_step1 == 0} {
		if {[hiset mom_tool_diameter]} {set mom_cycle_step1 [expr $mom_tool_diameter / 2]} else {set mom_cycle_step1 2}
		LIB_SPF_add_warning "With CYCLE/BREAKCHIP, STEP1 should be defined. Default value used by the post : 'INS->[format %.1f $mom_cycle_step1]<-'"
	}
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called fom MOM-Event and controls the handling to the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# This function outputs a warning as hole milling subprogram is not supported on this controller
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_mill_hole_move_LIB {} {
#@.pce@

    set commandcheck(MOM_mill_hole_move_LIB_ENTRY) [llength [info commands MOM_mill_hole_move_LIB_ENTRY]]

    LIB_GE_command_buffer MOM_mill_hole_move_LIB_ENTRY_start
    LIB_GE_command_buffer {if {$commandcheck(MOM_mill_hole_move_LIB_ENTRY)} {MOM_mill_hole_move_LIB_ENTRY start}} @DEFAULT_ENTRY
    LIB_GE_command_buffer_output
    #---------------------------------------------------------------------------------

    LIB_SPF_add_warning "Hole milling machine cycle is not supported on this controller"

    #---------------------------------------------------------------------------------
    LIB_GE_command_buffer MOM_mill_hole_move_LIB_ENTRY_end
    LIB_GE_command_buffer {if {$commandcheck(MOM_mill_hole_move_LIB_ENTRY)} {MOM_mill_hole_move_LIB_ENTRY end}} @DEFAULT_ENTRY
    LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called fom MOM-Event and controls the handling to the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# This function outputs a warning as thread milling subprogram is not supported on this controller
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_mill_hole_thread_move_LIB {} {

    set commandcheck(MOM_mill_hole_thread_move_LIB_ENTRY) [llength [info commands MOM_mill_hole_thread_move_LIB_ENTRY]]

    LIB_GE_command_buffer MOM_mill_hole_thread_move_LIB_ENTRY_start
    LIB_GE_command_buffer {if {$commandcheck(MOM_mill_hole_thread_move_LIB_ENTRY)} {MOM_mill_hole_thread_move_LIB_ENTRY start}} @DEFAULT_ENTRY
    LIB_GE_command_buffer_output
    #---------------------------------------------------------------------------------

    LIB_SPF_add_warning "Thread milling machine cycle is not supported on this controller"

    #---------------------------------------------------------------------------------
    LIB_GE_command_buffer MOM_mill_hole_thread_move_LIB_ENTRY_end
    LIB_GE_command_buffer {if {$commandcheck(MOM_mill_hole_thread_move_LIB_ENTRY)} {MOM_mill_hole_thread_move_LIB_ENTRY end}} @DEFAULT_ENTRY
    LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_drill_break_chip_move_LIB {} {


	global mom_cycle_feed_to mom_cycle_step1
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}

	set commandcheck(MOM_drill_break_chip_move_LIB_ENTRY) [llength [info commands MOM_drill_break_chip_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_drill_break_chip_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_break_chip_move_LIB_ENTRY)} {MOM_drill_break_chip_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_drill_break_chip_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_break_chip_move_LIB_ENTRY)} {MOM_drill_break_chip_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_tap
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_tap_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_tap_move_LIB {} {


	set commandcheck(MOM_tap_move_LIB_ENTRY) [llength [info commands MOM_tap_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_tap_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_move_LIB_ENTRY)} {MOM_tap_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_tap_set
	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_tap_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_move_LIB_ENTRY)} {MOM_tap_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_tap_float
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_tap_float_LIB {} {


	LIB_CYCLE_set

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_tap_float_move_LIB {} {


	set commandcheck(MOM_tap_float_move_LIB_ENTRY) [llength [info commands MOM_tap_float_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_tap_float_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_float_move_LIB_ENTRY)} {MOM_tap_float_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_tap_set
	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_tap_float_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_float_move_LIB_ENTRY)} {MOM_tap_float_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_tap_deep
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_tap_deep_LIB {} {

	global mom_cycle_step1 mom_cycle_feed_to
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}

	LIB_CYCLE_set

	if {![info exists mom_cycle_step1] || [EQ_is_zero $mom_cycle_step1]} {
		LIB_SPF_add_warning "Step value of Tap Deep cycle cannot be zero!"
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_tap_deep_move_LIB {} {


	global mom_cycle_feed_to mom_cycle_step1
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}

	set commandcheck(MOM_tap_deep_move_LIB_ENTRY) [llength [info commands MOM_tap_deep_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_tap_deep_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_deep_move_LIB_ENTRY)} {MOM_tap_deep_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_tap_set
	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_tap_deep_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_deep_move_LIB_ENTRY)} {MOM_tap_deep_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_tap_break_chip
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_tap_break_chip_LIB {} {

	global mom_cycle_step1 mom_cycle_feed_to
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}

	LIB_CYCLE_set

	if {![info exists mom_cycle_step1] || [EQ_is_zero $mom_cycle_step1]} {
		LIB_SPF_add_warning "Step value of Tap Break Chip cycle cannot be zero!"
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_tap_break_chip_move_LIB {} {


	global mom_cycle_feed_to mom_cycle_step1
	if {[EQ_is_gt $mom_cycle_step1 [expr abs($mom_cycle_feed_to)]]} {set mom_cycle_step1 [expr abs($mom_cycle_feed_to)]}

	set commandcheck(MOM_tap_break_chip_move_LIB_ENTRY) [llength [info commands MOM_tap_break_chip_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_tap_break_chip_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_break_chip_move_LIB_ENTRY)} {MOM_tap_break_chip_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_tap_set
	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_tap_break_chip_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_tap_break_chip_move_LIB_ENTRY)} {MOM_tap_break_chip_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_bore : output CYCLE85_Bore (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_bore_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_bore_move_LIB {} {


	set commandcheck(MOM_bore_move_LIB_ENTRY) [llength [info commands MOM_bore_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_bore_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_move_LIB_ENTRY)} {MOM_bore_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_bore_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_move_LIB_ENTRY)} {MOM_bore_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_bore_dwell : output CYCLE85_Bore_Dwell (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_bore_dwell_LIB {} {


	LIB_CYCLE_set

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_bore_dwell_move_LIB {} {


	set commandcheck(MOM_bore_dwell_move_LIB_ENTRY) [llength [info commands MOM_bore_dwell_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_bore_dwell_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_dwell_move_LIB_ENTRY)} {MOM_bore_dwell_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_bore_dwell_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_dwell_move_LIB_ENTRY)} {MOM_bore_dwell_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_bore_drag : output CYCLE89 (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_bore_drag_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_bore_drag_move_LIB {} {


	set commandcheck(MOM_bore_drag_move_LIB_ENTRY) [llength [info commands MOM_bore_drag_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_bore_drag_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_drag_move_LIB_ENTRY)} {MOM_bore_drag_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_bore_drag_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_drag_move_LIB_ENTRY)} {MOM_bore_drag_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_bore_no_drag : output CYCLE86 (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_bore_no_drag_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_bore_no_drag_move_LIB {} {


	set commandcheck(MOM_bore_no_drag_move_LIB_ENTRY) [llength [info commands MOM_bore_no_drag_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_bore_no_drag_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_no_drag_move_LIB_ENTRY)} {MOM_bore_no_drag_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_bore_no_drag_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_no_drag_move_LIB_ENTRY)} {MOM_bore_no_drag_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_bore_back : output CYCLE86 (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_bore_back_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_bore_back_move_LIB {} {


	set commandcheck(MOM_bore_back_move_LIB_ENTRY) [llength [info commands MOM_bore_back_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_bore_back_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_back_move_LIB_ENTRY)} {MOM_bore_back_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_bore_back_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_back_move_LIB_ENTRY)} {MOM_bore_back_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_bore_manual : output CYCLE87 (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_bore_manual_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_bore_manual_move_LIB {} {


	set commandcheck(MOM_bore_manual_move_LIB_ENTRY) [llength [info commands MOM_bore_manual_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_bore_manual_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_manual_move_LIB_ENTRY)} {MOM_bore_manual_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_bore_manual_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_manual_move_LIB_ENTRY)} {MOM_bore_manual_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_bore_manual_dwell : output CYCLE88 (default)
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_bore_manual_dwell_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_bore_manual_dwell_move_LIB {} {


	set commandcheck(MOM_bore_manual_dwell_move_LIB_ENTRY) [llength [info commands MOM_bore_manual_dwell_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_bore_manual_dwell_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_manual_dwell_move_LIB_ENTRY)} {MOM_bore_manual_dwell_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_bore_manual_dwell_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_bore_manual_dwell_move_LIB_ENTRY)} {MOM_bore_manual_dwell_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_drill_text
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_drill_text_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_drill_text_move_LIB {} {


	set commandcheck(MOM_drill_text_move_LIB_ENTRY) [llength [info commands MOM_drill_text_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_drill_text_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_text_move_LIB_ENTRY)} {MOM_drill_text_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_drill_text_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_drill_text_move_LIB_ENTRY)} {MOM_drill_text_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_thread
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_thread_LIB {} {


	LIB_CYCLE_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# MOM_thread_move
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc MOM_thread_move_LIB {} {


	set commandcheck(MOM_thread_move_LIB_ENTRY) [llength [info commands MOM_thread_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_thread_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_thread_move_LIB_ENTRY)} {MOM_thread_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_CYCLE_move

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_thread_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_thread_move_LIB_ENTRY)} {MOM_thread_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_cycle_off_LIB {} {


	set commandcheck(MOM_cycle_off_LIB_ENTRY) [llength [info commands MOM_cycle_off_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_cycle_off_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_cycle_off_LIB_ENTRY)} {MOM_cycle_off_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	LIB_GE_command_buffer CYCLE_OFF
	LIB_GE_command_buffer {
		if {[LIB_SPF_get_pretreatment cycle_tap] == "YES" && [CONF_CTRL_drill cycle_tap] == "rigid"} {
			MOM_do_template spindle_tap_rigid_init CREATE
		}
		if {[CONF_CTRL_drill cancel_cycle] == "G80"} {
			MOM_do_template cycle_off
		} elseif {[MOM_ask_address_value G_motion] > 1 } {
			MOM_do_template cycle_off
		}
	} @OFF
	LIB_GE_command_buffer {MOM_do_template cycle_init CREATE} @INIT
	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_cycle_off_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_cycle_off_LIB_ENTRY)} {MOM_cycle_off_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the drilling cycle setting conditions
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CYCLE_set {} {

	LIB_GE_command_buffer CYCLE_SET_start
	LIB_GE_command_buffer {
	global mom_cycle_feed_rate mom_cycle_feed_rate_mode mom_cycle_feed_rate_per_rev mom_spindle_rpm
		if {[string match *PR* [string toupper $mom_cycle_feed_rate_mode]] && [info exists mom_cycle_feed_rate_per_rev]} {
			set mom_cycle_feed_rate [expr $mom_cycle_feed_rate_per_rev * $mom_spindle_rpm]
		}
	} @CYCLE_FEED
	LIB_GE_command_buffer_output

	LIB_CYCLE_dwell_set
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the tapping cycle setting conditions
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CYCLE_tap_set {} {

	global mom_tool_pitch mom_cycle_feed_rate_per_rev
	global mom_cycle_thread_pitch
	global mom_cycle_thread_right_handed
	global mom_spindle_direction
	global mom_spindle_rpm mom_spindle_speed
	global mom_retract_spindle
	global mom_path_name
	global feed_mode
	global feed

	if {[info exists mom_tool_pitch]} {
		set pitch $mom_tool_pitch
	} elseif {[info exists mom_cycle_thread_pitch]} {
		set pitch $mom_cycle_thread_pitch
	} else {
		if {[CONF_CTRL_drill tool_pitch_used] == 0} {
			set pitch $mom_cycle_feed_rate_per_rev
		} else {
			set pitch 0
			LIB_GE_abort_message "INS->$mom_path_name<- : No pitch defined on the tool." "Please use Tap tool."
		}
	}

	if {![info exists mom_spindle_speed] || [EQ_is_zero $mom_spindle_speed]} {
		LIB_GE_abort_message "INS->$mom_path_name<- : spindle speed is 0." "Please verify."
	}

	if {[string match "*PR" [CONF_CTRL_drill cycle_tap_feed_type]]} {
		set feed $pitch
		MOM_set_address_format F Feed_[CONF_CTRL_drill cycle_tap_feed_type]
		#<lili 05-20-2019> In this case, G95 should be outputed, reset feed_mode.
		set feed_mode [CONF_CTRL_drill cycle_tap_feed_type]
	} elseif {[string match "*PR" $feed_mode]} {
		set feed $pitch
	} else {
		MOM_set_address_format F Coordinate
		set feed [expr $pitch*$mom_spindle_rpm]
	}

	LIB_CYCLE_tap_g_code_string_determine_for_standard
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the drilling move setting conditions
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CYCLE_move {} {


	global mom_cycle_feed_to mom_cycle_retract_to_pos mom_cycle_rapid_to_pos
	global mom_sys_cycle_tap_code mom_sys_cycle_tap_rigid_code mom_spindle_direction
	global mom_motion_event mom_sys_tap_rigid_code
	global cycle_peck_size lib_parameter cycle_factor
	global lib_prev_cycle_retract_to_pos lib_prev_cycle_rapid_to_pos lib_flag tool_axis
	global mom_namespace_name mom_cycle_rapid_to mom_cycle_clearance_plane mom_pos
	
	set commandcheck(LIB_CYCLE_move_ENTRY) [llength [info commands LIB_CYCLE_move_ENTRY]]
	LIB_GE_command_buffer LIB_CYCLE_move_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CYCLE_move_ENTRY)} {LIB_CYCLE_move_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

	# <NX1201 cam16012> new prereatment local csys
	# PR9772886: Override feed_to_pos/rapid_to_pos/retract_to_pos by related value in local namespace
	if {$lib_flag(local_namespace_output)} {
		LIB_SPF_recalculate_cycle_pos
	}
	LIB_GE_command_buffer START_CYCLE
	LIB_GE_command_buffer {LIB_SPINDLE_start cycle} @OUTPUT
	LIB_GE_command_buffer_output

	LIB_GE_command_buffer PREPOS_IN_CYCLE
	LIB_GE_command_buffer {
	if {$lib_flag(tool_path_motion) == 1} {
		switch -- $tool_axis {
				0 {LIB_SPF_decompose_block_template "{Y Z} {G_adjust X H}" "cycle_move" FORCE "G_adjust X Y Z H"}
				1 {LIB_SPF_decompose_block_template "{X Z} {G_adjust Y H}" "cycle_move" FORCE "G_adjust X Y Z H"}
				2 {LIB_SPF_decompose_block_template "{X Y} {G_adjust Z H}" "cycle_move" FORCE "G_adjust X Y Z H"}
		}
	}
	} @PREPOS_DEFAULT
	LIB_GE_command_buffer_output
	set lib_flag(tool_path_motion) 2

	switch -- $tool_axis {
		0 {set cycle_factor [LIB_SPF_check_x_factor MILL]}
		1 {set cycle_factor 1}
		2 {set cycle_factor 1}
	}

	LIB_SPF_retract_to_pos
	
	# Replace negative rapid_to by clearance_plane to keep safety distance in Cycle.
	LIB_GE_command_buffer RAPIDTOPOS_IN_CYCLE
	LIB_GE_command_buffer {
		if {$mom_cycle_rapid_to < 0} {
			set mom_cycle_rapid_to $mom_cycle_clearance_plane		
			set mom_cycle_rapid_to_pos($tool_axis)  [expr $mom_pos($tool_axis) + $mom_cycle_rapid_to]
		}
	} @RAPIDTOPOS_ADJUST
	LIB_GE_command_buffer_output
	
	set cycle_peck_size [expr ($mom_cycle_feed_to*(-1.0))]     ;# single peck size most cycles

	LIB_WRITE_coolant on

	if {[info exists lib_parameter(special_cycle,name)] && $lib_parameter(special_cycle,name) != ""} {
		LIB_CYCLE_move_special_$lib_parameter(special_cycle,name)
	} else {
		LIB_GE_command_buffer CYCLE_MODIFY_START
		LIB_GE_command_buffer {} @DEFAULT_ENTRY
		LIB_GE_command_buffer_output
			
		switch -- $mom_motion_event {
			"drill_move" 		{
							LIB_GE_command_buffer DRILL_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_drill} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"drill_dwell_move" 	{
							LIB_GE_command_buffer DRILL_DWELL_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_drill_dwell} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"drill_deep_move" 	{
							LIB_GE_command_buffer DRILL_DEEP_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_drill_deep} @OUTPUT
							LIB_GE_command_buffer_output

						}
			"drill_break_chip_move" {
							LIB_GE_command_buffer DRILL_BREAK_CHIP_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_drill_break_chip} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"tap_move" 		{
							if {[CONF_CTRL_drill cycle_tap] == "rigid"} {
								LIB_GE_command_buffer TAP_MOVE_RIGID
								LIB_GE_command_buffer {
									MOM_set_address_format G_motion Coordinate
									set mom_sys_cycle_tap_code $mom_sys_cycle_tap_rigid_code($mom_spindle_direction)
								} @SETTING_BEFORE
								LIB_GE_command_buffer {
									if {[MOM_ask_address_value M_rigid_tap] != $mom_sys_tap_rigid_code} {MOM_force once S}
									MOM_do_template spindle_tap_rigid
								} @RIGID_MODE_OUTPUT
								LIB_GE_command_buffer {MOM_do_template cycle_tap} @OUTPUT
								LIB_GE_command_buffer {
									MOM_set_address_format G_motion Digit_2
									set mom_sys_cycle_tap_code 84
								}  @SETTING_AFTER
								LIB_GE_command_buffer_output
							} else {
								LIB_GE_command_buffer TAP_MOVE
								LIB_GE_command_buffer {MOM_do_template cycle_tap} @OUTPUT
								LIB_GE_command_buffer_output
							}
						}
			"tap_float_move" 	{
							LIB_GE_command_buffer TAP_FLOAT_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_tap} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"tap_deep_move" 	{
							LIB_GE_command_buffer TAP_DEEP_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_tap_deep} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"tap_break_chip_move" 	{
							LIB_GE_command_buffer TAP_BREAK_CHIP_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_tap_deep} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"bore_move" 		{
							LIB_GE_command_buffer BORE_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_bore} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"bore_dwell_move" 	{
							LIB_GE_command_buffer BORE_DWELL_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_bore_dwell} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"bore_drag_move" 	{
							LIB_GE_command_buffer BORE_DRAG_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_bore_drag} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"bore_no_drag_move" 	{
							LIB_GE_command_buffer BORE_NO_DRAG_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_bore_no_drag} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"bore_back_move" 	{
							LIB_GE_command_buffer BORE_BACK_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_bore_back} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"bore_manual_move" 	{
							LIB_GE_command_buffer BORE_MANUAL_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_bore_manual} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"bore_manual_dwell_move" {
							LIB_GE_command_buffer BORE_MANUAL_DWELL_MOVE
							LIB_GE_command_buffer {MOM_do_template cycle_bore_manual_dwell} @OUTPUT
							LIB_GE_command_buffer_output
						}
			"drill_text_move" 	{# nothing for the moment}
			"thread_move" 		{# nothing for the moment}
		}
		
		LIB_GE_command_buffer CYCLE_MODIFY_END
		LIB_GE_command_buffer {} @DEFAULT_ENTRY
		LIB_GE_command_buffer_output
	}

	LIB_CTRL_cycle_retract_handling

	if {[info exists mom_namespace_name] && $mom_namespace_name == "::LOCAL_CSYS"} {
		namespace eval $::mom_namespace_name {
			array set lib_prev_cycle_retract_to_pos [array get mom_cycle_retract_to_pos]
			array set lib_prev_cycle_rapid_to_pos [array get mom_cycle_rapid_to_pos]
		}
	} else {
		array set lib_prev_cycle_retract_to_pos [array get mom_cycle_retract_to_pos]
		array set lib_prev_cycle_rapid_to_pos [array get mom_cycle_rapid_to_pos]

	}

	LIB_GE_command_buffer LIB_CYCLE_move_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CYCLE_move_ENTRY)} {LIB_CYCLE_move_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}
#____________________________________________________________________________________________
# <Internal Documentation>
# Controls the tapping cycle setting conditions.
#
# Determine the tapping G code according to thread direction for standard mode in tap move.
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CYCLE_tap_g_code_string_determine_for_standard {} {


	global mom_cycle_thread_right_handed
	global mom_spindle_direction
	global mom_sys_cycle_tap_code

	if {[info exists mom_cycle_thread_right_handed]} {

		if {$mom_cycle_thread_right_handed == "TRUE"} {

			set mom_sys_cycle_tap_code "84"

		} else {

			set mom_sys_cycle_tap_code "74"
		}

	} elseif {[info exists mom_spindle_direction]} {

		if {$mom_spindle_direction == "CLW"} {

			set mom_sys_cycle_tap_code "84"

		}

		if {$mom_spindle_direction == "CCLW"} {

			set mom_sys_cycle_tap_code "74"
		}
	} else {
			set mom_sys_cycle_tap_code "84"
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_cycle_retract_handling {} {

	global mom_cycle_retract_to_pos mom_cycle_rapid_to_pos tool_axis
	global mom_cycle_retract_to mom_cycle_rapid_to mom_pos
	global mom_cycle_retract_mode mom_namespace_name

	# If mom_cycle_retract_mode is "AUTO", for continuous drilling in local csys namespace,
	# rapidTo and retractTo are recalculated and may be different, but we don't need to output redundant NC code "G0 Z.."
	if {$mom_cycle_retract_mode == "AUTO"} {return}

# 31.01.2018 HES Why we retract only if mom_cycle_retract_mode is "MANUAL"
# change it if rapid and retract is different
#	if {![EQ_is_equal $mom_cycle_retract_to $mom_cycle_rapid_to] && $mom_cycle_retract_mode == "MANUAL"} {}
	if {![EQ_is_equal $mom_cycle_retract_to $mom_cycle_rapid_to]} {
		# <NX1201 cam16012> new prereatment local csys
		if {[info exists mom_namespace_name] && [namespace exists $mom_namespace_name]} {
			# Should set mom_pos or mom_mcs_goto in specify namespace mom_namespace_name if exist
			uplevel #0 {
				namespace eval $::mom_namespace_name {
					set tmp_posz $mom_pos($tool_axis)
					set tmp_mcs_gotoz $mom_mcs_goto($tool_axis)
					set mom_pos($tool_axis) $mom_cycle_retract_to_pos($tool_axis)
					set mom_mcs_goto($tool_axis) $mom_cycle_retract_to_pos($tool_axis)
					MOM_do_template [CONF_CTRL_moves rapid_template]
					set mom_pos($tool_axis) $tmp_posz
					set mom_mcs_goto($tool_axis) $tmp_mcs_gotoz
				}
			}
		} else {
			set tmpz $mom_pos($tool_axis)
			set mom_pos($tool_axis) $mom_cycle_retract_to_pos($tool_axis)
			LIB_GE_command_buffer CYCLE_RETRACT
			LIB_GE_command_buffer {MOM_do_template [CONF_CTRL_moves rapid_template]} @OUTPUT
			LIB_GE_command_buffer_output
			set mom_pos($tool_axis) $tmpz
		}
		MOM_force once R_cycle Q_cycle
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# Check for adjust register
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CHECK_adjust_register {} {


	global mom_path_name mom_tool_adjust_register mom_tool_length_adjust_register mom_tool_number
	global lib_flag

	LIB_GE_command_buffer CHECK_adjust_register
	LIB_GE_command_buffer {
		if {$mom_tool_length_adjust_register == 0} {set mom_tool_adjust_register $mom_tool_number}

		if {[CONF_CTRL_tool max_d_number] != 0 && $mom_tool_length_adjust_register > [CONF_CTRL_tool max_d_number]} {
			if {![hiset lib_flag(error_adjust_register,$mom_path_name)]} {
				set error [LIB_SPF_add_warning "Adjust register $mom_tool_length_adjust_register not possible ([CONF_CTRL_tool max_d_number] max) ... Adjust register $mom_tool_number (same as tool_number) is used"]
				set lib_flag(error_adjust_register,$mom_path_name) 1
			}
			set mom_tool_adjust_register $mom_tool_number
		}

		if {![LIB_SPF_check_adjust_register] && [CONF_CTRL_tool check_zero_adjust_register]} {
			MOM_output_to_listing_device "$mom_path_name adjust register $mom_tool_adjust_register is not defined in tool data\n"
		}
	} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Check to rotate the axis before plane handling
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_rotate_axis_before_plane {} {


	if {[CONF_TEMPLATE_3P2 rotate_before] == "1"} {
		LIB_CTRL_rotate_axis
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Check to rotate the axis after plane handling
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_rotate_axis_after_plane {} {


	if {[CONF_TEMPLATE_3P2 rotate_after] == "1"} {
		LIB_CTRL_rotate_axis
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is executed to output coolant on or off
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_WRITE_coolant {{option default}} {


	global mom_coolant_mode mom_coolant_status mom_kin_is_turbo_output

	switch -- $option {
		"on"	{
			if {![hiset mom_coolant_mode] || $mom_coolant_mode == ""} {set mom_coolant_mode [CONF_CTRL_coolant coolant_status]}
			if {$mom_coolant_mode == "OFF"} {return}

			LIB_GE_command_buffer COOLNT_on
			LIB_GE_command_buffer {
				if {[CONF_CTRL_coolant coolnt_output_before_motion] != 0} {
					MOM_do_template coolant_on
				}
			} @COOLNT_on_std
			LIB_GE_command_buffer_output
		}
		"off"	{
			LIB_GE_command_buffer COOLNT_off
			LIB_GE_command_buffer {
				if {[info exists mom_kin_is_turbo_output] && $mom_kin_is_turbo_output == "TRUE" && [MOM_ask_address_value M_coolant] != $::mom_sys_coolant_code(OFF)} {
					MOM_force once M_coolant ; #needs when turbo mode is activated (Bug#669)
				}
				MOM_do_template coolant_off
			} @COOLNT_on_std
			LIB_GE_command_buffer {
				if {[CONF_CTRL_coolant coolnt_auto] == 0} {
					set mom_coolant_mode "OFF"
					set mom_coolant_status "OFF"
				}
			} @COOLNT_on_std_2
			LIB_GE_command_buffer_output
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is called by MOM_circular_move and MOM_helix_move
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CIRCLE_set {} {
	

	global lib_arc_axis mom_arc_radius

	switch -- $lib_arc_axis {
		0 {MOM_suppress once I}
		1 {MOM_suppress once J}
		2 {MOM_suppress once K}
	}

	switch -- $lib_arc_axis {
		0 {MOM_force once Y Z J K}
		1 {MOM_force once X Z I K}
		2 {MOM_force once X Y I J}
	}

	LIB_SPF_check_arc_radius
	if {[info level -1] == "MOM_helix_move_LIB"} {
		# PR9980286: arc angle 360.0 and 180.0 only support arc output with IJK
		if {[CONF_CTRL_moves always_center_for_circle] != 1 && !([EQ_is_equal [expr fmod($::mom_arc_angle,360)] 0.0 0.1] || [EQ_is_equal [expr fmod($::mom_arc_angle,360)] 360.0 0.1]) && ![EQ_is_equal [expr fmod($::mom_arc_angle,360)] 180 0.1]} {
			MOM_suppress once I J K
			MOM_force once X Y Z R
			if {[expr fmod($::mom_arc_angle,360)] > 180} {
				set mom_arc_radius [expr abs($mom_arc_radius) * -1]
			} else {
				set mom_arc_radius [expr abs($mom_arc_radius) * +1]
			}

		} else {
			MOM_suppress once R
			MOM_force once X Y Z
		}
	} else {
		if {[CONF_CTRL_moves always_center_for_circle] != 1} {
			set mom_arc_radius [expr abs($mom_arc_radius)]

			if {[CONF_CTRL_feed feed_linear] == 2} {
				set ::feed $::mom_feedrate
				LIB_CTRL_feed_output
			}

			MOM_suppress once I J K

            # Set the tolerance to 0.1 because the calculation in NX is not exact (Bug #1280)
            if {[info exists ::lib_spf(nx_version)] && $::lib_spf(nx_version) < 2412 \
            && (([EQ_is_equal $::mom_arc_angle 360 0.1] && $::mom_sys_split_full_circle == 1) \
            || ([EQ_is_equal $::mom_arc_angle 180.0 0.1] && $::mom_sys_split_half_circle == 1))} {

				global mom_prev_pos mom_pos_arc_center mom_pos_arc_axis mom_pos oper_mcs_matrix
				global mom_namespace_name mom_output_pos_type
				if {[info exists mom_namespace_name] && [info exists mom_output_pos_type]} {
					if {$mom_namespace_name == "::"} {
						set namespace ::
					} else {
						set namespace ::LOCAL_CSYS::
					}
					if {$mom_output_pos_type == "mom_pos"} {
						VMOV 3 ${namespace}mom_prev_pos prev_pos
						VMOV 3 ${namespace}mom_pos_arc_center pos_arc_center
						VMOV 3 ${namespace}mom_pos_arc_axis pos_arc_axis
					} else {
						VMOV 3 ${namespace}mom_prev_mcs_goto prev_pos
						VMOV 3 ${namespace}mom_arc_center pos_arc_center
						VMOV 3 ${namespace}mom_arc_axis pos_arc_axis
					}
					VMOV 3 ${namespace}$mom_output_pos_type save_pos
				} else {
					set namespace ::
					set mom_output_pos_type mom_pos
					VMOV 3 mom_prev_pos prev_pos
					VMOV 3 mom_pos_arc_center pos_arc_center
					VMOV 3 mom_pos_arc_axis pos_arc_axis
					VMOV 3 mom_pos save_pos
				}
				VEC3_sub prev_pos pos_arc_center tmp_vec
				VEC3_unitize tmp_vec tmp_vec1
				VEC3_cross tmp_vec1 pos_arc_axis tmp_vec
				VEC3_scale mom_arc_radius tmp_vec tmp_vec1
				VEC3_add pos_arc_center tmp_vec1 tmp_vec
				VMOV 3 tmp_vec ${namespace}$mom_output_pos_type

				MOM_do_template [CONF_CTRL_moves circular_template]
				MOM_suppress once I J K
				VMOV 3 save_pos  ${namespace}$mom_output_pos_type
				set ::mom_arc_angle [expr $::mom_arc_angle - 90.0]

				switch -- $::lib_arc_axis {
					0 {
						MOM_force once Y Z
					}
					1 {
						MOM_force once X Z
					}
					2 {
						MOM_force once X Y
					}
				}
			}

			if {[EQ_is_gt $::mom_arc_angle 360 0.1]} {
				LIB_GE_abort_message "Variable mom_arc_angle is greater than 360 degree"
			}

			if {[EQ_is_gt $::mom_arc_angle 180.0]} {
				set mom_arc_radius [expr -1.0*$mom_arc_radius]
			}
		} else {
			MOM_suppress once R
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is called before each rotary motion
#
# <Internal Example>
#
#
#____________________________________________________________________________________________
proc LIB_CTRL_clamp_axis {} {


	if {[CONF_CTRL_clamp status] == 0 || [CONF_CTRL_clamp status] == 2 && [info level -1] != "MOM_clamp_LIB"} {return}
	if {[LIB_SPF_get_pretreatment axis_mode] == "SIMULTANEOUS"} {return}

	if {[CONF_CTRL_clamp fourth_axis] == 1} {
		LIB_GE_command_buffer CLAMP_FOURTH
		LIB_GE_command_buffer {if {[MOM_do_template clamp_fourth_axis CREATE] != ""} {MOM_force once M_clamp_fourth; MOM_do_template clamp_fourth_axis}} @OUTPUT
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer CLAMP_FOURTH_CREATE
		LIB_GE_command_buffer {MOM_do_template clamp_fourth_axis CREATE} @OUTPUT
		LIB_GE_command_buffer_output
	}

	if {[CONF_CTRL_clamp fifth_axis] == 1} {

		LIB_GE_command_buffer CLAMP_FIFTH
		LIB_GE_command_buffer {if {[MOM_do_template clamp_fifth_axis CREATE] != ""} {MOM_force once M_clamp_fifth; MOM_do_template clamp_fifth_axis}} @OUTPUT
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer CLAMP_FIFTH_CREATE
		LIB_GE_command_buffer {MOM_do_template clamp_fifth_axis CREATE} @OUTPUT
		LIB_GE_command_buffer_output
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is called after each rotary motion
#
# <Internal Example>
#
#
#____________________________________________________________________________________________
proc LIB_CTRL_unclamp_axis {} {


	if {[CONF_CTRL_clamp status] == 0 || [CONF_CTRL_clamp status] == 2 && [info level -1] != "MOM_clamp_LIB"} {return}

	if {[CONF_CTRL_clamp fifth_axis] == 1} {
		LIB_GE_command_buffer UNCLAMP_FIFTH
		LIB_GE_command_buffer {if {[MOM_do_template unclamp_fifth_axis CREATE] != ""} {MOM_force once M_clamp_fifth; MOM_do_template unclamp_fifth_axis}} @OUTPUT
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer UNCLAMP_FIFTH_CREATE
		LIB_GE_command_buffer {MOM_do_template unclamp_fifth_axis CREATE} @OUTPUT
		LIB_GE_command_buffer_output
	}

	if {[CONF_CTRL_clamp fourth_axis] == 1} {
		LIB_GE_command_buffer UNCLAMP_FOURTH
		LIB_GE_command_buffer {if {[MOM_do_template unclamp_fourth_axis CREATE] != ""} {MOM_force once M_clamp_fourth; MOM_do_template unclamp_fourth_axis}} @OUTPUT
		LIB_GE_command_buffer_output
	} else {
		LIB_GE_command_buffer UNCLAMP_FOURTH_CREATE
		LIB_GE_command_buffer {MOM_do_template unclamp_fourth_axis CREATE} @OUTPUT
		LIB_GE_command_buffer_output
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_rotate_axis {} {


	LIB_CTRL_unclamp_axis

	LIB_GE_command_buffer RAPID_ROTARY
	LIB_GE_command_buffer {MOM_do_template rapid_rotary} @OUTPUT
	LIB_GE_command_buffer_output

	LIB_CTRL_clamp_axis

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure contain the output that is done before the Commentary_Header
#
# <Internal Example>
#		Siemens			%_N_${lib_nc_header_name}_MPF
#		Heidenhain	BEGIN PGM ${lib_nc_header_name} MM
#		Fanuc			O${lib_nc_header_number}
#
#____________________________________________________________________________________________
proc LIB_CTRL_nc_header {} {


	global mom_attr_PROGRAMVIEW_PROGRAM_NUMBER
	global mom_output_file_basename lib_nc_header_number
	global lib_selected_group_name mom_dnc_program_name
	global mom_lib_program_name lib_flag

	#<cam17013 new pretreatment>
	if {$lib_flag(load_pretreatment)} {
		if {[LIB_PT_get_header_var lib_selected_group_name exists]} {
			set lib_selected_group_name [LIB_PT_get_header_var lib_selected_group_name]
		} else {
			set lib_selected_group_name [LIB_PT_get_header_var mom_oper_program]
		}
	}
	if {![info exists lib_selected_group_name]} {
		if {[info exists ::mom_selected_item_name_array(0)]} {
			if {[lindex $::mom_operation_name_list 0] == $::mom_selected_item_name_array(0) && \
				[llength [info commands MOM_ask_group_info]] && [MOM_ask_group_info [lindex $::mom_operation_name_list 0] program parent]} {
				set lib_selected_group_name $::mom_result
			} else {
				set lib_selected_group_name $::mom_selected_item_name_array(0)
			}
		} else {
			set lib_selected_group_name ""
		}
	}
	set lib_nc_header_number $mom_output_file_basename

	switch -- [CONF_CTRL_setting header_name] {
		"mom_attr_PROGRAMVIEW_PROGRAM_NUMBER" {
			if {$lib_flag(load_pretreatment)} {
			if { ![LIB_PT_get_header_var mom_attr_PROGRAMVIEW_PROGRAM_NUMBER exists] } {
				set lib_nc_header_number "0001"
			} else {
				set lib_nc_header_number [LIB_PT_get_header_var mom_attr_PROGRAMVIEW_PROGRAM_NUMBER]
				}
			} else {
			 	set lib_nc_header_number "0001"
			}
		}
		"output_file_basename" {set lib_nc_header_number $mom_output_file_basename}
		"selected_group" {
			set lib_nc_header_number $lib_selected_group_name
		}
		"ude_dnc_header" {
			if {[info exists mom_dnc_program_name]} {set lib_nc_header_number $mom_dnc_program_name}
		}
		"ude" {
			if {[info exists mom_lib_program_name]} {set lib_nc_header_number $mom_lib_program_name}
		}
		"ignore" {
                	return 0
		}
                "default" {
			LIB_CONF_do_prop_custom_proc CONF_CTRL_setting header_name "short_template_syntax"
		}
	}
	# Variable lib_nc_header_number is empty that means that mom_output_file_basename is used
	# and you are not in PP
	# for this case selected_group is used -- this is not ""

	if {$lib_nc_header_number == ""} {set lib_nc_header_number $lib_selected_group_name}

	LIB_GE_command_buffer PROG_NUMBER
	LIB_GE_command_buffer {
		if {![LIB_SPF_is_number $lib_nc_header_number]} {
			LIB_SPF_add_warning "The entry 'INS->$lib_nc_header_number<-' for the header with argument 'INS->[CONF_CTRL_setting header_name]<-' need a number as value. 0001 will be used"
			set lib_nc_header_number 0001
		}
		if {[EQ_is_gt $lib_nc_header_number 9999]} {LIB_SPF_add_warning "Header_number 'INS->$lib_nc_header_number<-' should be < 9999: 9999 will be used"}
	} @NUMBER_CHECK
	LIB_GE_command_buffer {
			MOM_suppress once N
			MOM_do_template header_program
	} @FIRST_LINE
	LIB_GE_command_buffer_output

}

#______________________________________________________________________________
# <Internal Documentation>
#
# Entrypoint to define additional variables which should be stored in pretreatment
#	Controller specific
#
# LIB_SPF_pretreatment_add_var in this proc to add return variables from pretreatment
#
# <Internal Example>
# Sample code as comment in proc body
#______________________________________________________________________________
proc LIB_SPF_pt_additional_variables_fanuc {} {


  #PR9239197 Add mom_lock_axis to pretreatment
  LIB_SPF_pretreatment_add_var MOM_lock_axis mom_lock_axis 0
}

#______________________________________________________________________________
# <Internal Documentation>
#
# Set the feed parameter if nessesary
# only if property feed_linear is set to 2(parameter)
#
#	NX      normal feedrate output
#	P_CUT   feedrate output as percentage of Cut Feed
#	Param   feedrate output as Parameter (F[#21])
#
#
# <Internal Example>
#
#______________________________________________________________________________
proc LIB_CTRL_set_feed_parameter {} {

	global mom_feed_rapid_output mom_feed_rapid_value
	global mom_feed_cut_unit mom_output_unit mom_feed_rate feed
	global mom_cycle_feed_rate mom_cycle_feed_rate_mode mom_cycle_feed_rate_per_rev
	global mom_feed_engage_value mom_feed_cut_value mom_feed_retract_value mom_feed_cycle_value
	global mom_feed_engage_unit mom_feed_cut_unit mom_feed_retract_unit mom_feed_cycle_value
	global mom_operation_type mom_motion_type lib_motion_type_list
	global lib_prev_feed_cut_value lib_flag mom_tool_name mom_kin_is_turbo_output
	global mom_feed_rate_output_mode mom_feed_rate_per_rev
	global lib_prev_feed_engage_value lib_prev_feed_retract_value
	global lib_prev_cycle_definition_mode mom_cycle_definition_mode mom_cycle_type

	set lib_flag(feed_turbo_mode_disable) 0
	if {[CONF_CTRL_feed feed_linear] == 0} {
		# use only NX-Values
	} elseif {[CONF_CTRL_feed feed_linear] == 1} {
		# use FAUTO (Feed from Tool definition
	} elseif {[CONF_CTRL_feed feed_linear] == 2} {
		# set this mom_sys.. variable That all motion feedrates are reduced to the mom_kin_max_fpm/fpr value
		set ::mom_sys_force_feedrate_limit_check 1

		# Workaraund to cover Rapid Engage and Retract if parametrric output is used
		if {[string toupper $::mom_feed_engage_nominal_unit] == "RAPID"} {
			if {$mom_output_unit != "MM"} {
				set mom_feed_engage_value [expr $::mom_kin_rapid_feed_rate * 25.4]
			} else {
				set mom_feed_engage_value $::mom_kin_rapid_feed_rate
			}
		}
		if {[string toupper $::mom_feed_retract_nominal_unit] == "RAPID"} {
			if {$mom_output_unit != "MM"} {
				set mom_feed_retract_value [expr $::mom_kin_rapid_feed_rate * 25.4]
			} else {
				set mom_feed_retract_value $::mom_kin_rapid_feed_rate
			}
		}

		foreach type $lib_motion_type_list {
			set tmp_motion_type [string tolower $type]
			if {[CONF_CTRL_feed exists feed_$tmp_motion_type]} {
				if {[CONF_CTRL_feed feed_$tmp_motion_type] != "NX"} {
					set lib_flag(feed_turbo_mode_disable) 1
					set mom_kin_is_turbo_output "FALSE"
				}
			}
		}
		if {$lib_flag(feed_turbo_mode_disable) == 1} {MOM_reload_kinematics_variable mom_kin_is_turbo_output}

		# check if "drilling" "Thread Milling" "Cylinder Milling" are the previous operation and the current cycle output is different
		# to the previous operation
		if {($mom_operation_type == "Drilling" || $mom_operation_type == "Cylinder Milling" || $mom_operation_type == "Thread Milling")} {
			if {![info exists mom_cycle_definition_mode] && $::lib_ge_env(major_version) <= 12} {
				if {![info exists mom_cycle_type]} {
					set mom_cycle_definition_mode 1
				} else {
					set mom_cycle_definition_mode 0
				}
			}
			if {![info exists lib_prev_cycle_definition_mode] || $lib_prev_cycle_definition_mode != $mom_cycle_definition_mode } {
				set check_cycle_definition_mode 1
			} else {
				set check_cycle_definition_mode 0
			}
			set lib_prev_cycle_definition_mode $mom_cycle_definition_mode
		} else {
			if {[info exists lib_prev_cycle_definition_mode] && $lib_prev_cycle_definition_mode == 0} {
				set check_cycle_definition_mode 1
			} else {
				set check_cycle_definition_mode 0
			}
			set lib_prev_cycle_definition_mode 1
		}
		if {[info level 1] != "MOM_start_of_path" || ($mom_tool_name == [LIB_SPF_get_pretreatment mom_tool_name -1]                && \
			(([info exist lib_prev_feed_cut_value]    && ![EQ_is_equal $mom_feed_cut_value $lib_prev_feed_cut_value])          || \
			([info exist lib_prev_feed_engage_value]  && ![EQ_is_equal $mom_feed_engage_value $lib_prev_feed_engage_value])    || \
			([info exist lib_prev_feed_retract_value] && ![EQ_is_equal $mom_feed_retract_value $lib_prev_feed_retract_value])  || \
			[LIB_SPF_get_pretreatment mom_operation_type -1] == "Hole Making"                                                  || \
			[LIB_SPF_get_pretreatment mom_operation_type -1] == "Point to Point"                                               || \
			[LIB_SPF_get_pretreatment mom_operation_type -1] == "Drilling"                                                     || \
			$check_cycle_definition_mode == 1))} {
			######
			# Calc percent if mom_feed_cut_value is over maximum
			if {[string range [string toupper $mom_feed_cut_unit] 0 1] == "MM" && $mom_output_unit != "MM"} {
				set mom_feed_rate [expr $mom_feed_cut_value/25.4]
			} elseif {[string range [string toupper $mom_feed_cut_unit] 0 1] != "MM" && $mom_output_unit != "IN"} {
				set mom_feed_rate [expr $mom_feed_cut_value * 25.4]
			} else {
				set mom_feed_rate $mom_feed_cut_value
			}
			if {[string match *PR* [string toupper $mom_feed_cut_unit]]} {
				set mom_feed_rate_per_rev $mom_feed_cut_value
				set mom_feed_rate [expr $mom_feed_cut_value * $::mom_spindle_rpm]
			}
			set mom_feed_rate_output_mode [string toupper $mom_feed_cut_unit]
			# PR10748690: parameter output should not exceed the max feed value in the post
			if {[info exists mom_feed_rate_output_mode] && ($mom_feed_rate_output_mode == "MMPM" || $mom_feed_rate_output_mode == "IPM")} {
				if {[info exists ::mom_kin_max_fpm] && $mom_feed_rate > $::mom_kin_max_fpm} {
					set ::lib_percent_feed_max [expr $::mom_kin_max_fpm / $mom_feed_rate]
				} else {
					set ::lib_percent_feed_max 1.0
				}
			} elseif {[info exists mom_feed_rate_output_mode] && ($mom_feed_rate_output_mode == "MMPR" || $mom_feed_rate_output_mode == "IPR")} {
				if {[info exists ::mom_kin_max_fpr] && $mom_feed_rate > $::mom_kin_max_fpr} {
					set ::lib_percent_feed_max [expr $::mom_kin_max_fpr / $mom_feed_rate]
				} else {
					set ::lib_percent_feed_max 1.0
				}
			}
			if {$::lib_percent_feed_max < 1 && [CONF_SPF_warning feed_over_max]} {
				LIB_SPF_add_warning [LIB_GE_MSG "Cut feedrate over max. limit. Reduce to max.limit. The ratio to the cut feed is retained for the other motion feedrates"]
			}

			MOM_force once F
			if {[CONF_CTRL_feed feed_engage] != "NX" && [CONF_CTRL_feed feed_engage] != "P_CUT"} {
				if {[string range [string toupper $mom_feed_engage_unit] 0 1] == "MM" && $mom_output_unit != "MM"} {
					set mom_feed_rate [expr $mom_feed_engage_value/25.4]
				} elseif {[string range [string toupper $mom_feed_engage_unit] 0 1] != "MM" && $mom_output_unit != "IN"} {
					set mom_feed_rate [expr $mom_feed_engage_value * 25.4]
				} else {
					set mom_feed_rate $mom_feed_engage_value
				}
				if {[string match *PR* [string toupper $mom_feed_engage_unit]]} {
					set mom_feed_rate_per_rev $mom_feed_engage_value
					set mom_feed_rate [expr $mom_feed_engage_value * $::mom_spindle_rpm]
				}
				set mom_feed_rate_output_mode [string toupper $mom_feed_engage_unit]
				set mom_motion_type "UNKNOWN"
				LIB_SPF_feedrate_set
				if {($mom_feed_rate_output_mode == "MMPM" || $mom_feed_rate_output_mode == "IPM")} {
					if {[EQ_is_gt $feed $::mom_kin_max_fpm]} {
						set ::lib_percent_feed_engage [expr $feed / $::mom_kin_max_fpm]
					} else {
						set ::lib_percent_feed_engage 1.0
					}
				}
				set feed [expr $feed * $::lib_percent_feed_max]
				if {[llength [info commands MOM_set_address_with_value]]} {
					MOM_set_address_with_value "F" $feed ; set feed [MOM_ask_address_value "F"]
				} else {
					set feed [LIB_SPF_eliminate_zero $feed 3]
				}
				LIB_GE_message "[CONF_CTRL_feed feed_engage] = $feed [CONF_GE_msg message_dspa1][LIB_GE_MSG "Engage Move"][CONF_GE_msg message_dspz1]" "output_0" "1"
			}
			
			if {$mom_operation_type == "Hole Making" || $mom_operation_type == "Point to Point" || (($mom_operation_type == "Drilling" || $mom_operation_type == "Thread Milling" || $mom_operation_type == "Cylinder Milling") && $::mom_cycle_definition_mode == 0)} {
				set mom_feed_rate $mom_feed_cut_value
				set mom_cycle_feed_rate $mom_feed_cut_value
				if {[string match *PR* [string toupper $mom_feed_cut_unit]]} {
					set mom_feed_rate_per_rev $mom_feed_cut_value
					set mom_cycle_feed_rate_per_rev $mom_feed_cut_value
					set mom_feed_rate [expr $mom_feed_cut_value * $::mom_spindle_rpm]
					set mom_cycle_feed_rate [expr $mom_feed_cut_value * $::mom_spindle_rpm]
				}
				set mom_feed_rate_output_mode [string toupper $mom_feed_cut_unit]
				set mom_cycle_feed_rate_mode [string toupper $mom_feed_cut_unit]
				set mom_motion_type "CYCLE"
				LIB_SPF_feedrate_set
				set feed [expr $feed * $::lib_percent_feed_max]
				if {[llength [info commands MOM_set_address_with_value]]} {
					MOM_set_address_with_value "F" $feed ; set feed [MOM_ask_address_value "F"]
				} else {
					set feed [LIB_SPF_eliminate_zero $feed 3]
				}
				if {[CONF_CTRL_feed feed_cycle] != "NX" && [CONF_CTRL_feed feed_cycle] != "P_CUT"} {
					LIB_GE_message "[CONF_CTRL_feed feed_cycle] = $feed [CONF_GE_msg message_dspa1][LIB_GE_MSG "Cycle Move"][CONF_GE_msg message_dspz1]" "output_0" "1"
				} elseif {[CONF_CTRL_feed feed_cycle] == "P_CUT"} {
					LIB_GE_message "[CONF_CTRL_feed feed_cut] = $feed [CONF_GE_msg message_dspa1][LIB_GE_MSG "Cutting"][CONF_GE_msg message_dspz1]" "output_0" "1"
				}
			} else {
				set mom_kin_is_turbo_output "FALSE"
				if {[CONF_CTRL_feed feed_cut] != "NX" && [CONF_CTRL_feed feed_cut] != "P_CUT"} {
					if {[string range [string toupper $mom_feed_cut_unit] 0 1] == "MM" && $mom_output_unit != "MM"} {
						set mom_feed_rate [expr $mom_feed_cut_value/25.4]
					} elseif {[string range [string toupper $mom_feed_cut_unit] 0 1] != "MM" && $mom_output_unit != "IN"} {
						set mom_feed_rate [expr $mom_feed_cut_value * 25.4]
					} else {
						set mom_feed_rate $mom_feed_cut_value
					}
					if {[string match *PR* [string toupper $mom_feed_cut_unit]]} {
						set mom_feed_rate_per_rev $mom_feed_cut_value
						set mom_feed_rate [expr $mom_feed_cut_value * $::mom_spindle_rpm]
					}
					set mom_feed_rate_output_mode [string toupper $mom_feed_cut_unit]
					LIB_SPF_feedrate_set
					set feed [expr $feed * $::lib_percent_feed_max]
					if {[llength [info commands MOM_set_address_with_value]]} {
						MOM_set_address_with_value "F" $feed ; set feed [MOM_ask_address_value "F"]
					} else {
						set feed [LIB_SPF_eliminate_zero $feed 3]
					}
					LIB_GE_message "[CONF_CTRL_feed feed_cut] = $feed [CONF_GE_msg message_dspa1][LIB_GE_MSG "Cutting"][CONF_GE_msg message_dspz1]" "output_0" "1"
				}
			}

			foreach type $::lib_motion_type_list {
				set type "[string tolower $type]"
				
				set exclude_list " engage cut undefined cycle from gohome gohome_default rapid"
				if {[string match "* $type*" $exclude_list] || ![CONF_CTRL_feed exists feed_$type] != 0} {continue}
				
				set feed_type $type
				regsub -all "firstcut" $feed_type "first_cut" feed_type
				regsub -all "lastcut" $feed_type "last_cut" feed_type
				global mom_feed_${feed_type}_unit mom_feed_${feed_type}_value mom_feed_${feed_type}_nominal_unit
				if {[info exists [subst [subst mom_feed_${feed_type}_unit]]] && ([CONF_CTRL_feed feed_$type] != "NX" && [CONF_CTRL_feed feed_$type] != "P_CUT")} {
					
					if {[info exists [subst [subst mom_feed_${feed_type}_nominal_unit]]]} {
						if {[string match -nocase "rapid" [subst $[subst mom_feed_${feed_type}_nominal_unit]]]} {
							if {[info exists mom_feed_rapid_output] && $mom_feed_rapid_output == 1} {
								if {![EQ_is_zero $mom_feed_rapid_value]} {
									set [subst [subst mom_feed_${feed_type}_value]] $mom_feed_rapid_value
								}
							}
						}
					}

					if {[string range [string toupper [subst $[subst mom_feed_${feed_type}_unit]]] 0 1] == "MM" && $mom_output_unit != "MM"} {
						set mom_feed_rate [expr [subst $[subst mom_feed_${feed_type}_value]]/25.4]
					} elseif {[string range [string toupper [subst $[subst mom_feed_${feed_type}_unit]]] 0 1] != "MM" && $mom_output_unit != "IN"} {
						set mom_feed_rate [expr [subst $[subst mom_feed_${feed_type}_value]] * 25.4]
					} else {
						set mom_feed_rate [subst $[subst mom_feed_${feed_type}_value]]
					}
					if {[string match *PR* [string toupper [subst $[subst mom_feed_${feed_type}_unit]]]]} {
						set mom_feed_rate_per_rev [subst $[subst mom_feed_${feed_type}_value]]
						set mom_feed_rate [expr [subst $[subst mom_feed_${feed_type}_value]] * $::mom_spindle_rpm]
					}
					set mom_feed_rate_output_mode [string toupper [subst $[subst mom_feed_${feed_type}_unit]]]
					set mom_motion_type "UNKNOWN"
					LIB_SPF_feedrate_set
					if {($mom_feed_rate_output_mode == "MMPM" || $mom_feed_rate_output_mode == "IPM")} {
						if {[EQ_is_gt $feed $::mom_kin_max_fpm]} {
							set [subst [subst ::lib_percent_feed_${feed_type}]] [expr $feed / $::mom_kin_max_fpm]
						} else {
							set [subst [subst ::lib_percent_feed_${feed_type}]] 1.0
						}
					}
					set feed [expr $feed * $::lib_percent_feed_max]
					if {![EQ_is_zero $feed]} {
						# PR10748690: parameter output should not exceed the max feed value in the post
						# this is done with setting the mom_sys_force_feedrate_limit_check to 1
						if {[llength [info commands MOM_set_address_with_value]]} {
							MOM_set_address_with_value "F" $feed ; set feed [MOM_ask_address_value "F"]
						} else {
							set feed [LIB_SPF_eliminate_zero $feed 3]
						}
						LIB_GE_message "[CONF_CTRL_feed feed_$type] = $feed [CONF_GE_msg message_dspa1][LIB_GE_MSG "[string toupper $type 0 0] Move"][CONF_GE_msg message_dspz1]" "output_0" "1"
					}
				}
			}

			set lib_prev_feed_cut_value $mom_feed_cut_value
			set lib_prev_feed_engage_value $mom_feed_engage_value
			set lib_prev_feed_retract_value $mom_feed_retract_value
		}
	}
}

#______________________________________________________________________________
# <Internal Documentation>
#
# Output the feed dependent on the setting
#	NX      normal feedrate output
#	P_CUT   feedrate output as percentage of Cut Feed
#	Param   feedrate output as Parameter (FQ21)
#
#
# <Internal Example>
#
#______________________________________________________________________________
proc LIB_CTRL_feed_output {} {


	global mom_motion_type mom_motion_event mom_feed_cut_value mom_feed_cut_unit mom_feed_rate mom_feed_rate_per_rev
	global mom_cycle_feed_rate mom_output_unit feed_mode
	global feed lib_prev_feed lib_prev_feed_percent
	global mom_feed_engage_value mom_feed_engage_unit
	global mom_feed_retract_value mom_feed_retract_unit

	set commandcheck(LIB_CTRL_feed_output_ENTRY) [llength [info commands LIB_CTRL_feed_output_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_feed_output_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_feed_output_ENTRY)} {LIB_CTRL_feed_output_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if {[CONF_CTRL_feed feed_linear] == 0} {
		# use only NX-Values
	} elseif {[CONF_CTRL_feed feed_linear] == 1} {
		# use FAUTO (Feed from Tool definition
	} elseif {[CONF_CTRL_feed feed_linear] == 2} {
		set tmp_motion_type [string tolower $mom_motion_type]

		if {[CONF_CTRL_feed feed_$tmp_motion_type] == "NX"} {
			if {[info exists mom_sys_feed_param(${feed_mode},format)]} {
				MOM_set_address_format F $mom_sys_feed_param(${feed_mode},format)
			} else {
				switch -- $feed_mode {
					IPM     -
					MMPM    -
					IPR     -
					MMPR    -
					DPM     -
					FRN     {
						MOM_set_address_format F Feed_${feed_mode}
						}
					INVERSE {MOM_set_address_format F Feed_INV}
				}
			}
			set lib_prev_feed $feed
		} elseif {[CONF_CTRL_feed feed_$tmp_motion_type] == "P_CUT"} {
			if {(![string match "rapid" $tmp_motion_type] && ![string match "traversal" $tmp_motion_type] && ![string match "approach" $tmp_motion_type] \
			&& ![string match "departure" $tmp_motion_type]) || $mom_feed_rate != $::mom_kin_rapid_feed_rate} {
				MOM_set_address_format F String
				regsub -all "firstcut" $tmp_motion_type "first_cut" tmp_motion_type
				regsub -all "lastcut" $tmp_motion_type "last_cut" tmp_motion_type
				if {![EQ_is_equal $feed $mom_feed_cut_value]} {
					if {[string range [string toupper $mom_feed_cut_unit] 0 1] == "MM" && $mom_output_unit != "MM"} {
						set tmp_feed_rate [expr $mom_feed_rate * 25.4]
						set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev * 25.4]
					} elseif {[string range [string toupper $mom_feed_cut_unit] 0 1] != "MM" && $mom_output_unit != "IN"} {
						set tmp_feed_rate [expr $mom_feed_rate / 25.4]
						set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev / 25.4]
					} else {
						set tmp_feed_rate $mom_feed_rate
						set tmp_feed_rate_per_rev $mom_feed_rate_per_rev
					}
					set tmp_reduce 0
					if {[subst $[subst ::mom_feed_${tmp_motion_type}_value]] > $::mom_kin_max_fpm} {set tmp_reduce 1}
					if {[string match *PR* [string toupper $mom_feed_cut_unit]]} {
						set tmp_feed_rate $tmp_feed_rate_per_rev
						if {[subst $[subst ::mom_feed_${tmp_motion_type}_value]] > $::mom_kin_max_fpr} {set tmp_reduce 1}
					}
					if {$tmp_reduce} {
						set tmp_feed_percent [expr ([subst $[subst ::mom_feed_${tmp_motion_type}_value]] / $mom_feed_cut_value)]
					} else {
						set tmp_feed_percent [expr ($tmp_feed_rate/$mom_feed_cut_value)]
					}
					set tmp_feed_percent [LIB_SPF_eliminate_zero $tmp_feed_percent 3]

					if {[info exist lib_prev_feed] && $feed  == $lib_prev_feed} {
						if {$tmp_motion_type == "cut"} {
							set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_cut][CONF_CTRL_feed param_feed_dspz1]"
						} else {
							if {![info exists lib_prev_feed_percent] || ![EQ_is_equal $lib_prev_feed_percent $tmp_feed_percent]} {
								MOM_force once F
							}
							set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_cut]*$tmp_feed_percent[CONF_CTRL_feed param_feed_dspz1]"
							set lib_prev_feed_percent $tmp_feed_percent
						}
					} else {
						if {![info exists lib_prev_feed_percent] || ![EQ_is_equal $lib_prev_feed_percent $tmp_feed_percent]} {
							MOM_force once F
						}
						set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_cut]*$tmp_feed_percent[CONF_CTRL_feed param_feed_dspz1]"
						set lib_prev_feed_percent $tmp_feed_percent
					}
				} else {
					set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_cut][CONF_CTRL_feed param_feed_dspz1]"
				}
			}
			set lib_prev_feed $feed
		} elseif {[CONF_CTRL_feed feed_$tmp_motion_type] == "MAX"} {
			MOM_set_address_format F String
			set feed [CONF_CTRL_feed feed_$tmp_motion_type]
		} else {
			MOM_set_address_format F String
			set tmp_feed $feed
			if {$tmp_motion_type == "cycle"} {
				set mom_cycle_feed_rate "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_$tmp_motion_type][CONF_CTRL_feed param_feed_dspz1]"
			}
			set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_$tmp_motion_type][CONF_CTRL_feed param_feed_dspz1]"
			if {$tmp_motion_type == "cut" && ![EQ_is_equal $mom_feed_rate [expr $mom_feed_cut_value * $::lib_percent_feed_max]] && ![EQ_is_zero $mom_feed_cut_value]} {
				if {[string range [string toupper $mom_feed_cut_unit] 0 1] == "MM" && $mom_output_unit != "MM"} {
					set tmp_feed_rate [expr $mom_feed_rate * 25.4]
					set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev * 25.4]
				} elseif {[string range [string toupper $mom_feed_cut_unit] 0 1] != "MM" && $mom_output_unit != "IN"} {
					set tmp_feed_rate [expr $mom_feed_rate / 25.4]
					set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev / 25.4]
				} else {
					set tmp_feed_rate $mom_feed_rate
					set tmp_feed_rate_per_rev $mom_feed_rate_per_rev
				}
				if {[string match *PR* [string toupper $mom_feed_cut_unit]]} {
					set tmp_feed_rate $tmp_feed_rate_per_rev
				}
				set tmp_feed_percent [expr ($tmp_feed_rate/($mom_feed_cut_value * $::lib_percent_feed_max))]
				set tmp_feed_percent [LIB_SPF_eliminate_zero $tmp_feed_percent 3]
				if {![info exists lib_prev_feed_percent] || ![EQ_is_equal $lib_prev_feed_percent $tmp_feed_percent]} {
					MOM_force once F
				}
				set lib_prev_feed_percent $tmp_feed_percent
				if {![EQ_is_equal $tmp_feed_percent 1.0]} {
					set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_$tmp_motion_type]*$tmp_feed_percent[CONF_CTRL_feed param_feed_dspz1]"
				}
			}

			# Workaraund to cover Rapid Engage and Retract if parametrric output is used
			if {$tmp_motion_type == "engage" && [string toupper $::mom_feed_engage_nominal_unit] == "RAPID"} {
				if {$mom_output_unit != "MM"} {
					set mom_feed_rate [expr $::mom_kin_rapid_feed_rate * 10]
					set mom_feed_engage_value [expr $::mom_kin_rapid_feed_rate * 10]
				} else {
					set mom_feed_rate $::mom_kin_rapid_feed_rate
					set mom_feed_engage_value $::mom_kin_rapid_feed_rate
				}
			}
			if {$tmp_motion_type == "retract" && [string toupper $::mom_feed_retract_nominal_unit] == "RAPID"} {
				if {$mom_output_unit != "MM"} {
					set mom_feed_rate [expr $::mom_kin_rapid_feed_rate * 10]
					set mom_feed_retract_value [expr $::mom_kin_rapid_feed_rate * 10]
				} else {
					set mom_feed_rate $::mom_kin_rapid_feed_rate
					set mom_feed_retract_value $::mom_kin_rapid_feed_rate
				}
			}
			
			if {$tmp_motion_type == "engage" && ![EQ_is_equal [expr $mom_feed_rate * $::lib_percent_feed_engage] $mom_feed_engage_value] && ![EQ_is_zero $mom_feed_engage_value]} { 
				if {[string range [string toupper $mom_feed_engage_unit] 0 1] == "MM" && $mom_output_unit != "MM"} {
					set tmp_feed_rate [expr $mom_feed_rate * 25.4]
					set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev * 25.4]
				} elseif {[string range [string toupper $mom_feed_engage_unit] 0 1] != "MM" && $mom_output_unit != "IN"} {
					set tmp_feed_rate [expr $mom_feed_rate / 25.4]
					set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev / 25.4]
				} else {
					set tmp_feed_rate $mom_feed_rate
					set tmp_feed_rate_per_rev $mom_feed_rate_per_rev
				}
				if {[string match *PR* [string toupper $mom_feed_engage_unit]]} {
					set tmp_feed_rate $tmp_feed_rate_per_rev
				}
				if {![info exists ::lib_percent_feed_engage] || $tmp_feed_rate <= $::mom_kin_max_fpm} {set $::lib_percent_feed_engage 1.0}
				set tmp_feed_percent [expr (($tmp_feed_rate * $::lib_percent_feed_engage) / ($mom_feed_engage_value * $::lib_percent_feed_max))]
				set tmp_feed_percent [LIB_SPF_eliminate_zero $tmp_feed_percent 3]
				if {![info exists lib_prev_feed_percent] || ![EQ_is_equal $lib_prev_feed_percent $tmp_feed_percent]} {
					MOM_force once F
				}
				set lib_prev_feed_percent $tmp_feed_percent
				if {![EQ_is_equal $tmp_feed_percent 1.0]} {
					set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_$tmp_motion_type]*$tmp_feed_percent[CONF_CTRL_feed param_feed_dspz1]"
				}
			}
			if {$tmp_motion_type == "retract" && ![EQ_is_equal [expr $mom_feed_rate * $::lib_percent_feed_retract] $mom_feed_retract_value] && ![EQ_is_zero $mom_feed_retract_value]} {
				if {[string range [string toupper $mom_feed_retract_unit] 0 1] == "MM" && $mom_output_unit != "MM"} {
					set tmp_feed_rate [expr $mom_feed_rate * 25.4]
					set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev * 25.4]
				} elseif {[string range [string toupper $mom_feed_retract_unit] 0 1] != "MM" && $mom_output_unit != "IN"} {
					set tmp_feed_rate [expr $mom_feed_rate / 25.4]
					set tmp_feed_rate_per_rev [expr $mom_feed_rate_per_rev / 25.4]
				} else {
					set tmp_feed_rate $mom_feed_rate
					set tmp_feed_rate_per_rev $mom_feed_rate_per_rev
				}
				if {[string match *PR* [string toupper $mom_feed_retract_unit]]} {
					set tmp_feed_rate $tmp_feed_rate_per_rev
				}
				if {![info exists ::lib_percent_feed_retract] || $tmp_feed_rate <= $::mom_kin_max_fpm} {set $::lib_percent_feed_retract 1.0}
				set tmp_feed_percent [expr (($tmp_feed_rate * $::lib_percent_feed_retract) / ($mom_feed_retract_value * $::lib_percent_feed_max))]
				set tmp_feed_percent [LIB_SPF_eliminate_zero $tmp_feed_percent 3]
				if {![info exists lib_prev_feed_percent] || ![EQ_is_equal $lib_prev_feed_percent $tmp_feed_percent]} {
					MOM_force once F
				}
				set lib_prev_feed_percent $tmp_feed_percent
				if {![EQ_is_equal $tmp_feed_percent 1.0]} {
					set feed "[CONF_CTRL_feed param_feed_dspa1][CONF_CTRL_feed feed_$tmp_motion_type]*$tmp_feed_percent[CONF_CTRL_feed param_feed_dspz1]"
				}
			}
			set lib_prev_feed $tmp_feed
		}

	} else {
		# use only NX-Values
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_feed_output_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_feed_output_ENTRY)} {LIB_CTRL_feed_output_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_cut_move_LIB {} {


	set commandcheck(LIB_CTRL_cut_move_LIB_ENTRY) [llength [info commands LIB_CTRL_cut_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_cut_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_cut_move_LIB_ENTRY)} {LIB_CTRL_cut_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_cut_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_cut_move_LIB_ENTRY)} {LIB_CTRL_cut_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_rapid_move_LIB {} {


	set commandcheck(LIB_CTRL_rapid_move_LIB_ENTRY) [llength [info commands LIB_CTRL_rapid_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_rapid_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_rapid_move_LIB_ENTRY)} {LIB_CTRL_rapid_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_rapid_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_rapid_move_LIB_ENTRY)} {LIB_CTRL_rapid_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_engage_move_LIB {} {


	set commandcheck(LIB_CTRL_engage_move_LIB_ENTRY) [llength [info commands LIB_CTRL_engage_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_engage_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_engage_move_LIB_ENTRY)} {LIB_CTRL_engage_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_engage_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_engage_move_LIB_ENTRY)} {LIB_CTRL_engage_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_retract_move_LIB {} {


	set commandcheck(LIB_CTRL_retract_move_LIB_ENTRY) [llength [info commands LIB_CTRL_retract_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_retract_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_retract_move_LIB_ENTRY)} {LIB_CTRL_retract_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_retract_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_retract_move_LIB_ENTRY)} {LIB_CTRL_retract_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_firstcut_move_LIB {} {


	set commandcheck(LIB_CTRL_firstcut_move_LIB_ENTRY) [llength [info commands LIB_CTRL_firstcut_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_firstcut_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_firstcut_move_LIB_ENTRY)} {LIB_CTRL_firstcut_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_firstcut_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_firstcut_move_LIB_ENTRY)} {LIB_CTRL_firstcut_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_approach_move_LIB {} {


	set commandcheck(LIB_CTRL_approach_move_LIB_ENTRY) [llength [info commands LIB_CTRL_approach_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_approach_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_approach_move_LIB_ENTRY)} {LIB_CTRL_approach_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_approach_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_approach_move_LIB_ENTRY)} {LIB_CTRL_approach_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_stepover_move_LIB {} {


	set commandcheck(LIB_CTRL_stepover_move_LIB_ENTRY) [llength [info commands LIB_CTRL_stepover_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_stepover_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_stepover_move_LIB_ENTRY)} {LIB_CTRL_stepover_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_stepover_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_stepover_move_LIB_ENTRY)} {LIB_CTRL_stepover_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_departure_move_LIB {} {


	set commandcheck(LIB_CTRL_departure_move_LIB_ENTRY) [llength [info commands LIB_CTRL_departure_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_departure_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_departure_move_LIB_ENTRY)} {LIB_CTRL_departure_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_departure_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_departure_move_LIB_ENTRY)} {LIB_CTRL_departure_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_return_move_LIB {} {


	set commandcheck(LIB_CTRL_return_move_LIB_ENTRY) [llength [info commands LIB_CTRL_return_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_return_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_return_move_LIB_ENTRY)} {LIB_CTRL_return_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_return_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_return_move_LIB_ENTRY)} {LIB_CTRL_return_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_traversal_move_LIB {} {


	set commandcheck(LIB_CTRL_traversal_move_LIB_ENTRY) [llength [info commands LIB_CTRL_traversal_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_traversal_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_traversal_move_LIB_ENTRY)} {LIB_CTRL_traversal_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_traversal_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_traversal_move_LIB_ENTRY)} {LIB_CTRL_traversal_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_sidecut_move_LIB {} {


	set commandcheck(LIB_CTRL_sidecut_move_LIB_ENTRY) [llength [info commands LIB_CTRL_sidecut_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_sidecut_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_sidecut_move_LIB_ENTRY)} {LIB_CTRL_sidecut_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_sidecut_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_sidecut_move_LIB_ENTRY)} {LIB_CTRL_sidecut_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_from_move_LIB {} {


	set commandcheck(LIB_CTRL_from_move_LIB_ENTRY) [llength [info commands LIB_CTRL_from_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_from_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_from_move_LIB_ENTRY)} {LIB_CTRL_from_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_from_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_from_move_LIB_ENTRY)} {LIB_CTRL_from_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_gohome_move_LIB {} {


	set commandcheck(LIB_CTRL_gohome_move_LIB_ENTRY) [llength [info commands LIB_CTRL_gohome_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_gohome_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_gohome_move_LIB_ENTRY)} {LIB_CTRL_gohome_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_gohome_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_gohome_move_LIB_ENTRY)} {LIB_CTRL_gohome_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_gohome_default_move_LIB {} {


	set commandcheck(LIB_CTRL_gohome_default_move_LIB_ENTRY) [llength [info commands LIB_CTRL_gohome_default_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_gohome_default_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_gohome_default_move_LIB_ENTRY)} {LIB_CTRL_gohome_default_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_gohome_default_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_gohome_default_move_LIB_ENTRY)} {LIB_CTRL_gohome_default_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_cycle_move_LIB {} {


	set commandcheck(LIB_CTRL_cycle_move_LIB_ENTRY) [llength [info commands LIB_CTRL_cycle_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_cycle_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_cycle_move_LIB_ENTRY)} {LIB_CTRL_cycle_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_cycle_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_cycle_move_LIB_ENTRY)} {LIB_CTRL_cycle_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_lift_move_LIB {} {


	set commandcheck(LIB_CTRL_lift_move_LIB_ENTRY) [llength [info commands LIB_CTRL_lift_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_lift_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_lift_move_LIB_ENTRY)} {LIB_CTRL_lift_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_lift_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_lift_move_LIB_ENTRY)} {LIB_CTRL_lift_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function correspond from the first PB integration and should not be used.
# From founders of legacy this can not be deleted.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_undefined_move_LIB {} {


	set commandcheck(LIB_CTRL_undefined_move_LIB_ENTRY) [llength [info commands LIB_CTRL_undefined_move_LIB_ENTRY]]

	LIB_GE_command_buffer LIB_CTRL_undefined_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_undefined_move_LIB_ENTRY)} {LIB_CTRL_undefined_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer LIB_CTRL_undefined_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(LIB_CTRL_undefined_move_LIB_ENTRY)} {LIB_CTRL_undefined_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Used when [CONF_CTRL_moves standard_path_between_rotary_motions] == 1 for internal tool path
# Set right rotary position when lib_flag(mode_current_status) changes
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_standard_path_between_rotary_motions_checking {{option default}} {


	global mom_out_angle_pos mom_kin_5th_axis_min_limit mom_kin_5th_axis_max_limit
	global prev_convert_mom_out_angle_pos mom_prev_pos mom_prev_out_angle_pos mom_pos

	switch -- $option {
		"pos_to_sim"	{
			# motion POS to SIM

			if {[info exists prev_convert_mom_out_angle_pos]} {
				# prev_convert_mom_out_angle_pos calculated with 5_axis_dual_head kinematics
				set mom_prev_pos(3) $prev_convert_mom_out_angle_pos(1)

			} else {
				set mom_prev_pos(3) 0

			}

			MOM_reload_variable -a mom_prev_pos

		}
		"pos_to_sim_next"	{
			# motion POS to SIM

			if {[info exists prev_convert_mom_out_angle_pos]} {
				set mom_pos(3) $prev_convert_mom_out_angle_pos(0)
			} else {
				set mom_pos(3) 0
			}

			MOM_reload_variable -a mom_pos

		}
		"sim_to_pos" {
			# motion SIM to POS
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This procedure is called at each start_of_path and machine_mode events.
# It's implemented for multi chains. Content of [CONF_SPF_advanced_settings chain_init] is executed
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_config_millturn {} {


	if {[CONF_SPF_advanced_settings chain_init] != "0"} {
		LIB_CONF_do_prop_custom_proc CONF_SPF_advanced_settings chain_init
		LIB_GE_copy_var_range lib_sav_sys_leader mom_sys_leader
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# Can be used to update mom_sys variables dependent on properties settings.
# This proc is called by LIB_SPF_default_initial_setting "default"
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_version_mom_sys {} {
	global mom_sys_feed_rate_mode_code mom_sys_spindle_max_rpm_code mom_sys_output_code mom_sys_cycle_ret_code
	global mom_sys_lathe_thread_advance_type

}

#____________________________________________________________________________________________
# <Internal Documentation>
# It's used to output polar code with axial mode when [CONF_CTRL_moves polar_transmit] property is set to 1
# This proc is called by LIB_SPF_polar_cart
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_polar_transmit {{mess "on"}} {
	global mom_motion_event mom_motion_type mom_prev_pos mom_pos mom_machine_mode
	global mom_sys_leader mom_sys_rapid_code
	global polar_mode_status lib_flag
	global polar_save_sys_leader lib_ge_active_chain

	if {$mom_machine_mode == "TURN" || [string match "point*" [LIB_SPF_ask_operation_type]] || [string match "probe*" [LIB_SPF_ask_operation_type]]} {return}

	if {[CONF_CTRL_moves polar_transmit] == "ON"} {
		if {$mess == "on"} {
			if {$lib_flag(first_transmit_move) == 0} {
				set polar_mode_status "ON"
				set lib_flag(first_transmit_move) 1 ;# first motion is not recalculated in polar mode anymore
			}
		} elseif {$mess == "start" && [info exists polar_mode_status] && $polar_mode_status == "ON"} {
			LIB_GE_command_buffer POLAR_MODE
			LIB_GE_command_buffer {
				set mom_pos([expr 3+$lib_flag(polar_rotary_axis)]) 0.0
				set mom_prev_pos([expr 3+$lib_flag(polar_rotary_axis)]) 0.0
				MOM_reload_variable -a mom_prev_pos
				MOM_reload_variable -a mom_pos

				if {[CONF_CTRL_moves prepos_before_transmit] == "5th" || [CONF_CTRL_moves prepos_before_transmit] == "5th_Z_X"} {
					if {$lib_flag(polar_rotary_axis) == 0} {
						set lib_flag(save_clamp_fourth_axis_setting) [CONF_CTRL_clamp fourth_axis]
						if {[CONF_CTRL_clamp fourth_axis] == 1} {
							MOM_do_template unclamp_fourth_axis
							MOM_do_template fourth_axis_rotate_move
							CONF_CTRL_clamp set fourth_axis 0
						} else {
							MOM_do_template fourth_axis_rotate_move
						}
					} else {
						set lib_flag(save_clamp_fifth_axis_setting) [CONF_CTRL_clamp fifth_axis]
						if {[CONF_CTRL_clamp fifth_axis] == 1} {
							MOM_do_template unclamp_fifth_axis
							MOM_do_template fifth_axis_rotate_move
							CONF_CTRL_clamp set fifth_axis 0
						} else {
							MOM_do_template fifth_axis_rotate_move
						}
					}
					if {[CONF_CTRL_moves prepos_before_transmit] == "5th_Z_X"} {
						LIB_SPF_decompose_block_template "{Z} {X}" prepos_transmit FORCE [join "{Z} {X}"]
					}
				} elseif {[CONF_CTRL_moves prepos_before_transmit] != ""} {
					LIB_CONF_do_prop_custom_proc CONF_CTRL_moves prepos_before_transmit "short_template_syntax"
				}

				set polar_save_sys_leader(Y) $mom_sys_leader(Y)
				
				if {$lib_flag(polar_rotary_axis) == 0} {
					set mom_sys_leader(Y) $mom_sys_leader(fourth_axis)
				} else {
					set mom_sys_leader(Y) $mom_sys_leader(fifth_axis)
				}
				
				LIB_GE_chain_set_global_var $lib_ge_active_chain mom_sys_leader(Y) $mom_sys_leader(Y)
				
				if {$mom_motion_event == "rapid_move"} {set mom_motion_event "linear_move"}

				set lib_flag(save_rapid_template)  [CONF_CTRL_moves rapid_template]
				CONF_CTRL_moves set rapid_template [CONF_CTRL_moves linear_template]

				set lib_flag(save_rapid_template_turbo)  [CONF_Turbo_Templates rapid_template_turbo]
				CONF_Turbo_Templates set rapid_template_turbo [CONF_Turbo_Templates linear_template_turbo]

				set mom_sys_rapid_code 1 ;# advanced turbo mode
			} @OUTPUT_ROTARY_AXIS

			LIB_GE_command_buffer {
				MOM_do_template polar_mode
			} @OUTPUT
			LIB_GE_command_buffer_output

			set lib_flag(first_transmit_move) 1
			if {$::lib_machine_mode == "3_AXIS_MILL_TURN"} {MOM_enable_address Y}
		}
	}

	if {$mess == "off" && [info exists lib_flag(first_transmit_move)] && $lib_flag(first_transmit_move) == 1} {
		set polar_mode_status "OFF"

		LIB_GE_command_buffer TRAFOFF
		LIB_GE_command_buffer {
			MOM_do_template polar_mode

			set mom_sys_leader(Y) $polar_save_sys_leader(Y)
			
			LIB_GE_chain_set_global_var $lib_ge_active_chain mom_sys_leader(Y) $mom_sys_leader(Y)

			if {$lib_flag(polar_rotary_axis) == 0} {
				MOM_force once fourth_axis
				if {[info exists lib_flag(save_clamp_fourth_axis_setting)]} {CONF_CTRL_clamp set fourth_axis $lib_flag(save_clamp_fourth_axis_setting)}
			} else {
				MOM_force once fifth_axis
				if {[info exists lib_flag(save_clamp_fifth_axis_setting)]} {CONF_CTRL_clamp set fifth_axis $lib_flag(save_clamp_fifth_axis_setting)}
			}
			#PR9261330 check if exists lib_flag(save_rapid_template)
			if {[info exists lib_flag(save_rapid_template)]} {
				CONF_CTRL_moves set rapid_template $lib_flag(save_rapid_template)
				set mom_sys_rapid_code 0 ;# advanced turbo mode
				unset lib_flag(save_rapid_template)
			}

			if {[info exists lib_flag(save_rapid_template_turbo)]} {
				CONF_Turbo_Templates set rapid_template_turbo $lib_flag(save_rapid_template_turbo)
				unset lib_flag(save_rapid_template_turbo)
			}
		} @OUTPUT
		LIB_GE_command_buffer_output

		set lib_flag(first_transmit_move) 0
		if {$::lib_machine_mode == "3_AXIS_MILL_TURN"} {MOM_disable_address Y}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_lathe_thread_LIB {} {

	set commandcheck(MOM_lathe_thread_LIB_ENTRY) [llength [info commands MOM_lathe_thread_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_lathe_thread_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_lathe_thread_LIB_ENTRY)} {MOM_lathe_thread_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------



	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_lathe_thread_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_lathe_thread_LIB_ENTRY)} {MOM_lathe_thread_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_start_of_thread_LIB {} {

	set commandcheck(MOM_start_of_thread_LIB_ENTRY) [llength [info commands MOM_start_of_thread_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_start_of_thread_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_thread_LIB_ENTRY)} {MOM_start_of_thread_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global lib_flag

	set lib_flag(lathe_thread_motion) 1

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_start_of_thread_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_thread_LIB_ENTRY)} {MOM_start_of_thread_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_lathe_thread_move_LIB {} {


	global mom_prev_pos mom_pos mom_lathe_thread_lead_i mom_lathe_thread_lead_k
	global thread_type

	set commandcheck(MOM_lathe_thread_move_LIB_ENTRY) [llength [info commands MOM_lathe_thread_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_lathe_thread_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_lathe_thread_move_LIB_ENTRY)} {MOM_lathe_thread_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	if { [EQ_is_zero $mom_lathe_thread_lead_i] } {
		MOM_suppress once I ; MOM_force once K
	} elseif { [EQ_is_zero $mom_lathe_thread_lead_k] } {
		MOM_suppress once K ; MOM_force once I
	} else {
		MOM_force once I ; MOM_force once K
	}

	LIB_GE_command_buffer OUTPUT
	LIB_GE_command_buffer { MOM_do_template lathe_thread_move } @MOVE
	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_lathe_thread_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_lathe_thread_move_LIB_ENTRY)} {MOM_lathe_thread_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM-Event and controls the handling of the controller
#
# The function should not be overwritten, this can be controlled with the standard mechnismen
# as described in the documentations. Changes will lead to an undesirable behavior.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc MOM_end_of_thread_LIB {} {

	set commandcheck(MOM_end_of_thread_LIB_ENTRY) [llength [info commands MOM_end_of_thread_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_end_of_thread_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_thread_LIB_ENTRY)} {MOM_end_of_thread_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global lib_flag

	set lib_flag(lathe_thread_motion) 0

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_end_of_thread_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_thread_LIB_ENTRY)} {MOM_end_of_thread_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_start_of_program event
#
# Specially useful for multichannels machine to reset addresses at the beginning of for each channel
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_channel_init {} {


	LIB_GE_command_buffer LIB_CTRL_channel_init
	LIB_GE_command_buffer {MOM_do_template channel_init CREATE} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_start_of_path event
#
# Helpful to redefine mom_sys_leader variables overwritten by the original ones with the normal run
# This procedure should be redefined in service layer
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_CTRL_sys_leader_home {} {
	#this proc is only here for documentation purposes.
	#the real proc should be created in service layer
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_start_of_subop_path.
#
# <Internal Example>
#____________________________________________________________________________________________
proc MOM_start_of_subop_path_LIB {} {
#@.pce@

	set commandcheck(MOM_start_of_subop_path_LIB_ENTRY) [llength [info commands MOM_start_of_subop_path_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_start_of_subop_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_subop_path_LIB_ENTRY)} {MOM_start_of_subop_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global lib_flag mom_operation_is_interop mom_subop_is_intraop lib_ge_transition_axis_mode

	# Generic motion without transition path doesn't have transition axis mode
	if {([info exists mom_operation_is_interop] && $mom_operation_is_interop == 1)} {
		LIB_SPF_get_transition_axis_mode
		# TCP mode could be continuous in several subops
		if {$lib_flag(mode_current_status) == "sim" && $lib_ge_transition_axis_mode != "SIMULTANEOUS"} {
			LIB_SPF_transition_axis_mode_reset
			set lib_flag(tool_path_motion) 0
		}
	} elseif {[info exists mom_subop_is_intraop] && $mom_subop_is_intraop == 1} {
		LIB_SPF_get_transition_axis_mode
		LIB_SPF_transition_axis_mode_reset
		set lib_flag(tool_path_motion) 0
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_start_of_subop_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_subop_path_LIB_ENTRY)} {MOM_start_of_subop_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_end_of_subop_path.
#
# <Internal Example>
#____________________________________________________________________________________________
proc MOM_end_of_subop_path_LIB {} {
#@.pce@

	set commandcheck(MOM_end_of_subop_path_LIB_ENTRY) [llength [info commands MOM_end_of_subop_path_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_end_of_subop_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_subop_path_LIB_ENTRY)} {MOM_end_of_subop_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global lib_flag mom_operation_is_interop mom_subop_is_intraop lib_ge_transition_axis_mode

	# Generic motion without transition path doesn't have transition axis mode
	if {[info exists mom_operation_is_interop] && $mom_operation_is_interop == 1} {
		# POSITIONING axis mode should be available only for one subop
		if {$lib_ge_transition_axis_mode == "POSITIONING"} {
			LIB_SPF_transition_axis_mode_reset
			set lib_flag(tool_path_motion) 0
		}
	} elseif {[info exists mom_subop_is_intraop] && $mom_subop_is_intraop == 0} {
		# Reset axis mode for every subop in intraop to avoid affecting cycle events
		LIB_SPF_transition_axis_mode_reset
		set lib_flag(tool_path_motion) 0
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_end_of_subop_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_subop_path_LIB_ENTRY)} {MOM_end_of_subop_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_start_of_transition_path.
#
# <Internal Example>
#____________________________________________________________________________________________
proc MOM_start_of_transition_path_lib {} {
#@.pce@

	set commandcheck(MOM_start_of_transition_path_LIB_ENTRY) [llength [info commands MOM_start_of_transition_path_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_start_of_transition_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_transition_path_LIB_ENTRY)} {MOM_start_of_transition_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global mom_path_name lib_pretreatment mom_interop_has_tool_change

   	if {$mom_interop_has_tool_change ==0 && [lsearch -exact $lib_pretreatment(operation_list) $mom_path_name] == 0} {
      	MOM_first_tool_LIB
   	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_start_of_transition_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_start_of_transition_path_LIB_ENTRY)} {MOM_start_of_transition_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_end_of_transition_path.
#
# <Internal Example>
#____________________________________________________________________________________________
proc MOM_end_of_transition_path_lib {} {
#@.pce@

	set commandcheck(MOM_end_of_transition_path_LIB_ENTRY) [llength [info commands MOM_end_of_transition_path_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_end_of_transition_path_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_transition_path_LIB_ENTRY)} {MOM_end_of_transition_path_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------


	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_end_of_transition_path_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_end_of_transition_path_LIB_ENTRY)} {MOM_end_of_transition_path_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_transition_rapid_move.
#
# <Internal Example>
#____________________________________________________________________________________________
proc MOM_transition_rapid_move_LIB {} {
#@.pce@

	set commandcheck(MOM_transition_rapid_move_LIB_ENTRY) [llength [info commands MOM_transition_rapid_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_transition_rapid_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_transition_rapid_move_LIB_ENTRY)} {MOM_transition_rapid_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global lib_ge_transition_axis_mode mom_out_angle_pos mom_pos mom_kin_4th_axis_leader mom_kin_5th_axis_leader mom_move_type

	LIB_GE_command_buffer TRANSITION_RAPID_MOVE
	if {$lib_ge_transition_axis_mode == "SIMULTANEOUS"} {
		LIB_GE_command_buffer {
			MOM_force once X Y Z
			MOM_do_template rapid_move
		} @TRANSITION_SIMULTANEOUS_MOVE
	} elseif {$lib_ge_transition_axis_mode == "POSITIONING"} {
		LIB_GE_command_buffer {
			MOM_force once X Y Z
			MOM_do_template rapid_move
		} @TRANSITION_POSITIONING_MOVE
	} else {
		# Set value of output axis
		set 4th [string tolower $mom_kin_4th_axis_leader]
		set 5th [string tolower $mom_kin_5th_axis_leader]
		set ::mom_transition_${4th}_axis $mom_out_angle_pos(0)
		set ::mom_transition_${5th}_axis $mom_out_angle_pos(1)
		set ::mom_transition_x_axis $mom_pos(0)
		set ::mom_transition_y_axis $mom_pos(1)
		set ::mom_transition_z_axis $mom_pos(2)

		# Set output axis
		set output_status 0
		# For machine limit move subop (mom_move_type = 23), the tool moves along previous or next tool axis vector
		if {[info exists mom_move_type] && $mom_move_type == 23} {
			MOM_force once G_zero
			foreach axis {x y z} {
				MOM_force once [string toupper $axis]_AXIS
			}
			set output_status 1
		} else {
			foreach axis {x y z a b c} {
				if {[set ::mom_move_output_$axis] == 0} {
					MOM_suppress once [string toupper $axis]_AXIS
				} else {
					MOM_force once [string toupper $axis]_AXIS
					set output_status 1
				}
			}
		}

		# Output rapid motion
		if {$output_status == 1 } {
			LIB_GE_command_buffer {
				MOM_force once H
				MOM_do_template transition_rapid_move
			} @TRANSITION_RAPID_MOVE
		}
	}
	LIB_GE_command_buffer_output

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_transition_rapid_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_transition_rapid_move_LIB_ENTRY)} {MOM_transition_rapid_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from MOM_machine_axis_move.
# mom_xaxis_status 1 - have a user defined axis value: machine limit or specify
#                  0 - not active
#
# <Internal Example>
#____________________________________________________________________________________________
proc MOM_machine_axis_move_LIB {} {
#@.pce@

	set commandcheck(MOM_machine_axis_move_LIB_ENTRY) [llength [info commands MOM_machine_axis_move_LIB_ENTRY]]

	LIB_GE_command_buffer MOM_machine_axis_move_LIB_ENTRY_start
	LIB_GE_command_buffer {if {$commandcheck(MOM_machine_axis_move_LIB_ENTRY)} {MOM_machine_axis_move_LIB_ENTRY start}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
	#---------------------------------------------------------------------------------

	global mom_interop_has_tool_change mom_move_type mom_sys_home_pos

	if {[info exists mom_interop_has_tool_change] && $mom_interop_has_tool_change == 1 && $mom_move_type == 810} {
		# Override home position to match transition path if current subop outputs tool change position
		set mom_sys_home_pos(0) $::mom_xaxis_value
		set mom_sys_home_pos(1) $::mom_yaxis_value
		set mom_sys_home_pos(2) $::mom_zaxis_value

		set 4th [string tolower $::mom_kin_4th_axis_leader]
		set 5th [string tolower $::mom_kin_5th_axis_leader]
		set mom_sys_home_pos(3) [set ::mom_${4th}axis_value]
		set mom_sys_home_pos(4) [set ::mom_${5th}axis_value]
		
		MOM_force once G_return
	} else {
		foreach axis {x y z a b c} {
			if {[set ::mom_move_output_$axis] == 0} {
				MOM_suppress Once [string toupper $axis]_AXIS
			} else {
				MOM_force Once [string toupper $axis]_AXIS
			}
		}

		LIB_GE_command_buffer MACHINE_AXIS_MOVE
		LIB_GE_command_buffer {
			MOM_force once G_return
			MOM_do_template machine_axis_move
		} @MACHINE_AXIS_MOVE
		LIB_GE_command_buffer_output
	}

	#---------------------------------------------------------------------------------
	LIB_GE_command_buffer MOM_machine_axis_move_LIB_ENTRY_end
	LIB_GE_command_buffer {if {$commandcheck(MOM_machine_axis_move_LIB_ENTRY)} {MOM_machine_axis_move_LIB_ENTRY end}} @DEFAULT_ENTRY
	LIB_GE_command_buffer_output
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is used to set fourth and fifth axis angles output value according to user option.
# It is called from LIB_ROTARY_positioning_init.
#
# <Internal Example>
#____________________________________________________________________________________________
proc LIB_CTRL_set_3P2_rotate_dir {} {


	global mom_kin_machine_type mom_sys_leader
	global mom_init_pos mom_init_alt_pos mom_pos mom_alt_pos mom_out_angle_pos mom_prev_out_angle_pos
	global mom_kin_4th_axis_direction mom_kin_4th_axis_leader mom_kin_4th_axis_min_limit mom_kin_4th_axis_max_limit
	global mom_kin_5th_axis_direction mom_kin_5th_axis_leader mom_kin_5th_axis_min_limit mom_kin_5th_axis_max_limit
	global mom_operation_is_interop plane_init_pos lib_flag

	# for simultaneous operation, if enabling prepositioning tool, forbid fourth and fifth axis rotation direction setting
	if {[LIB_SPF_get_pretreatment axis_mode] == "SIMULTANEOUS" && [CONF_SPF_sim_kin tcpm_prepos_plane] == 1} {
		return
	}

	# Don't reselect solution if transition path exists
	if {[info exists mom_operation_is_interop] && $mom_operation_is_interop == 0} {
		return
	}

	set rotate_dir [CONF_TEMPLATE_3P2 rotate_dir]
	if {[info exists lib_flag(preferred_solution)] && $lib_flag(preferred_solution) != "OFF"} {
		if {[CONF_TEMPLATE_3P2 rotate_dir] == "-" || [CONF_TEMPLATE_3P2 rotate_dir] == "+"} {
			LIB_SPF_add_warning "Set Preferred Solution is using, 3D rotate direction set to Auto"
			set rotate_dir 0
		}
	}

	if {[LIB_SPF_csys_examine_local] == "rotation"} {
		if {![string compare "5_axis_dual_head" $mom_kin_machine_type]} {
			set master_axis 4
		} else {
			set master_axis 3
		}

		if {$lib_flag(local_namespace_output) == 1} {
			set mom_init_pos(3) 0
			set mom_init_pos(4) 0
		} else {
			set plane_init_pos(3) [LIB_SPF_rotset $plane_init_pos(3) $mom_prev_out_angle_pos(0) $mom_kin_4th_axis_direction \
			$mom_kin_4th_axis_leader mom_sys_leader(fourth_axis) \
			$mom_kin_4th_axis_min_limit $mom_kin_4th_axis_max_limit]

			set plane_init_pos(4) [LIB_SPF_rotset $plane_init_pos(4) $mom_prev_out_angle_pos(1) $mom_kin_5th_axis_direction \
			$mom_kin_5th_axis_leader mom_sys_leader(fifth_axis) \
			$mom_kin_5th_axis_min_limit $mom_kin_5th_axis_max_limit]

			if {($rotate_dir == "-" && [EQ_is_gt $plane_init_pos($master_axis) 0.0]) || \
			($rotate_dir == "+" && [EQ_is_lt $plane_init_pos($master_axis) 0.0])} {

				set mom_init_pos(3) [LIB_SPF_rotset $mom_init_alt_pos(3) $mom_prev_out_angle_pos(0) $mom_kin_4th_axis_direction \
				$mom_kin_4th_axis_leader mom_sys_leader(fourth_axis) \
				$mom_kin_4th_axis_min_limit $mom_kin_4th_axis_max_limit]

				set mom_init_pos(4) [LIB_SPF_rotset $mom_init_alt_pos(4) $mom_prev_out_angle_pos(1) $mom_kin_5th_axis_direction \
				$mom_kin_5th_axis_leader mom_sys_leader(fifth_axis) \
				$mom_kin_5th_axis_min_limit $mom_kin_5th_axis_max_limit]
			} else {
				# If user defines a local coordinate system, $mom_init_pos won't be zero and may excess angle limit.
				set mom_init_pos(3) [LIB_SPF_rotset $mom_init_pos(3) $mom_prev_out_angle_pos(0) $mom_kin_4th_axis_direction \
				$mom_kin_4th_axis_leader mom_sys_leader(fourth_axis) \
				$mom_kin_4th_axis_min_limit $mom_kin_4th_axis_max_limit]

				set mom_init_pos(4) [LIB_SPF_rotset $mom_init_pos(4) $mom_prev_out_angle_pos(1) $mom_kin_5th_axis_direction \
				$mom_kin_5th_axis_leader mom_sys_leader(fifth_axis) \
				$mom_kin_5th_axis_min_limit $mom_kin_5th_axis_max_limit]
			}
		}

	} else {
		if {![string compare "5_axis_dual_head" $mom_kin_machine_type]} {
			set master_axis 1
		} else {
			set master_axis 0
		}
		if {($rotate_dir == "-" && [EQ_is_gt $mom_out_angle_pos($master_axis) 0.0]) || \
		($rotate_dir == "+" && [EQ_is_lt $mom_out_angle_pos($master_axis) 0.0])} {

			set mom_out_angle_pos(0) [LIB_SPF_rotset $mom_alt_pos(3) $mom_prev_out_angle_pos(0) $mom_kin_4th_axis_direction \
			$mom_kin_4th_axis_leader mom_sys_leader(fourth_axis) \
			$mom_kin_4th_axis_min_limit $mom_kin_4th_axis_max_limit]

			set mom_out_angle_pos(1) [LIB_SPF_rotset $mom_alt_pos(4) $mom_prev_out_angle_pos(1) $mom_kin_5th_axis_direction \
			$mom_kin_5th_axis_leader mom_sys_leader(fifth_axis) \
			$mom_kin_5th_axis_min_limit $mom_kin_5th_axis_max_limit]
		}
	}

}

#____________________________________________________________________________________________
# <Documentation>
# Output the BLK Form /WORKPIECE lines
#
#____________________________________________________________________________________________
proc LIB_start_of_program_blk_form {} {

	global mom_blk_point_1  mom_blk_point_2 lib_blk_point_1 lib_blk_point_2
	global lib_blank_cylinder_vector lib_blank_cylinder_center lib_blank_cylinder_height lib_blank_cylinder_diameter
	global mom_sys_control_out mom_sys_control_in
	
	LIB_GE_command_buffer BLK_form 

	LIB_GE_command_buffer {
		
		LIB_GE_message " " output_0
		LIB_GE_message " You can define your blank material output with following command " 
		LIB_GE_message " LIB_GE_command_edit_replace LIB_start_of_program_blk_form BLK_form @Output \{ " 
		LIB_GE_message "        Custom procedures " 
		LIB_GE_message " \} customBlankOutput " 
		LIB_GE_message " " output_0
		LIB_GE_message " Use following variables " 
		LIB_GE_message "  lib_blk_point_1(0) = [format %.2f $lib_blk_point_1(0)] -- Smallest X value " 
		LIB_GE_message "  lib_blk_point_1(1) = [format %.2f $lib_blk_point_1(1)] -- Smallest Y value " 
		LIB_GE_message "  lib_blk_point_1(2) = [format %.2f $lib_blk_point_1(2)] -- Smallest Z value " 
		LIB_GE_message "  lib_blk_point_2(0) = [format %.2f $lib_blk_point_2(0)] -- Largest X value " 
		LIB_GE_message "  lib_blk_point_2(1) = [format %.2f $lib_blk_point_2(1)] -- Largest Y value " 
		LIB_GE_message "  lib_blk_point_2(2) = [format %.2f $lib_blk_point_2(2)] -- Largest Z value " 
		LIB_GE_message "   or when blank is defined as a Cylinder in ZM direction " 
		LIB_GE_message "  lib_blank_cylinder_vector   -- Vector of cylinder axis " 
		LIB_GE_message "  lib_blank_cylinder_center   -- Distance from MCS to cylinder center " 
		LIB_GE_message "  lib_blank_cylinder_height   -- Cylinder height " 
		LIB_GE_message "  lib_blank_cylinder_diameter -- Cylinder diameter " 
		LIB_GE_message " " output_0

#		set zero 0; set one 1
#		VEC3_init one zero zero V0; VEC3_init zero one zero V1; VEC3_init zero zero one V2
#		if {[info exists lib_blank_cylinder_center(0)] && ([VEC3_is_parallel lib_blank_cylinder_vector V2]) \
#			 && ([VEC3_is_parallel lib_blank_cylinder_center lib_blank_cylinder_vector] || [VEC3_is_zero lib_blank_cylinder_center])} {
#			MOM_output_literal "WORKPIECE(,,,\"CYLINDER\",0,[format %.2f [expr $lib_blank_cylinder_center(2) - $lib_blank_cylinder_height/2]],[format %.2f $lib_blank_cylinder_height],\
#			[format %.2f $lib_blank_cylinder_diameter])"
#		} else {
#			MOM_output_literal "WORKPIECE(,,,\"BOX\",0,[format %.2f $lib_blk_point_1(2)],[format %.2f [expr $lib_blk_point_2(2) - $lib_blk_point_1(2)]],[format %.2f [expr $lib_blk_point_2(2) - $lib_blk_point_1(2)]],\
#			[format %.2f $lib_blk_point_1(0)],[format %.2f $lib_blk_point_1(1)],\
#			[format %.2f [expr $lib_blk_point_2(0) - $lib_blk_point_1(0)]],\
#			[format %.2f [expr $lib_blk_point_2(1) - $lib_blk_point_1(1)]])"
#		}
	} @Output
	
	LIB_GE_command_buffer_output

}

#____________________________________________________________________________________________
# <Internal Documentation>
#	This proc outputs the initial status in the start of the NC-Program
#
#
# <Internal Example>
#____________________________________________________________________________________________
proc LIB_CTRL_set_initial_status { } {
	
	set ::lib_sav_kin_machine_type [LIB_PT_get_header_var lib_sav_kin_machine_type]
	
# Set machine mode to MILL
	LIB_GE_command_buffer MACHINE_MODE
	LIB_GE_command_buffer {
		if {[CONF_CTRL_initial machine_mode]} {	
			#insert your code here	
		}
	} @OUTPUT
	LIB_GE_command_buffer_output
	
# Reset PLANE
	LIB_GE_command_buffer RESET_PLANE
	LIB_GE_command_buffer {
		if {[CONF_CTRL_initial reset_plane]} {	
			#insert your code here	
		}
	} @OUTPUT
	LIB_GE_command_buffer_output
	
# Reset TCPM mode
	LIB_GE_command_buffer RESET_TCPM
	LIB_GE_command_buffer {
		if {[CONF_CTRL_initial reset_tcpm]} {	
			#insert your code here	
		}
	} @OUTPUT
	LIB_GE_command_buffer_output
	
# Output fixture offset (G54...)
	LIB_GE_command_buffer FIXTURE_OFFSET
	LIB_GE_command_buffer {
		if {[CONF_CTRL_initial fixture_offset]} {
			#insert your code here	
		}
	} @OUTPUT
	LIB_GE_command_buffer_output
		
}

#____________________________________________________________________________________________
#<Internal Documentation>
# 
# Cooling time procedure
#
# This proc is called in MOM_path_region_marker_end
# <Example>
#___________________________________________________________________________________________
#------------------------------------------------------------
proc LIB_CTRL_Cooling_Time {} {
#------------------------------------------------------------
	global mom_delay_value

	if {[CONF_CTRL_additive_Coolant_Time  Additive_coolant_time_bool] == 0} {return}

	if {[info exists ::mom_delay_value] && $::mom_delay_value > 0} {
	
		LIB_GE_command_buffer ADDITIVE_DEPOSITION_STATE
		LIB_GE_command_buffer {
								if { [info exists ::mom_deposition_state] && $::mom_deposition_state == [CONF_CTRL_additive ADDITIVE_deposition_on] } {
									set ::mom_deposition_state [CONF_CTRL_additive ADDITIVE_deposition_off]
									MOM_do_template [CONF_CTRL_additive ADDITIVE_deposition_template]
								} 
							} @Additive_Deposition_State
		LIB_GE_command_buffer_output

		LIB_GE_command_buffer COOLANT_TIME_STANDARD
		LIB_GE_command_buffer {
								MOM_force Once G 
								MOM_do_template [CONF_CTRL_additive_Coolant_Time Additive_coolant_time_template]
							} @Coolant_Time_Standard
		LIB_GE_command_buffer_output
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# Custom proc for advanced turbo callback
#____________________________________________________________________________________________
CONF_CTRL_additive set ADDITIVE_advanced_turbo_callback [LIB_CONF_prop_custom_proc_body \
{# Advanced Turbo is always set for additive operations considering performance
# This callback is a replacement for non-turbo before_motion customization
	MOM_set_adv_turbo_callback -observer mom_motion_type { 
	if {$::mom_motion_type == "CUT" || $::mom_motion_type == "FIRSTCUT"} {
		set ::lib_output_motion_type "DEPOSITION"
	} else {
		set ::lib_output_motion_type $::mom_motion_type
	}
	MOM_do_template motion_type_message
}}]

#____________________________________________________________________________________________
# <Internal Documentation>
# Get MCS info
#
# <Internal Example>
#
#____________________________________________________________________________________________
CONF_SPF_file set ctrl_ini_get_mcs_info [LIB_CONF_prop_custom_proc_body \
{
	global mom_sys_tool_list_output_type
	global isv_ini_mcs_info
	global mom_kin_output_unit
	global mom_part_unit mom_output_unit
	global mom_operation_name_list
	global mom_mcs_info lib_spf
	global ini_file_channel_number

	catch {MOM_ask_mcs_info}
	# Convert mom_mcs_info if the rigth unit as outputed
	if {![string match $mom_output_unit $mom_part_unit]} {
		LIB_SPF_convert_unit INIT ",part"
	}

	# Get fixture MCS list and Main MCS
	set fixture_list [list]
	foreach mcs $lib_mcs_info(mcs_list) {
		if {$mom_mcs_info($mcs,parent) == "" && $mom_mcs_info($mcs,purpose)==0} {
			MOM_output_to_listing_device "No Main MCS defined in CAM setup!"
		}

		while {$mcs != "" && $mom_mcs_info($mcs,parent) != "" && $mom_mcs_info($mcs,purpose)==0 && $mom_mcs_info($mom_mcs_info($mcs,parent),purpose)!=1} {
			set mcs $mom_mcs_info($mcs,parent)
		}

		if {$mcs == ""} {
			MOM_output_to_listing_device "No Main MCS defined in CAM setup!"
		} elseif {$mom_mcs_info($mcs,purpose)==1} {
			set main_mcs $mcs
		} else {
			if {[llength $fixture_list]==0} {
				lappend fixture_list $mcs
			} else {
				set flag 0
				foreach fixture $fixture_list {
					if {[string match $fixture $mcs]} {set flag 1}
				}
				if {$flag ==0} {
					lappend fixture_list $mcs
				}
			}
			set main_mcs $mom_mcs_info($mcs,parent)
		}
	}

	set isv_ini_mcs_info(0) ""
	set isv_ini_mcs_info(1) ""
	set isv_ini_mcs_info(2) ""
	if {[info exists ini_file_channel_number] && $ini_file_channel_number == 2} {
		append isv_ini_mcs_info(1) "G10 L2 P0 X0.0 Y0.0 Z0.0\n"
		append isv_ini_mcs_info(2) "G10 L2 P0 X0.0 Y0.0 Z0.0\n"
	} else {
		append isv_ini_mcs_info(0) "G10 L2 P0 X0.0 Y0.0 Z0.0\n"
	}
	if {$main_mcs == ""} {return}

	foreach mcs $fixture_list {
		#Convert offset from ABS to MAIN MCS
		set x_matrix [expr $mom_mcs_info($mcs,org,0) - $mom_mcs_info($main_mcs,org,0)]
		set y_matrix [expr $mom_mcs_info($mcs,org,1) - $mom_mcs_info($main_mcs,org,1)]
		set z_matrix [expr $mom_mcs_info($mcs,org,2) - $mom_mcs_info($main_mcs,org,2)]
		set temp_x_offset [expr $x_matrix*$mom_mcs_info($main_mcs,xvec,0) + $y_matrix*$mom_mcs_info($main_mcs,xvec,1) + $z_matrix*$mom_mcs_info($main_mcs,xvec,2)]
		set temp_y_offset [expr $x_matrix*$mom_mcs_info($main_mcs,yvec,0) + $y_matrix*$mom_mcs_info($main_mcs,yvec,1) + $z_matrix*$mom_mcs_info($main_mcs,yvec,2)]
		set temp_z_offset [expr $x_matrix*$mom_mcs_info($main_mcs,zvec,0) + $y_matrix*$mom_mcs_info($main_mcs,zvec,1) + $z_matrix*$mom_mcs_info($main_mcs,zvec,2)]
		set temp_x_offset [format "%-.2f" [LIB_SPF_convert_unit $temp_x_offset "" [CONF_SPF_file output_unit_to_ini]]]
		set temp_y_offset [format "%-.2f" [LIB_SPF_convert_unit $temp_y_offset "" [CONF_SPF_file output_unit_to_ini]]]
		set temp_z_offset [format "%-.2f" [LIB_SPF_convert_unit $temp_z_offset "" [CONF_SPF_file output_unit_to_ini]]]

		if {![info exists mom_mcs_info($mcs,offset_val)]} {set mom_mcs_info($mcs,offset_val) 0.0}

		if {[info exists ini_file_channel_number] && $ini_file_channel_number == 2} {
			append isv_ini_mcs_info(1) "G10 L2 P$mom_mcs_info($mcs,offset_val) X$temp_x_offset Y$temp_y_offset Z$temp_z_offset\n"
			append isv_ini_mcs_info(2) "G10 L2 P$mom_mcs_info($mcs,offset_val) X$temp_x_offset Y$temp_y_offset Z$temp_z_offset\n"
		} else {
			append isv_ini_mcs_info(0) "G10 L2 P$mom_mcs_info($mcs,offset_val) X$temp_x_offset Y$temp_y_offset Z$temp_z_offset\n"
		}
	}
}
]

#____________________________________________________________________________________________
# <Internal Documentation>
# Get tool info
#
# <Internal Example>
#
#____________________________________________________________________________________________
CONF_SPF_file set ctrl_ini_get_tool_info [LIB_CONF_prop_custom_proc_body \
{
	global mom_isv_tool_count
	global mom_isv_tool_name
	global mom_isv_tool_type
	global mom_isv_tool_number
	global mom_isv_tool_carrier_id
	global mom_isv_tool_type
	global mom_isv_tool_flute_length
	global mom_isv_tool_x_correction
	global mom_isv_tool_y_correction
	global mom_isv_tool_z_correction
	global mom_isv_tool_r_correction
	global mom_isv_tool_carrier_name
	global mom_isv_tool_pocket_id
	global mom_isv_tool_diameter
	global mom_isv_tool_nose_radius
	global mom_isv_tool_corner1_radius
	global mom_isv_tool_adjust_register
	global mom_isv_tracking_point_count
	global isv_ini_tool_info
	global isv_ini_tool_count
	global mom_isv_tool_channel_id
	global mom_isv_tool_p_number
	global mom_multi_channel_mode
	global mom_output_unit mom_part_unit
	global mom_isv_tool_device_name
	global mom_isv_tool_adjust_reg_toggle
	global mom_ug_version
	global ini_file_channel_number
	global lib_spf
	global mom_number_of_runs mom_run_number
	global mom_isv_tool_track_point_name mom_operation_info mom_operation_name_list

	set isv_ini_tool_count(0) 0
	set isv_ini_tool_count(1) 0
	set isv_ini_tool_count(2) 0

	set isv_ini_tool_info(0) [list]
	set isv_ini_tool_info(1) [list]
	set isv_ini_tool_info(2) [list]

	set tool_data_list [list]
	set tool_number_list [list]

	# Don't output duplicated tool data
	# Don't output data with tool number/register number is zero
	# Last tool tracking point of milling and drilling tool comes from tool tab.
	# revised warning message.

	for {set i 0} {$i<$mom_isv_tool_count} {incr i} {
		set tool_tp_list($i) [list]
		set tool_tp_number_list [list]

		# check if there are duplicated tool number data and zero number
		if {$mom_isv_tool_number($i) == 0 || [lsearch $tool_number_list $mom_isv_tool_number($i)] >=0} {
			if {$mom_isv_tool_number($i) == 0} {
				LIB_SPF_add_warning "Tool INS->$mom_isv_tool_name($i)<- has tool number zero! Its info is not output into to_ini.ini file."
			} else {
				LIB_SPF_add_warning "Tool INS->$mom_isv_tool_name($i)<- has tool number INS->$mom_isv_tool_number($i)<- duplicated with other tool! Its info is not output into to_in.ini file."
			}
		} else {
			# check if there are duplicated tool adjust register number or zero number for tracking point

			if {[info exists lib_spf(nx_version)] && $lib_spf(nx_version) >= 903 && ( [string match "Milling" $mom_isv_tool_type($i)] ||[string match "Drilling" $mom_isv_tool_type($i)])} {
				set tracking_point_count($i) [expr $mom_isv_tracking_point_count($i) -1]
			} else {
				set tracking_point_count($i) $mom_isv_tracking_point_count($i)
			}
			set tool_opr_name($i) [list]
			foreach opr_name $mom_operation_name_list {
				if {[llength [info commands MOM_ask_oper_info]] && ![info exists mom_operation_info($opr_name,tool_name)]} {
					MOM_ask_oper_info mom_operation_name_list
				}
				if {[info exists mom_operation_info($opr_name,tool_name)] && [string match $mom_operation_info($opr_name,tool_name) $mom_isv_tool_name($i)]} {
					lappend tool_opr_name($i) $opr_name
				}
			}
			foreach operName $tool_opr_name($i) {
				if {[info exists mom_operation_info($operName,tracking_point_name)]} {
					for {set k 0} {$k < $tracking_point_count($i)} {incr k} {
						if {[string match $mom_isv_tool_track_point_name($i,$k) $mom_operation_info($operName,tracking_point_name)] } {
							lappend tool_tp_number_list $mom_isv_tool_adjust_register($i,$k)
							lappend tool_tp_list($i) $k
							break
						}
					}
				}
			}
			set tracking_point_flag 0
			for {set j 0} {$j<$tracking_point_count($i)} {incr j} {
				# As tracking point for operation has got in advance, skip the same one in list to avoid warning message.
				if { [lsearch $tool_tp_list($i) $j] >=0 } {
					continue
				}
				if {$mom_isv_tool_adjust_register($i,$j) == 0 || [lsearch $tool_tp_number_list $mom_isv_tool_adjust_register($i,$j)] >=0} {
					if {$mom_isv_tool_adjust_register($i,$j) == 0} {
						if {![info exists mom_isv_tool_adjust_reg_toggle($i,$j)] || $mom_isv_tool_adjust_reg_toggle($i,$j) == 1} {
							set tracking_point_flag 1
						}
					} else {
						LIB_SPF_add_warning "Tool INS->$mom_isv_tool_name($i)<- adjust register number INS->$mom_isv_tool_adjust_register($i,$j)<- is duplicated!"
						LIB_SPF_add_warning "The tracking point's data is not output into to_ini.ini file!"
					}
				} else {
					lappend tool_tp_number_list $mom_isv_tool_adjust_register($i,$j)
					lappend tool_tp_list($i) $j
				}
			}
			if {[string match "Milling" $mom_isv_tool_type($i)] ||[string match "Drilling" $mom_isv_tool_type($i)]} {
				if {$mom_isv_tool_adjust_register($i,$tracking_point_count($i)) !=0 && [lsearch $tool_tp_number_list $mom_isv_tool_adjust_register($i,$tracking_point_count($i))] <0} {
					lappend tool_tp_number_list $mom_isv_tool_adjust_register($i,$tracking_point_count($i))
					lappend tool_tp_list($i) $tracking_point_count($i)
				}
			}
			if {[llength $tool_tp_list($i)] == 0} {
				set tracking_point_flag 2
			} else {
				lappend tool_number_list $mom_isv_tool_number($i)
				lappend tool_data_list $i
			}

			if {$tracking_point_flag == 1} {
				LIB_SPF_add_warning "Tool INS->$mom_isv_tool_name($i)<- has tracking points with adjust register number as zero."
				LIB_SPF_add_warning "These tracking points are not output into to_ini.ini file! Adjust register from tool tab will be output."
			} elseif {$tracking_point_flag == 2} {
				LIB_SPF_add_warning "Tool INS->$mom_isv_tool_name($i)<- is not output into to_ini.ini file because all adjust registers are zero!"
			}
		}
	}

	foreach i $tool_data_list {
		set tool_info ""
		append tool_info "\$TC_TP1\[$mom_isv_tool_number($i)\]=$mom_isv_tool_number($i)\n"
		append tool_info "\$TC_TP2\[$mom_isv_tool_number($i)\]=\"$mom_isv_tool_name($i)\"\n"
		append tool_info "\$TC_TP8\[$mom_isv_tool_number($i)\]=10\n"

		if {$mom_isv_tracking_point_count($i)==0} {set mom_isv_tracking_point_count($i) 1}

		foreach j $tool_tp_list($i) {
			if {![info exists mom_isv_tool_adjust_register($i,$j)]} {set mom_isv_tool_adjust_register($i,$j) 1}
			append tool_info "\$TC_DP1\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=[LIB_SPF_ini_map_tool_type $i]\n"
			if {([string match "Milling" $mom_isv_tool_type($i)] ||[string match "Drilling" $mom_isv_tool_type($i)]) && \
			[info exists mom_isv_tool_flute_length($i)]} {
				set temp [format "%-.4f" [LIB_SPF_convert_unit $mom_isv_tool_flute_length($i) "" [CONF_SPF_file output_unit_to_ini]]]
				append tool_info "\$TC_DP2\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$temp\n"
			} elseif {[info exists mom_isv_tool_p_number($i,$j)]} {
				append tool_info "\$TC_DP2\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$mom_isv_tool_p_number($i,$j)\n"
			}
			if {[info exists mom_isv_tool_x_correction($i,$j)]} {
				set temp [format "%-.4f" [LIB_SPF_convert_unit $mom_isv_tool_x_correction($i,$j) "" [CONF_SPF_file output_unit_to_ini]]]
				append tool_info "\$TC_DP3\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$temp\n"
			}
			if {[info exists mom_isv_tool_y_correction($i,$j)]} {
				set temp [format "%-.4f" [LIB_SPF_convert_unit $mom_isv_tool_y_correction($i,$j) "" [CONF_SPF_file output_unit_to_ini]]]
				append tool_info "\$TC_DP4\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$temp\n"
			}
			if {[info exists mom_isv_tool_z_correction($i,$j)]} {
				set temp [format "%-.4f" [LIB_SPF_convert_unit $mom_isv_tool_z_correction($i,$j) "" [CONF_SPF_file output_unit_to_ini]]]
				append tool_info "\$TC_DP5\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$temp\n"
			}
			if {([string match "Milling" $mom_isv_tool_type($i)] ||[string match "Drilling" $mom_isv_tool_type($i)]) && \
			[info exists mom_isv_tool_r_correction($i,$j)]} {
				set temp [format "%-.4f" [LIB_SPF_convert_unit $mom_isv_tool_r_correction($i,$j) "" [CONF_SPF_file output_unit_to_ini]]]
				append tool_info "\$TC_DP6\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$temp\n"
			} elseif {[info exists mom_isv_tool_nose_radius($i)]} {
				set temp [format "%-.4f" [LIB_SPF_convert_unit $mom_isv_tool_nose_radius($i) "" [CONF_SPF_file output_unit_to_ini]]]
				append tool_info "\$TC_DP6\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$temp\n"
			}
			if {[info exists mom_isv_tool_corner1_radius($i)]} {
				set temp [format "%-.4f" [LIB_SPF_convert_unit $mom_isv_tool_corner1_radius($i) "" [CONF_SPF_file output_unit_to_ini]]]
				append tool_info "\$TC_DP7\[$mom_isv_tool_number($i),$mom_isv_tool_adjust_register($i,$j)\]=$temp\n"
			}
		}

		if {![info exists mom_isv_tool_pocket_id($i)] || [string length [string trim $mom_isv_tool_pocket_id($i)]] == 0 || \
		$mom_isv_tool_pocket_id($i) == "n/a"} {
			append tool_info "\$TC_MPP6\[1,1\]=$mom_isv_tool_number($i)\n\n\n"
		} else {
			append tool_info "\$TC_MPP6\[1,$mom_isv_tool_pocket_id($i)\]=$mom_isv_tool_number($i)\n\n\n"
		}
		if {$mom_isv_tool_channel_id($i) == 1} {
			append isv_ini_tool_info(1) $tool_info
			incr isv_ini_tool_count(1)
		} elseif {$mom_isv_tool_channel_id($i) == 2} {
			append isv_ini_tool_info(2) $tool_info
			incr isv_ini_tool_count(2)
		} else {
			append isv_ini_tool_info(0) $tool_info
			incr isv_ini_tool_count(0)
		}
	}

	if {[info exists mom_number_of_runs] && [info exists mom_run_number]} {
		set ini_file_channel_numbers $mom_number_of_runs
	} else {
		set ini_file_channel_numbers 1
	}

	if {![info exists mom_multi_channel_mode]} {
		set ini_file_channel_number 1
		if {$isv_ini_tool_count(2) > 0 || $isv_ini_tool_count(1) > 0} {
			set ini_file_channel_number 2
		}
	} else {
		set ini_file_channel_number $ini_file_channel_numbers
	}
}
]

proc @CONTAINER@_M_and_G_commands_TEMPLATE {} {

	LIB_GE_CREATE_obj CONF_GCode_SettingTemplate {GLOBAL_LINK_CONTAINER} {
		LIB_GE_property_ui_name        "G-Commands settings"
		LIB_GE_property_ui_tooltip     "Tooltip"

		#G-Group 1 properties
		set id mom_sys_polar_mode(ON)
		set $id \$::mom_sys_polar_mode(ON)
		set options($id)        {VALUE}
		set datatype($id)       "INT"
		set access($id)         222
		set dialog($id)         {{Polar Coord (ON)}}
		set descr($id)          {{Polar coordinate interpolation mode.}}
		set ui_parent($id)      "@CUI_G1_commands_group"
		set ui_sequence($id)    100

		#G-Group 1 properties
		set id mom_sys_polar_mode(OFF)
		set $id \$::mom_sys_polar_mode(OFF)
		set options($id)        {VALUE}
		set datatype($id)       "INT"
		set access($id)         222
		set dialog($id)         {{Polar Coord (OFF)}}
		set descr($id)          {{Polar coordinate interpolation mode cancel.}}
		set ui_parent($id)      "@CUI_G1_commands_group"
		set ui_sequence($id)    101
	}

	LIB_GE_CREATE_obj CONF_MCode_SettingTemplate {GLOBAL_LINK_CONTAINER} {
		LIB_GE_property_ui_name        "M-Commands settings"
		LIB_GE_property_ui_tooltip     "Tooltip"

		set id mom_sys_tap_rigid_code
		set $id \$::mom_sys_tap_rigid_code
		set options($id)        {*VALUE*}
		set datatype($id)       "INT"
		set access($id)         222
		set dialog($id)         {{Tap Rigid Mode}}
		set descr($id)          {"Cycle Tap rigid mode.\nglobal variable: mom_sys_tap_rigid_code"}
		set ui_parent($id)      "@CUI_M_codes_group"
		set ui_sequence($id)    -1
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from LIB_SPF_KINEMATICS_current_setting.
#
#____________________________________________________________________________________________
proc LIB_CTRL_check_absolute_output {} {

	# #PR9239197 Fix. Add get pretreatment of UDE lock axis. To handle the case: with Lock Axis defined. In PC settings,
	# option "Plane Output Supported" is set to "All" and "Set Polar Mode also for Linear Motions" set to "off",
	# lock axis may not work.
	# MFEC-28425: refactory the lock_axis
	# in this case we just put the code here because we don't need to set the plane_output_supported to NO_ORTHOGONAL before
	# otherwise it makes confused why we set and reset after that
	# when there is locked axis, directly set kinematics to absolute output mode
	set lib_flag(axis_locked) [LIB_SPF_get_pretreatment mom_lock_axis]
	if {($lib_flag(axis_locked) == "XAXIS" || $lib_flag(axis_locked) == "YAXIS" || $lib_flag(axis_locked) == "ZAXIS") && [CONF_CTRL_moves polar_allowed_moves] == "ALL"} {
		set lock_status 1
	}
	
	set commandcheck(CONF_CTRL_setting) [llength [info commands CONF_CTRL_setting]]
	
	if {$commandcheck(CONF_CTRL_setting) && ([CONF_CTRL_setting plane_output_supported] == "NO_ORTHOGONAL" || ([info exists lock_status] && $lock_status ==1))} {
			if {[LIB_SPF_get_pretreatment csys_is_offset] == 1} {
				if {[LIB_SPF_get_pretreatment axis_orthogonal_4th] == "TRUE" && [LIB_SPF_get_pretreatment axis_orthogonal_5th] == "TRUE"} {
					return 1
				} elseif {[CONF_SPF_plane_kin 5th_abs_move_for_orthogonal] == 1 && [LIB_SPF_get_pretreatment axis_orthogonal_4th] == "TRUE"} {
					return 1
				} else {
					return 0
				}
			} else {
				return 0
			}
	} elseif {($commandcheck(CONF_CTRL_setting) && [CONF_CTRL_setting plane_output_supported] == "NONE") || $::lib_flag(tool_axis_zm) == 1} {
		return 1
	} else {
		return 0
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
# This function is called from LIB_SPF_polar_cart.
# This function will check whether local namespace on should be used with polar motion
# 
#____________________________________________________________________________________________
proc LIB_CTRL_polar_with_local_csys {} {

	if {[CONF_CTRL_moves enable_polar_with_plane] == "OFF"} {
		return 0
	} else {
		return 1
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# This procedure is used to reset plane output type within rotary angle mode. 
# It is called by LIB_CSYS_plane_output_init when user specified rotation order can not work with rotary angle mode.
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_CTRL_reset_csys_3d_rot_order {} {
#@.pce@

	global lib_coord_ang_A lib_coord_ang_B lib_coord_ang_C
	global lib_coord_ang_1 lib_coord_ang_2 lib_coord_ang_3
	global mom_kin_4th_axis_vector mom_kin_5th_axis_vector

	if {[CONF_CTRL_setting lib_3d_rot_method] != "ROTARY_ANGLE"} {return}

	set fourth_axis_standard 0
	set fifth_axis_standard  0

	for {set i 0} {$i < 3} {incr i} {
		if {[EQ_is_equal [expr abs($mom_kin_4th_axis_vector($i))] 1.0]} {
			set fourth_axis_standard 1

            if {$i == 0} {
                set fourth_axis_dir "X"
            } elseif {$i == 1} {
                set fourth_axis_dir "Y"
            } elseif {$i == 2} {
                set fourth_axis_dir "Z"
            }
		}

		if {[EQ_is_equal [expr abs($mom_kin_5th_axis_vector($i))] 1.0]} {
			set fifth_axis_standard 1

            if {$i == 0} {
                set fifth_axis_dir "X"
            } elseif {$i == 1} {
                set fifth_axis_dir "Y"
            } elseif {$i == 2} {
                set fifth_axis_dir "Z"
            }
		}
	}

	if {$fourth_axis_standard == 0 || $fifth_axis_standard == 0} {return}

    set angle_mode ""
	if {![EQ_is_zero $lib_coord_ang_A] && ![EQ_is_zero $lib_coord_ang_B]} {
		if {[CONF_TEMPLATE_3P2 rot_mode] == "spatial"} {
			set angle_mode "*X*Y*"
		} else {
			set angle_mode "*Y*X*"
		}
	} elseif {![EQ_is_zero $lib_coord_ang_A] && ![EQ_is_zero $lib_coord_ang_C]} {
		if {[CONF_TEMPLATE_3P2 rot_mode] == "spatial"} {
			set angle_mode "*X*Z*"
		} else {
			set angle_mode "*Z*X*"
		}
	} elseif {![EQ_is_zero $lib_coord_ang_B] && ![EQ_is_zero $lib_coord_ang_C]} {
		if {[CONF_TEMPLATE_3P2 rot_mode] == "spatial"} {
			set angle_mode "*Y*Z*"
		} else {
			set angle_mode "*Z*Y*"
		}
	} elseif {![EQ_is_zero $lib_coord_ang_A]} {
		set angle_mode "*X*"
	} elseif {![EQ_is_zero $lib_coord_ang_B]} {
		set angle_mode "*Y*"
	} elseif {![EQ_is_zero $lib_coord_ang_C]} {
		set angle_mode "*Z*"
	}

    if {$angle_mode == ""} {return}

	lappend rot_order_list "XYZ" "XZY" "YXZ" "YZX" "ZXY" "ZYX" "XYX" "XZX" "YXY" "YZY" "ZXZ" "ZYZ"

	foreach rot_order $rot_order_list {
		if {[string match $angle_mode $rot_order]} {
			lappend valid_axis_orders $rot_order
		}
	}

	if {[lsearch $valid_axis_orders [CONF_TEMPLATE_3P2 rot_order]] < 0} {
		CONF_TEMPLATE_3P2 set rot_order [lindex $valid_axis_orders 0]
        
		LIB_SPF_add_warning "The specified rotation order can not work with rotary angle method. The rotation order will change to INS->[CONF_TEMPLATE_3P2 rot_order]<-"
	}

    set angle_mode [CONF_TEMPLATE_3P2 rot_order]

    if {[string range $angle_mode 0 0] == [string range $angle_mode 2 2]} {
        if {[string range $angle_mode 0 0] == $fourth_axis_dir} {
            if {[CONF_TEMPLATE_3P2 rot_mode] == "spatial"} {
                set angle_mode [string replace $angle_mode 2 2 "*"]
            } else {
                set angle_mode [string replace $angle_mode 0 0 "*"]
            }
        } elseif {[string range $angle_mode 0 0] == $fifth_axis_dir} {
            if {[CONF_TEMPLATE_3P2 rot_mode] == "spatial"} {
                set angle_mode [string replace $angle_mode 0 0 "*"]
            } else {
                set angle_mode [string replace $angle_mode 2 2 "*"]
            }
        }
    }

    set lib_coord_ang_1 0.0
	set lib_coord_ang_2 0.0
	set lib_coord_ang_3 0.0

    for {set ii 0} {$ii < 3} {incr ii} {
		if {[string range $angle_mode $ii $ii] == "X"} {
			set [subst [subst lib_coord_ang_[expr $ii+1]]] $lib_coord_ang_A
		} elseif {[string range $angle_mode $ii $ii] == "Y"} {
			set [subst [subst lib_coord_ang_[expr $ii+1]]] $lib_coord_ang_B
		} elseif {[string range $angle_mode $ii $ii] == "Z"} {
			set [subst [subst lib_coord_ang_[expr $ii+1]]] $lib_coord_ang_C
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Event handler of MOM_NC_start_of_program
#____________________________________________________________________________________________
proc MOM_NC_start_of_program {} {
#@.pce@
	global mom_o_buffer mom_event_name
	global mom_axes_range_min mom_axes_range_max
	global mom_sys_control_in mom_sys_control_out

	if {[info exists mom_axes_range_min] && [info exists mom_axes_range_max]} {
		if {[string match "*Smallest X*" $mom_o_buffer]} {
			set mom_o_buffer "$mom_sys_control_out  lib_blk_point_1(0) = [format %.2f $mom_axes_range_min(0)] -- Smallest X value $mom_sys_control_in"
		} elseif {[string match "*Smallest Y*" $mom_o_buffer]} {
			set mom_o_buffer "$mom_sys_control_out  lib_blk_point_1(1) = [format %.2f $mom_axes_range_min(1)] -- Smallest Y value $mom_sys_control_in"
		} elseif {[string match "*Smallest Z*" $mom_o_buffer]} {
			set mom_o_buffer "$mom_sys_control_out  lib_blk_point_1(2) = [format %.2f $mom_axes_range_min(2)] -- Smallest Z value $mom_sys_control_in"
		} elseif {[string match "*Largest X*" $mom_o_buffer]} {
			set mom_o_buffer "$mom_sys_control_out  lib_blk_point_2(0) = [format %.2f $mom_axes_range_max(0)] -- Largest X value $mom_sys_control_in"
		} elseif {[string match "*Largest Y*" $mom_o_buffer]} {
			set mom_o_buffer "$mom_sys_control_out  lib_blk_point_2(1) = [format %.2f $mom_axes_range_max(1)] -- Largest Y value $mom_sys_control_in"
		} elseif {[string match "*Largest Z*" $mom_o_buffer]} {
			set mom_o_buffer "$mom_sys_control_out  lib_blk_point_2(2) = [format %.2f $mom_axes_range_max(2)] -- Largest Z value $mom_sys_control_in"
		}
	}
}

#############################################################################################
#>>PRODUCT_KEY_CH: CTRL_TEMPLATE_BASE PP
#>>PRODUCT_KEY_DE: CTRL_TEMPLATE_BASE PP
#>>PRODUCT_KEY_FR: CTRL_TEMPLATE_BASE PP
#>>PRODUCT_KEY_IT: CTRL_TEMPLATE_BASE PP
#>>PRODUCT_KEY_A:  CTRL_TEMPLATE_BASE PP
