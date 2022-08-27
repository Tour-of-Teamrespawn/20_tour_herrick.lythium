waitUntil {!isNil "TOUR_init_complete"};
waitUntil {player == player};

execVM "scripts\general\dust.sqf";

{
//	_x execVM "scripts\Virtual_arsenal\init.sqf";
}forEach [TOUR_AmmoBox_1];

if (TOUR_introEnable) then 
{
	execVM "scripts\general\intro.sqf";
};

[] call A2S_tasksSync;

#include "briefing.hpp";

[] execVM "scripts\TOUR_IED\init.sqf";

TOUR_campfire_1 execVM "scripts\general\flicker.sqf";

// ADD ACE INTERACTION FOR CIVILIANS FOOD RATIONS

_action = 	["Give Food","Give Food","",
				{
					{
						_index = (items player) find _x;
						if (_index > -1) exitWith
						{
							player removeItem _x;
							_target additem _x;
							_count = (missionNameSpace getVariable "TOUR_mreCount") + 1;
							missionNameSpace setVariable ["TOUR_mreCount", _count, true];
						};
					}forEach 
					[	
						"ACE_MRE_BeefStew",
						"ACE_MRE_ChickenTikkaMasala",
						"ACE_MRE_ChickenHerbDumplings",
						"ACE_MRE_CreamChickenSoup",
						"ACE_MRE_CreamTomatoSoup",
						"ACE_MRE_LambCurry",
						"ACE_MRE_MeatballsPasta",
						"ACE_MRE_SteakVegetables"
					] ;
				},
				{
					(!isNil {missionNameSpace getVariable "TOUR_mreCount"})
					&&
					(_target distance (getMarkerPos "TOUR_mkr_tskMRE") < 200)
					&&
					(
						{_x in (items player)}count 
						[	
							"ACE_MRE_BeefStew",
							"ACE_MRE_ChickenTikkaMasala",
							"ACE_MRE_ChickenHerbDumplings",
							"ACE_MRE_CreamChickenSoup",
							"ACE_MRE_CreamTomatoSoup",
							"ACE_MRE_LambCurry",
							"ACE_MRE_MeatballsPasta",
							"ACE_MRE_SteakVegetables"
						] > 0
					)
					&&
					(
						{_x in (items _target)}count 
						[	
							"ACE_MRE_BeefStew",
							"ACE_MRE_ChickenTikkaMasala",
							"ACE_MRE_ChickenHerbDumplings",
							"ACE_MRE_CreamChickenSoup",
							"ACE_MRE_CreamTomatoSoup",
							"ACE_MRE_LambCurry",
							"ACE_MRE_MeatballsPasta",
							"ACE_MRE_SteakVegetables"
						] == 0
					)		
				}
			] call ace_interact_menu_fnc_createAction;


["UK3CB_TKC_C_CIV", 0, ["ACE_MainActions"], _action ]spawn ace_interact_menu_fnc_addActionToClass;

waitUntil {!isNil {missionNameSpace getVariable "TOUR_backpackRadioON"}};
waitUntil {!isNil {missionNameSpace getVariable "TOUR_backpackRadioBroadcast"}};
waitUntil {!isNil {missionNameSpace getVariable "TOUR_backpackRadioRequest"}};


_actionStaticRadioPickup = 	["Answer Radio","Answer Radio","",
				{
					TOUR_cmdRadio execVM "scripts\control\radioReply.sqf";
				},
				{
					(missionNameSpace getVariable "TOUR_tskRadioState" == "calling")		
				}
			] call ace_interact_menu_fnc_createAction;
			
[TOUR_cmdRadio, 0, ["ACE_MainActions"], _actionStaticRadioPickup ]spawn ace_interact_menu_fnc_addActionToObject;

_actionAnswerPersonalRadio = 	["Answer Radio","Answer Radio","",
				{
					player execVM "scripts\control\radioReply.sqf";
				},
				{
					(missionNameSpace getVariable "TOUR_backpackRadioON") && (missionNameSpace getVariable "TOUR_tskRadioState" == "calling")		
				}
			] call ace_interact_menu_fnc_createAction;
			
