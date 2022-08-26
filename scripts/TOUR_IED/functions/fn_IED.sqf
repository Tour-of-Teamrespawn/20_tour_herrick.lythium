_pos = (_this select 0);

_bombSize = "";
_explosiveMass = "";
_activationType = "";

_largeIEDs = ["IEDLandBig_F", "IEDUrbanBig_F"];
_smallIEDs = ["IEDUrbanSmall_F", "IEDLandSmall_F"];

_allIEDs = _largeIEDs + _smallIEDs;

_sequence = "";
for "_i" from 1 to 8 do
{
	if (floor (random 2) == 0) then
	{
		_sequence = _sequence + "l";
	}
	else
	{
		_sequence = _sequence + "r";
	};
};
_bombtype = selectRandom _allIEDs;


_ied = createVehicle [_bombtype, _pos, [], 0, "NONE"];

_ied setPosATL [ _pos select 0, _pos select 1, 0];
_ied setVariable ["TOUR_IED_examined", false, true];

if (_bombType in _allIEDs) then {
	_ied setVariable ["TOUR_IED_bombSequence", [_sequence, (20 + (ceil random 10))], true]; 
	_ied setVariable ["TOUR_IED_bombActive", true, true];
};

if (_ied getVariable "TOUR_IED_bombActive" == true) then {
	if (_bombtype in _largeIEDs) then {
		_ied setVariable ["TOUR_IED_LargeIED", true, true];
		_bombSize = "Large";
		_explosiveMass = "7 kilograms";
	};
	if (_bombtype in _smallIEDs) then {
		_ied setVariable ["TOUR_IED_LargeIED", false, true];
		_bombSize = "Small";
		_explosiveMass = "700 grams";
	};

	if (random 1 >= 0.75) then {
		_activationType = "Remote Phone";
	} else {
		_activationType = "Pressure Plate";
	};
	_ied setVariable ["TOUR_IED_ActivationType", _activationType, true];

	if (_activationType == "Remote Phone") then {
		_grp = createGroup RESISTANCE;
		waitUntil {!isNull _grp};
		_pos = [getPos _ied, 10, 50, 1, 0, 0, 0] call BIS_fnc_findSafePos;

		_unit = _grp createUnit ["UK3CB_TKC_C_CIV", _pos, [], 0, "NONE"];
		waitUntil {!isNull _unit};
		_unit setPos (_pos);

		_unit setUnitPos "UP";
		_unit call Tour_fnc_garbageEH;
		[_unit] call TOUR_fnc_skillAI;
		[group _unit, getPos _ied, 100] spawn TOUR_fnc_rndpatrol;

		TOUR_IED_Triggermen = TOUR_IED_Triggermen + [_unit];
	};
	_ied allowDamage true;

	_ied setVariable ["TOUR_IED_info", [_bombSize, _explosiveMass,_activationType], true];
	if !(isNil "TOUR_InsurgentBoolean") then 
	{
		if (TOUR_InsurgentAIBoolean == true) then {
			_roads = _ied nearRoads 50; 
			_closestRoads = [_roads, [], { _ied distance _x }, "ASCEND"] call BIS_fnc_sortBy;
			_roads = [_closestRoads select 0, _closestRoads select 1];
			_ied setDir (((_roads select 0) getDir (_roads select 1)) + 90);
			_ambush = [_ied] spawn TOUR_fnc_IED_ambush;
		};
	};

};

_ied;