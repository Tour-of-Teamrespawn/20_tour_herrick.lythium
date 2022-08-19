private ["_time", "_sound"];

TOUR_enemyChatter = 1;
waitUntil {!isNil {missionNameSpace getVariable "TOUR_tskRadioState"}};

while {true} do 
{
	_status = TOUR_enemyChatter;
	if (missionNameSpace getVariable "TOUR_tskRadioState" == "SILENT") then 
	{
		missionNameSpace setVariable ["TOUR_tskRadioState", "enemy", true];
	
		_sound = format ["TOUR_radio_tal_%1", ceil random 16];
		[[_sound],{TOUR_cmdRadio say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
		if (missionNameSpace getVariable "TOUR_backpacRadioON") then
		{
			[[_sound],{TOUR_radioSound say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
		};

		if (TOUR_enemyChatter == 1) then 
		{
			_time = time + 90;
		};
		if (TOUR_enemyChatter == 2) then 
		{
			_time = time + 60;
		};
		if (TOUR_enemyChatter == 3) then 
		{
			_time = time + 30;
		};
		if (TOUR_enemyChatter == 4) then 
		{
			_time = time + 15;
		};
		sleep 9;
		missionNameSpace setVariable ["TOUR_tskRadioState", "SILENT", true];
		sleep 1;
	}else 
	{
		sleep 10;
	};
	waitUntil {(TOUR_enemyChatter != _status) or (time > _time)};
};