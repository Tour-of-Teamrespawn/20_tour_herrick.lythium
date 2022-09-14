private ["_endHour", "_startHour", "_endMin", "_startMin", "_endDay"];

_startDay = TOUR_StartTime select 2;
_startHour = TOUR_StartTime select 3;
_startMin = TOUR_StartTime select 4;

if ((_startHour + TOUR_playTime) >= 24) then 
{
	_endHour = 24 - (_startHour + TOUR_playTime);
	_endDay = _endDay + 1;
}else 
{
	_endHour = (_startHour + TOUR_playTime);
	_endDay = _startDay;
};

_endMin = _startMin;

[WEST, "TOUR_objBase", [format ["Guard <marker name=""TOUR_mkr_FOB"">FOB MIKIS</marker> and carry out orders from command for %1 %4, till %2:%3.", TOUR_playTime, _endHour, "00" , if (TOUR_playTime > 1) then {"hours"}else{"hours"}], "Guard FOB", "TOUR_mkr_FOB"],  objNull, "ASSIGNED", -1, true, "defend"] call BIS_fnc_taskCreate;

[WEST, "TOUR_objCiv", [format ["Ensure there are no civilian casualties.", "asdf"], "Protect Civilians", "TOUR_mkr_FOB"],  objNull, "ASSIGNED", -1, true, ""] call BIS_fnc_taskCreate;

"TOUR_objBase" call BIS_fnc_taskSetCurrent;

waitUntil 
{
	if 
	(
		(date select 2 >= _endDay)
		&&
		(date select 3 >= _endHour)
		&&
		(date select 4 >= _endMin)
		&& 
		(isNil {missionNamespace getVariable "TOUR_tourComplete"})
	) then 
	{
		missionNameSpace setVariable ["TOUR_tourComplete", true, true];
	};
	sleep 2;
	TOUR_RC_WEST_DEAD
	or
	({(side _x == EAST) && (alive _x) && (_x distance (getMarkerPos "TOUR_mkr_FOB") <20)} count allUnits > 0)
	or 
	!(isNil {missionNamespace getVariable "TOUR_tourCompleteAnswered"})
};

if ("TOUR_objCiv" call BIS_fnc_taskState != "FAILED") then
{
	["TOUR_objCiv", "SUCCEEDED", false] call BIS_fnc_TaskSetState;
};

if (TOUR_RC_WEST_DEAD) then 
{
	["TOUR_objBase", "FAILED", false] call BIS_fnc_TaskSetState;
	sleep 7;
	["kia", false, true, false] remoteExecCall ["BIS_fnc_endMission"];
}else 
{
	if 	(
			!(isNil {missionNamespace getVariable "TOUR_tourCompleteAnswered"})
		)then 
	{
		["TOUR_objBase", "SUCCEEDED", true] call BIS_fnc_TaskSetState;
		sleep 7;
		["complete", true, true, false] remoteExecCall ["BIS_fnc_endMission"];
	}else 
	{
		["TOUR_objBase", "FAILED", false] call BIS_fnc_TaskSetState;
		sleep 7;
		["failed", false, true, false] remoteExecCall ["BIS_fnc_endMission"];
	};
};