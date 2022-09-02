private ["_location", "_mkr", "_item", "_grp", "_rumbled", "_men", "_unit1", "_unit2", "_unit3", "_time", "_well"];

_distance = 400 + (random 900);
_dir = random 360;
_pos = (getMarkerPos "TOUR_mkr_AO") getPos [_distance, _dir];
_locations = [[9272.2,11532,0],[9317.91,11712.5,0],[9596.52,12013.6,0],[9362.77,12158.1,0],[9466.69,11474.3,0],[9682.75,11778.8,0],[9818.05,11499,0],[9870.95,11441.9,0],[10174.1,11230.1,0],[9938.32,11141.7,0],[10489.9,10925.6,0],[10603.4,10875.7,0],[10513,10759.8,0],[10343.3,10453.2,0],[10039.8,10490.8,0],[9767.53,10432.2,0],[9720.36,10837.1,0],[9253.79,10753.8,0],[8949.28,10806,0],[8860.34,10883.7,0],[8867.91,10964.9,0],[8949.53,11371.4,0]];
_time = time + 5;
_men = [];

while {true} do 
{
	_location = selectRandom _locations;
	if (!(_location in TOUR_taskLocations) && ({((alive _x) && ((vehicle _x) distance _pos < 300))}count (playableUnits + switchableunits) == 0) && ({((side _x == EAST) && (alive _x) && ((vehicle _x) distance _pos < 300))}count (allUnits) == 0)) exitWith {TOUR_tskAccept = true};
	if (time > _time) exitWith {TOUR_tskAccept = false};
	sleep 0.05;
};

if !(TOUR_tskAccept) exitWith {};

if (str getMarkerPos "TOUR_mkr_tskProtect" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskProtect", _location];
}else
{
	"TOUR_mkr_tskProtect" setMarkerPos _location;
};

TOUR_taskLocations pushBack _location;

["protect", 9.5] call TOUR_fnc_hqOrders;

[WEST, "TOUR_objProtect", [format ["Protect the civilian workers building <marker name=""TOUR_mkr_tskProtect"">improved water services</marker> as part of the western alliance initiative of improving infastructure. Hold the position for around 15 minutes.", "asdf"], "Protect Workers", "TOUR_mkr_tskProtect"], getMarkerPos "TOUR_mkr_tskProtect", "CREATED", -1, true, "defend"] call BIS_fnc_taskCreate;

_well = "jbad_misc_well_c" createVehicle _location;

_grp = createGroup WEST;
_unit1 = _grp createUnit ["UK3CB_TKC_C_WORKER", _location, [], 0, "NONE"];
[_unit1, "InBaseMoves_assemblingVehicleErc", [1.15,1.15,-0.85], _well]spawn 
{
	_unit = _this select 0;
	_anim = _this select 1;
	_pos = _this select 2;
	_well = _this select 3;
	_unit disableAI "move";
	_unit disableAI "anim"; 
	while {!(toLower ("TOUR_objProtect" call BIS_fnc_taskState) in ["succeeded", "failed"])} do 
	{
		if (animationState _unit != _anim) then 
		{
			_unit setPos (_well modelToWorld _pos);
			_unit setDir (_unit getDir _well);
			[_unit, _anim]remoteExecCall["switchMove", 0];
		};
		sleep 5;
	};
	_unit enableAI "move";
	_unit enableAI "anim"; 
};

_grp = createGroup WEST;
_unit2 = _grp createUnit ["UK3CB_TKC_C_WORKER", _location, [], 0, "NONE"];
[_unit2, "Acts_carFixingWheel", [-0.75,1.65,-0.85], _well]spawn 
{
	_unit = _this select 0;
	_anim = _this select 1;
	_pos = _this select 2;
	_well = _this select 3;
	_unit disableAI "move";
	_unit disableAI "anim"; 
	while {!(toLower ("TOUR_objProtect" call BIS_fnc_taskState) in ["succeeded", "failed"])} do 
	{
		if (animationState _unit != _anim) then 
		{
			_unit setPos (_well modelToWorld _pos);
			_unit setDir (_unit getDir _well);
			[_unit, _anim]remoteExecCall["switchMove", 0];
		};
		sleep 5;
	};
	_unit enableAI "move";
	_unit enableAI "anim"; 
};

waitUntil {sleep 1; ({(alive _x) && (_x distance (getMarkerPos _mkr) < 50)} count (playableUnits + switchableUnits) > 0)};

_time = time + 900;
_rumbled = false;

while {true} do 
{
	if (time > _time) exitWith {};
	if ({(alive _x)}count [_unit1, _unit2] < 2) exitWith {};
	if !(_rumbled) then 
	{
		if (random 900 > 899) then 
		{
			_men = [_location, 20, EAST, 50, 150, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack; 
			if (count _men == 0) then 
			{
				_men = [_location, TOUR_EnemyInfGrp, "EAST", TOUR_enemyGrpSpawns, (ceil random 2), 500, 200, "TOUR_mkr_FOB"] call TOUR_fnc_rndGroupAttack;
			};
			_rumbled = true;
		};
	};
	sleep 1;
};

sleep 2;
if ({(alive _x)}count [_unit1, _unit2] < 2) then 
{
	["TOUR_objProtect", "FAILED", true] call BIS_fnc_taskSetState;
}else 
{
	["TOUR_objProtect", "SUCCEEDED", true] call BIS_fnc_taskSetState;
};

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

"TOUR_objProtect" call BIS_fnc_deleteTask;

sleep 2;

TOUR_taskLocations deleteAt (TOUR_taskLocations find _location);

waitUntil {sleep 1; (({(alive _x) && (_location distance _x < 200)} count (playableUnits + switchableUnits)) == 0)};

deleteVehicle _unit1;
deleteVehicle _unit2;
deleteVehicle _well;

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
