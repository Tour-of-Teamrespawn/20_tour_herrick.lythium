private ["_array", "_groupInfo", "_grp", "_wps", "_type", "_newGrp"];

_array = (missionNameSpace getVariable "TOUR_switchSideGroups");
_groupInfo = (missionNameSpace getVariable "TOUR_switchSideGroups") call BIS_fnc_selectRandom;
_array = _array - [_groupInfo];

_grp = _groupInfo select 0;
_wps = _groupInfo select 1;
_type = _groupInfo select 2;
_time = _groupInfo select 3;
_newGrp = createGroup EAST;

{
	if !(isNull _x) then
	{
		_x joinAsSilent [_newGrp, (count units _newGrp)];
	};
}forEach units _grp;

// ADD BACK IN WAYPOINTS
{
	if (_forEachIndex > 0) then 
	{
		_wp = _newGrp addWaypoint [_x, 0];
		_wp setWaypointType "MOVE";
	};
}forEach _wps;

_newGrp setCombatBehaviour "SAFE";
_newGrp setCombatMode "YELLOW";
_grp setSpeedMode "LIMITED";

_newArray = [_newGrp, _wps, _type, _time];
_array pushBack _newArray;
missionNameSpace setVariable ["TOUR_switchSideGroups", _array, true];

_newArray