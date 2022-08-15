private ["_time", "_task"];

TOUR_tskCount = 0;
TOUR_tskAvailable = ["patrol", "raid"];
TOUR_taskLocations = [];

while {TOUR_tskCount < TOUR_tskCountTarget} do 
{
	missionNameSpace setVariable ["TOUR_tskAccept", "calling", true];
	_time = time + 60;
	waitUntil {(missionNameSpace getVariable "TOUR_tskAccept" == "accepted") or (time > _time)};
	if (time > _time) then 
	{
		missionNameSpace setVariable ["TOUR_tskAccept", "silent", true];
	};

	if (missionNameSpace getVariable "TOUR_tskAccept" == "accepted") then 
	{
		while {true} do 
		{
			TOUR_tskAccept = nil;
			_task = TOUR_tskAvailable call BIS_fnc_selectRandom;
			execVM format ["scripts\control\tsk_%1.sqf", _task];
			waitUntil {!isNil "TOUR_tskAccept"};
			if (TOUR_tskAccept == true) exitWith 
			{
				TOUR_tskAvailable = TOUR_tskAvailable - [_task];
			};
		};
		sleep 5;
	};
	waitUntil {count TOUR_taskLocations < 3};
	//sleep 900;
	sleep 5;
};