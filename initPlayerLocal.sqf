waitUntil {!isNil "TOUR_init_complete"};
waitUntil {player == player};

execVM "scripts\general\dust.sqf";

{
	_x execVM "scripts\Virtual_arsenal\init.sqf";
}forEach [TOUR_AmmoBox_1];

player addAction ["<t color=""#d16a02"">"+"REPLY", "scripts\control\radioReply.sqf", 0, 10, true, false, "", 
"(missionNameSpace getVariable 'TOUR_tskRadioState' == 'calling') && 
	(
		((player distance TOUR_laptop < 2) && (cursorTarget == TOUR_laptop))
		or
		(
			(alive player) && (missionNameSpace getVariable 'TOUR_backpacRadioON') &&
			((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
		)
	)
"];

waitUntil {!isNil {missionNameSpace getVariable "TOUR_backpacRadioON"}};

player addAction ["<t color=""#d16a02"">"+"TURN ON RADIO", {missionNameSpace setVariable ["TOUR_backpacRadioON", true, true];}, 0, 10, true, false, "", 
" !(missionNameSpace getVariable 'TOUR_backpacRadioON') && 
	(
		((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
	)
"];

player addAction ["<t color=""#d16a02"">"+"TURN OFF RADIO", {missionNameSpace setVariable ["TOUR_backpacRadioON", false, true];}, 0, 10, true, false, "", 
" (missionNameSpace getVariable 'TOUR_backpacRadioON') && 
	(
		((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
	)
"];

[] call A2S_tasksSync;

#include "briefing.hpp";