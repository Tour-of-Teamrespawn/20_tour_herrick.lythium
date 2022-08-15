private ["_pos"];

_time = time + 5;
while {true} do 
{
	_distance = 400 + (random 800);
	_dir = random 360;
	_pos = (getMarkerPos "TOUR_mkr_AO") getPos [_distance, _dir];
	if ({((alive _x) && ((vehicle _x) distance _pos < 300)) or (_pos in TOUR_taskLocations)}count (playableUnits + switchableunits) == 0) exitWith {TOUR_tskAccept = true};
	if (time > _time) exitWith {TOUR_tskAccept = false};
	sleep 0.05;
};

if !(TOUR_tskAccept) exitWith {};

if (str getMarkerPos "TOUR_mkr_tskPatrol" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskPatrol", _pos];
}else
{
	"TOUR_mkr_tskPatrol" setMarkerPos _pos;
};

TOUR_taskLocations pushBack _pos;

["TOUR_objPatrol", {"Patrol"}] call A2S_createSimpleTask;
["TOUR_objPatrol", {"Patrol and scout <marker name=""TOUR_mkr_tskPatrol"">this area</marker>."}, {"Patrol"}, {"Patrol"}] call A2S_setSimpleTaskDescription;
"TOUR_objPatrol" call A2S_taskCommit;
sleep 1;
"TOUR_objPatrol" call A2S_taskHint;

waitUntil 
{
	sleep 5;
	({(alive _x) && ((vehicle _x) distance _pos < 50)}count (playableUnits + switchableunits) > 0)
};

["TOUR_objPatrol", "SUCCEEDED"] call A2S_setTaskState;
"TOUR_objPatrol" call A2S_taskCommit;
sleep 2;
"TOUR_objPatrol" call A2S_taskHint;

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

TOUR_taskLocations delteAt (TOUR_taskLocations find _pos);

//remove task?
