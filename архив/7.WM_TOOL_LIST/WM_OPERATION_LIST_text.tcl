#####################################################################
#    W M _ O P E R A T I O N _ L I S T _ T E X T . T C L
#####################################################################
# Список операций (WM) в текстовом формате.
# Пост в папке 7.WM_OPERATION_LIST, имя в template_post.dat: WM_OPERATION_LIST(text)
######################################################################

set mom_source_directory [MOM_ask_env_var UGII_CAM_SHOP_DOC_DIR]
source "${mom_source_directory}shopdoc_header.tcl"
set mom_sys_output_file_suffix "txt"
set line_flag 0

#=============================================================================
proc MOM_Start_Part_Documentation {} {
#=============================================================================
   ShopDoc_Header_text
}

#=============================================================
proc MOM_start_of_program { } {
#=============================================================
  global mom_sys_output_file_suffix mom_sys_list_file_suffix output_extn list_extn
  global ptp_file_name lpt_file_name warning_file_name mom_group_name prev_group_name
  global mom_output_file_directory mom_output_file_basename
  global mom_sys_ptp_output mom_output_file_suffix isinit_files isinit_group

  if {![info exists isinit_files]} {
    set output_extn ""
    if {[info exists mom_output_file_suffix]} {
      if {[string length $mom_output_file_suffix] > 0} {
        set output_extn ".${mom_output_file_suffix}"
      }
    }
    set pre_ptp_name "${mom_output_file_directory}${mom_output_file_basename}${output_extn}"
    if {[string length $output_extn] == 0} {
        if {[string length $mom_sys_output_file_suffix] > 0} {
           set output_extn ".${mom_sys_output_file_suffix}"
        }
    }
    set ptp_file_name "${mom_output_file_directory}${mom_output_file_basename}${output_extn}"
    MOM_close_output_file $pre_ptp_name
    if {"$ptp_file_name" != "$pre_ptp_name"} {MOM_close_output_file $ptp_file_name}
    if {[file exists $pre_ptp_name]} {
      MOM_remove_file $pre_ptp_name
    }
    if {[file exists $ptp_file_name]} {
      MOM_remove_file $ptp_file_name
    }
    MOM_open_output_file $ptp_file_name
    set isinit_files TRUE
  }
}

#=============================================================
proc MOM_start_of_group {} {
#=============================================================
    if {[info exists ptp_file_name]} {
      MOM_close_output_file $ptp_file_name ; MOM_start_of_program
      MOM_open_output_file $ptp_file_name
    } else {
      MOM_start_of_program
    }
    create_operation_list_text
}

#=============================================================
proc create_operation_list_text {} {
#=============================================================
  global setup_header
  global current_program_name mom_cycle_group_name mom_group_name
  global shop_docs_block shop_docs_output
  global mom_operation_name mom_operation_type template_type template_subtype mom_tool_name

  if {[info exists shop_docs_output]} {return}
  set shop_docs_output 0

  if {![info exists mom_cycle_group_name]} {
    if {[info exists mom_group_name]} {
      set mom_cycle_group_name $mom_group_name
    } else {
      set mom_cycle_group_name ""
    }
  }

  set current_program_name $mom_cycle_group_name
  set setup_header 0
  set shop_docs_block 0

  set cam_post_dir [MOM_ask_env_var UGII_CAM_SHOP_DOC_DIR]
  MOM_do_template_file ${cam_post_dir}post_operation_list_text.tpl

  shop_doc_output_literal "-----------------------------------------------------------------------------------------------"
  unset shop_docs_block
}

#=============================================================================
proc shop_doc_output_literal { line } {
#=============================================================================
  global tool_list_commentary list_file
  if {[info exists tool_list_commentary]} {
      if {[info exists line]} {puts $list_file $line}
  } else {
    MOM_output_literal $line
  }
}

