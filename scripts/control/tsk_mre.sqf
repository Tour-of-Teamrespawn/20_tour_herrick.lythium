private ["_location", "_mkr", "_item", "_grp", "_rumbled", "_men", "_unit1", "_unit2", "_unit3", "_time", "_well"];

_distance = 400 + (random 900);
_dir = random 360;
_pos = (getMarkerPos "TOUR_mkr_AO") getPos [_distance, _dir];
_locations = [[9270.29,11537.4,0],[9402.53,11747.3,0],[9885.39,11266.8,0],[10552.7,10836.1,0],[8886.47,10913.9,0]];
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

if (str getMarkerPos "TOUR_mkr_tskMRE" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskMRE", _location];
}else
{
	"TOUR_mkr_tskMRE" setMarkerPos _location;
};

TOUR_taskLocations pushBack _location;

["mre", 9.5] call TOUR_fnc_hqOrders;

["TOUR_objMRE", {"Talk To Locals"}] call A2S_createSimpleTask;
["TOUR_objMRE", {"Talk to the local population and hand out food rations to the around <marker name=""TOUR_mkr_tskMRE"">this area</marker>. Try to get at least 5 civilians in order to win over hearts and minds byt kind gestures."}, {"Talk To Locals"}, {"Talk To Locals"}] call A2S_setSimpleTaskDescription;
"TOUR_objMRE" call A2S_taskCommit;
sleep 1;
"TOUR_objMRE" call A2S_taskHint;
missionNameSpace setVariable ["TOUR_mreCount", 0, true];
_rumbled = false;

while {true} do 
{
	if (missionNameSpace getVariable "TOUR_mreCount" >= 5) exitWith {};
	if !(_rumbled) then 
	{
		if (random 900 > 899) then 
		{
			_men = [_location, 20, EAST, 1, 300, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack; 
			if (count _men == 0) then 
			{
				_men = [_location, TOUR_EnemyInfGrp, "EAST", TOUR_enemyGrpSpawns, (ceil random 2), 500, 200, "TOUR_mkr_FOB"] call TOUR_fnc_rndGroupAttack;
			};
			_rumbled = true;
		};
	};
	sleep 1;
};


["TOUR_objMRE", "SUCCEEDED"] call A2S_setTaskState;
"TOUR_objMRE" call A2S_taskCommit;
sleep 2;
"TOUR_objMRE" call A2S_taskHint;

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

"TOUR_objMRE" call A2S_removeSimpleTask;

sleep 2;

TOUR_taskLocations deleteAt (TOUR_taskLocations find _location);

waitUntil {sleep 1; (({(alive _x) && (_location distance _x < 200)} count (playableUnits + switchableUnits)) == 0)};

if (count _men > 0) then 
{

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

};
missionNameSpace setVariable ["TOUR_mreCount", nil, true];

{
	if (side _x == CIVILIAN) then 
	{
		_civ = _x;
		{
			_civ removeItem _x;
		}forEach 	[	
						"ACE_MRE_BeefStew",
						"ACE_MRE_ChickenTikkaMasala",
						"ACE_MRE_ChickenHerbDumplings",
						"ACE_MRE_CreamChickenSoup",
						"ACE_MRE_CreamTomatoSoup",
						"ACE_MRE_LambCurry",
						"ACE_MRE_MeatballsPasta",
						"ACE_MRE_SteakVegetables"
					];
	};
}forEach allUnits;