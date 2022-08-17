private ["_array", "_arrayNew", "_grp", "_unit", "_grpPatrols", "_soldierPatrols", "_type", "_positions", "_men", "_pos", "_time", "_wps", "_type", "_time", "_time2"];

TOUR_grpPatrolsTarget = 1;
TOUR_soldierPatrolsTarget = 3;
TOUR_dangerEvents = ["PATROL", "RANDOM"];
TOUR_dangerEvent = "TIMING";

missionNameSpace setVariable ["TOUR_switchSideGroups", [], true];

// CALCULATE TIME OF BUILD UP FOR MAIN ASSAULT IF IT IS GOING TO HAPPEN

TOUR_baseAttack = false;

if (random 100 <= TOUR_baseAttackProbability) then 
{
	TOUR_baseAttack == true;
};
TOUR_baseAttack = true;

_minutesPlay = TOUR_playTime * 60;
_secondsPlay = _minutesPlay * 60;
_minutesEarliest = 15;
_minuteLatest = _minutesPlay - 30;

_minutesAvailable = _minuteLatest - _minutesEarliest;

_attackStartInAvailablePeriod = ceil random _minutesAvailable;
_buildUpStartTime = _attackStartInAvailablePeriod + _minutesEarliest;

_hoursFloat = _buildUpStartTime / 60;
_minutes = 0;
_hoursFlat = floor _hoursFloat;
_minutes = ((_hoursFloat - _hoursFlat) * 60);

_startDay = TOUR_StartTime select 2;
_startHour = TOUR_StartTime select 3;
_startMin = TOUR_StartTime select 4;

_endDay = TOUR_StartTime select 2;
_endHour = TOUR_StartTime select 3;
_endMin = TOUR_StartTime select 4;

if ((_startHour + _hoursFlat) >= 24) then 
{
	_endHour = (_startHour + _hoursFlat) - 24;
	_endDay = _startDay + 1;
}else 
{
	_endHour = (_startHour + _hoursFlat);
};

if ((_startMin + _minutes) >= 60) then 
{
	_endMin =(_startMin + _minutes) - 60;
}else 
{
	_endMin = (_startMin + _minutes);
};

TOUR_baseAttackBuildStartTime = [TOUR_StartTime select 0, TOUR_StartTime select 1, _endDay, _endHour, _endMin];


// MAP OUT TIMES FOR POSSIBLE RANDOM EVENTS EVERY HOUR
TOUR_randomEventTimes = [];
_eventTimeInSeconds = 0;

for "_i" from 1 to 24 do 
{
	if (_i == 1) then 
	{
		_eventTimeInSeconds = 900 + (ceil random 2700);
	}else 
	{
		_eventTimeInSeconds = (ceil random 3600);
	};
	TOUR_randomEventTimes pushBack _eventTimeInSeconds;
};

