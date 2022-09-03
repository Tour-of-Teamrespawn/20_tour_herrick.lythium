private ["_men", "_grp", "_newGrp", "_man", "_array", "_unit"];

_men = [];

{
	if (side _x != EAST) then 
	{
		if ((alive _x)&&(!isNil {_x getVariable "TOUR_switchableSide"})) then 
		{
			_man = _x;
			{
				if ((_man distance _x < 50)&&(alive _x)) then 
				{
					_men pushBack [_x, _man];
				};
			}forEach playableUnits + switchableUnits;
		};
	};
}forEach allUnits;

if ((count _men > 0)&&(random 300 > 299)) then 
{
	_array = selectRandom _men;
	_unit = _array select 0;
	_man = _array select 1;
	_newGrp = createGroup EAST;
	_man joinAsSilent [_newGrp, (count units _newGrp)];
	_newGrp setCombatBehaviour "SAFE";
	_newGrp setCombatMode "YELLOW";
	_newGrp setSpeedMode "LIMITED";
	_man doMove getpos _unit;
};