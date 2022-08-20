private ["_time", "_waitTime", "_task"];

TOUR_patrolNo = 0;

TOUR_tskCountTarget = 10;
TOUR_tskCount = 0;
TOUR_taskRepo = ["patrol", "patrol", "patrol", "raid", "assault", "arrest", "kill", "ied"];
TOUR_tskAvailable = [];
{
	TOUR_tskAvailable pushBack _x;
} forEach TOUR_taskRepo;
TOUR_taskLocations = [];

missionNameSpace setVariable ["TOUR_backpacRadioON", false, true];
execVM "scripts\control\toggleRadio.sqf";

missionNameSpace setVariable ["TOUR_tskRadioState", "SILENT", true];
execVM "scripts\control\radioChatterLoop.sqf";
sleep 60;

while {TOUR_tskCount < TOUR_tskCountTarget} do 
{
	waitUntil {(missionNameSpace getVariable "TOUR_tskRadioState" != "tali")};
	missionNameSpace setVariable ["TOUR_tskRadioState", "calling", true];
	_waitTime = time + 120;
	_time = time - 1;
	while {true} do 
	{
		if (time > _waitTime && !(missionNameSpace getVariable "TOUR_tskRadioState" == "replying")) exitWith {};
		if (missionNameSpace getVariable "TOUR_tskRadioState" == "accepted") exitWith {};
		if ((missionNameSpace getVariable "TOUR_tskRadioState" == "calling") && (time > _time)) then 
		{
			_sound = format ["TOUR_snd_Line_%1", ceil random 4];
			[[_sound],{TOUR_cmdRadio say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
			if (missionNameSpace getVariable "TOUR_backpacRadioON") then
			{
				[[_sound],{TOUR_radioSound say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
			};
			_time = time + (10 + random 5);
		};
		sleep 1;
	};
	if (time > _waitTime) then 
	{
		missionNameSpace setVariable ["TOUR_tskRadioState", "silent", true];
		sleep 10;
	};
	if (missionNameSpace getVariable "TOUR_tskRadioState" == "accepted") then 
	{
		while {true} do 
		{
			TOUR_tskAccept = nil;
			_task = TOUR_tskAvailable call BIS_fnc_selectRandom;
			execVM format ["scripts\control\tsk_%1.sqf", _task];
			waitUntil {!isNil "TOUR_tskAccept"};
			if (TOUR_tskAccept == true) exitWith 
			{
				TOUR_tskAvailable deleteAt (TOUR_tskAvailable find _task);
			};
		};
		sleep 30;
		missionNameSpace setVariable ["TOUR_tskRadioState", "silent", true];
	};
	waitUntil {(count TOUR_tskAvailable > 0 && count TOUR_taskLocations < 3) or (count TOUR_tskAvailable == 0 && count TOUR_taskLocations == 0)};

	if (count TOUR_tskAvailable == 0) then 
	{
		TOUR_tskAvailable = [];
		{
			TOUR_tskAvailable pushBack _x;
		} forEach TOUR_taskRepo;
	};
	sleep 900;
};