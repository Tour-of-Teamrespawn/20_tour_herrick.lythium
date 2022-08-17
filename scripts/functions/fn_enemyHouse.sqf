/*
	ENMEY HOUSE SCRIPT
	by Mr.Ben
	
	params passed to script through an array:
	0 = centre
	1 = side, side

*/

private ["_return", "_warLord", "_warLordPosArray", "_bossType", "_centrepos", "_marker", "_array_type", "_skill", "_side", "_pos", "_test", "_buildingsnew", "_buildings", "_building", "_grp", "_unit", "_size", "_type", "_posarray", "_count", "_min", "_max", "_men"];

_centrepos = _this select 0;
_distance = _this select 1;
_side = _this select 2;
_min = _this select 3;
_max = _this select 4;
_array_type = _this select 5;
if (count _this > 6) then 
{
	_bossType = _this select 6;
};

_pos = [0,0,0];
_test = 0;
_buildingsnew = [];
_posarray = [];
_positions = [];
_buildings = [];
_warLordPosArray = [];
_return = [];

{
	_buildings set [count _buildings, _x];
}forEach (nearestObjects [_centrepos,["Building","House"], _distance]);

if ((count _buildings) == 0) exitWith
{
	_pos
};

{
	_building = _buildings select _forEachIndex;
	_test = 0;
	while {_test < 50} do 
	{
		if (format ["%1", _building buildingPos _test] != "[0,0,0]") then 
		{
			_posarray set [count _posarray, [_building, _building buildingPos _test]];
			if (({_x isKindOf "House"}count (lineIntersectsObjs [[(AGLtoASL (_building buildingPos _test)) select 0, (AGLtoASL (_building buildingPos _test)) select 1, ((AGLtoASL (_building buildingPos _test)) select 2) + 0.5], [(AGLtoASL (_building buildingPos _test)) select 0, (AGLtoASL (_building buildingPos _test)) select 1, (AGLtoASL (_building buildingPos _test) select 2) + 10], objnull, objnull, true, 32])) > 0) then 
			{
				_warLordPosArray set [count _warLordPosArray, [_building, _building buildingPos _test]];
			}; 
		};
		_test = _test + 1;
	};
}forEach _buildings;

if ((count _posarray) < _max) then
{
	_max = count _posarray;
};

if (_min > _max) then
{
	_min = _max;
};

if (_max < 1) then
{
	_max = 1;
	_min = 1;
};

if (count _posarray == 0) exitWith {};
if ((count _this > 6) && count _warLordPosArray == 0) exitWith {};

_men = [];
if (count _this > 6) then 
{
	_pos = (_warLordPosArray call BIS_fnc_selectRandom);
	_posarray = _posarray - [_pos];
	_grp = createGroup _side;
	waitUntil {!isNull _grp};
	_dir = ((getPosATL (_pos select 0)) getDir (_pos select 1));
	_warLord = _grp createUnit [_bossType, _pos select 1, [], _dir, "NONE"];
	waitUntil {!isNull _warLord};
	_warLord setPos (_pos select 1);
	_warLord setDir _dir;
	_grp setFormDir _dir;
	_warLord setUnitPos "UP";
	_warLord call TOUR_fnc_skillAI;
	_warLord disableAI "move";
	_warLord setVariable ["lambs_danger_disableAI", true];
	_return pushback _warLord;
};

for "_i" from 1 to (_min + (ceil (random (_max - _min)))) do
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
	_unit setDir _dir;
	_grp setFormDir _dir;
	_unit setUnitPos "UP";
	_unit call Tour_fnc_garbageEH;
	_unit call TOUR_fnc_skillAI;
	_unit setVariable ["lambs_danger_disableAI", true];
	_men pushbackUnique _unit;
};

if ( count _return > 0) then 
{
	_return pushback _men;
}else 
{
	_return = _men;
};

_return
