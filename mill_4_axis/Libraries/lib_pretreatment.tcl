####C#U#S#T#O#M##M#E#T#A##I#N#F#O#R#M#A#T#I#O#N##############################################
#
#	Customer Data
#
#	Company         :
#	Address         :
#	Contact person  :
#	Phone           :
#	Fax             :
#	Mail            :
#
####S#T#A#R#T##C#H#A#N#G#E##H#I#S#T#O#R#Y####################################################
#
#	Last changes:	01.02.2011 - UR  001 Initial Release and Installation
#			23.08.2013 - UR  002 Add keywords for comment lines (important, because automation respond)
#			03.09.2013 - UR  003 Releaseversion 1.0
#			09.10.2013 - COE 004 Changed setting of lib_ge_env(tmp_dir)
#			10.12.2013 - UR  005 Decomposing the basic functions
#			10.02.2014 - COE 006 Releaseversion 2.0
#			17.02.2014 - COE 007 Releaseversion 2.1
#			13.03.2014 - UR  008 Releaseversion 2.2
#			31.03.2014 - UR  009 Add lib_flag(PB_decontamination) to switch of PB support
#			31.03.2014 - UR  010 Releaseversion 2.3
#			11.04.2014 - UR  011 Releaseversion 2.3.1
#			12.05.2014 - UR  012 Releaseversion 2.3.2
#			18.05.2014 - UR  013 Add sourcing with the possibility of nesting folders
#			19.05.2014 - UR  014 Releaseversion 2.3.3
#			26.05.2014 - UR  015 Revision of the LIB_Shell_search_path_recursively routines when a blank is included in the path
#			16.06.2014 - COE 016 Releaseversion 2.3.4
#			16.06.2014 - UR  017 Add recursively sourcing for the pretreatment files
#			24.06.2014 - UR  018 Releaseversion 2.3.5
#			24.06.2014 - UR  019 Releaseversion 2.4
#			07.07.2014 - UR  020 Releaseversion 2.4.1
#			16.07.2014 - UR  021 Releaseversion 3.0
#			29.07.2014 - COE 022 LIB_Shell_environment_handling: lib_ge_env(installed_machines_dir,recursively)
#					     LIB_Shell_main: no longer call LIB_Shell_search_path_recursively
#			30.07.2014 - COE 023 Releaseversion 3.1
#			12.08.2014 - UR  024 Releaseversion 3.1.1
#			13.08.2014 - UR  025 Adopted revised texts from SPLM
#			13.08.2014 - UR  026 Releaseversion 3.2
#			13.08.2014 - UR  027 Releaseversion 3.2.1
#			15.08.2014 - COE 028 Adopt modifications SPLM
#			15.08.2014 - COE 029 Releaseversion 3.2.2
#			25.08.2014 - UR  030 Releaseversion 3.2.3
#			10.09.2014 - UR  031 Releaseversion 3.2.4
#			11.09.2014 - UR  032 Releaseversion 3.2.5
#			22.09.2014 - UR  033 Add property for "show where output comes from" and delete flag(show_where_output_comes_from)
#			29.09.2014 - COE 034 Releaseversion 3.2.6
#			13.10.2014 - COE 035 Releaseversion 3.2.7
#			21.10.2014 - COE 036 Releaseversion 3.2.8
#			04.11.2014 - COE 037 Releaseversion 3.2.9
#			11.11.2014 - UR  038 Modification of the complete post speed
#			13.11.2014 - UR  039 Modification of the complete post speed
#			21.11.2014 - COE 040 LIB_Shell_environment_handling: changde setting of lib_ge_env(installed_machines_dir,recursively)
#			28.11.2014 - COE 041 Releaseversion 3.2.10
#			22.12.2014 - UR  042 Releaseversion 3.3
#			22.12.2014 - UR  043 Releaseversion 3.3.1
#			05.01.2015 - UR  044 Releaseversion 3.3.2 and changed the Copyright
#			06.01.2015 - UR  045 Releaseversion 3.3.3
#			06.01.2015 - UR  046 Releaseversion 3.3.4
#			07.01.2015 - UR  047 Releaseversion 3.3.5
#			11.01.2015 - UR  048 Releaseversion 3.3.6
#			11.01.2015 - COE 049 Bugfix if the current directory has spaces
#			13.01.2015 - COE 050 Releaseversion 3.3.7
#			20.01.2015 - UR  051 Change file nativename and join to LIB_Shell_format_path_names to save runtime
#			25.01.2015 - UR  052 Releaseversion 3.3.8
#			28.01.2015 - UR  053 Bugfix at LIB_Shell_environment_handling to defined the base folder
#			03.02.2015 - UR  054 Correction if the PostConfigurator structure is used
#			09.02.2015 - UR  055 Releaseversion 3.3.9
#			02.03.2015 - COE 056 Releaseversion 3.4
#			12.03.2015 - UR  057 Releaseversion 3.4.1
#			16.03.2015 - UR  058 Releaseversion 3.4.2
#			30.03.2015 - UR  059 Releaseversion 3.4.3
#			20.04.2015 - COE 060 Releaseversion 3.4.4
#			28.04.2015 - COE 061 Releaseversion 3.4.5
#			15.06.2015 - UR  062 Releaseversion 3.4.6
#			15.06.2015 - UR  063 Change abort handling
#			16.06.2015 - UR  064 Releaseversion 3.4.7
#			22.06.2015 - UR  065 Releaseversion 3.4.8
#			21.07.2015 - UR  066 Releaseversion 3.4.9
#			28.07.2015 - COE 067 Releaseversion 3.4.10
#			11.08.2015 - COE 068 Releaseversion 3.4.11
#			16.08.2015 - UR  069 Save Time with Extended foreach Syntax e.g. foreach {a b c d e} [cmdReturningList] {break}
#						Side note: accelerated runtime after the first index, for one index no improvement
#					     Comparing if Command exists now with LIB_GE_check_commands to wrote the values to an list once
#					     Modifications of the memory handling with Procedures K SK D unset! clear and set!, see http://wiki.tcl.tk/1923
#					     Removing unneeded characters and partially reformat
#			20.08.2015 - UR  070 Changed misspelling from adress to address (Bug #784)
#			20.08.2015 - UR  071 Releaseversion 3.4.12
#			21.08.2015 - UR  072 Releaseversion 3.4.13
#			24.08.2015 - COE 073 Releaseversion 3.5
#			04.09.2015 - COE 074 Releaseversion 3.5.1
#			07.09.2015 - COE 075 Releaseversion 3.5.2
#			08.09.2015 - COE 076 Releaseversion 3.5.3
#			13.09.2015 - UR  077 Performance improvement when examining whether a procedure exists and also to loading files
#			15.09.2015 - UR  078 Releaseversion 3.5.4
#			17.09.2015 - UR  079 Change the filename for the lib_ge_dll_version to lower case
#			21.09.2015 - UR  080 Releaseversion 3.6
#			29.09.2015 - UR  081 Releaseversion 3.6.1
#			30.09.2015 - UR  082 Releaseversion 3.6.2
#			05.10.2015 - UR  083 Releaseversion 3.6.3
#			26.10.2015 - UR  084 Releaseversion 3.6.4
#			27.10.2015 - UR  085 Releaseversion 3.6.5
#			18.12.2015 - COE 086 Releaseversion 3.6.6
#			13.01.2016 - UR  087 Releaseversion 3.6.7
#			25.02.2016 - UR  088 Releaseversion 3.6.8
#			07.03.2016 - UR  089 Releaseversion 3.6.9
#			24.03.2016 - COE 090 Releaseversion 3.6.10
#			13.04.2016 - UR  091 Releaseversion 3.6.11
#			20.04.2016 - UR  092 Releaseversion 3.6.12
#			28.04.2016 - UR  093 Releaseversion 3.7
#			29.04.2016 - UR  094 Releaseversion 3.7.1
#			15.05.2016 - COE 095 Releaseversion 3.7.2
#			15.05.2016 - COE 096 Releaseversion 3.7.3
#			17.05.2016 - COE 097 Releaseversion 3.7.4
#			23.05.2016 - COE 098 Releaseversion 3.7.5
#			27.06.2016 - MAN 099 Update internal documentation
#			15.08.2016 - UR  100 Releaseversion 4.0
#			24.08.2016 - UR  101 Releaseversion 4.0.1
#			04.09.2016 - COE 102 Releaseversion 4.0.2
#			05.09.2016 - COE 103 LIB_Shell_environment_handling: 'libraries', 'controller' and 'bin'
#						all lowercase (we check it against the result of 'string tolower')
#						(back to status of version 100)
#			05.09.2016 - COE 104 Releaseversion 4.0.3
#			08.09.2016 - UR  105 Releaseversion 4.0.4
#			22.09.2016 - UR  106 HISTORY-> Modifications to support now also Linux <-
#			24.09.2016 - UR  107 Releaseversion 4.0.5
#			25.09.2016 - UR  108 Releaseversion 4.1
#			27.09.2016 - UR  109 Releaseversion 4.1.1
#			04.10.2016 - UR  110 Releaseversion 4.1.2
#			24.10.2016 - UR  111 Releaseversion 4.1.3
#			17.11.2016 - MAN 112 Source also from UGII_POST_POOL_DIR_NG_CUSTOM
#			19.11.2016 - UR  113 Releaseversion 4.1.4
#			21.11.2016 - MAN 114 Remove again sourcing from UGII_POST_POOL_DIR_NG_CUSTOM
#			07.12.2016 - UR  115 Releaseversion 4.1.5
#			11.01.2017 - COE 116 Releaseversion 4.1.6
#			21.02.2017 - UR  117 Releaseversion 4.1.7
#			24.02.2017 - UR  118 Releaseversion 4.1.8
#			13.03.2017 - COE 119 Releaseversion 4.2
#			05.04.2017 - COE 120 Releaseversion 4.2.1
#			06.04.2017 - COE 121 Releaseversion 4.2.2
#			07.04.2017 - COE 122 Releaseversion 4.2.3
#			24.04.2017 - UR  123 Remove PUI settings and procedures
#			28.04.2017 - COE 124 Releaseversion 4.2.4
#			19.05.2017 - UR  125 Releaseversion 4.2.5
#			18.06.2017 - COE 126 Releaseversion 4.2.6
#			27.06.2017 - COE 127 Releaseversion 4.2.7
#			06.07.2017 - UR  128 Extension for the layer editor
#			31.07.2017 - UR  129 Releaseversion 4.2.8
#			01.08.2017 - UR  130 Bugfix if variable TEMP not exists within LINUX systems
#			02.08.2017 - UR  131 Releaseversion 4.2.9
#			31.08.2017 - UR  132 Add support for *.pcf
#			01.09.2017 - UR  133 Releaseversion 4.2.10
#			11.09.2017 - COE 134 Releaseversion 4.2.11
#			25.09.2017 - COE 135 Releaseversion 4.3
#			12.11.2017 - COE 136 Releaseversion 4.3.1
#			28.11.2017 - UR  137 Releaseversion 4.3.2
#			04.12.2017 - UR  138 Adding the process ID to all files that are traded through the preparation process
#			21.02.2018 - COE 139 Releaseversion 4.3.3
#			12.03.2018 - UR  140 File contents revised for TCL8.6 and converted to UTF-8
#			14.03.2018 - UR  141 Releaseversion 4.4
#			20.03.2018 - UR  142 Releaseversion 4.4.1
#			12.04.2018 - UR  143 Releaseversion 4.4.2
#			04.05.2018 - UR  144 Releaseversion 4.4.3
#			14.05.2018 - UR  145 Releaseversion 4.4.4
#			02.07.2018 - UR  146 Releaseversion 4.4.5
#			20.07.2018 - COE 147 Releaseversion 4.4.6
#			10.09.2018 - UR  148 Releaseversion 4.4.7
#			24.09.2018 - UR  149 Releaseversion 4.4.8
#			08.10.2018 - UR  150 Releaseversion 4.4.9
#			18.10.2018 - COE 151 Releaseversion 4.5
#			11.01.2019 - UR  152 Releaseversion 4.6.1
#			08.02.2019 - UR  153 Releaseversion 4.6.2
#			16.03.2019 - UR  154 Releaseversion 4.6.3
#			21.03.2019 - UR  155 Function revision so that the MOM Execute can also be loaded in versions >= 1847
#			28.03.2019 - COE 156 Releaseversion 4.7
#			11.04.2019 - UR  157 Releaseversion 4.7.1
#			18.04.2019 - UR  158 Releaseversion 4.7.2
#			07.05.2019 - UR  159 Releaseversion 5.0
#			08.07.2019 - UR  160 Releaseversion 5.0.1
#			31.07.2019 - UR  161 Releaseversion 5.0.2
#			16.08.2019 - COE 162 Releaseversion 5.0.3
#			21.08.2019 - COE 163 Releaseversion 5.1.0
#			20.09.2019 - COE 164 Releaseversion 5.2.0
#			06.11.2019 - UR  165 Releaseversion 5.2.3
#			27.12.2019 - UR  166 Releaseversion 5.2.4
#			31.01.2020 - COE 167 Releaseversion 5.2.5
#			02.03.2020 - UR  168 Releaseversion 5.2.6
#			19.03.2020 - COE 169 Releaseversion 5.2.7
#			25.03.2020 - COE 170 Releaseversion 5.3.0
#			23.04.2020 - UR  171 Bugfix set lib_ge_dll_version instead of dotnet_version
#			01.07.2020 - COE 172 Releaseversion 5.3.1
#			09.07.2020 - COE 173 Releaseversion 5.3.2
#			06.09.2020 - COE 174 Releaseversion 5.3.3
#			15.09.2020 - COE 175 Releaseversion 5.3.4
#			26.09.2020 - COE 176 Releaseversion 5.3.5
#			26.11.2020 - COE 177 Releaseversion 5.3.6
#			24.01.2021 - COE 178 Releaseversion 5.3.7
#			06.02.2021 - COE 179 Releaseversion 5.3.8
#			15.03.2021 - COE 180 Releaseversion 5.3.9
#			13.04.2021 - COE 181 Releaseversion 5.4.0
#			16.05.2021 - COE 182 Bug#2260: check UGII_TMP_DIR first, use system-env only as fallback
#			02.06.2021 - COE 183 Releaseversion 5.4.1
#			11.06.2021 - COE 184 Linux compatibility
#			21.07.2021 - COE 185 Releaseversion 5.4.2
#			03.09.2021 - COE 186 Releaseversion 5.4.3
#			07.09.2021 - COE 187 Releaseversion 5.4.4
#			29.09.2021 - COE 188 Releaseversion 5.5.0
#			25.10.2021 - COE 189 Releaseversion 5.5.1
#			24.11.2021 - COE 190 Releaseversion 5.5.2
#			19.02.2022 - COE 191 Releaseversion 5.5.3
#			06.03.2022 - COE 192 Releaseversion 5.5.4
#			08.04.2022 - COE 193 Releaseversion 5.5.5
#			13.07.2022 - COE 194 Releaseversion 5.5.6
#			07.09.2022 - COE 195 Releaseversion 5.5.7
#			24.09.2022 - COE 196 Releaseversion 5.5.8
#			15.01.2023 - COE 197 Releaseversion 23.01.0
#			14.03.2023 - COE 198 Releaseversion 23.03.0
#			07.04.2023 - COE 199 Releaseversion 23.04.0
#			14.07.2023 - COE 200 Releaseversion 23.07.0
#			14.09.2023 - COE 201 Releaseversion 23.09.0
#			09.10.2023 - ET  202 Releaseversion 23.10.0
#			10.12.2023 - COE 203 Releaseversion 23.12.0
#			19.01.2024 - COE 204 Releaseversion 24.01.0
#			21.03.2024 - COE 205 Releaseversion 24.03.0
#			13.08.2024 - COE 206 Releaseversion 24.08.0
#			22.08.2024 - COE 207 Releaseversion 24.08.1
#			16.09.2024 - COE 208 Releaseversion 24.09.0
#			24.09.2024 - ET  209 Releaseversion 24.09.1
#			27.12.2024 - COE 210 Releaseversion 24.12.0
#			02.04.2025 - COE 211 Releaseversion 25.04.0
#
#
#
#
#
#
#
#
#
#############################################################################################
#	Copyright 2014-2024 Siemens Product Lifecycle Management Software Inc.
#				All Rights Reserved.

