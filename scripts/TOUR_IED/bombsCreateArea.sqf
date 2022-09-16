/*
PARAMS:
	0: Centre position of IED area <ARRAY>
	1: Area Size <INTEGER>
	2: Minimal guaranteed bomb count <INTEGER>
	3: Maximal bomb count <INTEGER>	
	4: Side that the bomb will activate for <SIDE>
	5: Variable name of the functions module <VARIABLE>
*/

private ["_ied", "_ieds", "_iedsNew", "_size", "_marker", "_bombCountMin", "_bombCountMax", "_fmodule", "_side", "_bombPosCount", "_bombtype", "_road"];

if (!isServer) exitwith {};

waituntil {!isnil "BIS_fnc_init"};
if (isNil "TOUR_IED_scriptran") then
{
	//execFSM "scripts\TOUR_IED\TOUR_IED_MAIN.fsm";
	TOUR_IED_scriptran = true;
	_fn_ied = execVM "scripts\TOUR_IED\functions\functions_init.sqf";
	waitUntil {scriptDone _fn_ied};
};

if (isNil "TOUR_IED_Triggermen") then
{
	TOUR_IED_Triggermen = [];
};
_size = 10;
_marker = (_this select 0);
_bombCountMin = _this select 1;//6;
_bombCountMax = _this select 2;//10;
_side = _this select 3;
if (count _this > 4) then
{
	TOUR_IEDtest = true;
}else
{
	TOUR_IEDtest = nil;
};

_bombPosCount = [];

if (((getmarkersize _marker) select 0)>((getmarkersize _marker) select 1)) then
{
	_size = ((getmarkersize _marker) select 0);
}else
{	
	_size = ((getmarkersize _marker) select 1);
};
_roads = ((getMarkerPos _marker) nearRoads _size);

_ieds = [];
if (!isNil {missionNameSpace getVariable "TOUR_IEDs"}) then 
{
	_ieds = (missionNameSpace getVariable "TOUR_IEDs");
};

{
	_road = (getPosATL _x);
	if (!(_road inArea _marker) or ({(_road distance _x) < 25}count _ieds > 0)) then 
	{
		_roads = _roads - [_x];
	};
}forEach _roads;

if (_bombCountMax > count _roads) exitwith {"There are too many possible IED's, for possible postions" remoteExec ["hint"]; };

{
	if (_x inarea _marker) then
	{
		_pos =_x getPos [ (1 + (random 2)), random 360];
		_bombPosCount set [(count _bombPosCount), _pos];
	};
}forEach _roads;

_used = [];
_iedsNew = [];

if (_bombCountMax > count _bombPosCount) exitwith {"There are too many possible IED's, for possible postions" remoteExec ["hint"]; };

for "_i" from 1 to (_bombCountMin + floor (random (_bombCountMax - _bombCountMin + 1))) do
{

	_rnd = _bombPosCount call BIS_fnc_selectRandom;
	_bombPosCount = _bombPosCount - [_rnd];

	_ied = [_rnd] call TOUR_IED_fnc_createIED;

	[_ied, _side] execvm "scripts\TOUR_ied\bombProximityCheck.sqf";
	_iedsNew set [count _iedsNew, _ied];
};

_ieds = _ieds + _iedsNew;
missionNamespace setVariable ["TOUR_IEDs", _ieds, true];

if (!isNil "TOUR_IEDtest") then 
{
	_num = 0;
	while {(str (getMarkerPos (format ["TOUR_IED_mkr_loc_%1", _num]))) != "[0,0,0]"} do 
	{
		_num = _num + 1;
	};

	{
		_mkr = createMarker [format ["TOUR_IED_mkr_loc_%1", _num], getPos _x];
		_mkr setMarkerType "hd_dot_noShadow";
		_mkr setMarkerColor "colorRed";
		_num = _num + 1;
	}forEach _iedsNew;

	_iedsNew
};