private ["_time", "_sound"];

missionNameSpace setVariable ["TOUR_enemyChatter", 1, true];
waitUntil {!isNil {missionNameSpace getVariable "TOUR_tskRadioState"}};
waitUntil {!isNil {missionNameSpace getVariable "TOUR_backpackRadioBroadcast"}};

while {true} do 
{
	_status = (missionNameSpace getVariable "TOUR_enemyChatter");
	if (missionNameSpace getVariable "TOUR_tskRadioState" == "SILENT") then 
	{
		missionNameSpace setVariable ["TOUR_tskRadioState", "enemy", true];
	
		_sound = format ["TOUR_radio_tal_%1", ceil random 16];
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

		if ((missionNameSpace getVariable "TOUR_enemyChatter") == 1) then 
		{
			_time = time + 80;
		};
		if ((missionNameSpace getVariable "TOUR_enemyChatter") == 2) then 
		{
			_time = time + 60;
		};
		if ((missionNameSpace getVariable "TOUR_enemyChatter") == 3) then 
		{
			_time = time + 20;
		};
		if ((missionNameSpace getVariable "TOUR_enemyChatter") == 4) then 
		{
			_time = time + 5;
		};
		sleep 9;
		missionNameSpace setVariable ["TOUR_tskRadioState", "SILENT", true];
		sleep 5;
		_time = _time + 10;
	}else 
	{
		sleep 10;
	};
	waitUntil {((missionNameSpace getVariable "TOUR_enemyChatter") != _status) or (time > _time)};
};