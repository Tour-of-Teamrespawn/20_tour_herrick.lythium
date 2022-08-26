/*
	ENMEY HOUSE SCRIPT
	by Mr.Ben
	
	params passed to script through an array:
	0 = centre
	1 = side, side

*/

private ["_number","_centrepos", "_marker", "_array_type", "_skill", "_side", "_pos", "_test", "_buildingsnew", "_buildings", "_building", "_grp", "_unit", "_size", "_type", "_posarray", "_count", "_min", "_max", "_men"];

_centrepos = _this select 0;
_number = _this select 1;
_side = _this select 2;
_min = _this select 3;
_max = _this select 4;
_array_type = _this select 5;
_safeArea = _this select 6;

_pos = [0,0,0];
_test = 0;
_buildingsnew = [];
_posarray = [];
_positions = [];
_buildings = [];
_men = [];

{
	_building = _x;
	if (!(_building inArea _safeArea) && {(alive _x) && (_x distance _building < _min)}count (playableUnits + switchableUnits) == 0) then 
	{
		_buildings set [count _buildings, _building];
	};
}forEach (nearestObjects [_centrepos,["Building","House"], _max]);

if ((count _buildings) == 0) exitWith
{
	_men
};

{
	_building = _buildings select _forEachIndex;
	_test = 0;
	while {_test < 50} do 
	{
		if (format ["%1", _building buildingPos _test] != "[0,0,0]") then 
		{
			if (({_x isKindOf "House"}count (lineIntersectsObjs [[(AGLtoASL (_building buildingPos _test)) select 0, (AGLtoASL (_building buildingPos _test)) select 1, ((AGLtoASL (_building buildingPos _test)) select 2) + 0.5], [(AGLtoASL (_building buildingPos _test)) select 0, (AGLtoASL (_building buildingPos _test)) select 1, (AGLtoASL (_building buildingPos _test) select 2) + 10], objnull, objnull, true, 32])) > 0) then 
			{
				_posarray set [count _posarray, [_building, _building buildingPos _test]];
			}; 
		};
		_test = _test + 1;
	};
}forEach _buildings;

if ((count _posarray) < _number) then
{
	_number = count _posarray;
};

if (_number < 1) exitWith {_men};


for "_i" from 1 to _number do
{
	_pos = [objnull, [0,0,0]];
	_pos = (_posarray call BIS_fnc_selectRandom);
	_posarray = _posarray - [_pos];
	_type = _array_type call BIS_fnc_selectRandom;
	if (typeName _type == "ARRAY") then
	{
		_type = _type select 1;
	};
	_grp = createGroup _side;
	waitUntil {!isNull _grp};
	_dir = ((getPosATL (_pos select 0)) getDir (_pos select 1));
	_unit = _grp createUnit [_type, _pos select 1, [], _dir, "NONE"];
	waitUntil {!isNull _unit};
	_unit setPos (_pos select 1);
	_unit setUnitPos "UP";
	_unit call Tour_fnc_garbageEH;
	[_unit, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
	_wp = _grp addWaypoint [_centrepos, 0];
	_wp setWaypointType "MOVE";	
	_wp = _grp addWaypoint [_centrepos, random 30];
	_wp setWaypointType "GUARD";	
	_grp setCombatBehaviour "AWARE";
	_grp setCombatMode "RED";
	_men pushbackUnique _unit;
};

_men
