private ["_pos", "_mkr", "_men", "_ieds", "_men2", "_roads", "_road", "_time"];

_ieds = [];
if (!isNil {missionNameSpace getVariable "TOUR_IEDs"}) then 
{
	_ieds = (missionNameSpace getVariable "TOUR_IEDs");
};

_initRoads = (getMarkerPos "TOUR_mkr_AO") nearRoads 1200;
_roads = [];

{
	_road = (getPosATL _x);
	if (!(_road inArea "TOUR_mkr_AO") or ({(_road distance (getPos _x)) < 100}count _ieds > 0)) then 
	{
		_roads pushBack _road;
	};
}forEach _initRoads;

if (count _roads == 0) exitWith {TOUR_tskAccept = false};

{
	_pos = _roads call BIS_fnc_selectRandom;
	_roads = _roads - [_pos];
	if (({_pos distance _x < 200} count TOUR_taskLocations == 0 )  && ({((alive _x) && ((vehicle _x) distance _pos < 300))}count (playableUnits + switchableunits) == 0)) exitWith {TOUR_tskAccept = true};
}forEach _roads;

if (isNil "TOUR_tskAccept") exitWith {};

if (str getMarkerPos "TOUR_mkr_tskIED" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskIED", _pos];
	_mkr setMarkerAlphaLocal 0;
	_mkr setMarkerShape "ELLIPSE";
	_mkr setMarkerSize [50,50];
}else
{
	"TOUR_mkr_tskIED" setMarkerPos _pos;
};

TOUR_taskLocations pushBack _pos;

["ied", 7] call TOUR_fnc_hqOrders;

[WEST, "TOUR_objIED", [format ["Locate and defuse suspected IED in <marker name=""TOUR_mkr_tskIED"">this area</marker>.", "asdf"], "Defuse IED", "TOUR_mkr_tskIED"], getMarkerPos "TOUR_mkr_tskIED", "CREATED", -1, true, "mine"] call BIS_fnc_taskCreate;

[_mkr, 1, 1, WEST] execVM "scripts\TOUR_IED\bombsCreateArea.sqf";

waitUntil {!isNil {missionNameSpace getVariable "TOUR_IEDs"}};
waitUntil {count (missionNamespace getVariable "TOUR_IEDs") > count _ieds};
_ied = (missionNamespace getVariable "TOUR_IEDs") select ((count (missionNamespace getVariable "TOUR_IEDs")) - 1);

_men = [];

if (random 1 > 0.3) then 
{
	_type = TOUR_EnemyInfGrp call BIS_fnc_selectRandom;
	_grp = [getMarkerPos _mkr, EAST, (configFile >> "CfgGroups" >> "EAST" >> "UK3CB_TKM_O" >> _type select 0 >> _type select 1)] call BIS_fnc_spawnGroup;
	[_grp, (getMarkerPos _mkr) getpos [50, random 360], 100] call TOUR_fnc_rndPatrol;
	{
		_x call Tour_fnc_garbageEH;
		[_x, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
		_men pushBack _x;
	}forEach units _grp;
};

_attack = false;
_start = false;
if (random 1 > 0.5) then 
{
	_attack = true;
	_time = 0;
};

_men2 = [];

while {!isNull _ied} do
{
	sleep 5;
	if (_attack) then 
	{
		if !(_start) then
		{
			if ( (_time == 0) && ({(alive _x) && (((vehicle _x) distance (getPos _ied)) < 50)}count (playableUnits + switchableunits) > 0) ) then 
			{
				_time = time + (random 300);
			};

			if (_time > 0) then 
			{
				if (_time > time) then 
				{
					_men = [_pos, 10, EAST, 50, 200, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack; 
					if (count _men == 0) then 
					{
						_men = [_pos, TOUR_EnemyInfGrp, "EAST", TOUR_enemyGrpSpawns, (ceil random 2), 500, 200, "TOUR_mkr_FOB"] call TOUR_fnc_rndGroupAttack;
					};					
				};
			};
		};
	};
};

_men = _men + _men2;

sleep 2;
["TOUR_objIED", "SUCCEEDED", true] call BIS_fnc_taskSetState;

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

"TOUR_objIED" call BIS_fnc_deleteTask;

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
