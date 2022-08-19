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

["TOUR_objBase", {"Guard Base"}] call A2S_createSimpleTask;
call compile format ["[""TOUR_objBase"", {""Guard <marker name=""""TOUR_mkr_FOB"""">FOB MIKIS</marker> and carry out orders from command for %1 %4, till %2:%3.""}, {""Guard Base""}, {""Guard Base""}] call A2S_setSimpleTaskDescription;", TOUR_playTime, _endHour, "00" , if (TOUR_playTime > 1) then {"hours"}else{"hours"}];
"TOUR_objBase" call A2S_taskCommit;

["TOUR_objCiv", {"Protect Civilians"}] call A2S_createSimpleTask;
["TOUR_objCiv", {"Ensure there are no civilian casualties."}, {"Protect Civilians"}, {"Protect Civilians"}] call A2S_setSimpleTaskDescription;
"TOUR_objCiv" call A2S_taskCommit;

waitUntil 
{
	sleep 2;
	TOUR_RC_WEST_DEAD
	or
	({(side _x == EAST) && (alive _x) && (_x distance (getMarkerPos "TOUR_mkr_FOB") <20)} count allUnits > 0)
	or
	(
		(date select 2 >= _endHour)
		&&
		(date select 3 >= _endHour)
		&&
		(date select 4 >= _endMin)
	)	
};

if ("TOUR_objCiv" call A2S_getTaskState != "FAILED") then
{
	["TOUR_objCiv", "SUCCEEDED"] call A2S_setTaskState;
	"TOUR_objCiv" call A2S_taskCommit;
};

if 	(
		(date select 2 >= _endHour)
		&&
		(date select 3 >= _endHour)
		&&
		(date select 4 >= _endMin)
	)then 
{
	["TOUR_objBase", "SUCCEEDED"] call A2S_setTaskState;
	"TOUR_objBase" call A2S_taskCommit;
}else 
{
	["TOUR_objBase", "FAILED"] call A2S_setTaskState;
	"TOUR_objBase" call A2S_taskCommit;
};