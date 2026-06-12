#####################################################################
#    P O S T _ T O O L _ L I S T _ H T M L _ A 4 . T C L
#####################################################################
# Список инструментов в HTML: оформление под печать на A4.
# Укажите этот пост в template_post.dat вместо post_tool_list_html.tcl
######################################################################

set mom_source_directory [MOM_ask_env_var UGII_CAM_SHOP_DOC_DIR]
source "${mom_source_directory}shopdoc_header.tcl"

proc ShopDoc_Header_html { } {
  global mom_output_file_basename
  set doc_title $mom_output_file_basename
  if {$doc_title == ""} { set doc_title "&#1057;&#1087;&#1080;&#1089;&#1086;&#1082; &#1080;&#1085;&#1089;&#1090;&#1088;&#1091;&#1084;&#1077;&#1085;&#1090;&#1086;&#1074;" }
  MOM_output_literal "<!DOCTYPE html>"
  MOM_output_literal "<HTML lang=\"ru\">"
  MOM_output_literal "<HEAD>"
  MOM_output_literal "<META charset=\"utf-8\">"
  MOM_output_literal "<META name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
  MOM_output_literal "<TITLE>$doc_title</TITLE>"
  MOM_output_literal "<STYLE>"
  MOM_output_literal "  @page { size: A4; margin: 10mm; }"
  MOM_output_literal "  * { box-sizing: border-box; }"
  MOM_output_literal "  body { font-family: 'Segoe UI', Arial, sans-serif; font-size: 9pt; line-height: 1.2; color: #000; margin: 0; padding: 0; background: #fff; }"
  MOM_output_literal "  .a4-frame { width: 210mm; min-height: 297mm; margin: 10px auto; padding: 12mm; background: #fff; border: 1px solid #000; }"
  MOM_output_literal "  .doc-header { text-align: center; margin-bottom: 8px; }"
  MOM_output_literal "  .doc-title { font-size: 14pt; font-weight: 700; color: #000; margin: 0; }"
  MOM_output_literal "  .section-title { font-size: 11pt; font-weight: 600; color: #000; margin: 8px 0 4px 0; padding: 4px 0; border-bottom: 1px solid #000; }"
  MOM_output_literal "  table.tool-list { width: 100%; border-collapse: collapse; font-size: 9pt; margin-bottom: 8px; }"
  MOM_output_literal "  table.tool-list th { background: #000; color: #fff; padding: 4px 6px; text-align: center; font-weight: 600; border: 1px solid #000; }"
  MOM_output_literal "  table.tool-list td { padding: 3px 6px; border: 1px solid #000; text-align: center; color: #000; }"
  MOM_output_literal "  table.tool-list tr:nth-child(even) { background: #f0f0f0; }"
  MOM_output_literal "  .info-table { width: 100%; border-collapse: collapse; font-size: 9pt; margin-bottom: 8px; }"
  MOM_output_literal "  .info-table th { text-align: left; padding: 4px 8px; color: #000; font-weight: 600; }"
  MOM_output_literal "  .info-table td { padding: 4px 8px; border-bottom: 1px solid #333; color: #000; }"
  MOM_output_literal "  .workpiece-preview { border: 1px solid #000; margin: 8px 0; min-height: 20mm; padding: 4px; font-size: 9pt; }"
  MOM_output_literal "  .workpiece-preview-title { font-weight: 600; margin-bottom: 4px; }"
  MOM_output_literal "  @media print { body { background: #fff; margin: 0; } .a4-frame { margin: 0; border: 1px solid #000; } }"
  MOM_output_literal "</STYLE>"
  MOM_output_literal "</HEAD>"
  MOM_output_literal "<BODY>"
  MOM_output_literal "<div class=\"a4-frame\">"
  MOM_output_literal "<div class=\"doc-header\"><H1 class=\"doc-title\">$doc_title</H1></div>"
}