while {true} do 
{
	// CLEAN UP ARRAYS TO GIVE A VIABLE LIST OF GROUPS
	_array = missionNameSpace getVariable "TOUR_switchSideGroups";
	_arrayNew = [];
	TOUR_grpPatrols = 0;
	TOUR_soldierPatrols = 0;

	if (count _array > 0) then 
	{
		{
			_grp = _x select 0;
			_wps = _x select 1;
			_type = _x select 2;
			_time2 = _x select 3;
			if (count waypoints _grp == 0) then 
			{
				{
					if (_forEachIndex > 0) then 
					{
						_wp = _grp addWaypoint [_x, 0];
						_wp setWaypointType "MOVE";
					};
				}forEach _wps;
			};

			if (
					(isNull _grp)
					or
					({alive _x}count units _grp == 0)
					or
					((_type == "group") && {(alive _x) && (_x distance (_wps select 2) > 70)}count units _grp == 0)
					or
					((_type == "soldier") && {(alive _x) && (_x distance (_wps select 1) > 15)}count units _grp == 0)
					or
					((time > _time2 + 120) && {(alive _x) && (_x distance (_wps select 0) < 30)}count units _grp > 0)
			 	) then 
				{
					//hint str ((time > _time2 + 120) && {(alive _x) && (_x distance (_wps select 0) < 30)}count units _grp > 0);
					sleep 1;
					{deleteVehicle _x} forEach (units _grp);
				}else 
				{
					_arrayNew pushback [_grp, _wps, _type, _time2];
				};
				
		}forEach _array;
	};
	//sleep 2;
	//hint str _arrayNew;

	missionNameSpace setVariable ["TOUR_switchSideGroups", _arrayNew, true];

	// ADD MORE GROUPS IF NEEDED TO REACH THE TARGET LEVEL OF PATROLS

	if (count _arrayNew > 0) then 
	{
		TOUR_grpPatrols = {_x select 2 == "group"} count _arrayNew;
		TOUR_soldierPatrols = {_x select 2 == "soldier"} count _arrayNew;
	};


	if (TOUR_grpPatrols < TOUR_grpPatrolsTarget) then 
	{
		_men = [getMarkerPos "TOUR_mkr_AO", TOUR_EnemyInfGrp, RESISTANCE, TOUR_enemyGrpSpawns, 1500, 1200, 500] call TOUR_fnc_rndGroupPatrol;
	};
	if (TOUR_soldierPatrols < TOUR_soldierPatrolsTarget) then 
	{
		_man = [format ["TOUR_mkr_civArea%1", ceil random 6], RESISTANCE, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndSoldierPatrol;
	};

	// SELECT DANGER EVENTS

	if (
			(date select 2 >= TOUR_baseAttackBuildStartTime select 2)
			&&
			(date select 3 >= TOUR_baseAttackBuildStartTime select 3)
			&&
			(date select 4 >= TOUR_baseAttackBuildStartTime select 4)
			&&
			(isNil "TOUR_baseAttackComplete")
		) then 
	{
		TOUR_dangerEvent = "BASE";
	}else 
	{
		if (count TOUR_randomEventTimes > 0) then 
		{
			_time = TOUR_randomEventTimes select 0;
			if (time > _time) then 
			{
				TOUR_randomEventTimes = TOUR_randomEventTimes - [_time];
				if (random 100 <= TOUR_randomEventProbability) then 
				{
					TOUR_dangerEvent = TOUR_dangerEvents call BIS_fnc_selectRandom;
				};
			};
		};

	};

	// IF A DANGER EVENT IS REQUESTED, LOOK FOR UNITS TO ASSAULT OR THE MAIN BASE

	if (TOUR_dangerEvent != "STOPPED") then 
	{
		_pos = getMarkerPos "TOUR_mkr_FOB";
		_positions = [];
		_men = [];

		switch (TOUR_dangerEvent) do 
		{
			case "BASE":	{
								TOUR_enemyChatter = 1;
								sleep 300;
								TOUR_enemyChatter = 2;
								sleep 300;
								TOUR_enemyChatter = 3;
								sleep 300;
								TOUR_enemyChatter = 4;

								_men =  [_pos, TOUR_EnemyInfGrp, EAST, TOUR_enemyGrpSpawns, 8, 800, 300, "TOUR_mkr_FOB"] call TOUR_fnc_rndGroupAttack;
								while {count _men < 75} do 
								{
									_menAdd =  [_pos, TOUR_EnemyInfGrp, EAST, TOUR_enemyGrpSpawns, 1, 800, 300, "TOUR_mkr_FOB"] call TOUR_fnc_rndGroupAttack;
									_men = _menAdd + _men;
								};
								sleep 60;
								_men2 = [getMarkerPos "TOUR_mkr_FOB", 20, EAST, 50, 300, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack;
								waitUntil {sleep 1; count _men2 < 5};
								_men3 = [getMarkerPos "TOUR_mkr_FOB", 20, EAST, 50, 300, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack;
								waitUntil {sleep 1; count _men3 < 5};
								_men4 = [getMarkerPos "TOUR_mkr_FOB", 20, EAST, 50, 300, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack;
								sleep 120;
								TOUR_baseAttackComplete = true;
								TOUR_enemyChatter = 1;
							};
			case "PATROL": 	{ 
								TOUR_enemyChatter = 1;
								sleep 120;
								TOUR_enemyChatter = 2;
								sleep 120;
								TOUR_enemyChatter = 3;
								sleep 120;
								TOUR_enemyChatter = 4;

								{
									if ((alive _x) && (_pos distance _x > 100)) then 
									{
										_positions pushBack (getPos _x);
									};
								}forEach playableUnits + switchableUNits;

								if (count _positions > 0) then 
								{
									_pos = _positions call BIS_fnc_selectRandom;
								};

								[]call TOUR_fnc_patrolSwitchSides;
								sleep 120;
							};
			case "RANDOM": 	{
								TOUR_enemyChatter = 1;
								sleep 120;
								TOUR_enemyChatter = 2;
								sleep 120;
								TOUR_enemyChatter = 3;
								sleep 120;
								TOUR_enemyChatter = 4;

								{
									if ((alive _x) && (_pos distance _x > 100)) then 
									{
										_positions pushBack (getPos _x);
									};
								}forEach playableUnits + switchableUNits;

								if (count _positions > 0) then 
								{
									_pos = _positions call BIS_fnc_selectRandom;
								};
					
								_men = [_pos, 10, EAST, 50, 150, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack; 
								if (count _men == 0) then 
								{
									_men = [_pos, TOUR_EnemyInfGrp, "EAST", TOUR_enemyGrpSpawns, (ceil random 2), 500, 200, "TOUR_mkr_FOB"] call TOUR_fnc_rndGroupAttack;
								};
								sleep 120;
							};
			default {};
		};
		TOUR_dangerEvent = "STOPPED";
	};
	sleep 5;
};