#
####S#T#A#N#D#A#R#D##S#O#U#R#C#I#N#G#########################################################

#____________________________________________________________________________________________
#
# Procedure debugger
#____________________________________________________________________________________________
#

set lib_ge_debug(on) 0
set lib_ge_debug(proc_watch_list) "MOM* PPLIB* PROC*"
set lib_ge_debug(var_write_trace_list) "mom_group_name"
set lib_ge_debug(proc_watch_exclude_list) "MOM_SMART* MOM_evaluate_arg MOM_before_each_add_var MOM_before_load_address"
#____________________________________________________________________________________________
set lib_debug_source_of_proc_list 		""
set lib_fh_do_after_output			0	;#if set to 0 the posttreatment loop is suppressed

if {![info exists lib_ge_platform]} {
	set lib_ge_temppath ""
	if {[info commands MOM_ask_env_var] != ""} {
		set lib_ge_temppath [MOM_ask_env_var UGII_TMP_DIR]
	}
	
	if {[string match "*windows*" $tcl_platform(platform)]} {
		set lib_ge_platform 1
		set lib_ge_slash "\\"
		if {$lib_ge_temppath == ""} {
			if {[info exists env(TEMP)]} {
				set lib_ge_temppath $env(TEMP)
			} elseif {[info exists env(TMP)]} {
				set lib_ge_temppath $env(TMP)
			}
		}
	} else {
		set lib_ge_platform 0
		set lib_ge_slash "/"
		if {$lib_ge_temppath == ""} {
			if {[info exists env(TMPDIR)]} {
				set lib_ge_temppath $env(TMPDIR)
			}
			if {![string length $lib_ge_temppath]} {
				set lib_ge_temppath "${lib_ge_slash}var${lib_ge_slash}tmp"
			}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Handling for the default environment variables
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_environment_handling {} {

 	global lib_ge_env lib_ge_slash lib_ge_installed_machines

	set lib_ge_env(post_pool_dir) 		[LIB_Shell_format_path_names [MOM_ask_env_var "UGII_POST_POOL_DIR_NG"]]
	set lib_ge_env(cam_post_dir) 		[LIB_Shell_format_path_names [MOM_ask_env_var "UGII_CAM_POST_DIR"]]
	set lib_ge_env(tmp_dir)                 [LIB_Shell_format_path_names [MOM_ask_env_var "UGII_TMP_DIR"]]
	if {$lib_ge_env(tmp_dir) == ""} {set lib_ge_env(tmp_dir) $::lib_ge_temppath}

	if {[string match [string tolower [file tail [file dirname [info script]]]] "libraries"]} {
		set lib_ge_installed_machines	[file dirname [info script]]
	} else {
		set lib_ge_installed_machines	[info script]
	}

	set lib_ge_env(installed_machines_dir) 	[LIB_Shell_format_path_names [file dirname $lib_ge_installed_machines]]
	# Needed is searchpath activ, therefore info script is wrong
	if {[file exists [LIB_Shell_format_path_names "$lib_ge_env(tmp_dir)${lib_ge_slash}pretreatment_script.tcl"]]} {source [LIB_Shell_format_path_names "$lib_ge_env(tmp_dir)${lib_ge_slash}pretreatment_script.tcl"]}

	set lib_ge_env(installed_machines_dir,recursively) ""
	lappend lib_ge_env(installed_machines_dir,recursively) $lib_ge_env(installed_machines_dir)

	set current_dir [pwd]
	if {![catch {cd [lindex $lib_ge_env(installed_machines_dir,recursively) 0]}]} {
		if {![catch {set dir [string tolower [glob *]]}]} {
			foreach e {libraries controller bin} {
				set index [lsearch -exact $dir $e]
				if {$index > -1} {
					set directory [lindex $dir $index]
					set directory [string toupper [string index $directory 0]][string range $directory 1 end]
					lappend lib_ge_env(installed_machines_dir,recursively) [LIB_Shell_format_path_names "[lindex $lib_ge_env(installed_machines_dir,recursively) 0]$lib_ge_slash$directory"]
				}
			}
		}
	}
	cd $current_dir

	if {![regexp -nocase -- {\w+} $lib_ge_env(post_pool_dir)]} {set lib_ge_env(post_pool_dir) $lib_ge_env(installed_machines_dir)}

	set lib_ge_env(version_bit)  			[MOM_ask_env_var "UGII_VERSION_BIT"]
	set lib_ge_env(base_dir)     			[MOM_ask_env_var "UGII_BASE_DIR"]

	set lib_ge_env(compatible_base_release_version)	[MOM_ask_env_var "NX_COMPATIBLE_BASE_RELEASE_VERSION"]
	set lib_ge_env(major_version)  			[MOM_ask_env_var "UGII_MAJOR_VERSION"]
	set lib_ge_env(minor_version)     		[MOM_ask_env_var "UGII_MINOR_VERSION"]
	set lib_ge_env(subminor_version)     		[MOM_ask_env_var "UGII_SUBMINOR_VERSION"]

	if {![info exists lib_ge_dll_version]} {global lib_ge_dll_version}
	if {$lib_ge_env(minor_version) > 0} {
		set lib_ge_dll_version "nx$lib_ge_env(major_version)$lib_ge_env(minor_version)"
	} else {
		set lib_ge_dll_version "nx$lib_ge_env(major_version)"
	}
	if {[llength $lib_ge_env(compatible_base_release_version)] > 0} {set lib_ge_dll_version "nx$lib_ge_env(compatible_base_release_version)"}

	if {[string match "*windows*" $::tcl_platform(platform)]} {
		regsub -all "/" $lib_ge_env(base_dir) "\\" lib_ge_env(base_dir)
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# This procedure may be used to format pathnames from unix format in windows
# format and delete double backslash
#
# Output:
# D:\Temp\mom\debug.out or \\Server\Temp\mom\debug.out
#
# e.g.
# set error [LIB_Shell_format_path_names "D:/Temp/mom/debug.out"]
#
# <Example>
# set error [LIB_Shell_format_path_names "D:/Temp/mom/debug.out"]
#____________________________________________________________________________________________
proc LIB_Shell_format_path_names {pathname} {

	global lib_ge_slash lib_ge lib_ge_platform

	regsub -all "/" $pathname "\\" pathname
	binary scan $pathname H* pathbin
	if {[info exists lib_ge(format_path,$pathbin,0,0,0)]} {
		return $lib_ge(format_path,$pathbin,0,0,0)
	}

	if {[regexp -nocase -- {^[\\\\]|^[\/\/]} $pathname]} {
		regsub -all "/" $pathname "\\" pathname
	}

	if {$lib_ge_platform} {
		regsub -all "/" $pathname "\\" pathname
		if {![regexp -nocase -- {^\\\\} $pathname]} {set unc 0} else {set unc 1}
			 while {[regsub -- "(?q)\\\\" $pathname "\\" pathname]} {}
		if {$unc} {set pathname "\\$pathname"}
	} elseif {!$lib_ge_platform} {
		regsub -all "\\\\" $pathname "/" pathname
		if {![regexp -nocase -- {^//} $pathname]} {set unc 0} else {set unc 1}
		while {[regsub -- "(?q)//" $pathname "/" pathname]} {}
		if {$unc} {set pathname "/$pathname"}
	}

	set lib_ge(format_path,$pathbin,0,0,0) [string trim $pathname]
	return $lib_ge(format_path,$pathbin,0,0,0)

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Abort postrun
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_abort {message} {

	MOM_output_to_listing_device $message
	MOM_log_message $message

	MOM_abort $message

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Handling for the main shell
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_main {} {

	global lib_ge_env lib_ge_slash
	global lib_cycle_path sourcefile

	LIB_Shell_environment_handling

	lappend ::lib_ge_monitored_files [LIB_Shell_format_path_names [info script]]

	if {[info commands LIB_GE_source] == ""} {
		set lib_cycle_path 0
		set searchpath $lib_ge_env(installed_machines_dir,recursively)
		lappend searchpath $lib_ge_env(post_pool_dir)
		foreach path $searchpath {
			if {$lib_cycle_path} {break}
			foreach ext {.tcl .tbc .pcf} {
				set sourcefile [LIB_Shell_format_path_names "$path${lib_ge_slash}lib_sourcing$ext"]
				if {[file exists $sourcefile]} {
					if {[string match ".tbc" $ext]} {
						LIB_Shell_abort "ByteCode Loader is not available, cannot process lib_sourcing$ext"
					}
					uplevel #0 {

						set err ""
						if {$tcl_version >= 8.6 && [catch {source -encoding utf-8 $sourcefile} err]} {
							if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $::errorInfo"}
							LIB_Shell_abort "File lib_sourcing $err not loadable"
						}
						if {$tcl_version < 8.6 && [catch {source $sourcefile} err]} {
							if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $::errorInfo"}
							LIB_Shell_abort "File lib_sourcing $err not loadable"
						}
						if {[string length $err] > 0} {
							set lib_ge_debug(lib_sourcing) "$sourcefile"
							lappend lib_ge_monitored_files "$sourcefile"
							lappend lib_ge_log_message "\n--> $sourcefile loaded"
							set lib_cycle_path 1 ; break
						}

					}
				}
			}
		}
		if {!$lib_cycle_path} {
			LIB_Shell_abort "File lib_sourcing not found"
		}
	}

	LIB_Shell_init

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Handling for the default environment variables
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_defined_post_environment {} {

	global lib_ge_env lib_ge_slash lib_pp_source_file

	#____________________________________________________________________________________________
	#
	# NX Post, load files
	#____________________________________________________________________________________________
	#

	# There are different ways to source each files
	#
	# e.g. Befor LIB_GE_source call
	# lappend lib_pp_source_file "machine,UGII_CAM_POST_DIR"
	#
	# e.g. After LIB_GE_source call
	# LIB_GE_source "Test" "C:/Temp/;d:/tmp/"
	#
	# e.g. To define a searchpath
	# LIB_GE_source "" "C:/Temp/;UGII_CAM_POST_DIR"
	# Allowed is the direct path and/or variable

	# This is the call the PB post LIB_GE files
	# ** internal funktion / Don't remove this line **

	if {[file exists "$lib_ge_env(tmp_dir)${lib_ge_slash}pt_source_list_[pid].tcl"]} {
		LIB_GE_source pt_source_list_[pid] "$lib_ge_env(tmp_dir)${lib_ge_slash}" ".tcl" 0 0 "RUNTIME"
		LIB_GE_source lib_pretreatment_post
	} else {
		lappend lib_pp_source_file "ugpost_base" "lib_msg" "lib_file_handling" "lib_standard_post_func" "lib_document" "lib_pretreatment_post"
		LIB_GE_source
	}
}

LIB_Shell_main

####S#T#A#R#T##C#U#S#T#O#M##M#O#D#I#F#I#C#A#T#I#O#N#S########################################

####E#N#D##C#U#S#T#O#M##M#O#D#I#F#I#C#A#T#I#O#N#S############################################

#############################################################################################
# This is to debug
#############################################################################################
if {[info commands LIB_GE_debug] != ""} {LIB_GE_debug}
