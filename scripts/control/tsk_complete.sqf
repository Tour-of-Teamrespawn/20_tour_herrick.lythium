private ["_sound"];
_sound = "TOUR_snd_end";

[[_sound],{TOUR_cmdRadio say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
if (missionNameSpace getVariable "TOUR_backpackRadioON") then
{
	if (missionNameSpace getVariable "TOUR_backpackRadioBroadcast") then
	{
		[[_sound],{TOUR_radioSound say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
	}else 
	{
		if !(missionNameSpace getVariable "TOUR_backpackRadioBroadcast") then 
		{
			[[_sound],
			{ 
				if (!isDedicated) then 
				{
					if ((toLower (backpack player)) in	["uk3cb_baf_b_bergen_mtp_radio_h_a","uk3cb_baf_b_bergen_mtp_radio_h_b","uk3cb_baf_b_bergen_mtp_radio_l_a","uk3cb_baf_b_bergen_mtp_radio_l_b"]) then
					{
						player say2d [_this select 0, 50];
					};
				};
			}] remoteExecCall ["BIS_fnc_spawn", 0, false];
		};
	};
};

sleep 6;
missionNamespace setVariable ["TOUR_tourCompleteAnswered", true];