#=============================================================================
proc MOM_TOOL_BODY { } {
#=============================================================================
  global mom_operation_name mom_operation_type template_type template_subtype
  global cycle_program_name current_program_name setup_header mom_tool_name line_flag

  set n1 [string toupper $cycle_program_name]
  set n2 [string toupper $current_program_name]
  if {$n1 != $n2} {return}

  if {$template_type == "" && $template_subtype == ""} {
    set oper_desc "--/--"
  } elseif {$template_type == ""} {
    set oper_desc "--/$template_subtype"
  } elseif {$template_subtype == ""} {
    set oper_desc "$template_type/--"
  } else {
    set oper_desc "$template_type/$template_subtype"
  }

  set output [format "%-30s %-35s %-20s\n" $mom_operation_name $oper_desc $mom_tool_name]
  MOM_output_literal "$output"
  set template_type ""
  set template_subtype ""
}

#=============================================================================
proc MOM_SETUP_HDR {} {
#=============================================================================
  global setup_header

  if {$setup_header == 0} {
    shop_doc_output_literal "                          WM OPERATION LIST BY PROGRAM                                        "
    shop_doc_output_literal "                          *** ********* **** ** *******                                        "
    shop_doc_output_literal "                                                                                               "
    set setup_header 1
  }
}

#=============================================================================
proc MOM_PROGRAMVIEW_HDR {} {
#=============================================================================
  global mom_member_nest_level mom_object_name line_flag

  set oper_name "OPERATION NAME"
  set oper_type "OPERATION DESCRIPTION"
  set tool_name "TOOL NAME"
  if {$line_flag} {
    MOM_output_literal "-----------------------------------------------------------------------------------------------"
    MOM_output_literal "    "
    set line_flag 0
  }

  set output [format "PROGRAM NAME : %-20s" $mom_object_name]
  MOM_output_literal "$output"
  MOM_output_literal "-----------------------------------------------------------------------------------------------"
  set output [format "%-30s %-35s %-20s" $oper_name $oper_type $tool_name]
  MOM_output_literal $output
  MOM_output_literal "-----------------------------------------------------------------------------------------------"
  set line_flag 1
}

#=============================================================================
proc MOM_SETUP_FTR { } {
#=============================================================================
}

#=============================================================================
proc MOM_MEMBERS_HDR { } {
#=============================================================================
  global mom_sys_program_stack cycle_program_name current_program_name
  lappend mom_sys_program_stack $cycle_program_name

  if {[lsearch $mom_sys_program_stack "$current_program_name"] >= 0} {
    set cycle_program_name $current_program_name
  }
}

#=============================================================================
proc MOM_MEMBERS_FTR { } {
#=============================================================================
  global mom_sys_program_stack cycle_program_name current_program_name

  set mom_sys_program_stack [lreplace $mom_sys_program_stack end end]
  set cycle_program_name [lindex $mom_sys_program_stack end]

  if {[lsearch $mom_sys_program_stack "$current_program_name"] >= 0} {
    set cycle_program_name $current_program_name
  }
}

#=============================================================================
proc MOM_PROGRAM_BODY { } {
#=============================================================================
  global mom_object_name cycle_program_name
  set cycle_program_name $mom_object_name
}

#=============================================================================
proc MOM_SETUP_BODY { } {
#=============================================================================
}

#=============================================================================
proc MOM_OPER_BODY { } {
#=============================================================================
  global mom_template_type mom_template_subtype template_type template_subtype
  global mom_operation_name mom_operation_type

  set template_type $mom_template_type
  set template_subtype $mom_template_subtype

  if {$mom_operation_type == "Wire EDM"} {
    set oper_desc "$template_type/$template_subtype"
    set output [format "%-30s %-35s %5s \n" $mom_operation_name $oper_desc "WIRE"]
    MOM_output_literal "$output"
  }
}

#=============================================================================
proc MOM_TOOL_HDR { } {
#=============================================================================
}

#=============================================================================
proc MOM_TOOL_FTR { } {
#=============================================================================
}

#=============================================================================
proc MOM_PROGRAMVIEW_FTR { } {
#=============================================================================
}

#=============================================================================
proc TOOL_LIST_start_of_group {} {
#=============================================================================
  global mom_cycle_group_name mom_group_name
  if {![info exists mom_cycle_group_name]} {set mom_cycle_group_name $mom_group_name}
}
