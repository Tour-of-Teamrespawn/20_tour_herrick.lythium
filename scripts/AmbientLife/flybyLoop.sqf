

while {true} do
{
	_time = time + 5;
	waitUntil {time > _time};
	_dir = (ceil random 360);
	_pos = (getMarkerPos "TOUR_mkr_AO") getPos [5000, _dir]; 
	_pos = [_pos select 0, _pos select 1, 400];
	_type = ["RHS_A10","UK3CB_baf_hercules_c4_mtp","UK3CB_BAF_apache_ah1_mtp","UK3CB_BAF_chinook_c2_mtp","UK3CB_BAF_chinook_c2_mtp"]call BIS_fnc_selectRandom;
	_info = [_pos,  _dir + 180, _type, CIVILIAN] call BIS_fnc_spawnVehicle;
	_grp = _info select 2;
	sleep 1;
	if !((_info select 0) isKindOf "plane") then 
	{
		(_info select 0) setposATL [(getPosATL (_info select 0)) select 0, (getPosATL (_info select 0)) select 1, 150];
		(_info select 0) flyinHeight 150;
	};
	_grp setbehaviour "CARELESS";
	_grp setCombatMode "BLUE";
	{
		_x disableAI "target";
		_x disableAI "autotarget";
		_x disableAI "fsm";
	}forEach units _grp;
	_pos2 = (getMarkerPos "TOUR_mkr_AO") getPos [5000, (_dir + 180)]; 
	_wp = _grp addWaypoint [_pos2, 1000];
	_time = time + 300;

	waitUntil {(time > _time) or ((_pos2 distance (vehicle (leader _grp))) < 500) or !(canMove (_info select 0))};
	if !(canMove (_info select 0)) then
	{
		sleep 300;
	};
	if (!isNull (_info select 0)) then
	{
		deleteVehicle (_info select 0);
	};
	{
		if (!isNull _x) then
		{
			deleteVehicle _x;
		};
	}forEach (_info select 1);		
	if (!isNull (_info select 2)) then
	{
		deleteGroup (_info select 2);
	};
};