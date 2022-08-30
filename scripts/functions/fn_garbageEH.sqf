_this addEventHandler ["KILLED", {_this spawn TOUR_fnc_garbage;}];

_this addEventHandler ["KILLED", 
{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if ((side _unit != EAST) && !(_unit in TOUR_IED_triggermen)) then
	{	
		if ((("TOUR_objCiv" call A2S_getTaskState) != "failed") && (side _instigator == WEST)) then 
		{	
			["TOUR_objCiv", "failed"] call A2S_setTaskState;
			"TOUR_objCiv" call A2S_taskCommit;
			[] spawn
			{
				sleep 4;
				"TOUR_objCiv" call A2S_taskHint;
			};
		};
	};
}];