proc Setup_Header_html { } {
  global mom_logname mom_date
  MOM_output_literal "<table class=\"info-table\">"
  MOM_output_literal "<tr><th>&#1057;&#1086;&#1079;&#1076;&#1072;&#1083;:</th><td>$mom_logname</td><th>&#1044;&#1072;&#1090;&#1072;:</th><td>$mom_date</td></tr>"
  MOM_output_literal "</table>"
  MOM_output_literal "<div class=\"workpiece-preview\">"
  MOM_output_literal "<div class=\"workpiece-preview-title\">&#1055;&#1088;&#1077;&#1076;&#1087;&#1088;&#1086;&#1089;&#1084;&#1086;&#1090;&#1088; &#1087;&#1088;&#1080;&#1074;&#1103;&#1079;&#1082;&#1080; &#1079;&#1072;&#1075;&#1086;&#1090;&#1086;&#1074;&#1082;&#1080;</div>"
  MOM_output_literal "<div>&#1057;&#1093;&#1077;&#1084;&#1072; &#1087;&#1088;&#1080;&#1082;&#1088;&#1077;&#1087;&#1083;&#1077;&#1085;&#1080;&#1103; &#1079;&#1072;&#1075;&#1086;&#1090;&#1086;&#1074;&#1082;&#1080; &#1082; &#1089;&#1090;&#1086;&#1083;&#1091; &#1089;&#1090;&#1072;&#1085;&#1082;&#1072; / &#1086;&#1089;&#1103; &#1089;&#1087;&#1088;&#1072;&#1074;&#1082;&#1080;</div>"
  MOM_output_literal "</div>"
}

set table_flag 0
set setup_header 0
set Tool_No(mill) 0
set Tool_No(drill) 0
set Tool_No(lathe) 0
set mom_sys_output_file_suffix "html"
set line_flag 0

proc MOM_Start_Part_Documentation {} {
  ShopDoc_Header_html
}

proc MOM_start_of_program { } {
  global mom_sys_output_file_suffix output_extn ptp_file_name mom_group_name
  global mom_output_file_directory mom_output_file_basename mom_sys_ptp_output mom_output_file_suffix isinit_files isinit_group
  if {![info exists isinit_files]} {
    set output_extn ""
    if {[info exists mom_output_file_suffix]} {
      if {[string length $mom_output_file_suffix] > 0} { set output_extn ".${mom_output_file_suffix}" }
    }
    set pre_ptp_name "${mom_output_file_directory}${mom_output_file_basename}${output_extn}"
    if {[string length $output_extn] == 0} {
      if {[info exists mom_sys_output_file_suffix]} {
        if {[string length $mom_sys_output_file_suffix] > 0} { set output_extn ".${mom_sys_output_file_suffix}" }
      }
    }
    set ptp_file_name "${mom_output_file_directory}${mom_output_file_basename}${output_extn}"
    MOM_close_output_file $pre_ptp_name
    if {"$ptp_file_name" != "$pre_ptp_name"} {MOM_close_output_file $ptp_file_name}
    if {[file exists $pre_ptp_name]} { MOM_remove_file $pre_ptp_name }
    if {[file exists $ptp_file_name]} { MOM_remove_file $ptp_file_name }
    MOM_open_output_file $ptp_file_name
    set isinit_files TRUE
  }
}

proc MOM_start_of_group {} {
  if {[info exists ptp_file_name]} {
    MOM_close_output_file $ptp_file_name ; MOM_start_of_program
    MOM_open_output_file $ptp_file_name
  } else {
    MOM_start_of_program
  }
  create_tool_list_html
}

