_this addEventHandler ["KILLED", {_this spawn TOUR_fnc_garbage;}];
if ((side _this != EAST) && !(_this in TOUR_IED_triggermen)) then
{
	_this addEventHandler ["KILLED", 
	{
		params ["_unit", "_killer", "_instigator", "_useEffects"];
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
	//	if (_unit in TOUR_civCountGlobalTotal) then 
	//	{
	//		TOUR_civCountGlobalTotal = TOUR_civCountGlobalTotal - [_unit];
	//	};
		//null = ["TOUR_mkrAO", 1] execVM "scripts\ambientLife\createPedestrians.sqf";
	}];
};