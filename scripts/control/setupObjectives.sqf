private ["_endHour", "_startHour", "_endMin", "_startMin"];

_startDay = TOUR_StartTime select 2;
_startHour = TOUR_StartTime select 3;
_startMin = TOUR_StartTime select 4;

if ((_startHour + TOUR_playTime) >= 24) then 
{
	_endHour = 24 - (_startHour + TOUR_playTime);
}else 
{
	_endHour = (_startHour + TOUR_playTime);
};

_endMin = _startMin;

["TOUR_objBase", {"Guard Base"}] call A2S_createSimpleTask;
call compile format ["[""TOUR_objBase"", {""Guard <marker name=""""TOUR_mkr_FOB"""">FOB MIKIS</marker> and carry out orders from command for %1 hours, till %2:%3.""}, {""Guard Base""}, {""Guard Base""}] call A2S_setSimpleTaskDescription;", TOUR_playTime, _endHour, _endMin];
"TOUR_objBase" call A2S_taskCommit;

["TOUR_objCiv", {"Protect Civilians"}] call A2S_createSimpleTask;
["TOUR_objCiv", {"Ensure there are no civilian casualties."}, {"Protect Civilians"}, {"Protect Civilians"}] call A2S_setSimpleTaskDescription;
"TOUR_objCiv" call A2S_taskCommit;