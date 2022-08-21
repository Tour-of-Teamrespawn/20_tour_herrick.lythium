waitUntil {!isNil "TOUR_init_complete"};
waitUntil {player == player};

execVM "scripts\general\dust.sqf";

{
	_x execVM "scripts\Virtual_arsenal\init.sqf";
}forEach [TOUR_AmmoBox_1];

if (TOUR_introEnable) then 
{
	execVM "scripts\general\intro.sqf";
};

[] call A2S_tasksSync;

#include "briefing.hpp";

[] execVM "scripts\TOUR_IED\init.sqf";

TOUR_campfire_1 execVM "scripts\general\flicker.sqf";

waitUntil {!isNil {missionNameSpace getVariable "TOUR_backpackRadioON"}};
waitUntil {!isNil {missionNameSpace getVariable "TOUR_backpackRadioBroadcast"}};

TOUR_playerActions = 
{
	player addAction ["<t color=""#d16a02"">"+"TURN ON RADIO", {missionNameSpace setVariable ["TOUR_backpackRadioON", true, true];}, 0, 10, true, false, "", 
	" !(missionNameSpace getVariable 'TOUR_backpackRadioON') && 
		(
			((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
		)
	"];

	player addAction ["<t color=""#d16a02"">"+"TURN OFF RADIO", {missionNameSpace setVariable ["TOUR_backpackRadioON", false, true];}, 0, 10, true, false, "", 
	" (missionNameSpace getVariable 'TOUR_backpackRadioON') && 
		(
			((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
		)
	"];

	player addAction ["<t color=""#d16a02"">"+"RADIO BROADCAST ON", {missionNameSpace setVariable ["TOUR_backpackRadioBroadcast", true, true];}, 0, 10, true, false, "", 
	" !(missionNameSpace getVariable 'TOUR_backpackRadioBroadcast') && 
		(
			((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
		)
	"];

	player addAction ["<t color=""#d16a02"">"+"RADIO BROADCAST OFF", {missionNameSpace setVariable ["TOUR_backpackRadioBroadcast", false, true];}, 0, 10, true, false, "", 
	" (missionNameSpace getVariable 'TOUR_backpackRadioBroadcast') && 
		(
			((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
		)
	"];

	player addAction ["<t color=""#d16a02"">"+"REPLY", "scripts\control\radioReply.sqf", 0, 10, true, false, "", 
	"(missionNameSpace getVariable 'TOUR_tskRadioState' == 'calling') && 
		(
			((player distance TOUR_laptop < 2) && (cursorTarget == TOUR_laptop))
			or
			(
				(alive player) && (missionNameSpace getVariable 'TOUR_backpackRadioON') &&
				((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])
			)
		)
	"];
};

[]call TOUR_playerActions;

player addEventHandler ["Respawn" ,
{
	[]call TOUR_playerActions;
}];

sleep 5;

[player,"img\insigniaQLR"] call BIS_fnc_setUnitInsignia;