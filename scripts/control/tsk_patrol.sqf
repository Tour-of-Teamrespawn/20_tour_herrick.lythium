_time = time + 5;
while {true} do 
{
	_distance = 400 + (random 900);
	_dir = random 360;
	_pos = getPos [_distance, _dir];
	if ({(alive _x) && ((vehicle _x) distance _pos < 300)}count playableUnits == 0) exitWith {TOUR_tskAccept = true};
	if (time > _time) exitWith {TOUR_tskAccept = false};
	sleep 0.1;
};

if !(TOUR_tskAccept) exitWith {};

if (str getMarkerPos "TOUR_mkr_tskPatrol" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskPatrol", _pos];
};

["TOUR_objPatrol", {"Patrol"}] call A2S_createSimpleTask;
["TOUR_objPatrol", {"Patrol and scout <marker name=""TOUR_mkr_tskPatrol"">this area</marker>."}, {"Patrol"}, {"Patrol"}] call A2S_setSimpleTaskDescription;
"TOUR_objPatrol" call A2S_taskCommit;

waitUntil 
{
	sleep 5;
	({(alive _x) && ((vehicle _x) distance _pos < 50)}count playableUnits > 0)
};

["TOUR_objPatrol", "SUCCEEDED"] call A2S_setTaskState;
"TOUR_objPatrol" call A2S_taskCommit;
sleep 2;
"TOUR_objPatrol" call A2S_taskHint;

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

//remove task?
