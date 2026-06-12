lappend lib_config_data  [list "lib_sourcing" "LIB-Sourcing-Version 289"]
set lib_release_version "25.04.0"
#############################################################################################
#
#	Copyright 2014-2024 Siemens Product Lifecycle Management Software Inc.
#				All Rights Reserved.
#
####S#T#A#R#T##C#H#A#N#G#E##H#I#S#T#O#R#Y####################################################
#
#	Last changes:	10.12.2013 - UR  001 Initial Release and Installation
#			10.02.2014 - UR  002 Change sequence to source tbcload,
#						if the new one not exist source the old one
#			10.02.2014 - COE 003 Releaseversion 2.0
#			17.02.2014 - COE 004 Releaseversion 2.1
#			25.02.2014 - UR  005 Add undo to LIB_Shell_exchange_env after postrun
#			13.03.2014 - UR  006 Releaseversion 2.2
#			31.03.2014 - UR  007 Add lib_flag(load_ugpost_base) to load explicitly ugpost_base.tcl
#			31.03.2014 - UR  008 Releaseversion 2.3
#			01.04.2014 - UR  009 Added functionality to source *.apb files
#			07.04.2014 - UR  010 Added load Loader functionality
#			11.04.2014 - UR  011 Releaseversion 2.3.1
#			15.04.2014 - UR  012 Structural change for sourcing
#			12.05.2014 - UR  013 Releaseversion 2.3.2
#			18.05.2014 - UR  014 Add sourcing with the possibility of nesting folders
#			19.05.2014 - UR  015 Releaseversion 2.3.3
#			20.05.2014 - COE 016 LIB_Shell_external_source: check if xml-file exists
#			26.05.2014 - UR  017 Revision of the LIB_Shell_search_path_recursively routines when a blank is included in the path
#			27.05.2014 - UR  018 Change extension at LIB_Shell_external_source from xml to pcc
#						change extension from apb to pce
#			03.06.2014 - COE 019 Buigfix in LIB_Shell_search_path_recursively
#			16.06.2014 - COE 020 Releaseversion 2.3.4
#			18.06.2014 - UR  021 Change extension from pcc to psc
#			24.06.2014 - UR  022 Releaseversion 2.3.5
#			24.06.2014 - UR  023 Catch the complete post-processor in the case of an error
#			24.06.2014 - UR  024 Releaseversion 2.4
#			01.07.2014 - UR  025 Revision to the description texts
#			03.07.2014 - UR  026 Add to LIB_Shell_external_source the nodes for Environment and SubFolder
#			04.07.2014 - UR  027 Add a third option to set env
#			07.07.2014 - UR  028 Releaseversion 2.4.1
#			16.07.2014 - UR  029 Releaseversion 3.0
#			17.07.2014 - UR  030 Configuration file has to run without node "Processing"
#			18.07.2014 - UR  031 Allowed to change the search directories after main sourcing
#			29.07.2014 - COE 032 LIB_Shell_main: no longer call LIB_Shell_search_path_recursively
#					     LIB_Shell_search_file_recursively: nolonger call LIB_Shell_search_path_recursively
#					     LIB_Shell_init: nolonger call LIB_Shell_search_path_recursively
#					     Removed "JE-" in lib_config_data
#					     LIB_Shell_load_bytecode: store tbcload log message to output later on
#					     LIB_Shell_load_xml_handling and LIB_Shell_load_general : output tbcload log message
#			30.07.2014 - COE 033 Releaseversion 3.1
#			12.08.2014 - UR  034 Releaseversion 3.1.1
#			13.08.2014 - UR  035 Adopted revised texts from SPLM
#			13.08.2014 - UR  036 Releaseversion 3.2
#			13.08.2014 - UR  037 Releaseversion 3.2.1
#			15.08.2014 - COE 038 Adopt modifications SPLM
#			15.08.2014 - COE 039 Releaseversion 3.2.2
#			25.08.2014 - UR  040 Releaseversion 3.2.3
#			10.09.2014 - UR  041 Add interrogation for expiration date and Sold-To ID check
#			10.09.2014 - UR  042 Releaseversion 3.2.4
#			11.09.2014 - UR  043 Releaseversion 3.2.5
#			29.09.2014 - COE 044 Releaseversion 3.2.6
#			13.10.2014 - COE 045 Releaseversion 3.2.7
#			21.10.2014 - COE 046 Releaseversion 3.2.8
#			04.11.2014 - UR  047 Set flag lib_shell(load_loader) if the loader loaded
#			04.11.2014 - COE 048 Releaseversion 3.2.9
#			11.11.2014 - UR  049 Modification of the complete post speed
#			13.11.2014 - UR  050 Modification of the complete post speed
#			26.11.2014 - UR  051 Bugfix for special characters with glob
#					     Modification of the complete post speed
#			26.11.2014 - UR  052 Bugfix if a - sign at the file name(Bug #507)
#			27.11.2014 - UR  053 Bugfix at LIB_Shell_directory_exists because in some constellation NX crashed
#			28.11.2014 - COE 054 LIB_Shell_exchange_env: implemented setting of POST_LIB_CURRENT_MACH_DIR
#			28.11.2014 - COE 055 Releaseversion 3.2.10
#			07.12.2014 - UR  056 Modifications to support *.tbc
#			19.12.2014 - UR  057 Add call to LIB_GE_analyze_path if there an 8.3 pathname (Bug #527)
#					     Bugfix at LIB_Shell_files_from_dir is it an unc directory (Bug #527)
#					     Rename AdvancedPostBuilder to PostConfigurator
#			20.12.2014 - COE 058 LIB_Shell_exchange_env: clean up and only use "POST_LIB_CURRENT_MACH_DIR" for new postproecessors (Bug #470)
#			22.12.2014 - UR  059 Releaseversion 3.3
#			22.12.2014 - COE 060 LIB_Shell_exchange_env: check if MOM_set_env_var exixts (is not the case in PostConfigurator interpreter nx-version < NX10.0.1)
#			22.12.2014 - UR  061 Releaseversion 3.3.1
#			05.01.2015 - UR  062 Releaseversion 3.3.2 and changed the Copyright
#			06.01.2015 - UR  063 Releaseversion 3.3.3
#			06.01.2015 - UR  064 Releaseversion 3.3.4
#			07.01.2015 - UR  065 Releaseversion 3.3.5
#			09.01.2015 - UR  066 Bugfix for UNC handling an spaces inside an path
#					     Replace variable ID to something else because there is a tracer active to the variable ID
#			11.01.2015 - UR  067 Releaseversion 3.3.6 and check if loader available to load encrypted files
#			12.01.2015 - UR  068 At Runtime of VBScript we change now to the temp directory to execute script to have rights results for UNC handling
#			12.01.2015 - UR  069 Errorhandling for LIB_Shell_holding_stack and replace tbcload 1.6 and 1.7 because it doesn't work
#			13.01.2015 - COE 070 Releaseversion 3.3.7
#			20.01.2015 - UR  071 Bugfix is a path defined like e.g. C:\Users\ROD458~1.DBF\AppData\Local\Temp
#					     Remove call to LIB_GE_analyze_path
#			20.01.2015 - UR  072 Remove debug stuff
#			20.01.2015 - UR  073 Remove LoadLoader information from syslog
#			25.01.2015 - UR  074 Releaseversion 3.3.8
#			26.01.2015 - UR  075 Add lib_ge_slash global at LIB_Shell_files_from_dir
#			03.02.2015 - UR  076 Load LIB_Shell_load_user_function "JEDLL_NG_Execute" less then NX10, not NX9
#			05.02.2015 - UR  077 Add to the filelist the extension .def and .cdl at LIB_Shell_file_glob
#			09.02.2015 - UR  078 Releaseversion 3.3.9
#			12.02.2015 - UR  079 Bug 592 Error in sourcing .tbc-files
#					     Correct LIB_Shell_load_bytecode tcl-version >=8.4 should call tbcload17
#					     Error in sourcing (lib_file_handling)
#			16.02.2015 - UR  080 Change slash conversation inside LIB_Shell_load_user_function
#			23.02.2015 - COE 081 Load LIB_Shell_load_user_function "JEDLL_NG_Execute" if current version < 9
#			02.03.2015 - COE 082 Releaseversion 3.4
#			11.03.2015 - UR  083 First implementation to handle all librarys in one file
#			12.03.2015 - UR  084 Releaseversion 3.4.1
#			16.03.2015 - UR  085 Releaseversion 3.4.2
#			30.03.2015 - UR  086 Releaseversion 3.4.3
#			30.03.2015 - UR  087 Change the mechanism to check if loader command are available
#					     Change the time loops at LIB_Shell_holding_stack to 300, because the default was to low at shared folder
#			15.04.2015 - UR  088 Reworke file delete in reference to (Bug #591)
#			20.04.2015 - COE 089 Releaseversion 3.4.4
#			28.04.2015 - COE 090 LIB_Shell_load_loader: global lib_shell
#			28.04.2015 - COE 091 removed setting of encoding_system (this caused some problem with PCE files in NX10.0.2)
#			28.04.2015 - COE 092 Releaseversion 3.4.5
#			11.06.2015 - UR  093 Workaround, if inside NX8.5 TCL8.4 as a preview active
#			11.06.2015 - UR  094 Close the opened files, because VNCK crashes - Reported from MAN
#			15.06.2015 - UR  095 Releaseversion 3.4.6
#			15.06.2015 - UR  096 Add check if lib_general is loaded and change abort handling
#					     Change sequence to check the loader commands at LIB_Shell_load_loader
#			16.06.2015 - UR  097 Releaseversion 3.4.7
#			22.06.2015 - UR  098 Releaseversion 3.4.8
#			26.06.2015 - UR  099 Bugfix at LIB_Shell_files_from_dir to rectify the infinite loop (Bug #670)
#			29.06.2015 - UR  100 Bugfix at LIB_Shell_files_from_dir and eliminate the return at load loader
#			29.06.2015 - UR  101 add LIB_Shell_replace_special_characters as an part from LIB_GE_replace_special_characters
#			15.07.2015 - UR  102 Load LIB_Shell_load_user_function "JEDLL_NG_Execute" if current version NX8.5 with TCL 8.4
#			21.07.2015 - UR  103 Releaseversion 3.4.9
#			24.07.2015 - COE 104 LIB_Shell_search_file_recursively : tbcload and user_functions are now also found in 'bin' subfolder
#					     LIB_Shell_exchange_env: NX >= 9, do not abort if 'MOM_set_env_var' is not there
#						(command is not available in PostConfigurator environment in NX9 --> PostConf in NX9 did not open)
#						(Bug#755)
#			28.07.2015 - COE 105 Releaseversion 3.4.10
#			11.08.2015 - COE 106 Releaseversion 3.4.11
#			16.08.2015 - UR  107 Save Time with Extended foreach Syntax e.g. foreach {a b c d e} [cmdReturningList] {break}
#						Side note: accelerated runtime after the first index, for one index no improvement
#					     Comparing if Command exists now with LIB_GE_check_commands to wrote the values to an list once
#					     Modifications of the memory handling with Procedures K SK D unset! clear and set!, see http://wiki.tcl.tk/1923
#					     Modifications at LIB_Shell_load_loader only to load it if NX > 8.5
#			20.08.2015 - UR  108 Delete some unneeded calls to LIB_Shell_exchange_env
#					     Modification at LIB_Shell_exchange_env to eliminate option which were not defined
#			20.08.2015 - UR  109 Add POST_SYS_CYCL_VERS at LIB_Shell_exchange_env to handle SYS_CYCLE with PC
#			20.08.2015 - UR  110 Checking whether subdirectories for librarie and controller exist
#			20.08.2015 - UR  111 Releaseversion 3.4.12
#			21.08.2015 - UR  112 Releaseversion 3.4.13
#			22.08.2015 - UR  113 Included LoaderFunction also at NX8.5 with TCL8.4
#			24.08.2015 - COE 114 Releaseversion 3.5
#			04.09.2015 - COE 115 Releaseversion 3.5.1
#			07.09.2015 - COE 116 Releaseversion 3.5.2
#			08.09.2015 - COE 117 Releaseversion 3.5.3
#			13.09.2015 - UR  118 Performance improvement when examining whether a procedure exists and also to loading files
#			15.09.2015 - UR  119 Add more options to handle file sourcing
#			15.09.2015 - UR  120 Releaseversion 3.5.4
#			15.09.2015 - UR  121 Bugfix to support UNC directories at LIB_Shell_file_glob
#			16.09.2015 - UR  122 Change the inventory of files with glob at LIB_Shell_file_glob
#					     Performance improvement based on the list from SPLM and other discoveries
#			17.09.2015 - UR  123 Improving performance in the examination of existing functions
#			21.09.2015 - UR  124 Add LIB_Shell_reload_functions with TCL > 8.3 functions (Otherwise TBC errors)
#			21.09.2015 - UR  125 Releaseversion 3.6
#			21.09.2015 - UR  126 Bugfix to handle SendToCustomer
#			22.09.2015 - UR  127 Bugfix to handle SendToCustomer
#			22.09.2015 - UR  128 Workaround if the function MOM_set_env_var not work correctly
#			29.09.2015 - UR  129 Releaseversion 3.6.1
#			30.09.2015 - UR  130 Releaseversion 3.6.2
#			05.10.2015 - UR  131 Bugfix to support backwords compatibility from NX9 to NX9.0.3 (Bug#838)
#			05.10.2015 - UR  132 Releaseversion 3.6.3
#			26.10.2015 - UR  133 Releaseversion 3.6.4
#			27.10.2015 - UR  134 Releaseversion 3.6.5
#			28.10.2015 - UR  135 Change lib_shell(quick_source) to 0 if subdirectorie 'bin' is not available
#			30.10.2015 - UR  136 Add the check if SYS_CYCLE exists only inside the folder 'Libraries' (Bug #850)
#			24.11.2015 - UR  137 Remove comment
#			18.12.2015 - COE 138 Releaseversion 3.6.6
#			13.01.2016 - UR  139 Releaseversion 3.6.7
#			14.01.2016 - UR  140 Enhanced the search path also with POST_* (Bug #886)
#			17.02.2016 - UR  141 Enhanced LIB_Shell_replace_special_characters for batch and xml handling
#			25.02.2016 - MAN 142 Enhanced LIB_Shell_replace_special_characters with special case 8 for MOM__part_attributes
#			25.02.2016 - UR  143 Releaseversion 3.6.8
#			07.03.2016 - UR  144 Releaseversion 3.6.9
#			24.03.2016 - COE 145 Releaseversion 3.6.10
#			05.04.2016 - UR  146 Bugfix to execute the Post with NX7.5 (Bug #961)
#			13.04.2016 - UR  147 Releaseversion 3.6.11
#			20.04.2016 - UR  148 Releaseversion 3.6.12
#			28.04.2016 - UR  149 Releaseversion 3.7
#			29.04.2016 - UR  150 Releaseversion 3.7.1
#			09.05.2016 - UR  151 Add an solution for NX7.5, because in some reasons the LIB_Shell_load_xml_handling freeze the NX session
#			15.05.2016 - COE 152 Releaseversion 3.7.2
#			15.05.2016 - COE 153 Releaseversion 3.7.3
#			17.05.2016 - COE 154 Releaseversion 3.7.4
#			23.05.2016 - COE 155 Releaseversion 3.7.5
#			23.05.2016 - MAN 156 Add POST_LIB_CURRENT_BMP_DIR at LIB_Shell_exchange_env to handle bitmaps in installed_machines folder
#			14.06.2016 - MAN 157 Add redefinition of MOM_output_text to LIB_Shell_reload_functions
#			27.06.2016 - MAN 158 Update internal documentation
#			29.06.2016 - UR  159 Workaround for NX7.5 (Bug #1021), because sometimes the session freeze
#			15.08.2016 - UR  160 Releaseversion 4.0
#			24.08.2016 - UR  161 Releaseversion 4.0.1
#			26.08.2016 - MAN 162 Update sourcing for Unix/OSX, bugfix at LIB_Shell_file_pathname
#			04.09.2016 - COE 163 Releaseversion 4.0.2
#			05.09.2016 - COE 164 Releaseversion 4.0.3
#			08.09.2016 - UR  165 Releaseversion 4.0.4
#			20.09.2016 - UR  166 Enhanced LIB_Shell_file_exists to check if the file exist without an filename (Bug #1109)
#					     Bugfix to support Linux at LIB_Shell_directory_exists (Bug #1105)
#			24.09.2016 - UR  167 Releaseversion 4.0.5
#			25.09.2016 - UR  168 Adaptation of upper- and lowercase letters in folder names for PCE support under Linux
#			25.09.2016 - UR  169 Releaseversion 4.1
#			26.09.2016 - UR  170 Change reversed as simulation and output without an ending does not work anymore (Bug #1109)
#			27.09.2016 - UR  171 Releaseversion 4.1.1
#			04.10.2016 - UR  172 Releaseversion 4.1.2
#			24.10.2016 - UR  173 Releaseversion 4.1.3
#			19.11.2016 - UR  174 Releaseversion 4.1.4
#			07.12.2016 - UR  175 Releaseversion 4.1.5
#			11.01.2017 - COE 176 Releaseversion 4.1.6
#			11.01.2017 - COE 177 Releaseversion 4.1.6
#			15.02.2017 - UR  178 Preparation for TCL8.6, special here the function CLOCK is not implemented by default
#			21.02.2017 - UR  179 Releaseversion 4.1.7
#			24.02.2017 - UR  180 Releaseversion 4.1.8
#			13.03.2017 - COE 181 Releaseversion 4.2
#			05.04.2017 - COE 182 Releaseversion 4.2.1
#			06.04.2017 - COE 183 Releaseversion 4.2.2
#			07.04.2017 - COE 184 Releaseversion 4.2.3
#			28.04.2017 - COE 185 Releaseversion 4.2.4
#			19.05.2017 - UR  186 Releaseversion 4.2.5
#			18.06.2017 - COE 187 Releaseversion 4.2.6
#			27.06.2017 - COE 188 Releaseversion 4.2.7
#			06.07.2017 - UR  189 Extension for the layer editor
#			31.07.2017 - UR  190 Releaseversion 4.2.8
#			01.08.2017 - UR  191 Bug #1335: History->Bugfix if variable TEMP not exists within LINUX systems<-
#			02.08.2017 - UR  192 Releaseversion 4.2.9
#			31.08.2017 - UR  193 Add support for *.pcf
#			01.09.2017 - UR  194 Releaseversion 4.2.10
#			11.09.2017 - COE 195 Releaseversion 4.2.11
#			25.09.2017 - COE 196 Releaseversion 4.3
#			12.11.2017 - COE 197 Releaseversion 4.3.1
#			21.11.2017 - MAN 198 Update library functions description
#			23.11.2017 - UR  199 Bug #1210: Enhance sourcing based at the*.psc informations for 'Folder' and 'Extension'
#			28.11.2017 - UR  200 Releaseversion 4.3.2
#			20.02.2018 - COE 201 LIB_Shell_file_glob: bugfix for TCL8.6
#						(problem only occures if files are loaded from an other folder than the folder of current postprocessor)
#					     LIB_Shell_load_general and LIB_Shell_load_xml_handling: unset ::status if it exists
#			21.02.2018 - COE 202 Releaseversion 4.3.3
#			12.03.2018 - UR  203 File contents revised for TCL8.6 and converted to UTF-8
#			12.03.2018 - UR  204 React to the property to execute LIB_Shell_replace_special_characters
#			14.03.2018 - UR  205 Releaseversion 4.4
#			19.03.2018 - UR  206 Extending the information of errors when loading TBC files
#			20.03.2018 - UR  207 Releaseversion 4.4.1
#			12.04.2018 - UR  208 Releaseversion 4.4.2
#			24.04.2018 - UR  209 Change check for lib_ge_tclversion
#			26.04.2018 - UR  210 Bugfix for TCL8.6 if lib_general is loaded, the message info is ..\tcl8.6\platform\pkgIndex.tcl which is wrong
#			04.05.2018 - UR  211 Releaseversion 4.4.3
#			14.05.2018 - UR  212 Releaseversion 4.4.4
#			02.07.2018 - UR  213 Releaseversion 4.4.5
#			20.07.2018 - COE 214 Releaseversion 4.4.6
#			10.09.2018 - UR  215 Releaseversion 4.4.7
#			24.09.2018 - UR  216 Releaseversion 4.4.8
#			08.10.2018 - UR  217 Releaseversion 4.4.9
#			18.10.2018 - COE 218 Releaseversion 4.5
#			05.11.2018 - UR  219 Version from Shanghai compared and adopted for TBC handling
#			15.11.2018 - UR  220 Message when loading the "loader.dll" built in for errors
#			11.01.2019 - UR  221 Releaseversion 4.6.1
#			04.02.2019 - UR  222 Add option for handle packages
#			08.02.2019 - UR  223 Releaseversion 4.6.2
#			13.02.2019 - UR  224 Correction of special characters
#			16.03.2019 - UR  225 Releaseversion 4.6.3
#			21.03.2019 - UR  226 Function revision so that the MOM Execute can also be loaded in versions >= 1847
#			28.03.2019 - COE 227 LIB_Shell_reload_functions: redefine MOM_output_text not only for CSE (PR#9360571)
#			28.03.2019 - COE 228 Releaseversion 4.7
#			11.04.2019 - UR  229 Releaseversion 4.7.1
#			18.04.2019 - UR  230 Implementation for the support of layer sections in the XML structure of the *.PSC file
#			18.04.2019 - UR  231 Releaseversion 4.7.2
#			03.05.2019 - UR  232 Add SubFolder section to the sourcing
#			07.05.2019 - UR  233 Releaseversion 5.0
#			08.07.2019 - UR  234 Releaseversion 5.0.1
#			31.07.2019 - UR  235 Releaseversion 5.0.2
#			16.08.2019 - COE 236 Releaseversion 5.0.3
#			21.08.2019 - COE 237 Releaseversion 5.1.0
#			20.09.2019 - COE 238 Releaseversion 5.2.0
#			06.11.2019 - UR  239 Releaseversion 5.2.3
#			27.12.2019 - UR  240 Releaseversion 5.2.4
#			31.01.2020 - COE 241 Releaseversion 5.2.5
#			02.03.2020 - UR  242 Releaseversion 5.2.6
#			19.03.2020 - COE 243 Releaseversion 5.2.7
#			25.03.2020 - COE 244 Releaseversion 5.3.0
#			23.04.2020 - UR  245 Add POST_LIB_CURRENT_BIN_DIR
#					     Bugfix set lib_ge_dll_version instead of dotnet_version
#			01.07.2020 - COE 246 Releaseversion 5.3.1
#			09.07.2020 - COE 247 Releaseversion 5.3.2
#			06.09.2020 - COE 248 Releaseversion 5.3.3
#			15.09.2020 - COE 249 Releaseversion 5.3.4
#			26.09.2020 - COE 250 Releaseversion 5.3.5
#			26.11.2020 - COE 251 Releaseversion 5.3.6
#			07.12.2020 - UR  252 Functions EQ_is_* revised more robust
#			24.01.2021 - COE 253 Releaseversion 5.3.7
#			06.02.2021 - COE 254 Releaseversion 5.3.8
#			15.03.2021 - COE 255 Releaseversion 5.3.9
#			13.04.2021 - COE 256 Releaseversion 5.4.0
#			16.05.2021 - COE 257 Bug#2260: check UGII_TMP_DIR first, use system-env only as fallback
#			02.06.2021 - COE 258 Releaseversion 5.4.1
#			11.06.2021 - COE 259 Linux compatibility
#			14.07.2021 - COE 260 merge changes from Shanghai team (TBC-loader for Linux)
#			21.07.2021 - COE 261 Bug#2304: eliminate 'switch -nocase' (Linux version of NX which is still using TCL8.4)
#			21.07.2021 - COE 262 Releaseversion 5.4.2
#			03.09.2021 - COE 263 Releaseversion 5.4.3
#			07.09.2021 - COE 264 Releaseversion 5.4.4
#			14.09.2021 - UR  265 Add Check for command MOM_abort to LIB_Shell_exchange_env
#			29.09.2021 - COE 266 Releaseversion 5.5.0
#			25.10.2021 - COE 267 Releaseversion 5.5.1
#			24.11.2021 - COE 268 Releaseversion 5.5.2
#			19.02.2022 - COE 269 Releaseversion 5.5.3
#			06.03.2022 - COE 270 Releaseversion 5.5.4
#			08.04.2022 - COE 271 Releaseversion 5.5.5
#			13.07.2022 - COE 272 Releaseversion 5.5.6
#			07.09.2022 - COE 273 Releaseversion 5.5.7
#			24.09.2022 - COE 274 Releaseversion 5.5.8
#			15.01.2023 - COE 275 Releaseversion 23.01.0
#			14.03.2023 - COE 276 Releaseversion 23.03.0
#			07.04.2023 - COE 277 Releaseversion 23.04.0
#			14.07.2023 - COE 278 Releaseversion 23.07.0
#			14.09.2023 - COE 279 Releaseversion 23.09.0
#			09.10.2023 - ET  280 Releaseversion 23.10.0
#			10.12.2023 - COE 281 Releaseversion 23.12.0
#			19.01.2024 - COE 282 Releaseversion 24.01.0
#			21.03.2024 - COE 283 Releaseversion 24.03.0
#			13.08.2024 - COE 284 Releaseversion 24.08.0
#			22.08.2024 - COE 285 Releaseversion 24.08.1
#			16.09.2024 - COE 286 Releaseversion 24.09.0
#			24.09.2024 - ET  287 Releaseversion 24.09.1
#			27.12.2024 - COE 288 Releaseversion 24.12.0
#			02.04.2025 - COE 289 Releaseversion 25.04.0
#
#
#
#
#
#
#
#
#
#
#
####E#N#D##C#H#A#N#G#E##H#I#S#T#O#R#Y########################################################

