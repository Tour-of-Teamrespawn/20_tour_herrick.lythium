private ["_position", "_types", "_side", "_grpSpawns", "_spawns", "_type", "_grp", "_men"];

_position = _this select 0;
_types = _this select 1;
_side = _this select 2;
_grpSpawns = _this select 3;
_number = _this select 4;
_max = _this select 5;
_min = _this select 6;
_safeArea = _this select 7;

_spawns = [];
_men = [];

{
	_spawn = _x;
	if (!(_spawn inArea _safeArea) && (_spawn distance _position < _max) && {(_x distance _spawn < _min) && (alive _x)}count (playableUnits + switchableUnits) == 0) then 
	{
		_spawns pushbackUnique _spawn;
	};
}forEach _grpSpawns;

if (count _spawns < _number) exitWith {};

_spawns = _spawns apply { [_x distance _position, _x] };
_spawns sort true;

for "_i" from 0 to (_number -1) do 
{
	_pos = _spawns call BIS_fnc_selectRandom;
	_spawns = _spawns - [_pos];
	_pos = _pos select 1;
	_type = _types call BIS_fnc_selectRandom;
	_grp = [_pos, _side, (configFile >> "CfgGroups" >> "EAST" >> "UK3CB_TKM_O" >> _type select 0 >> _type select 1)] call BIS_fnc_spawnGroup;
	{
		_x call Tour_fnc_garbageEH;
		[_x, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
		_men pushBack _x;
		_x setVariable ["TOUR_enemySide", true];
	}forEach units _grp;
	_wp = _grp addWaypoint [_position, random 30];
	_wp setWaypointType "GUARD";	
	_grp setCombatBehaviour "AWARE";
	_grp setCombatMode "RED";
};

_men