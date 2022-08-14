_distance = 400 + (random 900);
_dir = random 360;
_pos = getPos [_distance, _dir];

if (str getMarkerPos "TOUR_mkr_tskraid" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskraid", _pos];
};

["TOUR_objRaid", {"Raid"}] call A2S_createSimpleTask;
["TOUR_objRaid", {"Raid <marker name=""TOUR_mkr_tskraid"">these buildings</marker> and search for intel on local Taliban within the area."}, {"Raid"}, {"Raid"}] call A2S_setSimpleTaskDescription;
"TOUR_objRaid" call A2S_taskCommit;

//ta = []; {ta = ta + [getposATL _x]}forEach allMissionObjects "evmap"; copyToClipboard str ta

_pos = [[8839.93,10869.9,4.35738],[8824.13,10932.4,0.305328],[8898.7,10964.5,0.550491],[8883.45,11173.5,0.910614],[8951.74,10915.5,4.57913],[8963.06,10749.7,5.10092],[8967.48,11374.5,0.666443],[9060.44,12347.8,2.17285],[9127.19,10742.4,4.01341],[9210.58,10855.6,7.02188],[9239.08,11529,0.876312],[9219.96,11619.2,6.71022],[9226.43,11664.6,0.527283],[9259.54,10801.5,1.4192],[9311.87,11501.9,3.77798],[9294.31,11744.6,1.88466],[9384.58,11719.3,1.49617],[9382.83,12256,1.7092],[9379.87,12252.4,5.13989],[9438.57,11760.7,0.296097],[9487.65,11796.3,0.659866],[9513.4,12077.3,0.878448],[9539.08,12024.3,0.474075],[9526.68,12052.1,6.12309],[9599.82,10838.4,0.161102],[9646.86,10501.6,0.804443],[9651.55,11650,0.820251],[9649.78,11655.3,4.5686],[9654.48,11979.1,3.46849],[9670.44,11993.3,0.558517],[9703.49,11791,1.93553],[9732.21,10830.4,0.603943],[9762.68,10407.6,1.63486],[9813.73,10771,0.0844345],[9893.85,10585,0.170372],[9905.3,11299,0.490753],[9952.84,11137.1,0.47567],[9944.2,11191.7,2.28198],[9943.98,11178.4,8.62352],[9947.32,11324.6,1.70576],[9951.22,11401,0.925613],[10069.1,10507,0.996506],[10064.9,11106.3,6.99672],[10086.1,11281.8,0.2995],[10172.7,11260.5,3.33368],[10260.9,10667.6,0.967361],[10292.1,10625.7,0.6157],[10346,10839,0.140488],[10401.8,10620,1.0272],[10468.4,10588.6,0.560913],[10506.8,10973.6,0.446548],[10483.2,11144.2,0.397995],[10547.6,10714.2,1.10726],[10550.8,10735.1,1.33079],[10534.8,10984.1,0.420654],[10567.2,10604,1.77644],[10585.8,10761.5,0.36171],[10675.9,10930.2,0.376114],[10696.5,10845.9,3.88821]] call BIS_fnc_selectRandom;

TOUR_objRaid_evidence = "evMap" createVehicle _pos;
TOUR_objRaid_evidence setPosATL _pos;

_time = time + 5;
_evidence = {_x distance _x} [getposATL _x]}forEach allMissionObjects "evmap";
{

}forEach 


while {true} do 
{
	
	if ({(alive _x) && ((vehicle _x) distance _pos < 300)}count playableUnits == 0) exitWith {TOUR_tskAccept = true};
	if (time > _time) exitWith {TOUR_tskAccept = false};
	sleep 0.1;
};

_intel = _evidence call BIS_fnc_selectRandom;
_intel setVariable ["TOUR_tskRaidIntel", true, true];

{
	[
		_this,
		"Check Intel",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
		"cursorTarget == _target && _this distance _target < 2",
		"cursorTarget == _target && _this distance _target < 2",
		{},
		{},
		{
			[
				[_target, _caller],
				{
					if (!isNil {(_this select 0) getVariable "TOUR_tskRaidIntel"}) then 
					{
						deleteVehicle (_this select 0);
					};
				}
			] remoteExecCall
			[
				"BIS_fnc_Spawn",
				0,
				true
			];
		},
		{},
		[],
		3,
		6,
		true,
		false
	] call BIS_fnc_holdActionAdd;
}forEach _evidence;

waitUntil 
{
	sleep 5;
	isNull TOUR_objRaid_evidence
};

["TOUR_objRaid", "SUCCEEDED"] call A2S_setTaskState;
"TOUR_objRaid" call A2S_taskCommit;
sleep 2;
"TOUR_objRaid" call A2S_taskHint;

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

//remove task?