set lib_flag(load_ugpost_base)			0
set lib_shell(load_loader) 			0
set lib_shell(load_library) 			0

# Source handling
set lib_shell(quick_source)			1 	; # Default is 1 otherwise with 0 we search through all directories
set lib_shell(quick_source,globstyle)		1 	; # Default is 1 otherwise with 0 we search through all directories
set lib_shell(quick_source,post_pool_dir) 	"" 	; # If you would search to an specific directory under post pool you have to add it to the list
set lib_shell(quick_source,cam_post_dir) 	"" 	; # If you would search to an specific directory under cam post you have to add it to the list

set lib_ge_tclversion 				[info tclversion]
if {[string match "library.tbc" [file tail [info script]]]} {
	set lib_shell(load_library) 		1
	set lib_ge_debug(library) [info script] ; set lib_config_datas $lib_config_data ; unset lib_config_data
	lappend lib_config_data  [list "library" "Library-Version [format %03d [string trimleft [lindex [lindex [lindex $lib_config_datas end] 1] 1] 0]]"]
}

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
if {[info commands LIB_Shell_environment_handling] != ""} {
	proc LIB_Shell_environment_handling {} {

		global lib_ge_env lib_ge_slash lib_ge_installed_machines

		# Language file and OS specific values
		if {![info exists lib_ge_slash]} {
			global lib_ge_slash
			if {[string match "*windows*" $::tcl_platform(platform)]} {set lib_ge_slash "\\"} else {set lib_ge_slash "/"}
		}

		if {![info exists lib_ge_env]} {global lib_ge_env}

		set lib_ge_env(post_pool_dir) 		[MOM_ask_env_var "UGII_POST_POOL_DIR_NG"]
		set lib_ge_env(cam_resource_dir) 	[MOM_ask_env_var "UGII_CAM_RESOURCE_DIR"]
		set lib_ge_env(cam_post_dir) 		[MOM_ask_env_var "UGII_CAM_POST_DIR"]
		set lib_ge_env(tmp_dir)                 [MOM_ask_env_var "UGII_TMP_DIR"]
		if {$lib_ge_env(tmp_dir) == ""} {set lib_ge_env(tmp_dir) $::lib_ge_temppath}

		set lib_ge_installed_machines		[info script]

		regsub -all "/" $lib_ge_env(post_pool_dir) "\\" lib_ge_env(post_pool_dir)
		regsub -all "/" $lib_ge_env(cam_post_dir) "\\" lib_ge_env(cam_post_dir)
		regsub -all "/" [LIB_Shell_format_path_names [file dirname $lib_ge_installed_machines]]$lib_ge_slash "\\" lib_ge_env(installed_machines_dir)

		if {![regexp -nocase -- {\w+} $lib_ge_env(post_pool_dir)]} {set lib_ge_env(post_pool_dir) $lib_ge_env(installed_machines_dir)}

		LIB_Shell_path_init $lib_ge_env(installed_machines_dir)
		LIB_Shell_path_init $lib_ge_env(cam_post_dir)
		if {$lib_ge_env(installed_machines_dir) != $lib_ge_env(post_pool_dir)} {
			LIB_Shell_path_init $lib_ge_env(post_pool_dir)
		}

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
}

if {[info commands LIB_Shell_main] != ""} {
	proc LIB_Shell_main {} {

		global lib_ge_env lib_ge_slash
		global lib_cycle_path sourcefile

		LIB_Shell_environment_handling

		if {[info commands LIB_GE_source] == ""} {
			set lib_cycle_path 0
			set searchpath "$lib_ge_env(installed_machines_dir,recursively)"
			lappend searchpath $lib_ge_env(post_pool_dir)
			foreach path $searchpath {
				if {$lib_cycle_path} {break}
				foreach name {library lib_sourcing} {
					foreach ext {.tcl .pce .pcf .tbc} {
						set sourcefile [LIB_Shell_format_path_names "${path}${lib_ge_slash}$name$ext"]
						if {[LIB_Shell_file_exists $sourcefile]} {
							if {![string match "library.tbc" "$name$ext"] && [string match ".tbc" $ext]} {
								LIB_Shell_abort "ByteCode Loader is not available, cannot process $name$ext"
							}
							uplevel #0 {

								set err ""
								if {$tcl_version >= 8.6 && [catch {source -encoding utf-8 $sourcefile} err]} {
									if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $::errorInfo"}
									LIB_Shell_abort "File [file tail $sourcefile] $err not loadable"
								}
								if {$tcl_version < 8.6 && [catch {source $sourcefile} err]} {
									if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $::errorInfo"}
									LIB_Shell_abort "File [file tail $sourcefile] $err not loadable"
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
			}
			if {!$lib_cycle_path} {
				LIB_Shell_abort "File lib_sourcing not found"
			}
		}
		LIB_Shell_init
	}
}

#___________________________________________________________________________________________
# <Internal Documentation>
#
# Search directories recursively
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_search_file_recursively {pathname filename {value ""}} {

	global lib_ge_env lib_ge_slash

	upvar $value returnvalue

	set filename [LIB_Shell_format_path_names $pathname$lib_ge_slash$filename]
	if {[LIB_Shell_file_exists $filename 1]} {
		if {![string length $value]} {
			return $filename
		} else {
			set returnvalue $filename
			return 1
		}
	}

	set searchpath "$lib_ge_env(installed_machines_dir,recursively)"
	lappend searchpath $lib_ge_env(post_pool_dir)

	foreach pathnames $searchpath {
		set filenames [LIB_Shell_format_path_names $pathnames$lib_ge_slash[file tail $filename]]
		if {[LIB_Shell_file_exists $filenames 1]} {
			if {![string length $value]} {
				return $filenames
			} else {
				set returnvalue $filenames
				return 1
			}
		}
	}
	return 0
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
# Load ByteCodeLoader and Functions
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_load_bytecode {} {

	global lib_ge_env lib_ge_env lib_ge_slash
	global lib_ge_log_message lib_ge_nx_platform
	global lib_ge_monitored_files lib_ge_tclversion
	global lib_ge_ByteCodeLoader_msg lib_shell lib_ge_platform

	# if loaded we don't need it again
	if {[regexp -nocase -- {tbcload} [package names]] && [info exists lib_ge_nx_platform]} {return}

	package forget tbcload

	if {$lib_ge_env(version_bit) == "32Bit" || [LIB_Shell_file_exists [file join "$lib_ge_env(base_dir)${lib_ge_slash}ugii${lib_ge_slash}msvcp71.dll"] 1]} {
		set lib_ge_nx_platform 32 ; # NX works with 32Bit
	} elseif {$lib_ge_env(version_bit) == "64Bit" || ![LIB_Shell_file_exists [file join "$lib_ge_env(base_dir)${lib_ge_slash}ugii${lib_ge_slash}msvcp71.dll"] 1]} {
		set lib_ge_nx_platform 64 ; # NX works with 64Bit
	}

	if {![info exists lib_ge_env(cam_resource_dir)]} {
		set lib_ge_env(cam_resource_dir) [MOM_ask_env_var UGII_CAM_RESOURCE_DIR]
	}
	set post_configurator_bin_dir [file join $lib_ge_env(cam_resource_dir) post_configurator post_template bin]
	set nx_bin_dir [file join $lib_ge_env(base_dir) nxbin]

	set check 0
	if {$lib_ge_nx_platform == 64} {
		if {$lib_ge_tclversion >= 8.6} {
			if {$lib_ge_platform} {
				if {![LIB_Shell_search_file_recursively $post_configurator_bin_dir tbcload18.dll loadfile]} {
					set loadfile [LIB_Shell_file_pathname tbcload18 ".dll" 1]
				}
			} else {
				if {![LIB_Shell_search_file_recursively $nx_bin_dir libtbcload18.so loadfile]} {
					set loadfile [LIB_Shell_file_pathname libtbcload18 ".so" 1]
				}
			}

			package ifneeded tbcload 1.7 [list load $loadfile] ; set check 1
		} elseif {$lib_ge_tclversion == 8.4} {
			if {$lib_ge_platform} {
				if {![LIB_Shell_search_file_recursively $post_configurator_bin_dir tbcload17.dll loadfile]} {
					set loadfile [LIB_Shell_file_pathname tbcload17 ".dll" 1]
				}
			} else {
				if {![LIB_Shell_search_file_recursively $nx_bin_dir libtbcload17.so loadfile]} {
					set loadfile [LIB_Shell_file_pathname libtbcload17 ".so" 1]
				}
			}
			
			package ifneeded tbcload 1.7 [list load $loadfile] ; set check 1
		} else {
			if {$lib_shell(quick_source)} {set loadfile [LIB_Shell_file_pathname tbcload14 ".dll" 1]}
			if {$lib_shell(quick_source) || [LIB_Shell_search_file_recursively $lib_ge_env(post_pool_dir) tbcload14.dll loadfile]} {
				package ifneeded tbcload 1.4 [list load $loadfile] ; set check 1
			}
		}
		set lib_ge_ByteCodeLoader_msg "ByteCodeLoader [package versions tbcload] for TCLVersion $lib_ge_tclversion with 64Bit loaded"
	} elseif {$lib_ge_nx_platform == 32} {
		if {$lib_shell(quick_source)} {set loadfile [LIB_Shell_file_pathname tbcload13 ".dll" 1]}
		if {$lib_shell(quick_source) || [LIB_Shell_search_file_recursively $lib_ge_env(post_pool_dir) tbcload13.dll loadfile]} {
				package ifneeded tbcload 1.3 [list load $loadfile] ; set check 1
		}
		set lib_ge_ByteCodeLoader_msg "ByteCodeLoader [package versions tbcload] for TCLVersion $lib_ge_tclversion with 32Bit loaded"
	}
	if {!$check} {
		set lib_ge_ByteCodeLoader_msg "ByteCodeLoader for TCLVersion $lib_ge_tclversion '${lib_ge_nx_platform}Bit' not found"
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Load Package and Functions
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_load_package {packagename} {

	global lib_ge_env lib_ge_env lib_ge_slash
	global lib_ge_log_message lib_ge_nx_platform
	global lib_ge_monitored_files lib_ge_tclversion
	global lib_ge_ByteCodeLoader_msg lib_shell
	global auto_path lib_ge_pretreatment_runtime

	if {[info exists lib_ge_pretreatment_runtime] && $lib_ge_pretreatment_runtime} {return}

	switch -- [string tolower $packagename] {
		"tdom" 	{
				set packagepath [LIB_Shell_format_path_names [file join $lib_ge_env(installed_machines_dir) "Libraries" "tdom0.9.1"]]
				if {![LIB_Shell_file_exists $packagepath]} {return}
				set lib_shell(package,$packagename) 1
			}
		default {
				if {[llength [info commands LIB_Shell_load_packag_custom]]} {
					set packagepath [LIB_Shell_load_packag_custom]
					if {![LIB_Shell_file_exists $packagepath]} {return}
				} else {
					return
				}
			}
	}

	# if loaded we don't need it again
	if {[regexp -nocase -- {$packagename} [package names]] && [info exists lib_ge_nx_platform]} {return}

	package forget $packagename

	if {[lsearch -exact $packagepath $auto_path] < 0} {lappend auto_path $packagepath}
	package require $packagename

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Load user function
#
# <Internal Example>
#
# e.g. LIB_Shell_load_user_function "lib_execute_$lib_ge_dll_version" "JEDLL_NG_Execute"
#
#____________________________________________________________________________________________
proc LIB_Shell_load_user_function {{filename ""} {entrypoint ""}} {

	global lib_ge_env lib_ge_slash
	global lib_ge_execute_extension
	global lib_ge_nx_platform
	global lib_ge_user_function
	global lib_ge_monitored_files
	global lib_ge_log_message
	global lib_shell

	if {!$lib_shell(quick_source)} {
		set searchfile	[LIB_Shell_search_file_recursively $lib_ge_env(post_pool_dir) $filename$lib_ge_execute_extension.dll]
		set file 	[LIB_Shell_format_path_names "$lib_ge_env(cam_post_dir)$lib_ge_slash$filename$lib_ge_execute_extension.dll"]
	} else {
		set file 	[LIB_Shell_file_pathname "$filename$lib_ge_execute_extension" ".dll" 1]
		if {[string length $file] == 0} {return}
	}

	if {$lib_shell(quick_source) && [string length $file] > 0} {
		MOM_run_user_function $file "$entrypoint"
		lappend lib_ge_log_message "UserFunction $file loaded"
		lappend lib_ge_user_function $file
		lappend lib_ge_monitored_files $file
	} elseif {!$lib_shell(quick_source) && [LIB_Shell_search_file_recursively $lib_ge_env(post_pool_dir) $filename$lib_ge_execute_extension.dll searchfile]} {
		MOM_run_user_function $searchfile "$entrypoint"
		lappend lib_ge_log_message "UserFunction $searchfile loaded"
		lappend lib_ge_user_function $searchfile
		lappend lib_ge_monitored_files $searchfile
	} elseif {[LIB_Shell_file_exists $file]} {
		MOM_run_user_function $file "$entrypoint"
		lappend lib_ge_log_message "UserFunction $file loaded"
		lappend lib_ge_user_function $file
		lappend lib_ge_monitored_files $file
	} else {
		LIB_Shell_abort "Could not find file: $lib_ge_env(post_pool_dir)\\$filename$lib_ge_execute_extension.dll"
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Exchange env variable
#
# <Internal Example>
#
# e.g. set error [JEDLL_SET_VARIABLE UGII_POST_POOL_DIR $lib_ge_env(post_pool_dir)]
#
#____________________________________________________________________________________________
proc LIB_Shell_exchange_env {} {

	global lib_ge_env lib_shell lib_ge_env_init lib_ge_dll_version lib_ge_slash

	set lib_shell(status,bin) 1 ; set lib_shell(bin) [LIB_Shell_format_path_names "$lib_ge_env(installed_machines_dir)${lib_ge_slash}Bin"]
	if {![file isdirectory $lib_shell(bin)]} {set lib_shell(status,bin) 0 ; set lib_shell(bin) $lib_ge_env(installed_machines_dir)}

	set lib_shell(status,controller) 1 ; set lib_shell(controller) [LIB_Shell_format_path_names "$lib_ge_env(installed_machines_dir)${lib_ge_slash}Controller"]
	if {![file isdirectory $lib_shell(controller)]} {set lib_shell(status,controller) 0 ; set lib_shell(controller) $lib_ge_env(installed_machines_dir)}

	set lib_shell(status,libraries) 1 ; set lib_shell(libraries) [LIB_Shell_format_path_names "$lib_ge_env(installed_machines_dir)${lib_ge_slash}Libraries"]
	if {![file isdirectory $lib_shell(libraries)]} {set lib_shell(status,libraries) 0 ; set lib_shell(libraries) $lib_ge_env(installed_machines_dir)}

	set lib_shell(status,bitmaps) 1 ; set lib_shell(bitmaps) [LIB_Shell_format_path_names "$lib_ge_env(installed_machines_dir)${lib_ge_slash}Bitmaps"]
	if {![file isdirectory $lib_shell(bitmaps)]} {set lib_shell(status,bitmaps) 0 ; set lib_shell(bitmaps) ""}

	set ge_dll_version [string toupper $lib_ge_dll_version]

	if {$lib_ge_env(major_version) < 9} {
		if {[info commands loader::setvariable] != ""} {
			set error [loader::setvariable UGII_LIB_POST_CURRENT_MASCH_DIR $lib_ge_env(installed_machines_dir)]
			set error [loader::setvariable POST_LIB_CURRENT_MACH_DIR $lib_ge_env(installed_machines_dir)]
			set error [loader::setvariable POST_LIB_CURRENT_CTRL_DIR $lib_shell(controller)]
			set error [loader::setvariable POST_LIB_CURRENT_BIN_DIR $lib_shell(bin)]
			set error [loader::setvariable POST_LIB_CURRENT_LIB_DIR $lib_shell(libraries)]
			set error [loader::setvariable POST_LIB_CURRENT_BMP_DIR $lib_shell(bitmaps)]
			set error [loader::setvariable POST_SYS_CYCL_VERS "_$ge_dll_version"]
		} elseif {[info commands JEDLL_SET_VARIABLE] != ""} {
			set error [JEDLL_SET_VARIABLE UGII_LIB_POST_CURRENT_MASCH_DIR $lib_ge_env(installed_machines_dir)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_MACH_DIR $lib_ge_env(installed_machines_dir)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_CTRL_DIR $lib_shell(controller)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_BIN_DIR $lib_shell(bin)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_LIB_DIR $lib_shell(libraries)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_BMP_DIR $lib_shell(bitmaps)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_SYS_CYCL_VERS "_$ge_dll_version"]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
		} else {
			LIB_Shell_abort "Cannot replace environment variable"
		}
	} else {
		if {[info commands loader::setvariable] != ""} {
			set error [loader::setvariable UGII_LIB_POST_CURRENT_MASCH_DIR $lib_ge_env(installed_machines_dir)]
			set error [loader::setvariable POST_LIB_CURRENT_MACH_DIR $lib_ge_env(installed_machines_dir)]
			set error [loader::setvariable POST_LIB_CURRENT_CTRL_DIR $lib_shell(controller)]
			set error [loader::setvariable POST_LIB_CURRENT_BIN_DIR $lib_shell(bin)]
			set error [loader::setvariable POST_LIB_CURRENT_LIB_DIR $lib_shell(libraries)]
			set error [loader::setvariable POST_LIB_CURRENT_BMP_DIR $lib_shell(bitmaps)]
			set error [loader::setvariable POST_SYS_CYCL_VERS ""]
		} elseif {[info commands JEDLL_SET_VARIABLE] != ""} {
			set error [JEDLL_SET_VARIABLE UGII_LIB_POST_CURRENT_MASCH_DIR $lib_ge_env(installed_machines_dir)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_MACH_DIR $lib_ge_env(installed_machines_dir)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_CTRL_DIR $lib_shell(controller)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_BIN_DIR $lib_shell(bin)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_LIB_DIR $lib_shell(libraries)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_BMP_DIR $lib_shell(bitmaps)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_SYS_CYCL_VERS ""]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
		} elseif {[info command MOM_set_env_var] != ""} {
			if {"$lib_ge_env(major_version)$lib_ge_env(minor_version)$lib_ge_env(subminor_version)" < "903" && $lib_ge_env(major_version) > "7"} {
				LIB_Shell_special_queries
			} else {
				MOM_set_env_var POST_LIB_CURRENT_MACH_DIR $lib_ge_env(installed_machines_dir)
				MOM_set_env_var POST_LIB_CURRENT_CTRL_DIR $lib_shell(controller)
				MOM_set_env_var POST_LIB_CURRENT_BIN_DIR $lib_shell(bin)
				MOM_set_env_var POST_LIB_CURRENT_LIB_DIR $lib_shell(libraries)
				MOM_set_env_var POST_LIB_CURRENT_BMP_DIR $lib_shell(bitmaps)
				MOM_set_env_var POST_SYS_CYCL_VERS ""
			}
		} else {
			if {[info command MOM_abort] != ""} {LIB_Shell_abort "Cannot replace environment variable"}
		}
	}

	set lib_ge_env(lib_current_mach_dir) 		[MOM_ask_env_var "POST_LIB_CURRENT_MACH_DIR"]
	set lib_ge_env(lib_current_ctrl_dir) 		[MOM_ask_env_var "POST_LIB_CURRENT_CTRL_DIR"]
	set lib_ge_env(lib_current_bin_dir) 		[MOM_ask_env_var "POST_LIB_CURRENT_BIN_DIR"]
	set lib_ge_env(lib_current_lib_dir) 		[MOM_ask_env_var "POST_LIB_CURRENT_LIB_DIR"]
	set lib_ge_env(lib_current_bmp_dir) 		[MOM_ask_env_var "POST_LIB_CURRENT_BMP_DIR"]
	set lib_ge_env(sys_cycl_vers) 			[MOM_ask_env_var "POST_SYS_CYCL_VERS"]

}

proc LIB_Shell_special_queries {} {

	global lib_ge_env lib_shell lib_ge_env_init lib_ge_dll_version lib_ge_slash

	# Workaround if the function not work correctly
	MOM_set_env_var POST_LIB_TEST "POST_LIB_TEST"
	if {[string length [MOM_ask_env_var "POST_LIB_TEST"]] == 0} {
		set ::lib_ge_execute_extension "_nx85_64bit_84"
		LIB_Shell_load_user_function "lib_execute" "JEDLL_NG_Execute"
		if {[info commands JEDLL_SET_VARIABLE] != ""} {
			set error [JEDLL_SET_VARIABLE UGII_LIB_POST_CURRENT_MASCH_DIR $lib_ge_env(installed_machines_dir)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_MACH_DIR $lib_ge_env(installed_machines_dir)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_CTRL_DIR $lib_shell(controller)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_BIN_DIR $lib_shell(bin)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_LIB_DIR $lib_shell(libraries)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			set error [JEDLL_SET_VARIABLE POST_LIB_CURRENT_BMP_DIR $lib_shell(bitmaps)]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			if {"$lib_ge_env(major_version)$lib_ge_env(minor_version)$lib_ge_env(subminor_version)" > "901"} {
				set error [JEDLL_SET_VARIABLE POST_SYS_CYCL_VERS ""]
				if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
			} else {
				# SYS_CYCLE Drill_Tap_Breakchip, SYS_CYCLE Drill_Tap_Deep, SYS_CYCLE Drill_Tap_Float not available
				set error [JEDLL_SET_VARIABLE POST_SYS_CYCL_VERS "_NX85"]
				if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
				if {[LIB_Shell_file_pathname "ctrl_s840d_base" ".cdl" 1] != "" && [LIB_Shell_file_pathname "ctrl_s840d_base_cycle_NX85" ".cdl" 1] == "" || \
				    [LIB_Shell_file_pathname "ctrl_s828d_base" ".cdl" 1] != "" && [LIB_Shell_file_pathname "ctrl_s828d_base_cycle_NX85" ".cdl" 1] == ""} {
					if {[regexp -nocase -- "Libraries" [LIB_Shell_file_pathname "ctrl_s840d_base" ".cdl" 1]] || \
				    	    [regexp -nocase -- "Libraries" [LIB_Shell_file_pathname "ctrl_s828d_base" ".cdl" 1]]} {
					    LIB_Shell_abort "\n The postprocessor can not be executed because the function:\n\n\
								SYS_CYCLE Drill_Tap_Breakchip,\n\
								SYS_CYCLE Drill_Tap_Deep and\n\
								SYS_CYCLE Drill_Tap_Float\n\n\
								are not yet supported in the ctrl_s8**d_base.cdl before NX9.0.2.\n\n\
								\n Please comment this manuel, or make ctrl_s8**d_base_cycle_NX85.cdl available."
					}
				}
			}
		}
		# Check if the variable is now set
		if {[string length [MOM_ask_env_var "POST_LIB_CURRENT_MACH_DIR"]] == 0} {
			MOM_output_to_listing_device "Unfortunately, the current version of NX can not be supported."
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Load lib_general
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_load_loader {} {

	global lib_ge_env lib_ge_slash sourcefile
	global lib_cycle_loader loaderfile lib_shell

	if {[info commands LIB_GE_source] == "" && ($lib_ge_env(major_version) >= 9 || [string match "85" "$lib_ge_env(major_version)$lib_ge_env(minor_version)"] && $::tcl_version >= 8.4)} {

		set lib_shell(PCE_ready) 1

		if {[llength [info commands ::loader::load]]} {
			lappend lib_ge_log_message "Included LoaderFunction loaded"
			set lib_shell(load_loader) 1
			return
		}

		if {!$lib_shell(quick_source)} {

			set searchpath "$lib_ge_env(installed_machines_dir,recursively)"
			lappend searchpath $lib_ge_env(post_pool_dir)

			foreach path $searchpath {

				set sourcefile [LIB_Shell_format_path_names "${path}${lib_ge_slash}loader.dll"]
				if {[LIB_Shell_file_exists $sourcefile]} {
					uplevel #0 {
						catch {
							load $sourcefile ; set loaderfile $sourcefile
							lappend lib_ge_log_message "LoaderFunction INS->$sourcefile<- loaded"
							lappend lib_ge_user_function "$sourcefile"
							lappend lib_ge_monitored_files "$sourcefile"
							set lib_shell(load_loader) 1
						} err
						if {[info exists err] && [string length $err] > 0} {
							set errcheck [file exists $sourcefile]
							MOM_output_to_listing_device "Error when loading the file:\n$err\n File exists '$errcheck' (0=No/1=Yes)"
							if {$errcheck} {MOM_output_to_listing_device "Possibly NX was open when copying and the file is now corrupt."}
							MOM_log_message "Error when loading the file:\n$err\n File exists '$errcheck' (0=No/1=Yes)"
							if {$errcheck} {MOM_log_message "Possibly NX was open when copying and the file is now corrupt."}
						}
					}
				}
			}
		} else {
			set sourcefile [LIB_Shell_file_pathname "loader" ".dll"]
			uplevel #0 {
				catch {
					load $sourcefile ; set loaderfile $sourcefile
					lappend lib_ge_log_message "LoaderFunction INS->$sourcefile<- loaded"
					lappend lib_ge_user_function "$sourcefile"
					lappend lib_ge_monitored_files "$sourcefile"
					set lib_shell(load_loader) 1
				} err
				if {[info exists err] && [string length $err] > 0} {
					set errcheck [file exists $sourcefile]
					MOM_output_to_listing_device "Error when loading the file:\n$err\n File exists '$errcheck' (0=No/1=Yes)"
					if {$errcheck} {MOM_output_to_listing_device "Possibly NX was open when copying and the file is now corrupt."}
					MOM_log_message "Error when loading the file:\n$err\n File exists '$errcheck' (0=No/1=Yes)"
					if {$errcheck} {MOM_log_message "Possibly NX was open when copying and the file is now corrupt."}
				}			}
		}
	} else {
		set lib_shell(PCE_ready) 0
		if {[info exists lib_shell(load_loader)]} {unset lib_shell(load_loader)}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Load lib_general
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_load_general {} {

	global lib_ge_env lib_ge_slash lib_ge_debug
	global lib_cycle_path sourcefile sourcefilename errorInfo
	global lib_spf loaderfile lib_shell

	set errorInfo ""

	if {[info commands LIB_GE_source] == ""} {

		if {[info exists ::status]} {unset ::status}

		if {!$lib_shell(quick_source)} {
			set lib_cycle_path 0
			set searchpath "$lib_ge_env(installed_machines_dir,recursively)"
			lappend searchpath $lib_ge_env(post_pool_dir)

			foreach path $searchpath {
				if {$lib_cycle_path} {break}
				foreach ext {.pce .pcf .tbc .tcl} {
					set sourcefile [LIB_Shell_format_path_names "${path}${lib_ge_slash}lib_general$ext"]
					set sourcefilename $sourcefile
					if {[LIB_Shell_file_exists $sourcefile]} {
						if {$ext == ".tbc" && [info exists ::lib_ge_ByteCodeLoader_msg]} {MOM_log_message $::lib_ge_ByteCodeLoader_msg ; unset ::lib_ge_ByteCodeLoader_msg}
						uplevel #0 {
							if {$lib_shell(PCE_ready) && [string match ".pce" [file extension $sourcefile]]} {
								if {![llength [info commands ::loader::load]]} {
									LIB_Shell_abort "Loader is unavailable, check installation to execute encrypted files"
								}
								if {[catch {::loader::load [file nativename [file join $sourcefile]]}]} {
									LIB_Shell_abort "Loader is available, but does not supported this version"
								} ; set status 1
								set lib_ge_debug(lib_general) "$sourcefilename"
								lappend lib_ge_monitored_files "$sourcefilename"
								lappend lib_ge_log_message "\n--> $sourcefilename loaded"
								lappend lib_ge_debug(sourced) $sourcefilename
								set lib_cycle_path 1 ; break

							} else {

								if {![info exists status]} {
									if {$tcl_version >= 8.6 && [catch {source -encoding utf-8 $sourcefile} err]} {
										if {[string match ".tbc" [file extension $sourcefile]]} {
											MOM_log_message "--->[info command tbcload::*]<---"
											MOM_log_message "--->package names='[package names]' - package version='[package versions tbcload]'<---"
										}
										if {[info exists ::errorInfo]} {
											MOM_log_message "--->ErrorInfo='$errorInfo'<---"
											MOM_output_to_listing_device "errorInfo $errorInfo"
										}
										LIB_Shell_abort "File lib_general $err not loadable in section"
									}
									if {$tcl_version < 8.6 && [catch {source $sourcefile} err]} {
										if {[string match ".tbc" [file extension $sourcefile]]} {
											MOM_log_message "--->[info command tbcload::*]<---"
											MOM_log_message "--->package names='[package names]' - package version='[package versions tbcload]'<---"
										}
										if {[info exists ::errorInfo]} {
											MOM_log_message "--->ErrorInfo='$errorInfo'<---"
											MOM_output_to_listing_device "errorInfo $errorInfo"
										}
										LIB_Shell_abort "File lib_general $err not loadable in section"
									}
								}

								set lib_ge_debug(lib_general) "$sourcefilename"
								lappend lib_ge_monitored_files "$sourcefilename"
								lappend lib_ge_log_message "\n--> $sourcefilename loaded"
								lappend lib_ge_debug(sourced) $sourcefilename
								set lib_cycle_path 1 ; break

							}
						}
					}
				}
			}
			if {!$lib_cycle_path} {
				LIB_Shell_abort "File lib_general not found"
			}
		} else {

			set sourcefile [LIB_Shell_file_pathname "lib_general"]
			set sourcefilename $sourcefile
			if {([file extension $sourcefile] == ".tbc" || [file extension $sourcefile] == ".pcf") && [info exists ::lib_ge_ByteCodeLoader_msg]} {MOM_log_message $::lib_ge_ByteCodeLoader_msg ; unset ::lib_ge_ByteCodeLoader_msg}

			uplevel #0 {
				if {$lib_shell(PCE_ready) && [string match ".pce" [file extension $sourcefile]]} {
					if {![llength [info commands ::loader::load]]} {
						LIB_Shell_abort "Loader is unavailable, check installation to execute encrypted files"
					}
					if {[catch {::loader::load [file nativename [file join $sourcefile]]}]} {
						LIB_Shell_abort "Loader is available, but does not supported this version"
					} ; set status 1
					set lib_ge_debug(lib_general) "$sourcefilename"
					lappend lib_ge_monitored_files "$sourcefilename"
					lappend lib_ge_log_message "\n--> $sourcefilename loaded"
					lappend lib_ge_debug(sourced) $sourcefilename

				} else {
					if {![info exists status]} {

						if {$tcl_version >= 8.6 && [catch {source -encoding utf-8 $sourcefile} err]} {
							if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $errorInfo"}
							LIB_Shell_abort "File lib_general $err not loadable in section"
						}

						if {$tcl_version < 8.6 && [catch {source $sourcefile} err]} {
							if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $errorInfo"}
							LIB_Shell_abort "File lib_general $err not loadable in section"
						}

					}

					set lib_ge_debug(lib_general) "$sourcefilename"
					lappend lib_ge_monitored_files "$sourcefilename"
					lappend lib_ge_log_message "\n--> $sourcefilename loaded"
					lappend lib_ge_debug(sourced) $sourcefilename
				}
			}
		}

		if {[info exists ::status]} {unset ::status}
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Load lib_xml_handling
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_load_xml_handling {} {

	global lib_ge_env lib_ge_slash lib_ge_debug
	global lib_cycle_path sourcefile errorInfo
	global lib_shell

	set errorInfo ""

	if {!$lib_shell(load_library) && [info commands LIB_XML_xml_to_list] != "LIB_XML_xml_to_list"} {

		if {[info exists ::status]} {unset ::status} ;#we have to unset it. it could be set from LIB_Shell_load_general

		if {!$lib_shell(quick_source)} {
			set lib_cycle_path 0
			set searchpath "$lib_ge_env(installed_machines_dir,recursively)"
			lappend searchpath $lib_ge_env(post_pool_dir)
			foreach path $searchpath {
				if {$lib_cycle_path} {break}
				foreach ext {.pce .pcf .tbc .tcl} {
					set sourcefile [LIB_Shell_format_path_names "${path}${lib_ge_slash}lib_xml_handling$ext"]
					if {[LIB_Shell_file_exists $sourcefile]} {
						if {$ext == ".tbc" && [info exists ::lib_ge_ByteCodeLoader_msg]} {MOM_log_message $::lib_ge_ByteCodeLoader_msg ; unset ::lib_ge_ByteCodeLoader_msg}
						uplevel #0 {

							if {[string match ".pce" [file extension $sourcefile]]} {

								if {[catch {::loader::load [file nativename [file join $sourcefile]]}]} {
									LIB_Shell_abort "Loader is available, but does not supported this version"
								} ; set status 1
								set lib_ge_debug(lib_xml_handling) "$sourcefile"
								lappend lib_ge_monitored_files "$sourcefile"
								lappend lib_ge_log_message "\n--> $sourcefile loaded"
								lappend lib_ge_debug(sourced) $sourcefile
								set lib_cycle_path 1 ; break

							} else {
								if {![info exists status]} {
									if {[catch {LIB_GE_source_covered_with_arguments $sourcefile implicitly 0} err]} {
										if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $errorInfo"}
										LIB_Shell_abort "File lib_xml_handling '$err' not loadable in section"
									}
								}

								set lib_ge_debug(lib_xml_handling) "$sourcefile"
								lappend lib_ge_monitored_files "$sourcefile"
								lappend lib_ge_log_message "\n--> $sourcefile loaded"
								lappend lib_ge_debug(sourced) $sourcefile
								set lib_cycle_path 1 ; break
							}
						}
					}
				}
			}
			if {!$lib_cycle_path} {
				LIB_Shell_abort "File lib_xml_handling not found"
			}
		} else {
			set sourcefile [LIB_Shell_file_pathname "lib_xml_handling"]
			if {[file extension $sourcefile] == ".tbc" && [info exists ::lib_ge_ByteCodeLoader_msg]} {MOM_log_message $::lib_ge_ByteCodeLoader_msg ; unset ::lib_ge_ByteCodeLoader_msg}
			uplevel #0 {
				if {[string match ".pce" [file extension $sourcefile]]} {

					if {[catch {::loader::load [file nativename [file join $sourcefile]]}]} {
						LIB_Shell_abort "Loader is available, but does not supported this version"
					} ; set status 1
					set lib_ge_debug(lib_xml_handling) "$sourcefile"
					lappend lib_ge_monitored_files "$sourcefile"
					lappend lib_ge_log_message "\n--> $sourcefile loaded"
					lappend lib_ge_debug(sourced) $sourcefile
				} else {

					if {![info exists status]} {
						if {[catch {LIB_GE_source_covered_with_arguments $sourcefile implicitly 0} err]} {
							if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $errorInfo"}
							LIB_Shell_abort "File lib_xml_handling '$err' not loadable in section"
						}
					}

					set lib_ge_debug(lib_xml_handling) "$sourcefile"
					lappend lib_ge_monitored_files "$sourcefile"
					lappend lib_ge_log_message "\n--> $sourcefile loaded"
					lappend lib_ge_debug(sourced) $sourcefile
				}
			}
		}

		if {[info exists ::status]} {unset ::status}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Load ugpost_base
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_load_ugpost_base {} {

	global lib_flag lib_ge_env lib_ge_slash
	global lib_cycle_path sourcefile lib_ge_debug

	if {!$lib_flag(load_ugpost_base)} {return}

	if {[info commands LIB_GE_source] == ""} {
		set lib_cycle_path 0
		set searchpath "$lib_ge_env(installed_machines_dir,recursively)"
		lappend searchpath $lib_ge_env(cam_post_dir)
		lappend searchpath $lib_ge_env(post_pool_dir)
		foreach path $searchpath {
			if {$lib_cycle_path} {break}
			foreach ext {.tbc .tcl} {
				set sourcefile [LIB_Shell_format_path_names "${path}${lib_ge_slash}ugpost_base$ext"]
				if {[LIB_Shell_file_exists $sourcefile]} {
					uplevel #0 {

						set err ""
						if {$tcl_version >= 8.6 && [catch {source -encoding utf-8 $sourcefile} err]} {
							if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $errorInfo"}
							LIB_Shell_abort "File lib_general $err not loadable"
						}
						if {$tcl_version < 8.6 && [catch {source $sourcefile} err]} {
							if {[info exists ::errorInfo]} {MOM_output_to_listing_device "errorInfo $errorInfo"}
							LIB_Shell_abort "File lib_general $err not loadable"
						}
						if {[string length $err] > 0} {
							set lib_ge_debug(lib_general) "$sourcefile"
							lappend lib_ge_monitored_files "$sourcefile"
							lappend lib_ge_log_message "\n--> $sourcefile loaded"
							lappend lib_ge_debug(sourced) $sourcefile
							catch {unset mom_sys_leader}
							set lib_cycle_path 1 ; break
						}

					}
				}
			}
		}
		if {!$lib_cycle_path} {
			LIB_Shell_abort "File ugpost_base not found"
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
proc LIB_Shell_init {} {

	global lib_ge_user_function lib_ge_execute_extension
	global lib_ge_dll_version lib_ge_nx_platform lib_ge_env
	global lib_pp_source_file lib_ge_slash lib_shell
	global lib_load_user_function
	global errorCode errorInfo

	if {$lib_shell(load_library) && [info commands LIB_Shell_init_custom] != ""} {LIB_Shell_init_custom}
	if {$lib_shell(load_library) && [info commands LIB_Shell_load] != ""} {LIB_Shell_load}

	LIB_Shell_path_init $lib_ge_env(installed_machines_dir)
	if {![LIB_Shell_directory_exists "$lib_ge_env(installed_machines_dir)\\Bin"]} {
		set lib_shell(quick_source) 0
	}
	# In special cases, the customer's environment UGII_CAM_POST_DIR can be initialized if here an subdirectory or an dummy defined
	if {$::lib_shell(quick_source,cam_post_dir) != ""} {
		LIB_Shell_path_init $lib_ge_env(cam_post_dir) $::lib_shell(quick_source,cam_post_dir)
	}
	if {![string match $lib_ge_env(post_pool_dir) $lib_ge_env(installed_machines_dir)]} {
		LIB_Shell_path_init $lib_ge_env(post_pool_dir) $::lib_shell(quick_source,post_pool_dir)
		LIB_Shell_path_init $lib_ge_env(cam_post_dir) $::lib_shell(quick_source,cam_post_dir)
	}

	LIB_Shell_load_package tdom
	if {[llength [info commands LIB_Shell_init_packag_custom]]} {LIB_Shell_init_packag_custom}
	LIB_Shell_load_bytecode

	if {![info exists lib_ge_env(installed_machines_dir,recursively)]} {
		set lib_ge_env(installed_machines_dir,recursively) $lib_ge_env(installed_machines_dir)
	}

	set lib_ge_user_function ""
	set lib_ge_execute_extension "_32bit"
	if {$lib_ge_nx_platform == 64} {set lib_ge_execute_extension "_64bit"}

	# Available as basic functions from NX9, but optionally possible via lib_load_user_function
	if {$lib_ge_env(major_version) < 9 || [info exists lib_load_user_function] && $lib_load_user_function} {
		# Workaround, if inside NX8.5 TCL 8.4 as a preview active
		if {[string match "85" "$lib_ge_env(major_version)$lib_ge_env(minor_version)"] && $::tcl_version >= 8.4} {
			append lib_ge_execute_extension "_84"
		}
		LIB_Shell_load_user_function "lib_execute_$lib_ge_dll_version" "JEDLL_NG_Execute"
	}

	LIB_Shell_load_loader

	LIB_Shell_exchange_env

	LIB_Shell_load_ugpost_base

	LIB_Shell_load_general

	LIB_Shell_load_xml_handling

	LIB_Shell_defined_post_environment

	if {![info exists lib_shell(version)] || $lib_shell(version) < 2} {
		if {$lib_shell(load_library)} {
			set lib_pp_source_file [LIB_GE_cleanup_list [list "lib_general" "lib_msg" "lib_file_handling" "lib_standard_post_func" "lib_document"] $lib_pp_source_file 1]
		}
	}

	if {[info commands LIB_GE_cleanup_list] != ""} {
		set lib_pp_source_file [LIB_GE_cleanup_list $lib_pp_source_file]
	} else {
		if {[info exists errorCode] && [string length $errorCode] > 0} {
			MOM_log_message "$errorCode"
		}
		if {[info exists errorInfo] && [string length $errorInfo] > 0} {
			MOM_log_message "$errorInfo"
		}
		LIB_Shell_abort "Cannot run current post-processor, one or more files could not be loaded"
	}

	LIB_GE_source

	LIB_GE_layer_editor

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Read the sourcingfiles from an XML file
#
# <Internal Example>
#
# <?xml version="1.0" encoding="utf-8"?>
# <Configuration>
#   <Copyright>Copyright © 2012-2018 Siemens Industry Software GmbH & Co. KG</Copyright>
#   <Version>1.0</Version>
#   <Controller>Siemens 840D</Controller>
#   <MachineName>MyMachine</MachineName>
#   <Environment>
#     <Variable Name="UGII_CAM_LIBRARY_INSTALLED_MACHINES_DEF_DIR" Target="D:\Temp\post_mit_kim"></Variable>
#   </Environment>
#   <Sourcing>
#     <Sequence>
#       <SubFolder Folder="Bin" />
#       <SubFolder Folder="Controller" />
#       <SubFolder Folder="Libraries" />
#       <Filename Name="ctrl_s840d_base" Processing="true" />
#       <Filename Name="post_mit_kim_mtb" Processing="true" />
#       <Filename Name="oem_my_oem" Processing="true" />
#       <Filename Name="mach_my_machine" Processing="true" />
#       <Filename Name="post_mit_kim_service" Processing="true" />
#       <Filename Name="post_mit_kim_test" Processing="true" />
#	<Filename Name="shop_doc" Processing="true" Folder="UGII_CAM_SHOP_DOC_DIR" Extension=".TCL" />
#     </Sequence>
#   </Sourcing>
#   <Metadata>
#     <Comment>
#       <Changes>Uwe Roosz</Changes>
#       <Date>2014/05/15 12:00:00</Date>
#       <Content>Auto-generated by aPB</Content>
#     </Comment>
#     <Customer>
#       <Company></Company>
#       <Address></Address>
#       <Contact></Contact>
#       <Phone></Phone>
#       <Fax></Fax>
#       <Mail></Mail>
#     </Customer>
#   </Metadata>
# </Configuration>
#
#____________________________________________________________________________________________
proc LIB_Shell_external_source {} {

	global lib_ge_installed_machines lib_xml_node_idx
	global lib_pp_source_file lib_pp_source_folder
	global lib_shell lib_xml node

	set sourcefile [LIB_Shell_format_path_names "[file rootname $lib_ge_installed_machines].psc"]
	if {![LIB_Shell_file_exists $sourcefile]} {return}

	if {[info commands LIB_XML_to_list] != ""} {
		if {[info exists lib_shell(package,tdom)]} {
			LIB_XML_tdom_load $sourcefile

			if {[info exists lib_xml(tdom)]} {
				foreach sublist $lib_xml(tdom) {
					switch -- [string tolower [lindex $sublist 0]] {
					  "configuration"	{
						  			foreach {name value} [lindex $sublist 1] {
						  				LIB_Shell_external_status_variable $name $value
						  			}
						  			if {[info exists lib_shell(version)] && $lib_shell(version) > 1} {
						  				set lib_pp_source_file ""
						  			}
					  			}
					  "variable"		{
					  				foreach {name target} [lindex $sublist 1] {
					  					LIB_Shell_external_source_variable $name $target
					  				}
					  			}
					  "subfolder"		{
					  				foreach {name} [lindex $sublist 1] {
					  					LIB_Shell_external_source_subfolder $name
					  				}
					  			}
					  "filename" -
					  "scripts"		{
					  				LIB_Shell_external_source_files [lindex $sublist 1]
					  			}
					  "definedevents"	{
					  				LIB_Shell_external_def_files [lindex $sublist 1]
					  			}
					  "customerdialogs"	{
					  				LIB_Shell_external_cdl_files [lindex $sublist 1]
					  			}
					  "functions"		{
					  				# Implementation currently still without reaction
					  			}
					}
				}
			}

		} else {

			set xmllist [LIB_XML_to_list $sourcefile]

			# Read out all environment which are to be created
			set node [LIB_XML_get_node $xmllist Environment]

			set lib_xml_node_idx 0
			while	{$lib_xml_node_idx > -1} {
				set namelist [LIB_XML_get_nodes $node Variable]
				set name [lindex [lindex $namelist 1] [expr [lsearch -exact [lindex $namelist 1] "Name"]+1]]
				set target [lindex [lindex $namelist 1] [expr [lsearch -exact [lindex $namelist 1] "Target"]+1]]
				LIB_Shell_external_source_variable $name $target
			}

			# Read out all environment which are to be created
			set value [LIB_XML_get_value $xmllist "Version"]
			if {[llength $value]} {
				LIB_Shell_external_status_variable "Version" $value
	  			if {[info exists lib_shell(version)] && $lib_shell(version) > 1} {
	  				set lib_pp_source_file ""
	  			}
			}

			# Read out all folder which are to be analysed
			set node [LIB_XML_get_node $xmllist Sourcing]
			set node [LIB_XML_get_node $node Sequence]

			set lib_xml_node_idx 0
			while	{$lib_xml_node_idx > -1} {
				set namelist [LIB_XML_get_nodes $node SubFolder]
				set name [lindex [lindex $namelist 1] [expr [lsearch -exact [lindex $namelist 1] "Folder"]+1]]
				LIB_Shell_external_source_subfolder $name
			}

			# Read out all filenames which are to be sourced
			set node [LIB_XML_get_node $xmllist Sourcing]
			set node [LIB_XML_get_node $node Sequence]

			set lib_xml_node_idx 0
			while	{$lib_xml_node_idx > -1} {
				LIB_Shell_external_source_files
			}
		}

	} else {
		# The current post-processor can not run, because not all files were loaded
		# This is also the case, if utility.pce not available
		return
	}

}

set lib_shell(version) 1.0

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Internal function to handle loading environment variables
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_external_status_variable {name value} {

	global lib_shell

	if {[string length $name] > 0} {
		set lib_shell([string tolower $name]) $value
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Internal function to handle loading environment variables
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_external_source_variable {name target} {

	if {[string length $name] > 0} {
		if {[info commands MOM_set_env_var] != ""} {
			set error [MOM_set_env_var $name $target]
		} elseif {[info commands JEDLL_SET_VARIABLE] != ""} {
			set error [JEDLL_SET_VARIABLE $name $target]
			if {$error!=0} {MOM_log_message "ERROR JEDLL_SET_VARIABLE $::errorInfo $::error"}
		} else {
			MOM_log_message "Not possible to set environment variable"
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Internal function to handle loading sub folder
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_external_source_subfolder {name} {

	if {[string length $name] > 0} {
		LIB_Shell_path_init $name
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Internal function to handle loading files
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_external_source_files {{list ""} {action 0}} {

	global lib_pp_source_file lib_shell node lib_xml_node_idx

	array set external "Name {} Processing {} Folder {} Extension {}"
	if {!$action && [llength $list] < 1} {

		if {![info exists lib_shell(version)] || $lib_shell(version) < 2} {
			array set external [lindex [LIB_XML_get_nodes $node Filename] 1]
		} else {
			set nodes [LIB_XML_get_nodes $node [list Layer Filename]]
			switch -- [lindex $nodes 0] {
				"Layer"
				{

					if {[string match "Name" [lindex [lindex $nodes 1] 0]]} {
						foreach {variable value} [lindex $nodes 1] {
							switch -- $variable {
								"SubFolder"
								{
									if {[string match "Bin" $value] || [string match "Controller" $value] || [string match "Libraries" $value]} {
										continue
									}
									set value [LIB_GE_search_pathname $value]
									if {![LIB_Shell_file_exists $value]} {
										set value [file join $::lib_ge_env(installed_machines_dir) $value]
										set value [LIB_GE_search_pathname $value]
									}

									LIB_Shell_external_source_subfolder $value
								}
							}
						}
					}

					foreach e {Scripts DefinedEvents CustomerDialogs Functions} {
						set nodes [LIB_XML_get_node $nodes $e]
						switch -- [lindex $nodes 0] {
							"Scripts"
							{
								foreach files [lindex $nodes 2] {
									LIB_Shell_external_source_files [lindex $files 1] 1
								}
								return
							}
							"DefinedEvents"
							{
								foreach files [lindex $nodes 2] {
									LIB_Shell_external_def_files [lindex $files 1]
								}
								return
							}
							"CustomerDialogs"
							{
								foreach files [lindex $nodes 2] {
									LIB_Shell_external_cdl_files [lindex $files 1]
								}
								return
							}
							"Functions"
							{
								# Implementation currently still without reaction
							}
						}
					}
				}
				"Filename"
				{
					array set external [lindex $nodes 1]
				}
			}
		}
	} else {
		array set external $list
	}

	if {[string match -nocase "TRUE" $external(Processing)] || ![string length $external(Processing)]} {
		if {[string length $external(Folder)] && [string length $external(Name)]} {
			if {[string length $external(Extension)]} {
				lappend lib_pp_source_file "$external(Name)@[LIB_GE_format_path_names [LIB_GE_search_pathname $external(Folder)] 1 2]@$external(Extension)"
			} else {
				lappend lib_pp_source_file "$external(Name)@[LIB_GE_format_path_names [LIB_GE_search_pathname $external(Folder)] 1 2]"
			}
		} elseif {[string length $external(Name)]} {
			if {[string length $external(Extension)]} {
				lappend lib_pp_source_file "$external(Name)@@$external(Extension)"
			} else {
				lappend lib_pp_source_file "$external(Name)"
			}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Internal function to handle loading def files
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_external_def_files {{list ""}} {

	global lib_pp_source_file node

	array set external "Name {} Processing {} Include {} Folder {} Extension {}"
	if {[llength $list] < 1} {
		array set external [lindex [LIB_XML_get_nodes $node Filename] 1]
	} else {
		array set external $list
	}

	if {[string length $external(Extension)] <= 0} {set external(Extension) ".def"}

	if {[string match -nocase "FALSE" $external(Include)] && ([string match -nocase "TRUE" $external(Processing)] || ![string length $external(Processing)])} {
		if {[string length $external(Folder)] && [string length $external(Name)]} {
			if {[string length $external(Extension)]} {
				lappend lib_pp_source_file "$external(Name)@[LIB_GE_format_path_names [LIB_GE_search_pathname $external(Folder)] 1 2]@$external(Extension)"
			}
		} elseif {[string length $external(Name)]} {
			if {[string length $external(Extension)]} {
				lappend lib_pp_source_file "$external(Name)@@$external(Extension)"
			}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Internal function to handle loading def files
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_external_cdl_files {{list ""}} {

	global lib_pp_source_file node

	array set external "Name {} Processing {} Include {} Folder {} Extension {}"
	if {[llength $list] < 1} {
		array set external [lindex [LIB_XML_get_nodes $node Filename] 1]
	} else {
		array set external $list
	}

	if {[string length $external(Extension)] <= 0} {set external(Extension) ".cdl"}

	if {[string match -nocase "FALSE" $external(Include)] && ([string match -nocase "TRUE" $external(Processing)] || ![string length $external(Processing)])} {
		if {[string length $external(Folder)] && [string length $external(Name)]} {
			if {[string length $external(Extension)]} {
				lappend lib_pp_source_file "$external(Name)@[LIB_GE_format_path_names [LIB_GE_search_pathname $external(Folder)] 1 2]@$external(Extension)"
			}
		} elseif {[string length $external(Name)]} {
			if {[string length $external(Extension)]} {
				lappend lib_pp_source_file "$external(Name)@@$external(Extension)"
			}
		}
	}
}

set lib_flag(format_path_names,reference) ""
set lib_flag(format_path_names,compare) ""

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
# <Internal Example>
# set error [LIB_Shell_format_path_names "D:/Temp/mom/debug.out"]
#____________________________________________________________________________________________
proc LIB_Shell_format_path_names {pathname} {

	global lib_flag lib_ge_platform

	# Store the information into the list to make the procedure a bit faster
	regsub -all "/" $pathname "\\" pathname
	set reference [lsearch -exact $lib_flag(format_path_names,reference) $pathname]
	if {$reference < 0} {
		lappend lib_flag(format_path_names,reference) $pathname
	} else {
		return [lindex $lib_flag(format_path_names,compare) $reference]
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
	set returnvalue [string trim $pathname]
	if {$reference < 0} {
		lappend lib_flag(format_path_names,compare) $returnvalue
	}
	return $returnvalue

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Workaround to handle 'file exists' in a faster way
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_file_exists {check {realtime 0} {reset 0}} {

	global lib_shell

	# TCL has an bug in the commands "file exists"
	# this requires at version 8.4 many times during execution
	if {$::tcl_version != 8.4} {
		return [file exists $check]
	}

	# Replaces the following functionality ; # return [file exists $check]

	set lib_shell(path) 		[LIB_Shell_format_path_names [file dirname $check]]
	set lib_shell(file) 		[file rootname [file tail $check]]
	set lib_shell(extension) 	[file extension $check]

	if {![string length $lib_shell(path)] || ![string length $lib_shell(file)] || ![string length $lib_shell(extension)]} {return 0}
	binary scan $lib_shell(path) H* pathbin

	# Query at loop, updated information is needed
	if {$realtime || [string match $pathbin [lindex [array get lib_shell check] 1]]} {
		return [file exists $check]
	}

	if {$reset && [llength [array get lib_shell $pathbin]]} {unset lib_shell($pathbin)}
	if {![llength [array get lib_shell $pathbin]]} {
		set lib_shell($pathbin) [string tolower [LIB_Shell_file_glob $lib_shell(path)]]
		if {$lib_shell($pathbin) == 0} {
			return 0
		}
	}

	set lib_shell(check) $pathbin

	if {[llength [array get lib_shell $pathbin]]} {
		if {[lsearch -exact [string tolower $lib_shell($pathbin)] [string tolower "$lib_shell(file)$lib_shell(extension)"]] > -1} {
			return 1
		}
	}
	return 0

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Workaround to handle 'file isdirectory' in an faster way
#
# <Internal Example>
#
#____________________________________________________________________________________________
proc LIB_Shell_directory_exists {check {realtime 0}} {

	global lib_shell

	# Replaces the following functionality ; # return [file isdirectory "$check"]
	if {$realtime == 2} {
		return [file isdirectory $check]
	}

	set check [LIB_Shell_format_path_names $check]
	if {![regexp -nocase -- {^\\{2}|^\/|^[A-Z]:\\} $check]} {return 0}
	binary scan $check H* pathbin

	if {!$realtime && [info exists lib_shell($pathbin,unavailable)]} {
		return 0
	} elseif {$realtime || ![info exists lib_shell($pathbin)]} {
		set current_path [pwd]

		if {$realtime && [info exists lib_shell($pathbin)]} {unset lib_shell($pathbin)}
		if {[catch {cd $check}]} {
			if {[string length $pathbin] > 0} {
				lappend lib_shell($pathbin,unavailable) 1
			}
			return 0
		}
		cd $current_path
		lappend lib_shell($pathbin) 1
		return 1
	} elseif {[info exists lib_shell($pathbin)]} {
		return 1
	}
	return 0
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Search glob directories
#
# Argument (1):
# path to search
#
# Argument (2):
# f = file
# p = path
# c = all
#
# <Internal Example>
#
# set content [LIB_Shell_file_glob "D:/Temp/Test"]
# returns e.g.: Test Functions Librarys
#____________________________________________________________________________________________
proc LIB_Shell_file_glob {path {argument "file"}} {

	global tcl_version lib_ge_platform

	if {$lib_ge_platform} {
		# Glob leaves TCL crash is some reson, depending on the file name (special characters)
		if {$::lib_shell(quick_source,globstyle) || [regexp -nocase -- {^[\\]{2}|^[/]{2}} $path]} {
			# Reaction with unc directories
			if {$tcl_version <= 8.3} {set initialdir [pwd] ; cd $path}
			switch -- $argument {
				f - file		{
								if {$tcl_version > 8.3} {
					    				 return [glob -nocomplain -directory [file nativename $path] -tails -types f *{tcl,tbc,pce,pcf,dll,exe,psc,cdl,def}]
								} else {
									set returnvalue [glob -nocomplain *{tcl,tbc,pce,pcf,dll,exe,psc,cdl,def}]
								}
							}
				p - path		{
								if {$tcl_version > 8.3} {
					    				 return [glob -nocomplain -directory [file nativename $path] -types d *]
								} else {
									set value [glob -nocomplain *] ; set returnvalue ""
									foreach e $value {if {[LIB_Shell_directory_exists [file join $path $e]]} {lappend returnvalue [LIB_Shell_format_path_names [file join $path $e]]}}
								}
							}
				r - pathrecursively	{
								set dirs "" ; lappend dirs [file join $path] ; set initial $dirs ; set initialdir "" ; lappend initialdir [pwd]
								while {[llength $dirs]} {
									set name [lindex $dirs 0]
									if {$tcl_version > 8.3} {
								    		set dirs [concat [glob -nocomplain -directory [lindex $dirs 0] -type d *] [lrange $dirs 1 end]]
									} else {
										cd [lindex $dirs 0] ; if {[catch {glob *}]} {lappend directories [lindex $dirs 0] ; set dirs [concat [lrange $dirs 1 end]] ; continue} else {set all [glob *]}
										foreach e $all {if {[LIB_Shell_directory_exists [file join [lindex $dirs 0] $e]]} {lappend dirs [file join [lindex $dirs 0] $e]}}
										set dirs [concat [lrange $dirs 1 end]]
									}
									lappend directories [LIB_Shell_format_path_names $name]
								}
								cd [lindex $initialdir 0]
								return $directories
							}
				c - content 		{
								if {$tcl_version > 8.3} {
					    				 return [glob -nocomplain -directory [file nativename $path] -tails -types f *]
								} else {
									set returnvalue [glob -nocomplain *]
								}
							}
			}
			if {$tcl_version <= 8.3} {cd $initialdir ; return $returnvalue}
		} else {
			# Reaction with directories
			switch -- $argument {
				f - file		{return [LIB_Shell_files_from_dir $path "/a-d" "*.tcl *.tbc *.pce *.pcf *.dll *.exe *.psc *.cdl *.def"]}
				p - path		{return [LIB_Shell_files_from_dir $path "/ad"]}
				r - pathrecursively	{return [LIB_Shell_files_from_dir $path "/ad" "/s"]}
				c - content 		{return [LIB_Shell_files_from_dir $path "" "*"]}
			}
		}
	} else {
			if {$tcl_version <= 8.3} {set initialdir [pwd] ; cd $path}
			switch -- $argument {

				f - file	{
								if {$tcl_version > 8.3} {
					    				 return [glob -nocomplain -directory [file nativename $path] -tails -types f *{tcl,tbc,pce,pcf,dll,exe,psc,cdl,def}]
								} else {
									set returnvalue [glob -nocomplain *{tcl,tbc,pce,pcf,dll,exe,psc,cdl,def}]
								}
							}

				p - path		{
								if {$tcl_version > 8.3} {
					    				return [glob -nocomplain -directory [file nativename $path] -types d *]
								} else {
									set value [glob -nocomplain *] ; set returnvalue ""
									foreach e $value {if {[LIB_Shell_directory_exists [file join $path $e]]} {lappend returnvalue [LIB_Shell_format_path_names [file join $path $e]]}}
								}
							}

				r - pathrecursively	{
								set dirs "" ; lappend dirs [file join $path] ; set initial $dirs ; set initialdir "" ; lappend initialdir [pwd]
								while {[llength $dirs]} {
									set name [lindex $dirs 0]
									if {$tcl_version > 8.3} {
								    		set dirs [concat [glob -nocomplain -directory [lindex $dirs 0] -type d *] [lrange $dirs 1 end]]
									} else {
										cd [lindex $dirs 0] ; if {[catch {glob *}]} {lappend directories [lindex $dirs 0] ; set dirs [concat [lrange $dirs 1 end]] ; continue} else {set all [glob *]}
										foreach e $all {if {[LIB_Shell_directory_exists [file join [lindex $dirs 0] $e]]} {lappend dirs [file join [lindex $dirs 0] $e]}}
										set dirs [concat [lrange $dirs 1 end]]
									}
									lappend directories [LIB_Shell_format_path_names $name]
								}
								cd [lindex $initialdir 0]
								return $directories
							}

				c - content  {
								if {$tcl_version > 8.3} {
					    				 return [glob -nocomplain -directory [file nativename $path] -tails -types f *]
								} else {
									set returnvalue [glob -nocomplain *]
								}
							}
		}
	}
}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Delete a file and watch if it's possible
# It's also return true, if the file not exist
#
# <Internal Example>
#
# set content [LIB_Shell_file_delete "D:/Temp/Test.txt"]
# returns e.g.: Test Functions Librarys
#____________________________________________________________________________________________
proc LIB_Shell_file_delete {filename} {

	if {[catch {file delete -force $filename}]} {
		MOM_log_message "Can't delete file '$filename'"
		return 0
	} else {
		return 1
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Calling to ask a windows console with an dir command to search directory content
#
# <Internal Example>
# >> This function is a black box procedure <<
#____________________________________________________________________________________________
proc LIB_Shell_files_from_dir {path argument {extensions ""}} {

	global env dir_channel_list lib_ge_slash lib_ge_temppath

	# Glob leaves TCL crash is some reson, depending on the file name (special characters)
	if {[string match "Files" $argument]} {

		set current_path [pwd]
		cd $lib_ge_temppath

		# Support for UNC
		set temppath [LIB_Shell_format_path_names "$lib_ge_temppath${lib_ge_slash}PostConfigurator${lib_ge_slash}[pid]"]
		if {![LIB_Shell_directory_exists $temppath]} {
			set error [file mkdir $temppath]
			set error [file attribute $temppath -hidden 1]
		}

		set transfername [LIB_Shell_format_path_names "$temppath${lib_ge_slash}FilesFromDir.tcl"]
		set checkname [LIB_Shell_format_path_names "$temppath${lib_ge_slash}FilesFromDir.check"]
		set batname [LIB_Shell_format_path_names "$temppath${lib_ge_slash}FilesFromDir.bat"]
		set vbsname [LIB_Shell_format_path_names "$temppath${lib_ge_slash}FilesFromDir.vbs"]

		LIB_Shell_file_delete $vbsname
		LIB_Shell_file_delete $batname
		LIB_Shell_file_delete $checkname
		LIB_Shell_file_delete $transfername

		lappend content "set VBSTEMP=$temppath"
		lappend content "set VBSNAME=$vbsname"
		lappend content "set BATNAME=$batname"
		lappend content "set TRANSFERNAME=$transfername"
		lappend content "del %TRANSFERNAME% > nul 2>&1"
		lappend content ""
		lappend content "@echo set VBSNAME=$vbsname"
		lappend content "@echo set objFSO = CreateObject(\"Scripting.FileSystemObject\")>%VBSNAME%"
		lappend content "@echo objStartFolder = \"[LIB_Shell_format_path_names $path]\">>%VBSNAME%"
		lappend content "@echo Set objFolder = objFSO.GetFolder(objStartFolder)>>%VBSNAME%"
		lappend content "@echo Set colFiles = objFolder.Files>>%VBSNAME%"
		lappend content "@echo For Each objFile in colFiles>>%VBSNAME%"
		lappend content "@echo \tWscript.Echo \"lappend response \{\" ^& objFile.Name ^& \"\}\">>%VBSNAME%"
		lappend content "@echo Next>>%VBSNAME%"
		lappend content "@echo \tWScript.Quit 1>>%VBSNAME%"
		lappend content ""
		lappend content "@echo off & setlocal"
		lappend content ""
		lappend content "cscript //NoLogo %VBSNAME% >\"$transfername\""
		lappend content "echo set fid \[open \{$checkname\} w+\] ; puts \$fid Finish ; flush \$fid ; close \$fid>>\"$transfername\""
		lappend content "del %VBSNAME% > nul 2>&1"
		lappend content ""
		lappend content "exit"

		set error [LIB_Shell_list_to_file $content $batname] ; set content ""

		set batchname "LongFileAnalysis"
		set batchvbs [LIB_Shell_format_path_names "$temppath${lib_ge_slash}$batchname.vbs"]
		set batchresult [LIB_Shell_format_path_names "$temppath${lib_ge_slash}$batchname.[pid]"]

		lappend content "WScript.CreateObject\( \"WScript.Shell\" \).Run \"\"\"$batname\"\"\",0,1"
		lappend content "Set objFSO = CreateObject\(\"Scripting.FileSystemObject\"\)"
		lappend content "Set objFile = objFSO.CreateTextFile\(\"$batchresult\"\)"
		lappend content "WScript.Quit 1"

		set error [LIB_Shell_list_to_file $content $batchvbs]

		set cmd [list exec $::env(COMSPEC) /c start {} $batchvbs &]
		set retval [catch $cmd output]

		LIB_Shell_holding_stack $batchresult
		LIB_Shell_holding_stack $transfername

		if {$retval} {LIB_GE_error_message "Execute silent..." "Unable to execute file 'INS->$batchvbs<-'"}

		LIB_Shell_file_delete $batchresult
		LIB_Shell_file_delete $batchvbs

		if {$::tcl_version >= 8.6} {
			source -encoding utf-8 $transfername
		} else {
			source $transfername
		}

		LIB_Shell_holding_stack $checkname
		LIB_Shell_holding_stack $transfername

		LIB_Shell_file_delete $vbsname
		LIB_Shell_file_delete $batname
		LIB_Shell_file_delete $checkname
		LIB_Shell_file_delete $transfername

		cd $current_path

	} else {

		set current_path [pwd]

		if {[catch {cd [LIB_Shell_format_path_names $path]}]} {return 0}

		set channel [open "|cmd /c dir $argument $extensions /on /b"] ; after 10
		lappend dir_channel_list $channel

		while {![eof $channel]} {
			if {[gets $channel readin] != -1} {
				lappend response $readin
			}
		}
		catch {close $channel}
		cd $current_path

	}

	if {[info exists response]} {return $response} else {return ""}

}

#______________________________________________________________________________
#
# Wait until file exists
#
# e.g.
# LIB_Shell_holding_stack "C:\\Temp\\Test.txt"
#______________________________________________________________________________
proc LIB_Shell_holding_stack {obj {loops 300} {wait 100} {abort 1}} {

	if {[regexp -nocase -- {^[\\]{2}|^[A-Z][:][\\|\/]} $obj]} {set file 1} else {set file 0}
	if {$loops < 0} {set loops [expr abs($loops)] ; set negate 1} else {set negate 0}
	for { set n 1 } { $n <= $loops } { incr n } {
		if {!$negate && !$file && [info exists $obj]} {
			return
		} elseif {!$negate && $file && [file exists $obj]} {
			return
		} elseif {$negate && !$file && ![info exists $obj]} {
			return
		} elseif {$negate && $file && ![file exists $obj]} {
			return
		}
		after $wait
	}

	if {$abort} {
		LIB_Shell_abort "Timeout at LIB_Shell_holding_stack '$obj'"
	}
}

#______________________________________________________________________________
#
# Write a list to a file
#
# e.g.
# set error [LIB_Shell_list_to_file $content "C:\\Temp\\Test.txt"]
#______________________________________________________________________________
proc LIB_Shell_list_to_file {list filename {action w+}} {

	catch {MOM_remove_file $filename}
	set fileid [open $filename $action]
	foreach e $list {
		puts $fileid $e
	}
	flush $fileid
	close $fileid

}

set lib_shell(collection) ""

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Search directories recursively
#
# <Internal Example>
#
# set directories [LIB_Shell_path_init "D:/Temp/Test"]
# returns: D:/Temp/Test D:/Temp/Test/Functions D:/Temp/Test/Librarys D:/Temp/Test/Librarys/Test
#____________________________________________________________________________________________
proc LIB_Shell_path_init {folder {authorized "bin controller libraries"}} {

	global lib_shell lib_ge_slash

	set folder [LIB_Shell_format_path_names $folder]

	if {[llength $authorized] > 0} {
		set dirs [LIB_Shell_file_glob $folder p]
		set dirs [linsert $dirs 0 $folder]
	} else {
		set dirs [list $folder]
	}

	for { set n 0 } { $n <= [llength $dirs] } { incr n } {
		set name [lindex $dirs $n]
		set pathname [LIB_Shell_format_path_names $name]

		if {[llength $authorized] > 0 && $n > 0} {
			regsub -all (?q)$folder$lib_ge_slash $pathname "" pathnames
			set last [file tail $pathnames]
			if {[llength [file split $pathnames]] > 1} {continue}
			set continue 1
			foreach e $authorized {
				if {[string match -nocase $e $last]} {
					set continue 0
				}
			}
			if {[string length $last] > 0 && $continue} {continue}
		}

		if {$n > 0 && [lsearch -exact [string tolower $authorized] [string tolower [file tail $pathname]]] < 0} {continue}
		binary scan $pathname H* pathbin
		if {![llength [array get lib_shell $pathbin]] || [string length $lib_shell($pathbin)] <= 1} {
			set content [LIB_Shell_file_glob $pathname]
			if {$content != 0} {
				set lib_shell($pathbin) $content
				set lib_shell(collection) [join [lappend lib_shell(collection) $content]]
				foreach e $lib_shell($pathbin) {
					binary scan $e H* e
					if {![info exists lib_shell($e)]} {set lib_shell($e) $pathname}
				}
			}
		}
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# Search location
#
# <Internal Example>
#
# set location [LIB_Shell_file_pathname "lib_general"]
#____________________________________________________________________________________________
proc LIB_Shell_file_pathname {filename {extension ".pce .pcf .tbc .tcl"} {logsuppress 0}} {

	global lib_shell lib_ge_slash

	foreach ext $extension {
		set name "$filename$ext"
		binary scan $name H* file
		binary scan [string tolower $name] H* lowerfile
		if {[llength [array get lib_shell $file]]} {
			return [LIB_Shell_format_path_names "$lib_shell($file)$lib_ge_slash$name"]
		} elseif {[llength [array get lib_shell $lowerfile]]} {
			return [LIB_Shell_format_path_names "$lib_shell($lowerfile)$lib_ge_slash$name"]
		} elseif {[lsearch -exact [string tolower $lib_shell(collection)] [string tolower $name]] > -1} {
			set index [lindex $lib_shell(collection) [lsearch -exact [string tolower $lib_shell(collection)] [string tolower $name]]]
			binary scan $index H* index
			if {[info exists lib_shell($index)]} {
				return [LIB_Shell_format_path_names "$lib_shell($index)$lib_ge_slash$name"]
			}
		}
	}

	if {!$logsuppress} {
		LIB_Shell_abort "File not found '$filename$ext' on the file system to source"
	}

}

#____________________________________________________________________________________________
# <Internal Documentation>
#
# This procedure can be called whenever a textoutput need to be checked for special characters.
#
# The options are:
#	0 = direct output (default)
#	1 = replace special characters to international spelling. Considers diameter, degree, inch and dollar sign.
#	2 = replace special characters to html
#	3 = replace UTF-8 to Unicode
#	4 = replace special characters to international spelling. No conversion of diameter, degree, inch and dollar sign.
#	5 = replace special characters to xml
#	6 = replace special characters to batch
#	7 = replace special characters to batch (for regex pattern of FINDSTR)
#	8 = replace special characters to MOM__part_attributes
#
# <Internal Example>
# set text [LIB_Shell_replace_special_characters $text]
#____________________________________________________________________________________________
proc LIB_Shell_replace_special_characters {text {special 0}} {

	if {[llength [info commands CONF_GE_msg]] && ![CONF_GE_msg replace_special_character]} {
		uplevel #0 {
			proc LIB_Shell_replace_special_characters {text {special 0}} {
				return $text
			}
		}
	}

	if {$special == 1} {
		regsub -all {1º} $text "1"    	   text
		regsub -all {2º} $text "2"    	   text
		regsub -all {3º} $text "3"    	   text
		regsub -all {ä}  $text "ae"   	   text
		regsub -all {Ä}  $text "AE"   	   text
		regsub -all {ö}  $text "oe"   	   text
		regsub -all {Ö}  $text "OE"   	   text
		regsub -all {ü}  $text "ue"   	   text
		regsub -all {Ü}  $text "UE"   	   text
		regsub -all {Ø}  $text "D"    	   text
		regsub -all {ø}  $text "D"    	   text
		regsub -all {°}  $text "D"    	   text
		regsub -all {ß}  $text "ss"   	   text
		regsub -all {\t} $text "    " 	   text
		regsub -all {à}  $text "a"    	   text
		regsub -all {À}  $text "A"    	   text
		regsub -all {â}  $text "a"    	   text
		regsub -all {Â}  $text "A"    	   text
		regsub -all {ô}  $text "o"    	   text
		regsub -all {Ô}  $text "O"    	   text
		regsub -all {ç}  $text "c"    	   text
		regsub -all {Ç}  $text "C"    	   text
		regsub -all {é}  $text "e"    	   text
		regsub -all {É}  $text "E"    	   text
		regsub -all {è}  $text "e"    	   text
		regsub -all {È}  $text "E"    	   text
		regsub -all {ê}  $text "e"    	   text
		regsub -all {Ê}  $text "E"    	   text
		regsub -all {ï}  $text "i"    	   text
		regsub -all {Ï}  $text "I"    	   text
		regsub -all {ù}  $text "u"    	   text
		regsub -all {Ù}  $text "U"    	   text
		regsub -all {\"}  $text "Inch"     text
		regsub -all {\$}  $text "Dollar"   text
	} elseif {$special == 2} {
		regsub -all "¡" $text "\\&iexcl;"  text
		regsub -all "¢" $text "\\&cent;"   text
		regsub -all "£" $text "\\&pound;"  text
		regsub -all "¤" $text "\\&curren;" text
		regsub -all "¥" $text "\\&yen;"    text
		regsub -all "¦" $text "\\&brvbar;" text
		regsub -all "§" $text "\\&sect;"   text
		regsub -all "¨" $text "\\&uml;"    text
		regsub -all "©" $text "\\&copy;"   text
		regsub -all "ª" $text "\\&ordf;"   text
		regsub -all "«" $text "\\&laquo;"  text
		regsub -all "¬" $text "\\&not;"    text
		regsub -all "­" $text "\\&shy;"    text
		regsub -all "®" $text "\\&reg;"    text
		regsub -all "¯" $text "\\&macr;"   text
		regsub -all "°" $text "\\&deg;"    text
		regsub -all "±" $text "\\&plusmn;" text
		regsub -all "²" $text "\\&sup2;"   text
		regsub -all "³" $text "\\&sup3;"   text
		regsub -all "´" $text "\\&acute;"  text
		regsub -all "µ" $text "\\&micro;"  text
		regsub -all "¶" $text "\\&para;"   text
		regsub -all "·" $text "\\&middot;" text
		regsub -all "¸" $text "\\&cedil;"  text
		regsub -all "¹" $text "\\&sup1;"   text
		regsub -all "º" $text "\\&ordm;"   text
		regsub -all "»" $text "\\&raquo;"  text
		regsub -all "¼" $text "\\&frac14;" text
		regsub -all "½" $text "\\&frac12;" text
		regsub -all "¾" $text "\\&frac34;" text
		regsub -all "¿" $text "\\&iquest;" text
		regsub -all "À" $text "\\&Agrave;" text
		regsub -all "Á" $text "\\&Aacute;" text
		regsub -all "Â" $text "\\&Acirc;"  text
		regsub -all "Ã" $text "\\&Atilde;" text
		regsub -all "Ä" $text "\\&Auml;"   text
		regsub -all "Å" $text "\\&Aring;"  text
		regsub -all "Æ" $text "\\&AElig;"  text
		regsub -all "Ç" $text "\\&Ccedil;" text
		regsub -all "È" $text "\\&Egrave;" text
		regsub -all "É" $text "\\&Eacute;" text
		regsub -all "Ê" $text "\\&Ecirc;"  text
		regsub -all "Ë" $text "\\&Euml;"   text
		regsub -all "Ì" $text "\\&Igrave;" text
		regsub -all "Í" $text "\\&Iacute;" text
		regsub -all "Î" $text "\\&Icirc;"  text
		regsub -all "Ï" $text "\\&Iuml;"   text
		regsub -all "Ð" $text "\\&ETH;"    text
		regsub -all "Ñ" $text "\\&Ntilde;" text
		regsub -all "Ò" $text "\\&Ograve;" text
		regsub -all "Ó" $text "\\&Oacute;" text
		regsub -all "Ô" $text "\\&Ocirc;"  text
		regsub -all "Õ" $text "\\&Otilde;" text
		regsub -all "Ö" $text "\\&Ouml;"   text
		regsub -all "×" $text "\\&times;"  text
		regsub -all "Ø" $text "\\&Oslash;" text
		regsub -all "Ù" $text "\\&Ugrave;" text
		regsub -all "Ú" $text "\\&Uacute;" text
		regsub -all "Û" $text "\\&Ucirc;"  text
		regsub -all "Ü" $text "\\&Uuml;"   text
		regsub -all "Ý" $text "\\&Yacute;" text
		regsub -all "Þ" $text "\\&THORN;"  text
		regsub -all "ß" $text "\\&szlig;"  text
		regsub -all "à" $text "\\&agrave;" text
		regsub -all "á" $text "\\&aacute;" text
		regsub -all "â" $text "\\&acirc;"  text
		regsub -all "ã" $text "\\&atilde;" text
		regsub -all "ä" $text "\\&auml;"   text
		regsub -all "å" $text "\\&aring;"  text
		regsub -all "æ" $text "\\&aelig;"  text
		regsub -all "ç" $text "\\&ccedil;" text
		regsub -all "è" $text "\\&egrave;" text
		regsub -all "é" $text "\\&eacute;" text
		regsub -all "ê" $text "\\&ecirc;"  text
		regsub -all "ë" $text "\\&euml;"   text
		regsub -all "ì" $text "\\&igrave;" text
		regsub -all "í" $text "\\&iacute;" text
		regsub -all "î" $text "\\&icirc;"  text
		regsub -all "ï" $text "\\&iuml;"   text
		regsub -all "ð" $text "\\&eth;"    text
		regsub -all "ñ" $text "\\&ntilde;" text
		regsub -all "ò" $text "\\&ograve;" text
		regsub -all "ó" $text "\\&oacute;" text
		regsub -all "ô" $text "\\&ocirc;"  text
		regsub -all "õ" $text "\\&otilde;" text
		regsub -all "ö" $text "\\&ouml;"   text
		regsub -all "÷" $text "\\&divide;" text
		regsub -all "ø" $text "\\&oslash;" text
		regsub -all "ù" $text "\\&ugrave;" text
		regsub -all "ú" $text "\\&uacute;" text
		regsub -all "û" $text "\\&ucirc;"  text
		regsub -all "ü" $text "\\&uuml;"   text
		regsub -all "ý" $text "\\&yacute;" text
		regsub -all "þ" $text "\\&thorn;"  text
		regsub -all "ÿ" $text "\\&yuml;"   text
	} elseif {$special == 3} {
		regsub -all "ô" $text "Ã´"    text
		regsub -all "š" $text "Å¡"    text
		regsub -all "¤" $text "Â¤"    text
		regsub -all "ö" $text "Ã¶"    text
		regsub -all "Þ" $text "Å¢"    text
		regsub -all "¦" $text "Â¦"    text
		regsub -all "÷" $text "Ã·"    text
		regsub -all "þ" $text "Å£"    text
		regsub -all "§" $text "Â§"    text
		regsub -all "ú" $text "Ãº"    text
		regsub -all "¨" $text "Â¨"    text
		regsub -all "ü" $text "Ã¼"    text
		regsub -all "©" $text "Â©"    text
		regsub -all "ý" $text "Ã½"    text
		regsub -all "Ù" $text "Å®"    text
		regsub -all "«" $text "Â«"    text
		regsub -all "Ã" $text "Ä‚"    text
		regsub -all "ù" $text "Å¯"    text
		regsub -all "¬" $text "Â¬"    text
		regsub -all "ã" $text "Äƒ"    text
		regsub -all "Û" $text "Å°"    text
		regsub -all "¥" $text "Ä„"    text
		regsub -all "û" $text "Å±"    text
		regsub -all "®" $text "Â®"    text
		regsub -all "¹" $text "Ä..."  text
		regsub -all "°" $text "Â°"    text
		regsub -all "Æ" $text "Ä†"    text
		regsub -all "Ÿ" $text "Åº"    text
		regsub -all "±" $text "Â±"    text
		regsub -all "æ" $text "Ä‡"    text
		regsub -all "¯" $text "Å»"    text
		regsub -all "´" $text "Â´"    text
		regsub -all "È" $text "ÄŒ"    text
		regsub -all "¿" $text "Å¼"    text
		regsub -all "µ" $text "Âµ"    text
		regsub -all "è" $text "Ä?"    text
		regsub -all "Ž" $text "Å½"    text
		regsub -all "¶" $text "Â¶"    text
		regsub -all "Ï" $text "ÄŽ"    text
		regsub -all "ž" $text "Å¾"    text
		regsub -all "·" $text "Â·"    text
		regsub -all "ï" $text "Ä?"    text
		regsub -all "¡" $text "Ë‡"    text
		regsub -all "¸" $text "Â¸"    text
		regsub -all "Ð" $text "Ä?"    text
		regsub -all "¢" $text "Ë~"    text
		regsub -all "»" $text "Â»"    text
		regsub -all "ð" $text "Ä‘"    text
		regsub -all "ÿ" $text "Ë™"    text
		regsub -all "Á" $text "Ã?"    text
		regsub -all "Ê" $text "Ä~"    text
		regsub -all "²" $text "Ë›"    text
		regsub -all "Â" $text "Ã‚"    text
		regsub -all "ê" $text "Ä™"    text
		regsub -all "½" $text "Ë?"    text
		regsub -all "Ä" $text "Ã„"    text
		regsub -all "Ì" $text "Äš"    text
		regsub -all "–" $text "â€“"   text
		regsub -all "Ç" $text "Ã‡"    text
		regsub -all "ì" $text "Ä›"    text
		regsub -all "—" $text "â€”"   text
		regsub -all "É" $text "Ã‰"    text
		regsub -all "Å" $text "Ä¹"    text
		regsub -all "‘" $text "â€~"   text
		regsub -all "Ë" $text "Ã‹"    text
		regsub -all "å" $text "Äº"    text
		regsub -all "’" $text "â€™"   text
		regsub -all "Í" $text "Ã?"    text
		regsub -all "¼" $text "Ä½"    text
		regsub -all "‚" $text "â€š"   text
		regsub -all "Î" $text "ÃŽ"    text
		regsub -all "¾" $text "Ä¾"    text
		regsub -all "“" $text "â€œ"   text
		regsub -all "Ó" $text "Ã“"    text
		regsub -all "£" $text "Å?"    text
		regsub -all "”" $text "â€?"   text
		regsub -all "Ô" $text "Ã”"    text
		regsub -all "³" $text "Å‚"    text
		regsub -all "„" $text "â€ž"   text
		regsub -all "Ö" $text "Ã–"    text
		regsub -all "Ñ" $text "Åƒ"    text
		regsub -all "†" $text "â€"    text
		regsub -all "×" $text "Ã—"    text
		regsub -all "ñ" $text "Å„"    text
		regsub -all "‡" $text "â€¡"   text
		regsub -all "Ú" $text "Ãš"    text
		regsub -all "Ò" $text "Å‡"    text
		regsub -all "•" $text "â€¢"   text
		regsub -all "Ü" $text "Ãœ"    text
		regsub -all "ò" $text "Åˆ"    text
		regsub -all "Ý" $text "Ã?"    text
		regsub -all "Õ" $text "Å?"    text
		regsub -all "‰" $text "â€°"   text
		regsub -all "ß" $text "ÃŸ"    text
		regsub -all "õ" $text "Å‘"    text
		regsub -all "‹" $text "â€¹"   text
		regsub -all "á" $text "Ã¡"    text
		regsub -all "À" $text "Å”"    text
		regsub -all "›" $text "â€º"   text
		regsub -all "â" $text "Ã¢"    text
		regsub -all "à" $text "Å•"    text
		regsub -all "€" $text "â‚¬"   text
		regsub -all "ä" $text "Ã¤"    text
		regsub -all "Ø" $text "Å ~"   text
		regsub -all "™" $text "â„¢"   text
		regsub -all "ç" $text "Ã§"    text
		regsub -all "ø" $text "Å™"    text
		regsub -all "é" $text "Ã©"    text
		regsub -all "Œ" $text "Åš"    text
		regsub -all "ë" $text "Ã«"    text
		regsub -all "œ" $text "Å›"    text
		regsub -all "í" $text "Ã-"    text
		regsub -all "ª" $text "Åž"    text
		regsub -all "î" $text "Ã®"    text
		regsub -all "º" $text "ÅŸ"    text
		regsub -all "ó" $text "Ã³"    text
		regsub -all "Š" $text "Å"     text
	} elseif {$special == 4} {
		regsub -all {ä}  $text "ae"   	text
		regsub -all {Ä}  $text "AE"   	text
		regsub -all {ö}  $text "oe"   	text
		regsub -all {Ö}  $text "OE"   	text
		regsub -all {ü}  $text "ue"   	text
		regsub -all {Ü}  $text "UE"   	text
		regsub -all {ß}  $text "ss"   	text
		regsub -all {à}  $text "a"    	text
		regsub -all {À}  $text "A"    	text
		regsub -all {â}  $text "a"    	text
		regsub -all {Â}  $text "A"    	text
		regsub -all {ô}  $text "o"    	text
		regsub -all {Ô}  $text "O"    	text
		regsub -all {ç}  $text "c"    	text
		regsub -all {Ç}  $text "C"    	text
		regsub -all {é}  $text "e"    	text
		regsub -all {É}  $text "E"    	text
		regsub -all {è}  $text "e"    	text
		regsub -all {È}  $text "E"    	text
		regsub -all {ê}  $text "e"    	text
		regsub -all {Ê}  $text "E"    	text
		regsub -all {ï}  $text "i"    	text
		regsub -all {Ï}  $text "I"    	text
		regsub -all {ù}  $text "u"    	text
		regsub -all {Ù}  $text "U"    	text
	} elseif {$special == 5} {
		regsub -all {ä}  $text "ae" 	    text
		regsub -all {&}  $text "\\&amp;"    text
		regsub -all {§}  $text "\\&sect;"   text
		regsub -all {‰}  $text "\\&permil;" text
		regsub -all {¯}  $text "\\&macr;"   text
		regsub -all {–}  $text "\\&ndash;"  text
		regsub -all {—}  $text "\\&mdash;"  text
		regsub -all {¦}  $text "\\&brvbar;" text
		regsub -all {†}  $text "\\&dagger;" text
		regsub -all {‡}  $text "\\&Dagger;" text
		regsub -all {←}  $text "\\&larr;"   text
		regsub -all {→}  $text "\\&rarr;"   text
		regsub -all {↑}  $text "\\&uarr;"   text
		regsub -all {↓}  $text "\\&darr;"   text
		regsub -all {↔}  $text "\\&harr;"   text
		regsub -all {◊}  $text "\\&loz;"    text
		regsub -all {•}  $text "\\&bull;"   text
		regsub -all {¡}  $text "\\&iexcl;"  text
		regsub -all {¿}  $text "\\&iquest;" text
		regsub -all {♥}  $text "\\&hearts;" text
		regsub -all {♠}  $text "\\&spades;" text
		regsub -all {♣}  $text "\\&clubs;"  text
		regsub -all {♦}  $text "\\&diams;"  text
		regsub -all {€}  $text "\\&euro;"   text
		regsub -all {£}  $text "\\&pound;"  text
		regsub -all {¥}  $text "\\&yen;"    text
		regsub -all {¢}  $text "\\&cent;"   text
		regsub -all {„}  $text "\\&quot;"   text
		regsub -all {‘}  $text "\\&lsquo;"  text
		regsub -all {’}  $text "\\&rsquo;"  text
		regsub -all {‚}  $text "\\&sbquo;"  text
		regsub -all {“}  $text "\\&ldquo;"  text
		regsub -all {”}  $text "\\&rdquo;"  text
		regsub -all {„}  $text "\\&bdquo;"  text
		regsub -all {‹}  $text "\\&lsaquo;" text
		regsub -all {›}  $text "\\&rsaquo;" text
		regsub -all {«}  $text "\\&laquo;"  text
		regsub -all {»}  $text "\\&raquo;"  text
		regsub -all {<}  $text "\\&lt;"     text
		regsub -all {>}  $text "\\&gt;"     text
		regsub -all {±}  $text "\\&plusmn;" text
		regsub -all {×}  $text "\\&times;"  text
		regsub -all {÷}  $text "\\&divide;" text
		regsub -all {≤}  $text "\\&le;"     text
		regsub -all {≥}  $text "\\&ge;"     text
		regsub -all {≈}  $text "\\&asymp;"  text
		regsub -all {≠}  $text "\\&ne;"     text
		regsub -all {¼}  $text "\\&frac14;" text
		regsub -all {½}  $text "\\&frac12;" text
		regsub -all {¾}  $text "\\&frac34;" text
		regsub -all {¹}  $text "\\&sup1;"   text
		regsub -all {²}  $text "\\&sup2;"   text
		regsub -all {³}  $text "\\&sup3;"   text
		regsub -all {√}  $text "\\&radic;"  text
		regsub -all {∫}  $text "\\&int;"    text
		regsub -all {∞}  $text "\\&infin;"  text
		regsub -all {∂}  $text "\\&part;"   text
		regsub -all {∩}  $text "\\&cap;"    text
		regsub -all {©}  $text "\\&copy;"   text
		regsub -all {®}  $text "\\&reg;"    text
		regsub -all {™}  $text "\\&trade;"  text
		regsub -all {ˆ}  $text "\\&circ;"   text
		regsub -all {˜}  $text "\\&tilde;"  text
		regsub -all {¸}  $text "\\&cedil;"  text
		regsub -all {À}  $text "\\&Agrave;" text
		regsub -all {à}  $text "\\&agrave;" text
		regsub -all {Á}  $text "\\&Aacute;" text
		regsub -all {Â}  $text "\\&Acirc;"  text
		regsub -all {Ã}  $text "\\&Atilde;" text
		regsub -all {Ä}  $text "\\&Auml;"   text
		regsub -all {Å}  $text "\\&Aring;"  text
		regsub -all {Æ}  $text "\\&AElig;"  text
		regsub -all {Ç}  $text "\\&Ccedil;" text
		regsub -all {Þ}  $text "\\&THORN;"  text
		regsub -all {Ð}  $text "\\&ETH;"    text
		regsub -all {þ}  $text "\\&thorn;"  text
		regsub -all {ð}  $text "\\&eth;"    text
		regsub -all {Ø}  $text "\\&Oslash;" text
		regsub -all {Œ}  $text "\\&OElig;"  text
		regsub -all {œ}  $text "\\&oelig;"  text
		regsub -all {Š}  $text "\\&Scaron;" text
		regsub -all {š}  $text "\\&scaron;" text
	} elseif {$special == 6} {
		# May not always be required in doublequoted strings, just try
		regsub -all {%}  $text "%%"     text
		# May not always be required in doublequoted strings, but it won't hurt
		regsub -all {\^}  $text "\^\^"  text
		regsub -all {&}  $text "\^\\\&" text
		regsub -all {<}  $text "\^<"    text
		regsub -all {>}  $text "\^>"    text
		regsub -all {\|}  $text "\^|"   text
		# Required only in the FOR /F subject (i.e. between the parenthesis), unless backq is used
		regsub -all {\'}  $text "\^'"   text
		# Required only in the FOR /F subject (i.e. between the parenthesis), if backq is used
		regsub -all {\`}  $text "\^`"   text
		# Required only in the FOR /F subject (i.e. between the parenthesis), even in doublequoted strings
		regsub -all {,}  $text "\^,"    text
		regsub -all {;}  $text "\^;"    text
		regsub -all {=}  $text "\^="    text
		regsub -all {\(}  $text "\^("   text
		regsub -all {\)}  $text "\^)"   text
		# Required only when delayed variable expansion is active
		regsub -all {!}  $text "\^\^"   text
		# Required only inside the search pattern of FIND
		regsub -all {\"}  $text "\"\""  text
	} elseif {$special == 7} {
		# Required only inside the regex pattern of FINDSTR
		regsub -all {\\} $text "\\\\\\" text
		regsub -all {[}  $text "\\\["   text
		regsub -all {]}  $text "\\\]"   text
		regsub -all {\"}  $text "\\\""  text
		regsub -all {.}  $text "\\\."   text
		regsub -all {*}  $text "\\\*"   text
		regsub -all {?}  $text "\\\?"   text
	} elseif {$special == 8} {
		#this is nx internal conversion for MOM__part_attributes (mom_mcsname_attach_opr)
		regsub -all {Ä}  $text "Ã„"   	   text
		regsub -all {Ö}  $text "Ã–"   	   text
		regsub -all {Ü}  $text "Ãœ"   	   text
		regsub -all {ß}  $text "ÃŸ"   	   text
		regsub -all {Ø}  $text "Ã˜"    	   text
		regsub -all {À}  $text "Ã€"    	   text
		regsub -all {Â}  $text "Ã‚"    	   text
		regsub -all {Ô}  $text "Ã”"    	   text
		regsub -all {Ç}  $text "Ã‡"    	   text
		regsub -all {É}  $text "Ã‰"    	   text
		regsub -all {È}  $text "Ãˆ"    	   text
		regsub -all {Ê}  $text "ÃŠ"    	   text
		regsub -all {Ï}  $text "Ã"    	   text
		regsub -all {Ù}  $text "Ã™"    	   text
	}

	return $text

}

proc LIB_Shell_reload_functions {} {

	uplevel #0 {

		#____________________________________________________________________________________________
		#
		# Procs used to detect equality between scalars of real data type.
		#
		# global mom_system_tolerance
		# EQ_is_equal(s, t)  (abs(s-t) <= mom_system_tolerance) Return true if scalars are equal
		# EQ_is_ge(s, t)     (s > t - mom_system_tolerance)     Return true if s is greater than
		#                                         or equal to t
		# EQ_is_gt(s, t)     (s > t + mom_system_tolerance)     Return true if s is greater than t
		# EQ_is_le(s, t)     (s < t + mom_system_tolerance)     Return true if s is less than or
		#                                         equal to t
		# EQ_is_lt(s, t)     (s < t - mom_system_tolerance)     Return true if s is less than t
		# EQ_is_zero(s)      (abs(s) < mom_system_tolerance)    Return true if scalar is zero
		#____________________________________________________________________________________________
		# <Internal Documentation>
		#
		# Procs used to detect equality between scalars of real data type.
		# Return true if scalars are equal
		#
		# <Internal Example>
		# EQ_is_equal 12.0 12.0
		#____________________________________________________________________________________________
		proc EQ_is_equal [list s t [list tol $mom_system_tolerance]] {
		#@.pce@
			if {[string trim $s] == "" || [string trim $t] == ""} {return 0}
			expr {abs($s - $t) <= $tol}
		}

		#____________________________________________________________________________________________
		# <Internal Documentation>
		#
		# Procs used to detect equality between scalars of real data type.
		# Return true if s is greater than or equal to t
		#
		# <Internal Example>
		# EQ_is_ge 12.0 12.0
		#____________________________________________________________________________________________
		proc EQ_is_ge [list s t [list tol $mom_system_tolerance]] {
		#@.pce@
			if {[string trim $s] == "" || [string trim $t] == ""} {return 0}
			expr {$s > ($t - $tol)}
		}

		#____________________________________________________________________________________________
		# <Internal Documentation>
		#
		# Procs used to detect equality between scalars of real data type.
		# Return true if s is greater than t
		#
		# <Internal Example>
		# EQ_is_gt 12.0 14.0
		#____________________________________________________________________________________________
		proc EQ_is_gt [list s t [list tol $mom_system_tolerance]] {
		#@.pce@
			if {[string trim $s] == "" || [string trim $t] == ""} {return 0}
			expr {$s > ($t + $tol)}
		}

		#____________________________________________________________________________________________
		# <Internal Documentation>
		#
		# Procs used to detect equality between scalars of real data type.
		# Return true if s is less than or equal to t
		#
		# <Internal Example>
		# EQ_is_le 12.0 14.0
		#____________________________________________________________________________________________
		proc EQ_is_le [list s t [list tol $mom_system_tolerance]] {
		#@.pce@
			if {[string trim $s] == "" || [string trim $t] == ""} {return 0}
			expr {$s < ($t + $tol)}
		}

		#____________________________________________________________________________________________
		# <Internal Documentation>
		#
		# Procs used to detect equality between scalars of real data type.
		# Return true if s is less than t
		#
		# <Internal Example>
		# EQ_is_lt 12.0 14.0
		#____________________________________________________________________________________________
		proc EQ_is_lt [list s t [list tol $mom_system_tolerance]] {
		#@.pce@
			if {[string trim $s] == "" || [string trim $t] == ""} {return 0}
			expr {$s < ($t - $tol)}
		}

		#____________________________________________________________________________________________
		# <Internal Documentation>
		#
		# Procs used to detect equality between scalars of real data type.
		# Return true if scalar is zero
		#
		# <Internal Example>
		# EQ_is_zero 0.0
		#____________________________________________________________________________________________
		proc EQ_is_zero [list s [list tol $mom_system_tolerance]] {
		#@.pce@
			if {[string trim $s] == ""} {return 0}
			expr {abs($s) <= $tol}
		}

		#____________________________________________________________________________________________
		# <Internal Documentation>
		#
		# MOM_output_text differ from MOM_output_literal in the NX-Core!!
		# so we have to change this proc when we are in simulation
		#
		# PR#9360571 : remove mom_post_in_smulation check, change MOM_output_text for both of post and
		# simulation
		#
		# <Internal Example>
		# >> This function is a black box  <<
		#____________________________________________________________________________________________


		if {![llength [info commands PC_MOM_output_text]]} {
			rename MOM_output_text PC_MOM_output_text

			proc MOM_output_text {arg} {
			#@.pce@
				set seq_status	[MOM_set_seq_off]
				set output	[MOM_output_literal $arg]
				if {[string match "on" $seq_status]} {
					MOM_set_seq_on
				}
				return $output
			}
		}

	}
}

set lib_spf(clock,exists) 1
if {$lib_ge_tclversion >= 8.6 && [info commands clock] == ""} {

	foreach {weekday month day time year} $mom_date {break}
	switch $month {
		Jan {set month 01}
		Feb {set month 02}
		Mar {set month 03}
		Apr {set month 04}
		May {set month 05}
		Jun {set month 06}
		Jul {set month 07}
		Aug {set month 08}
		Sep {set month 09}
		Oct {set month 10}
		Nov {set month 11}
		Dec {set month 12}
	}
	set lib_ge_date "${day}.${month}.${year}"
	set lib_ge_time $time
	set lib_spf(clock,random) [expr {int(rand()*99999999)}]
	set lib_spf(clock,exists) 0

} elseif {$lib_ge_tclversion >= 8.6 && [info commands clock] != ""} {
	set lib_spf(clock,exists) 2
}

if {![info exists lib_spf(clock,start)]} {
	if {$lib_ge_tclversion > 8.3} {
		set lib_spf(clock,start) 	[format %.01f [clock clicks -milliseconds]]
	} elseif {$lib_spf(clock,exists)} {
		set lib_spf(clock,start) 	[format %.01f [clock clicks]]
	}
}
