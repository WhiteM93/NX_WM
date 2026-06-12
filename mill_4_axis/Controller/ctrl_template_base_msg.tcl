lappend lib_config_data		[list "ctrl_template_base_msg" "Ctrl_Template_Base-MSG-Version 057"]
####C#O#P#Y#R#I#G#H#T########################################################################
#
#	Copyright 2014-2024 Siemens Product Lifecycle Management Software Inc.
#				All Rights Reserved.
#
####S#T#A#R#T##C#H#A#N#G#E##H#I#S#T#O#R#Y####################################################
#
#       Last changes:	09.02.2019 - TJ  001 Initial Release and Installation
#			16.03.2019 - UR  002 Releaseversion 4.6.3
#			28.03.2019 - COE 003 Releaseversion 4.7
#			11.04.2019 - UR  004 Releaseversion 4.7.1
#			18.04.2019 - UR  005 Releaseversion 4.7.2
#			07.05.2019 - UR  006 Releaseversion 5.0
#			08.07.2019 - UR  007 Releaseversion 5.0.1
#			31.07.2019 - UR  008 Releaseversion 5.0.2
#			16.08.2019 - COE 009 Releaseversion 5.0.3
#			21.08.2019 - COE 010 Releaseversion 5.1.0
#			20.09.2019 - COE 011 Releaseversion 5.2.0
#			06.11.2019 - UR  012 Releaseversion 5.2.3
#			27.12.2019 - UR  013 Releaseversion 5.2.4
#			31.01.2020 - COE 014 Releaseversion 5.2.5
#			02.03.2020 - UR  015 Releaseversion 5.2.6
#			19.03.2020 - COE 016 Releaseversion 5.2.7
#			25.03.2020 - COE 017 Releaseversion 5.3.0
#			01.07.2020 - COE 018 Releaseversion 5.3.1
#			09.07.2020 - COE 019 Releaseversion 5.3.2
#			06.09.2020 - COE 020 Releaseversion 5.3.3
#			15.09.2020 - COE 021 Releaseversion 5.3.4
#			26.09.2020 - COE 022 Releaseversion 5.3.5
#			26.11.2020 - COE 023 Releaseversion 5.3.6
#			24.01.2021 - COE 024 Releaseversion 5.3.7
#			06.02.2021 - COE 025 Releaseversion 5.3.8
#			15.03.2021 - COE 026 Releaseversion 5.3.9
#			13.04.2021 - COE 027 Releaseversion 5.4.0
#			02.06.2021 - COE 028 Releaseversion 5.4.1
#			21.07.2021 - COE 029 Releaseversion 5.4.2
#			03.09.2021 - COE 030 Releaseversion 5.4.3
#			07.09.2021 - COE 031 Releaseversion 5.4.4
#			29.09.2021 - COE 032 Releaseversion 5.5.0
#			25.10.2021 - COE 033 Releaseversion 5.5.1
#			24.11.2021 - COE 034 Releaseversion 5.5.2
#			19.02.2022 - COE 035 Releaseversion 5.5.3
#			06.03.2022 - COE 036 Releaseversion 5.5.4
#			08.04.2022 - COE 037 Releaseversion 5.5.5
#			13.07.2022 - COE 038 Releaseversion 5.5.6
#			07.09.2022 - COE 039 Releaseversion 5.5.7
#			24.09.2022 - COE 040 Releaseversion 5.5.8
#			15.01.2023 - COE 041 Releaseversion 23.01.0
#			14.03.2023 - COE 042 Releaseversion 23.03.0
#			07.04.2023 - COE 043 Releaseversion 23.04.0
#			14.07.2023 - COE 044 Releaseversion 23.07.0
#			14.09.2023 - COE 045 Releaseversion 23.09.0
#			14.09.2023 - COE 046 Releaseversion 23.09.0
#			09.10.2023 - ET  047 Releaseversion 23.10.0
#			09.10.2023 - ET  048 Releaseversion 23.10.0
#			10.12.2023 - COE 049 Releaseversion 23.12.0
#			19.01.2024 - COE 050 Releaseversion 24.01.0
#			21.03.2024 - COE 051 Releaseversion 24.03.0
#			13.08.2024 - COE 052 Releaseversion 24.08.0
#			22.08.2024 - COE 053 Releaseversion 24.08.1
#			16.09.2024 - COE 054 Releaseversion 24.09.0
#			24.09.2024 - ET  055 Releaseversion 24.09.1
#			27.12.2024 - COE 056 Releaseversion 24.12.0
#			02.04.2025 - COE 057 Releaseversion 25.04.0
#
#
#
####G#E#N#E#R#A#L##D#E#S#C#R#I#P#T#I#O#N#####################################################
#
# In this function, the text in the appropriate language UGII_LANG is translated.
# Optional wildcards can be used in the example.
#
# Permitted languages:  braz_portuguese / french / german / italian / japanese /
#			korean / russian / simpl_chinese / spanish / trad_chinese...
#
# e.g.
# set message [LIB_GE_MSG "Configuration file does not exist"]
# set message [LIB_GE_MSG "File can not be copied from INS->xxx<- to INS->zzz<-"]
# set message [LIB_GE_MSG "File INS->C:\\Temp\\xxx.txt<- not found"]
#
# set message [LIB_GE_MSG "SURFACE COORDINATE" "core"]
#
# (It's for development only)
# set message [LIB_GE_MSG 0001] <-- Please, don't work with this solution
#
#############################################################################################

##############################################################################################
###  controller/machine/customer... translations
###  between the commas the text is selectable e.g. 0000,$lib_controller_message,xxx,english
##############################################################################################
set lib_msg(0000,$lib_controller_message,core)          "Please contact Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,czech)         "Kontaktujte společnost Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,danish)        "Kontakt Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,dutch)         "Neem contact op met Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,english)       "Please contact Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,finnish)       "Ota yhteyttä Siemens PLM -ohjelmistoon"
set lib_msg(0000,$lib_controller_message,french)        "S'il vous plaît contactez Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,german)        "Bitte Siemens PLM Software kontaktieren"
set lib_msg(0000,$lib_controller_message,hungarian)     "Kérjük, lépjen kapcsolatba a Siemens PLM szoftverrel"
set lib_msg(0000,$lib_controller_message,italian)       "Contattare Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,japanese)      "お問い合わせください Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,korean)        "문의하시기 바랍니다 Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,norwegian)     "Ta kontakt med Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,polish)        "Prosze o kontakt Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,portuguese)    "Entre em contato com a Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,russian)       "пожалуйста свяжитесь Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,simpl_chinese) "请联系 Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,slovak)        "Obráťte sa na spoločnosť Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,slovenian)     "Prosimo, pokličite programsko opremo Siemens PLM"
set lib_msg(0000,$lib_controller_message,spanish)       "Por favor, póngase en contacto con Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,swedish)       "Vänligen kontakta Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,trad_chinese)  "請聯繫 Siemens PLM Software"
set lib_msg(0000,$lib_controller_message,turkish)       "Lütfen Siemens PLM Yazılımına başvurun."

if {$tcl_version < 8.4} {
	array set lib_msg [LIB_GE_replace_special_characters [array get lib_msg] 4 0]
}
