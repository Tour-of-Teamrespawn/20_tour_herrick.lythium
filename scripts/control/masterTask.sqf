private ["_time", "_waitTime", "_task", "_patrolActive"];

TOUR_patrolNo = 0;

TOUR_tskCountTarget = 1000;
TOUR_tskCount = 0;
TOUR_taskRepo = ["patrol", "patrol", "patrol", "raid", "assault", "arrest", "kill", "ied", "protect","mre","heal","elder"];//["heal","patrol", "patrol", "patrol", "raid", "assault", "arrest", "kill", "ied", "protect","mre","elder"];
TOUR_tskAvailable = [];
{
	TOUR_tskAvailable pushBack _x;
} forEach TOUR_taskRepo;
TOUR_taskLocations = [];

missionNameSpace setVariable ["TOUR_backpackRadioON", false, true];
missionNameSpace setVariable ["TOUR_backpackRadioBroadcast", true, true];
execVM "scripts\control\toggleRadio.sqf";

missionNameSpace setVariable ["TOUR_tskRadioState", "SILENT", true];
execVM "scripts\control\radioChatterLoop.sqf";
sleep 120;

while {TOUR_tskCount < TOUR_tskCountTarget} do 
{
	waitUntil {(missionNameSpace getVariable "TOUR_tskRadioState" == "silent")};
	missionNameSpace setVariable ["TOUR_tskRadioState", "calling", true];
	_waitTime = if (isNil {missionNamespace getVariable "TOUR_tourComplete"}) then 
	{
		time + 120;
	}else 
	{
		time + 99999;
	};
	_time = time - 1;
	while {true} do 
	{
		if (time > _waitTime && !(missionNameSpace getVariable "TOUR_tskRadioState" == "replying")) exitWith {};
		if (missionNameSpace getVariable "TOUR_tskRadioState" == "accepted") exitWith {};
		if ((missionNameSpace getVariable "TOUR_tskRadioState" == "calling") && (time > _time)) then 
		{
			_sound = format ["TOUR_snd_Line_%1", ceil random 4];
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
			_patrolActive = false;
			if (isNil {missionNamespace getVariable "TOUR_tourComplete"}) then 
			{
				for "_i" from 0 to 10 do
				{
					if ((format ["TOUR_objPatrol_%1", _i]) call BIS_fnc_taskExists) exitWith 
					{
						_patrolActive = true;
					};
				};
				if (_patrolActive) then 
				{
					_weights = [];
					{
						if (_x == "patrol") then 
						{
							_weights pushBack 0.001;
						}else 
						{
							_weights pushBack 1;
						};
					}forEach TOUR_tskAvailable;
					_task = TOUR_tskAvailable selectRandomWeighted _weights;
				}else 
				{
					_task = selectRandom TOUR_tskAvailable;
				};
			}else 
			{
				_task = "complete";
			};
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
		TOUR_patrolNo = 0;
	};

	if !(isNil {missionNamespace getVariable "TOUR_tourComplete"}) then 
	{
		sleep 10;
	}else 
	{
		sleep 900;
	};
};