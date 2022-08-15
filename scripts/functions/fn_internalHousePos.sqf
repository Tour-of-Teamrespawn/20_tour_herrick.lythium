/*
	BOSS HOUSE SCRIPT
	by Mr.Ben
	
	params passed to script through an array:
	0 = marker name, string
	1 = side, side

*/

private ["_centrepos", "_marker", "_array_type", "_skill", "_side", "_pos", "_test", "_buildings", "_building", "_grp", "_unit", "_distance", "_type", "_count", "_min", "_max"];

_marker = _this select 0;
_distance = _this select 1;

_pos = [0,0,0];
_test = 0;
_buildingsnew = [];
TOUR_posarray = [];
TOUR_warLordPosArray = [];

_positions = [];
_buildings = [];

_array_type = 
[
	"UK3CB_TKM_O_SL",
	"UK3CB_TKM_O_TL",
	"UK3CB_TKM_O_MD",
	"UK3CB_TKM_O_MG",
	"UK3CB_TKM_O_MG_ASST",
	"UK3CB_TKM_O_AR",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AA",
	"UK3CB_TKM_O_MK",
	"UK3CB_TKM_O_SNI",
	"UK3CB_TKM_O_SPOT",
	"UK3CB_TKM_O_ENG",
	"UK3CB_TKM_O_DEM",
	"UK3CB_TKM_O_IED",
	"UK3CB_TKM_O_RIF_1",
	"UK3CB_TKM_O_RIF_2",
	"UK3CB_TKM_O_GL"
];

_buildings = (nearestObjects [getMarkerPos _marker,["Building","House"], _distance]);

if ((count _buildings) == 0) exitWith
{
	_pos
};

if (count _buildings == 0) exitWith
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
			if (({_x isKindOf "House"}count (lineIntersectsObjs [[(AGLtoASL (_building buildingPos _test)) select 0, (AGLtoASL (_building buildingPos _test)) select 1, ((AGLtoASL (_building buildingPos _test)) select 2) + 0.5], [(AGLtoASL (_building buildingPos _test)) select 0, (AGLtoASL (_building buildingPos _test)) select 1, (AGLtoASL (_building buildingPos _test) select 2) + 10], objnull, objnull, true, 32])) > 0) then 
			{
				TOUR_warLordPosArray set [count TOUR_warLordPosArray, [_building, _building buildingPos _test]];
			}; 
			TOUR_posarray set [count TOUR_posarray, [_building, _building buildingPos _test]];
		};_test = _test + 1
	};
	
}forEach _buildings;

if (count TOUR_posarray == 0) exitWith {};

//waitUntil {!isNil "TOUR_introDone"};

TOUR_wlPosArray = (TOUR_warLordPosArray call BIS_fnc_selectRandom);

TOUR_warLord setPos (TOUR_wlPosArray select 1);

"TOUR_mkrWarlord" setMarkerPos getMarkerPos TOUR_warLordCentre;

TOUR_posarray = TOUR_posarray - [TOUR_wlPosArray];

for "_i" from 1 to (15 + (ceil (random (5)))) do
{
	_pos = [objnull, [0,0,0]];
	_pos = (TOUR_posarray call BIS_fnc_selectRandom);
	TOUR_posarray = TOUR_posarray - [_pos];
	_type = _array_type call BIS_fnc_selectRandom;
	if (typeName _type == "ARRAY") then
	{
		_type = _type select 1;
	};
	_grp = createGroup EAST;
	waitUntil {!isNull _grp};
	_dir = ((getPosATL (_pos select 0)) getDir (_pos select 1));
	_unit = _grp createUnit [_type, _pos select 1, [], _dir, "NONE"];
	waitUntil {!isNull _unit};
	_unit setPos (_pos select 1);
	_unit setDir _dir;
	_grp setFormDir _dir;
	_unit setUnitPos "UP";
	_unit setVariable ["lambs_danger_disableAI", true];
	_unit call Tour_fnc_garbageEH;
	_unit call TOUR_fnc_loadouts;
};

