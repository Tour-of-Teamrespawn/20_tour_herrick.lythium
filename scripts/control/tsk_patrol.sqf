private ["_pos", "_mkr", "_men", "_taskName"];

_time = time + 5;
while {true} do 
{
	_distance = 400 + (random 800);
	_dir = random 360;
	_pos = (getMarkerPos "TOUR_mkr_AO") getPos [_distance, _dir];
	if ({((alive _x) && ((vehicle _x) distance _pos < 300)) or (_pos in TOUR_taskLocations)}count (playableUnits + switchableunits) == 0) exitWith {TOUR_tskAccept = true};
	if (time > _time) exitWith {TOUR_tskAccept = false};
	sleep 0.05;
};

if !(TOUR_tskAccept) exitWith {};

TOUR_patrolNo = TOUR_patrolNo + 1;
_taskName = (format ["TOUR_objPatrol_%1", TOUR_patrolNo]);

if (str getMarkerPos (format ["TOUR_mkr_tskPatrol_%1", TOUR_patrolNo]) == "[0,0,0]") then 
{
	_mkr = createMarker [(format ["TOUR_mkr_tskPatrol_%1", TOUR_patrolNo]), _pos];
}else
{
	(format ["TOUR_mkr_tskPatrol_%1", TOUR_patrolNo]) setMarkerPos _pos;
};

TOUR_taskLocations pushBack _pos;

["patrol", 3] call TOUR_fnc_hqOrders;

[WEST, _taskName, [format ["Patrol and scout <marker name=""TOUR_mkr_tskPatrol_%1"">this area</marker>.", TOUR_patrolNo], "Patrol", format ["TOUR_mkr_tskPatrol_%1", TOUR_patrolNo]], getMarkerPos (format ["TOUR_mkr_tskPatrol_%1", TOUR_patrolNo]), "CREATED", -1, true, "walk"] call BIS_fnc_taskCreate;

_men = [];

if (random 1 > 0.5) then 
{
	for "_i" from 1 to (ceil random 2) do
	{
		_type = TOUR_EnemyInfGrp call BIS_fnc_selectRandom;
		_grp = [getMarkerPos _mkr, EAST, (configFile >> "CfgGroups" >> "EAST" >> "UK3CB_TKM_O" >> _type select 0 >> _type select 1)] call BIS_fnc_spawnGroup;
		[_grp, (getPosATL (leader _grp))] call BIS_fnc_taskDefend;
		{
			_x call Tour_fnc_garbageEH;
			[_x, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
			_men pushBack _x;
			_x setVariable ["TOUR_enemySide", true];
		}forEach units _grp;
	};
};

if (random 1 > 0.5) then 
{
	for "_i" from 1 to (ceil random 2) do
	{
		_type = TOUR_EnemyInfGrp call BIS_fnc_selectRandom;
		_grp = [getMarkerPos _mkr, EAST, (configFile >> "CfgGroups" >> "EAST" >> "UK3CB_TKM_O" >> _type select 0 >> _type select 1)] call BIS_fnc_spawnGroup;
		[_grp, (getMarkerPos _mkr) getpos [50, random 360], 100] call TOUR_fnc_rndPatrol;
		{
			_x call Tour_fnc_garbageEH;
			[_x, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
			_men pushBack _x;
			_x setVariable ["TOUR_enemySide", true];
		}forEach units _grp;
	};
};

waitUntil 
{
	sleep 5;
	({(alive _x) && ((vehicle _x) distance _pos < 50)}count (playableUnits + switchableunits) > 0)
};

sleep 2;
[_taskName, "SUCCEEDED", true] call BIS_fnc_taskSetState;

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

_taskName call BIS_fnc_deleteTask;

sleep 2;

TOUR_taskLocations deleteAt (TOUR_taskLocations find _pos);

waitUntil {sleep 1; (({(alive _x) && (_pos distance _x < 200)} count (playableUnits + switchableUnits)) == 0)};

{
	_man = _x;
	if (!isNull _x) then 
	{
		if (({(alive _x) && (_man distance _x < 300)} count (playableUnits + switchableUnits)) == 0) then 
		{
			deleteVehicle _x;
		};
	};
	sleep 0.5;
	if ({!isNull _x}count _men == 0) exitwith {};
}forEach _men;
