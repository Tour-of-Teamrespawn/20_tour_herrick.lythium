_this addEventHandler ["KILLED", {_this spawn TOUR_fnc_garbage;}];

_this addEventHandler ["KILLED", 
{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if ((isNil{_unit getVariable "TOUR_enemySide"}) && !(_unit in TOUR_IED_triggermen)) then
	{	
		if ((isNil "TOUR_civKilled") && (side _instigator == WEST)) then 
		{	
			TOUR_civKilled = true;
			[] spawn
			{
				sleep 4;
				["TOUR_objCiv", "failed", true] call BIS_fnc_taskSetState;
			};
		};
	};
}];
