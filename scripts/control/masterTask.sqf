while {true} do 
{
	if (count TOUR_tskCount < 3) then 
	{
		while {true} do 
		{
			TOUR_tskAccept = nil;
			execVM format ["scripts\control\tsk_%1", _availableTasks call BIS_fnc_selectRandom];
			waitUntil {!isNil "TOUR_tskAccept"};
			if (TOUR_tskAccept == true) exitWith {};
		};
	};


};