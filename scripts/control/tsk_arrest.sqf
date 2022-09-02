private ["_pos", "_mkr", "_men", "_warlord"];

_locations = [[9375.09,12280.4,0],[9529.69,12072.2,0],[9493.41,11812.6,0],[9253.37,11659.9,0],[9237.86,11550.4,0],[9967.43,11347.3,0],[9980.34,11133.3,0],[10188.6,11252.9,0],[10498.9,10982.3,0],[10327.1,10845.1,0],[10290.5,10644.2,0],[10473.1,10604.6,0],[9196.67,10833.6,0],[9105.55,10746.6,0],[8986.36,10748.6,0],[8833.92,10910.2,0],[8928.24,10966.1,0],[9662.67,10508.8,0],[9776.31,10431.2,0],[9739,10829.4,0]];

_time = time + 5;
while {true} do 
{
	_pos = _locations call BIS_fnc_selectRandom;
	if ({((alive _x) && ((vehicle _x) distance _pos < 300)) or (_pos in TOUR_taskLocations)}count (playableUnits + switchableunits) == 0) exitWith {TOUR_tskAccept = true};
	if (time > _time) exitWith {TOUR_tskAccept = false};
	sleep 0.05;
};

if !(TOUR_tskAccept) exitWith {};

if (str getMarkerPos "TOUR_mkr_tskArrest" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskArrest", _pos];
}else
{
	"TOUR_mkr_tskArrest" setMarkerPos _pos;
};

TOUR_taskLocations pushBack _pos;

["arrest", 3] call TOUR_fnc_hqOrders;

_array = [getMarkerPos _mkr, 50, RESISTANCE, 5, 15, ["UK3CB_TKC_C_CIV"], "UK3CB_TKC_C_CIV"] call TOUR_fnc_enemyHouse;
_warlord = _array select 0;
_men = _array select 1;

[WEST, "TOUR_objArrest", [format ["Arrest %1, a local chief suspected of affilations with the Taliban, located somewhere in <marker name=""TOUR_mkr_tskArrest"">these buildings</marker>. Once apprehended, return him to <marker name=""respawn_west"">KalaeNoowi airbase</marker> for processing", name _warlord], "Arrest Suspect", "respawn_west"], getMarkerPos "Arrest Suspect", "CREATED", -1, true, "danger"] call BIS_fnc_taskCreate;

for "_i" from 1 to (ceil random 3) do
{
	_type = TOUR_EnemyInfGrp call BIS_fnc_selectRandom;
	_grp = [getMarkerPos _mkr, EAST, (configFile >> "CfgGroups" >> "RESISTANCE" >> "UK3CB_TKM_O" >> _type select 0 >> _type select 1)] call BIS_fnc_spawnGroup;
	[_grp, (getMarkerPos _mkr) getpos [30, random 360], 100] call TOUR_fnc_rndPatrol;
	{
		_x call Tour_fnc_garbageEH;
		[_x, TOUR_EnemySFs, TOUR_EnemySnipers] call TOUR_fnc_skillAI;
		_men pushBack _x;
	}forEach units _grp;
};

_rumbled = false;
while {(alive _warlord) && ((vehicle _warlord) distance (getMarkerPos "respawn_west") > 1000)} do 
{
	if !(_rumbled) then 
	{
		if ({(alive _x) && (_x distance (getMarkerPos _mkr) < 50)} count (playableUnits + switchableUnits) > 0) then 
		{
			if (random 200 > 199) then 
			{
				{
					if ((!isNull _x)&&(alive _x)) then 
					{
						_grp = createGroup EAST;
						_x joinAsSilent [_grp, count units _grp];
					};
				}forEach _men;
				if (random 1 > 0.5) then 
				{
					_men = [_pos, 10, EAST, 50, 150, TOUR_EnemyInfMen, "TOUR_mkr_FOB"] call TOUR_fnc_rndhouseAttack; 
					if (count _men == 0) then 
					{
						_men = [_pos, TOUR_EnemyInfGrp, "EAST", TOUR_enemyGrpSpawns, (ceil random 2), 500, 200, "TOUR_mkr_FOB"] call TOUR_fnc_rndGroupAttack;
					};
				};
				_rumbled = true;
			};
		}
	};
	sleep 1;
};

sleep 2;
if (alive _warLord) then 
{
	["TOUR_objArrest", "SUCCEEDED", true] call BIS_fnc_taskSetState;
}else 
{
	["TOUR_objArrest", "FAILED", true] call BIS_fnc_taskSetState;
};

sleep 60;

"TOUR_objArrest" call BIS_fnc_deleteTask;

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
	if ({!isNull _x}count (_men + [_warlord]) == 0) exitwith {};
}forEach (_men + [_warlord]);
