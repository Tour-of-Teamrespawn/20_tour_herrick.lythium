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

if (str getMarkerPos "TOUR_mkr_tskkill" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskkill", _pos];
}else
{
	"TOUR_mkr_tskkill" setMarkerPos _pos;
};

TOUR_taskLocations pushBack _pos;

["kill", 3] call TOUR_fnc_hqOrders;

_array = [getMarkerPos _mkr, 50, EAST, 5, 15, TOUR_EnemyInfMen, "uk3cb_tkm_o_war"] call TOUR_fnc_enemyHouse;
_warlord = _array select 0;
_men = _array select 1;

["TOUR_objKill", {"Kill Taliban Leader"}] call A2S_createSimpleTask;
call compile format ["[""TOUR_objKill"", {""A local Taliban leader is believed to be <marker name=""""TOUR_mkr_tskKill"""">in the local area</marker>. Take out %1 and confirm the kill by identifying his body.""}, {""Kill Taliban Leader""}, {""Kill Taliban Leader""}] call A2S_setSimpleTaskDescription;", name _warlord];
"TOUR_objKill" call A2S_taskCommit;
sleep 1;
"TOUR_objKill" call A2S_taskHint;

for "_i" from 2 to (2 + (ceil random 2)) do
{
	_type = TOUR_EnemyInfGrp call BIS_fnc_selectRandom;
	_grp = [getMarkerPos _mkr, EAST, (configFile >> "CfgGroups" >> "EAST" >> "UK3CB_TKM_O" >> _type select 0 >> _type select 1)] call BIS_fnc_spawnGroup;
	[_grp, (getMarkerPos _mkr) getpos [30, random 360], 100] call TOUR_fnc_rndPatrol;
	{
		_x call TOUR_fnc_skillAI;
		_men pushBack _x;
	}forEach units _grp;
};

[
	([_warlord] + _men),
	{
		{
			[
				_x,
				"Identify",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
				"!alive _target && (cursorTarget == _target) && (_this distance _target < 2.5) && (isNil {_target getVariable ""TOUR_checked""})",
				"!alive _target && (cursorTarget == _target) && (_this distance _target < 2.5) && (isNil {_target getVariable ""TOUR_checked""})",
				{},
				{},
				{
					_target setVariable ["TOUR_checked", true, true];
					if (typeof _target == "uk3cb_tkm_o_war") then 
					{
						hint (["hint", "Target confirmed"] call TOUR_fnc_hint);
					}else
					{
						hint (["hint", "Target Not Confirmed"] call TOUR_fnc_hint);
					};
				},
				{},
				[],
				3,
				6,
				true,
				false
			] call BIS_fnc_holdActionAdd;
		}forEach _this;
	}
] remoteExecCall
[
	"spawn",
	0,
	true
];


while {isNil {_warLord getVariable "TOUR_checked"}} do 
{
	sleep 2;
};

["TOUR_objKill", "SUCCEEDED"] call A2S_setTaskState;
"TOUR_objKill" call A2S_taskCommit;
sleep 2;
"TOUR_objKill" call A2S_taskHint;

sleep 60;

"TOUR_objKill" call A2S_removeSimpleTask;

sleep 2;

TOUR_taskLocations deleteAt (TOUR_taskLocations find _pos);

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
