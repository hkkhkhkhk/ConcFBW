sasl.options.setLuaErrorsHandling(SASL_STOP_PROCESSING)

include("datarefs.lua")
include("functions.lua")

components = {
  rates_computation{},
	simpleap{},
	simpleap_ui{},
}

function Show_hide_FBW_UI()
    SSS_FBW_UI:setIsVisible(not SSS_FBW_UI:isVisible())
end

Menu_master	= sasl.appendMenuItem (PLUGINS_MENU_ID, "ConcordeFBW" )
Menu_main	= sasl.createMenu ("", PLUGINS_MENU_ID, Menu_master)
ShowHideFBWUI	= sasl.appendMenuItem(Menu_main, "Show/Hide Arcade UI", Show_hide_FBW_UI)

SSS_FBW_UI = contextWindow {
    name = "MENU";
    position = { 0 , 0 , 600 , 600};
    noBackground = true ;
    proportional = true ;
    minimumSize = {300 , 300};
    maximumSize = {900 , 900};
    gravity = { 0 , 1 , 0 , 1 };
    visible = true ;
    components = {
      fbw_ui {position = { 0 , 0 , 1000 , 600 }}
    };
  }