proc create_tool_list_html {} {
  global setup_header current_program_name mom_cycle_group_name mom_group_name
  global shop_docs_block shop_docs_output mom_tool_number mom_tool_length_adjust_register mom_tool_name
  global tool_list_output Tool_No tool_counted_mill tool_counted_drill tool_counted_lathe
  global tool_d_register
  set saved_tool_number $mom_tool_number
  set saved_adjust_register $mom_tool_length_adjust_register
  set saved_tool_name $mom_tool_name
  if {[info exists shop_docs_output]} {return}
  set shop_docs_output 0
  set tool_list_output {}
  set Tool_No(mill) 0
  set Tool_No(drill) 0
  set Tool_No(lathe) 0
  set tool_counted_mill {}
  set tool_counted_drill {}
  set tool_counted_lathe {}
  if {[array exists tool_d_register]} { array unset tool_d_register }
  if {![info exists mom_cycle_group_name]} {
    if {[info exists mom_group_name]} { set mom_cycle_group_name $mom_group_name } else { set mom_cycle_group_name "" }
  }
  set current_program_name $mom_cycle_group_name
  set setup_header 0
  set shop_docs_block 0
  set cam_post_dir [MOM_ask_env_var UGII_CAM_SHOP_DOC_DIR]
  MOM_do_template_file ${cam_post_dir}post_tool_list_html.tpl
  global table_flag
  if {[info exists table_flag] && $table_flag == 1} {
    MOM_output_literal "</table>"
    set table_flag 0
  }
  set mom_tool_number $saved_tool_number
  set mom_tool_length_adjust_register $saved_adjust_register
  set mom_tool_name $saved_tool_name
  unset shop_docs_block
  shop_doc_output_literal " "
}

proc MOM_End_Part_Documentation {} {
  MOM_output_literal "</div>"
  MOM_output_literal "</BODY></HTML>"
}

proc shop_doc_output_literal { line } {
  global tool_list_commentary list_file
  if {[info exists tool_list_commentary]} {
    if {[info exists line]} {puts $list_file $line}
  } else {
    MOM_output_literal $line
  }
}

proc MOM_SETUP_HDR {} {
  global setup_header tool_head
  if { $setup_header == 0 } {
    Setup_Header_html
    set setup_header 1
    set tool_head ""
  } elseif { $setup_header == 1 } {
    set tool_head "LATHE"
    set setup_header 2
  } elseif { $setup_header == 2 } {
    set tool_head "DRILL"
    set setup_header 3
  } elseif { $setup_header == 3 } {
    set tool_head "MILL"
    set setup_header 4
  }
}

proc MOM_PROGRAM_BODY { } {
  global mom_object_name cycle_program_name
  set cycle_program_name $mom_object_name
}

proc MOM_SETUP_BODY {} {}
proc MOM_OPER_BODY { } {
  global mom_template_type mom_template_subtype template_type template_subtype
  set template_type $mom_template_type
  set template_subtype $mom_template_subtype
}
proc MOM_SETUP_FTR {} {}

# При включении корректора радиуса (D) в операции NX вызывает MOM_cutcom_on —
# сохраняем номер D для текущего инструмента, чтобы в списке подставить правильный D.
proc MOM_cutcom_on {} {
  global mom_tool_number mom_cutcom_adjust_register mom_tool_radius_adjust_register tool_d_register
  if {![info exists mom_tool_number]} { return }
  set d_val ""
  if {[info exists mom_cutcom_adjust_register] && $mom_cutcom_adjust_register != "" && $mom_cutcom_adjust_register != "0"} {
    set d_val $mom_cutcom_adjust_register
  }
  if {($d_val == "" || $d_val == "0") && [info exists mom_tool_radius_adjust_register] && $mom_tool_radius_adjust_register != "" && $mom_tool_radius_adjust_register != "0"} {
    set d_val $mom_tool_radius_adjust_register
  }
  if {$d_val != "" && $d_val != "0"} {
    set tool_d_register($mom_tool_number) $d_val
  }
}

proc MOM_MEMBERS_HDR {} {
  global mom_sys_program_stack cycle_program_name current_program_name
  lappend mom_sys_program_stack $cycle_program_name
  if {[lsearch $mom_sys_program_stack "$current_program_name"] >= 0 } { set cycle_program_name $current_program_name }
}

