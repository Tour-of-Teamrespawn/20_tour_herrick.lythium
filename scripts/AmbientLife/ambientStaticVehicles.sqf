private ["_vehicles", "_array", "_car", "_info"];
_vehicles = _this;
_array = [];

for "_i" from 1 to 120 do 
{
	if (!isNil format ["TOUR_Ambient_Car_%1", _i]) then 
	{
		_car = call compile format ["TOUR_Ambient_Car_%1", _i];
		_array pushBack [getPos _car, getDir _car];
		deleteVehicle _car;
	};
}; 
sleep 1;

for "_i" from 1 to ceil ((count _array) / 1.4) do 
{
	_info =  selectRandom _array;
	_array = _array - [_info];
	_car = createVehicle [selectRandom _vehicles, _info select 0, [], 0, "NONE"];
	_car setDir (_info select 1);
	_car lock true;
};