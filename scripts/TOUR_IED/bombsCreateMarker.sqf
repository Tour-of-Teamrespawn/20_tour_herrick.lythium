/*
PARAMS:
	0: Number of possible bomb positions <INTEGER>
	1: Minimal guaranteed bomb count <INTEGER>
	2: Maximal bomb count <INTEGER>	
	3: Side that the bomb will activate for <SIDE>
	4: Variable name of the functions module <VARIABLE>
*/

TOUR_IED_failhint = {hint "There are too many possible IED's, for possible postions"};

waituntil {!isnil "BIS_fnc_init"};
if (!isDedicated) then
{
	if (isNil "TOUR_IED_scriptran") then
	{
		execFSM "scripts\TOUR_IED\TOUR_IED_MAIN.fsm";
		TOUR_IED_scriptran = true;
	};
};

if (!isServer) exitwith {};

if (isNil "TOUR_IED_Triggermen") then
{
	TOUR_IED_Triggermen = [];
};

_bombPosCount = _this select 0;//10;
_bombCountMin = _this select 1;//6;
_bombCountMax = _this select 2;//10;
_fmodule = _this select 3;
_side = _this select 4;
if (count _this > 6) then
{
	TOUR_IEDtest = true;
}else
{
	TOUR_IEDtest = nil;

};

publicVariable "TOUR_IEDtest";

if (_bombCountMax > _bombPosCount) exitwith {[[],"TOUR_IED_failhint"]call BIS_fnc_MP;};

_iedPoints = [];
for "_p" from 1 to 129 do
{
	_iedPoints set [count _iedPoints, getMarkerPos format ["TOUR_IED_%1", _p]];
};


_used = [];
_ieds = [];

//_maxBombCount = (_bombCountMin + floor (random (_bombCountMax - _bombCountMin + 1)));
_maxBombCount = [_bombCountMin, _bombCountMax] call BIS_fnc_randomInt;
for "_i" from 1 to _maxBombCount do
{
	_rnd = selectRandom _iedPoints;
	while {_rnd in _used} do
	{
		_rnd = selectRandom _iedPoints;
	};
	_used set [count _used, _rnd];

	_ied = [_rnd] call TOUR_fnc_ied;
	
	[_ied, _side] execvm "scripts\TOUR_ied\bombProximityCheck.sqf";
	_ieds set [count _ieds, _ied];
};

missionNamespace setVariable ["TOUR_IEDs", _ieds, true];

