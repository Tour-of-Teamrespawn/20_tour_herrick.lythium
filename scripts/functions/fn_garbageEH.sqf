_this addEventHandler ["KILLED", {_this spawn TOUR_fnc_garbage;}];

_this addEventHandler ["KILLED", 
{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if ((side _unit != EAST) && !(_unit in TOUR_IED_triggermen)) then
	{	
		if ((("TOUR_objCiv" call BIS_fnc_taskState) != "failed") && (side _instigator == WEST)) then 
		{	
			["TOUR_objCiv", "failed", false] call BIS_fnc_taskSetState;
			[] spawn
			{
				sleep 4;
				["TOUR_objCiv", "failed", true] call BIS_fnc_taskSetState;
			};
		};
	};
}];