proc MOM_MEMBERS_FTR { } {
  global mom_sys_program_stack cycle_program_name current_program_name
  set mom_sys_program_stack [lreplace $mom_sys_program_stack end end]
  set cycle_program_name [lindex $mom_sys_program_stack end]
  if {[lsearch $mom_sys_program_stack "$current_program_name"] >= 0 } {
    set cycle_program_name $current_program_name
  }
}

proc MOM_TOOL_BODY {} {
  global mom_tool_name mom_tool_number mom_template_subtype mom_tool_diameter mom_tool_nose_radius
  global mom_tool_length_adjust_register mom_tool_adjust_register
  global mom_length_comp_register mom_tool_radius_adjust_register mom_cutcom_adjust_register
  global mom_tool_cutcom_register mom_cutcom_register mom_cutcom_status
  global mom_tool_orientation mom_tool_corner1_radius
  global mom_tool_point_angle mom_tool_flute_length mom_tool_length
  global setup_header tool_head Tool_No
  global cycle_program_name current_program_name
  global tool_list_output tool_counted_mill tool_counted_drill tool_counted_lathe
  global tool_d_register

  set n1 [string toupper $cycle_program_name]
  set n2 [string toupper $current_program_name]
  if {$n1 != $n2} {return}
  MapToolType tool_type

  if {$setup_header > 1} {
    if {[lsearch -exact $tool_list_output $mom_tool_number] >= 0} { return }
    lappend tool_list_output $mom_tool_number

    set t_num "T$mom_tool_number"
    # Корректор H — всегда. Корректор D — только если на инструменте включён (проставляем значение D).
    set h_reg ""
    if {[info exists mom_tool_adjust_register] && $mom_tool_adjust_register != ""} { set h_reg $mom_tool_adjust_register }
    if {($h_reg == "" || $h_reg == "0") && [info exists mom_tool_length_adjust_register] && $mom_tool_length_adjust_register != ""} { set h_reg $mom_tool_length_adjust_register }
    if {($h_reg == "" || $h_reg == "0") && [info exists mom_length_comp_register] && $mom_length_comp_register != ""} { set h_reg $mom_length_comp_register }
    if {$h_reg == "" || $h_reg == "0"} { set h_reg $mom_tool_number }
    set h_cell "H$h_reg"
    # Корректор D: если на инструменте включён корректор (G41 D) — ставим "on", иначе ячейка пустая.
    # Учитываем tool_d_register, mom_cutcom_status = on/LEFT/RIGHT и переменные из описания/операции.
    set d_cell ""
    set has_d 0
    if {[info exists tool_d_register($mom_tool_number)] && $tool_d_register($mom_tool_number) != "" && $tool_d_register($mom_tool_number) != "0"} { set has_d 1 }
    if {!$has_d && [info exists mom_cutcom_status] && ([string match -nocase "on" $mom_cutcom_status] || [string match -nocase "LEFT" $mom_cutcom_status] || [string match -nocase "RIGHT" $mom_cutcom_status])} { set has_d 1 }
    if {!$has_d && [info exists mom_cutcom_adjust_register] && $mom_cutcom_adjust_register != "" && $mom_cutcom_adjust_register != "0"} { set has_d 1 }
    if {!$has_d && [info exists mom_tool_radius_adjust_register] && $mom_tool_radius_adjust_register != "" && $mom_tool_radius_adjust_register != "0"} { set has_d 1 }
    if {!$has_d && [info exists mom_tool_cutcom_register] && $mom_tool_cutcom_register != "" && $mom_tool_cutcom_register != "0"} { set has_d 1 }
    if {!$has_d && [info exists mom_cutcom_register] && $mom_cutcom_register != "" && $mom_cutcom_register != "0"} { set has_d 1 }
    if {$has_d} { set d_cell "on" }

    if {$tool_type == "LATHE"} {
      if {[info exists mom_tool_length] && $mom_tool_length != ""} {
        set stickout [format "%.4f" $mom_tool_length]
      } else {
        set stickout [format "%.4f" $mom_tool_flute_length]
      }
    } else {
      set stickout [format "%.4f" $mom_tool_flute_length]
    }
    if {$tool_type == "LATHE"} {
      set dia_str [format "%.4f" $mom_tool_nose_radius]
    } else {
      set dia_str "&#216;[format \"%.4f\" $mom_tool_diameter]"
    }
    set type_ru $tool_type
    if {$tool_type == "MILL"}  { set type_ru "&#1060;&#1088;&#1077;&#1079;&#1072;" }
    if {$tool_type == "DRILL"} { set type_ru "&#1057;&#1074;&#1077;&#1088;&#1083;&#1086;" }
    if {$tool_type == "LATHE"} { set type_ru "&#1058;&#1086;&#1082;&#1072;&#1088;&#1085;&#1099;&#1081;" }

    MOM_output_literal "<tr>"
    MOM_output_literal "<td ALIGN=CENTER>$t_num</td>"
    MOM_output_literal "<td ALIGN=CENTER>$h_cell</td>"
    MOM_output_literal "<td ALIGN=CENTER>$type_ru</td>"
    MOM_output_literal "<td ALIGN=LEFT>$mom_tool_name</td>"
    MOM_output_literal "<td ALIGN=CENTER>$dia_str</td>"
    MOM_output_literal "<td ALIGN=CENTER>$stickout</td>"
    MOM_output_literal "<td ALIGN=CENTER>$d_cell</td>"
    MOM_output_literal "</tr>"
  } else {
    switch $tool_type {
      "MILL" {
        if {[lsearch -exact $tool_counted_mill $mom_tool_number] < 0} {
          lappend tool_counted_mill $mom_tool_number
          incr Tool_No(mill)
        }
      }
      "DRILL" {
        if {[lsearch -exact $tool_counted_drill $mom_tool_number] < 0} {
          lappend tool_counted_drill $mom_tool_number
          incr Tool_No(drill)
        }
      }
      "LATHE" {
        if {[lsearch -exact $tool_counted_lathe $mom_tool_number] < 0} {
          lappend tool_counted_lathe $mom_tool_number
          incr Tool_No(lathe)
        }
      }
    }
  }
}

