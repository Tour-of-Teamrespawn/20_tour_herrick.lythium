/*
	ENMEY HOUSE SCRIPT
	by Mr.Ben
	
	params passed to script through an array:
	0 = centre
	1 = side, side

*/

private ["_number","_mkr", "_marker", "_array_type", "_skill", "_side", "_pos", "_test", "_buildingsnew", "_buildings", "_building", "_grp", "_unit", "_size", "_type", "_posarray", "_count", "_min", "_max", "_man"];

_mkr = _this select 0;
_side = _this select 1;
_array_type = _this select 2;
_safeArea = _this select 3;

_pos1 = [0,0,0];
_pos2 = [0,0,0];
_test = 0;
_buildingsnew = [];
_posarray = [];
_positions = [];
_buildings = [];
_man = objNull;

_size = ((getMarkerSize _mkr) select 0) max ((getMarkerSize _mkr) select 1);

{
	_building = _x;
	if (!(_building inArea _safeArea) && (_building inArea _mkr) && ({(alive _x) && (_x distance _building < 30)}count (playableUnits + switchableUnits) == 0)) then 
	{
		_buildings set [count _buildings, _building];
	};
}forEach (nearestObjects [getMarkerPos _mkr,["Building","House"], _size]);

if ((count _buildings) == 0) exitWith
{
	_man
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
				_posarray set [count _posarray, _building buildingPos _test];
			}; 
		};
		_test = _test + 1;
	};
}forEach _buildings;

if (count _posarray < 2) exitWith {_man};

_pos1 = [0,0,0];
_pos1 = (_posarray call BIS_fnc_selectRandom);
_posarray = _posarray - [_pos1];
_type = _array_type call BIS_fnc_selectRandom;
if (typeName _type == "ARRAY") then
{
	_type = _type select 1;
};
_grp = createGroup _side;
waitUntil {!isNull _grp}; 
_unit = _grp createUnit [_type, _pos1, [], 0, "NONE"];
waitUntil {!isNull _unit};
_unit setPos _pos1;
_unit setUnitPos "UP";
_unit call Tour_fnc_garbageEH;
[_unit, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
_unit addWeapon "rhs_weap_akm";
_unit addBackpack "UK3CB_B_INVISIBLE";
for "_i" from 1 to 7 do {_unit addMagazine "rhs_30Rnd_762x39mm_bakelite";};
_unit setVariable ["TOUR_switchableSide", true, true];

[_unit, _posArray, _mkr] execFSM "scripts\ambientLife\soldierControl.fsm";
_man = _unit;

_man