[player, 1, ["ACE_SelfActions", "ACRE_Interact"], _actionAnswerPersonalRadio ]spawn ace_interact_menu_fnc_addActionToObject;

_actionAnswerPersonalRadio = 	["Turn On Radio","Turn On Radio","",
				{
					missionNameSpace setVariable ["TOUR_backpackRadioON", true, true];
				},
				{
					!(missionNameSpace getVariable "TOUR_backpackRadioON") && 
					(
						((toLower (backpack player)) in	["uk3cb_baf_b_bergen_mtp_radio_h_a","uk3cb_baf_b_bergen_mtp_radio_h_b","uk3cb_baf_b_bergen_mtp_radio_l_a","uk3cb_baf_b_bergen_mtp_radio_l_b"])
					)	
				}
			] call ace_interact_menu_fnc_createAction;
			
[player, 1, ["ACE_SelfActions", "ACRE_Interact"], _actionAnswerPersonalRadio ]spawn ace_interact_menu_fnc_addActionToObject;

_actionAnswerPersonalRadio = 	["Turn Off Radio","Turn Off Radio","",
				{
					missionNameSpace setVariable ["TOUR_backpackRadioON", false, true];
				},
				{
					(missionNameSpace getVariable "TOUR_backpackRadioON") && 
					(
						((toLower (backpack player)) in	["uk3cb_baf_b_bergen_mtp_radio_h_a","uk3cb_baf_b_bergen_mtp_radio_h_b","uk3cb_baf_b_bergen_mtp_radio_l_a","uk3cb_baf_b_bergen_mtp_radio_l_b"])
					)	
				}
			] call ace_interact_menu_fnc_createAction;
			
[player, 1, ["ACE_SelfActions", "ACRE_Interact"], _actionAnswerPersonalRadio ]spawn ace_interact_menu_fnc_addActionToObject;

_actionAnswerPersonalRadio = 	["Internal Radio","Internal Radio","",
				{
					missionNameSpace setVariable ["TOUR_backpackRadioBroadcast", false, true];
				},
				{
					(missionNameSpace getVariable "TOUR_backpackRadioON") && (missionNameSpace getVariable "TOUR_backpackRadioBroadcast") && 
					(
						((toLower (backpack player)) in	["uk3cb_baf_b_bergen_mtp_radio_h_a","uk3cb_baf_b_bergen_mtp_radio_h_b","uk3cb_baf_b_bergen_mtp_radio_l_a","uk3cb_baf_b_bergen_mtp_radio_l_b"])
					)	
				}
			] call ace_interact_menu_fnc_createAction;
			
[player, 1, ["ACE_SelfActions", "ACRE_Interact"], _actionAnswerPersonalRadio ]spawn ace_interact_menu_fnc_addActionToObject;

_actionAnswerPersonalRadio = 	["Broadcast Radio","Broadcast Radio","",
				{
					missionNameSpace setVariable ["TOUR_backpackRadioBroadcast", true, true];
				},
				{
					(missionNameSpace getVariable "TOUR_backpackRadioON") && !(missionNameSpace getVariable "TOUR_backpackRadioBroadcast") && 
					(
						((toLower (backpack player)) in	["uk3cb_baf_b_bergen_mtp_radio_h_a","uk3cb_baf_b_bergen_mtp_radio_h_b","uk3cb_baf_b_bergen_mtp_radio_l_a","uk3cb_baf_b_bergen_mtp_radio_l_b"])
					)	
				}
			] call ace_interact_menu_fnc_createAction;
			
[player, 1, ["ACE_SelfActions", "ACRE_Interact"], _actionAnswerPersonalRadio ]spawn ace_interact_menu_fnc_addActionToObject;

TOUR_playerActions = 
{
	player addAction ["<t color=""#d16a02"">"+"Request Deployment", { missionNameSpace setVariable ["TOUR_backpackRadioRequest", true, true]; }, 0, 10, true, false, "", 
	" !(missionNameSpace getVariable 'TOUR_backpackRadioRequest') && 
		(
			(alive player) && (canMove TOUR_chopper_1) (vehicle player == TOUR_chopper_1) && (TOUR_chopper_1 distance getMarkerPos ""respawn_west"" < 300)
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