proc MOM_PROGRAMVIEW_HDR {} {
  global table_flag tool_head Tool_No
  set has_any [expr {($Tool_No(drill) + $Tool_No(mill) + $Tool_No(lathe)) > 0}]
  if {$has_any && $table_flag == 0} {
    MOM_output_literal "<div class=\"section-title\">&#1057;&#1087;&#1080;&#1089;&#1086;&#1082; &#1080;&#1085;&#1090;&#1088;&#1091;&#1084;&#1077;&#1085;&#1090;&#1086;&#1074;</div>"
    MOM_output_literal "<table class=\"tool-list\" BORDER=1>"
    MOM_output_literal "<tr><th>&#1053;&#1086;&#1084;&#1077;&#1088;</th><th>&#1050;&#1086;&#1088;&#1088;&#1077;&#1082;&#1090;&#1086;&#1088; H</th><th>&#1058;&#1080;&#1087;</th><th>&#1053;&#1072;&#1080;&#1084;&#1077;&#1085;&#1086;&#1074;&#1072;&#1085;&#1080;&#1077;</th><th>&#1044;&#1080;&#1072;&#1084;&#1077;&#1090;&#1088;/&#1056;&#1072;&#1076;&#1080;&#1091;&#1089;</th><th>&#1042;&#1099;&#1083;&#1077;&#1090;</th><th>&#1050;&#1086;&#1088;&#1088;&#1077;&#1082;&#1090;&#1086;&#1088; D</th></tr>"
    set table_flag 1
  }
}

proc MOM_PROGRAMVIEW_FTR {} {
  # Таблица закрывается в create_tool_list_html после прохода шаблона
}

proc TOOL_LIST_start_of_group {} {
  global mom_cycle_group_name mom_group_name
  if {![info exists mom_cycle_group_name]} {set mom_cycle_group_name $mom_group_name}
}
