private ["_array", "_grp", "_newGrp"];

{
	if (side _x == RESISTANCE) then 
	{
		_grp = _x;
		if (count units _grp > 0) then 
		{
			{
				if (!isNil {_x getVariable "TOUR_switchableSide"}) exitWith
				{
					_newGrp = createGroup EAST;

					{
						if !(isNull _x) then
						{
							_x joinAsSilent [_newGrp, (count units _newGrp)];
						};
					}forEach units _x;

					_newGrp setCombatBehaviour "SAFE";
					_newGrp setCombatMode "YELLOW";
					_newGrp setSpeedMode "LIMITED";
				};
			}forEach units _x;
		};
	};
}forEach allGroups;