private ["_unit","_grp", "_time"];

_unit = (_this select 0);
_time = time;

if (_unit isKindOf "MAN") then
{
	_grp = group _unit;	
	TOUR_garbagearray set [count TOUR_garbagearray, [_unit, _time, _grp]];
}else
{
	TOUR_garbagearray set [count TOUR_garbagearray, [_unit, _time]];
};

