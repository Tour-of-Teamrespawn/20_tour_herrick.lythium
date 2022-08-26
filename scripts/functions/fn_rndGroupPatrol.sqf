private ["_mid", "_position", "_types", "_side", "_grpSpawns", "_spawns", "_type", "_grp", "_men"];

_position = _this select 0;
_types = _this select 1;
_side = _this select 2;
_grpSpawns = _this select 3;
_max = _this select 4;
_min = _this select 5;

_spawns = [];
_men = [];

{
	_spawn = _x;
	if ((_spawn distance _position < _max) && {(_x distance _spawn < _min) && (alive _x)}count (playableUnits + switchableUnits) == 0) then 
	{
		_spawns pushbackUnique _spawn;
	};
}forEach _grpSpawns;

if (count _spawns < 2) exitWith {};

_pos1 = _spawns call BIS_fnc_selectRandom;
_spawns = _spawns - [_pos1];

_spawns2 = [];
{
	_spawn = _x;
	if ((_spawn distance _pos1 < _max) && (_spawn distance _position < _max) && {(_x distance _spawn < _min) && (alive _x)}count (playableUnits + switchableUnits) == 0) then 
	{
		_spawns2 pushbackUnique _spawn;
	};
}forEach _spawns;

if (count _spawns2 < 1) exitWith {};

_pos3 = _spawns call BIS_fnc_selectRandom;

_type = _types call BIS_fnc_selectRandom;
_grp = [_pos1, _side, (configFile >> "CfgGroups" >> "EAST" >> "UK3CB_TKM_O" >> _type select 0 >> _type select 1)] call BIS_fnc_spawnGroup;
{
	_x call Tour_fnc_garbageEH;
	[_x, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
	_men pushBack _x;
	_x setVariable ["TOUR_switchableSide", true, true];
}forEach units _grp;

_pos2 = _position getPos [150  + random 350, random 360];

_wp = _grp addWaypoint [_pos2, 0];
_wp setWaypointType "MOVE";	
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointCombatMode "YELLOW";	
_wp setWaypointSpeed "LIMITED";	
_wp setWaypointCompletionRadius 50;	

_wp2 = _grp addWaypoint [_pos3, 0];
_wp2 setWaypointType "MOVE";	