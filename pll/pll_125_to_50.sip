set_global_assignment -entity "pll_125_to_50" -library "lib_pll_125_to_50" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_125_to_50" -library "lib_pll_125_to_50" -name IP_TOOL_VERSION "15.0"
set_global_assignment -entity "pll_125_to_50" -library "lib_pll_125_to_50" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_125_to_50" -name SPD_FILE [file join $::quartus(sip_path) "pll_125_to_50.spd"]

set_global_assignment -library "lib_pll_125_to_50" -name MISC_FILE [file join $::quartus(sip_path) "pll_125_to_50_sim/pll_125_to_50.vo"]
