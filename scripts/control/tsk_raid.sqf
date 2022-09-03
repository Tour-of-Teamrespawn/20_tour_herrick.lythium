private ["_location", "_mkr", "_item", "_grp", "_rumbled", "_men", "_man", "_time"];

_distance = 400 + (random 900);
_dir = random 360;
_pos = (getMarkerPos "TOUR_mkr_AO") getPos [_distance, _dir];

//ta = []; {ta = ta + [getposATL _x]}forEach allMissionObjects "evmap"; copyToClipboard str ta

_itemLocations = [[8839.93,10869.9,4.35738],[8818.12,10897.6,4.35114],[8824.13,10932.4,0.305328],[8874.13,11156.6,0],[8898.7,10964.5,0.550491],[8883.45,11173.5,0.910614],[8951.74,10915.5,4.57913],[8922.38,10941.7,4.22063],[8963.06,10749.7,5.10092],[8979.93,10736.4,0.094696],[9010.25,10737.8,1.42114],[9060.44,12347.8,2.17285],[9058.55,12347.8,0.990555],[9049.98,12363.9,0],[9197.32,10823.8,1.65891],[9210.58,10855.6,7.02188],[9239.08,11529,0.876312],[9219.96,11619.2,6.71022],[9226.43,11664.6,0.527283],[9248.87,11537.6,0.251831],[9241.83,11556.1,3.26994],[9248.78,11639.2,3.45726],[9311.87,11501.9,3.77798],[9328.83,11507.2,1.42383],[9346.08,11513.5,0.266678],[9382.83,12256,1.7092],[9379.87,12252.4,5.13989],[9367.16,12306.8,0.306091],[9367.17,12325.1,0.716354],[9438.57,11760.7,0.296097],[9450.22,11736.9,0.922897],[9492.46,11732.9,0.885986],[9487.65,11796.3,0.659866],[9506.94,11820.4,0.33255],[9491.46,11827.8,1.31798],[9513.4,12077.3,0.878448],[9539.08,12024.3,0.474075],[9526.68,12052.1,6.12309],[9646.86,10501.6,0.804443],[9654.48,11979.1,3.46849],[9670.44,11993.3,0.558517],[9666.05,12013.7,2.33794],[9680.51,10524.6,7.70319],[9703.49,11791,1.93553],[9698.95,11807.1,0.679184],[9696.63,11810,1.55606],[9758.78,10443.1,0.626053],[9754.15,10799.2,1.3288],[9732.21,10830.4,0.603943],[9762.68,10407.6,1.63486],[9799.23,10434,1.73087],[9799.03,10447.8,2.95783],[9796.55,10748.1,3.34704],[9764.35,10825.2,1.08148],[9829.94,10751.2,0.612663],[9813.73,10771,0.0844345],[9871.95,11469.8,0.501556],[9893.85,10585,0.170372],[9899.41,10582.2,0.256485],[9897.93,11462.7,1.63582],[9944.2,11191.7,2.28198],[9943.98,11178.4,8.62352],[9947.32,11324.6,1.70576],[9951.13,11362.1,1.24669],[9962.04,11194.4,0.450058],[9980.68,11362.9,0.671036],[10035.3,10449.1,0.916237],[10069.1,10507,0.996506],[10065.2,10481.5,0.648193],[10064.9,11106.3,6.99672],[10055.9,11091.7,6.37192],[10041.9,11081.9,11.3188],[10062,11298.9,1.10385],[10081.4,11275,1.30077],[10086.1,11281.8,0.2995],[10172.7,11260.5,3.33368],[10201,11225.6,1.36974],[10206.1,11256.9,3.3266],[10260.9,10667.6,0.967361],[10270.9,10887.7,0.00601196],[10292.1,10625.7,0.6157],[10325.4,10646.3,0.0347137],[10331.7,10785.1,0.601524],[10346,10839,0.140488],[10468.4,10588.6,0.560913],[10458.6,10590.9,1.94239],[10462.3,10586,1.41473],[10462.7,10971.6,0.481415],[10454.4,11152.9,0.39682],[10466.6,11128.5,0.395309],[10506.8,10973.6,0.446548],[10483.2,11144.2,0.397995],[10547.6,10714.2,1.10726],[10550.8,10735.1,1.33079],[10534.8,10984.1,0.420654],[10567.2,10604,1.77644],[10591.8,10620.2,0.810059],[10602.5,10649.3,0.595337],[10630.1,10917.5,0.273346],[10649.2,10896.6,1.60979],[10675.9,10930.2,0.376114],[10696.5,10845.9,3.88821],[10702.4,10847.9,0.231247],[10721.6,10868.9,1.14315]];
_locations = [[9056.71,12344,0],[9376.33,12278.2,0],[9536.76,12067.4,0],[9671.35,11987,0],[9493.79,11814.1,0],[9465.45,11745.9,0],[9234.99,11639.6,0],[9238.1,11544.9,0],[9323.05,11523.5,0],[9702.94,11810.5,0],[9891.22,11468.3,0],[9968.58,11346.7,0],[10071,11288.5,0],[9951.92,11192.1,0],[10057.9,11094.1,0],[10190.5,11248.9,0],[10466,11144.8,0],[10498.3,10981.3,0],[10644.1,10910.4,0],[10705.4,10860.5,0],[10587.9,10626.9,0],[10465.1,10604.6,0],[10293.7,10650.2,0],[10333.1,10852.8,0],[10049.4,10480.5,0],[9895.58,10594.7,0],[9809.37,10752.1,0],[9744.12,10823.7,0],[9776.08,10434.2,0],[9666.22,10507.4,0],[9197.24,10838.1,0],[8985.11,10746.7,0],[8820.06,10904.5,0],[8929.25,10948.5,0],[8878.92,11165.1,0]];
_types = ["evmap", "evphoto", "evmoscow"];
_time = time + 5;

while {true} do 
{
	_location = _locations call BIS_fnc_selectRandom;
	if (!(_location in TOUR_taskLocations) && {((alive _x) && ((vehicle _x) distance _pos < 300))}count (playableUnits + switchableunits) == 0) exitWith {TOUR_tskAccept = true};
	if (time > _time) exitWith {TOUR_tskAccept = false};
	sleep 0.05;
};

if !(TOUR_tskAccept) exitWith {};

if (str getMarkerPos "TOUR_mkr_tskraid" == "[0,0,0]") then 
{
	_mkr = createMarker ["TOUR_mkr_tskraid", _location];
}else
{
	"TOUR_mkr_tskraid" setMarkerPos _location;
};

TOUR_taskLocations pushBack _location;

["raid", 7.5] call TOUR_fnc_hqOrders;

[WEST, "TOUR_objRaid", [format ["Raid <marker name=""TOUR_mkr_tskraid"">these buildings</marker> and search for intel on local Taliban within the area.", "asdf"], "Acquire Intel", "TOUR_mkr_tskraid"], getMarkerPos "TOUR_mkr_tskraid", "CREATED", -1, true, "documents"] call BIS_fnc_taskCreate;

_items = [];
{
	if (_x distance _location < 50) then 
	{
		_item = (_types call BIS_fnc_selectRandom) createVehicle _x;
		_item setPosATL _x;
		_items pushback _item;
	};
}forEach _itemLocations;

TOUR_tskRaidItems = _items;

_evidence = _items call BIS_fnc_selectRandom;
_evidence setVariable ["TOUR_tskRaidIntel", true, true];

{
	[ [_x], 
	{
		if (!isNull (_this select 0)) then 
		{
			_action = 	["Examine Intel","Examine Intel","",
							{
								if (!isNil {_target getVariable "TOUR_tskRaidIntel"}) then 
								{
									
									hint (["hint", "This is good intel"] call TOUR_fnc_hint);
									_type = typeOf _target;
									player addItem _type;
								}else
								{
									hint (["hint", "This is not good intel"] call TOUR_fnc_hint);
								};
								deleteVehicle _target;
							},
							{
								true		
							}
						] call ace_interact_menu_fnc_createAction;
			[(_this select 0), 0, ["ACE_MainActions"], _action ]spawn ace_interact_menu_fnc_addActionToObject;
		};
	}] remoteExecCall
	[
		"spawn",
		0,
		true
	];
}forEach _items;

_side = if (random 1 > 0) then {RESISTANCE} else {EAST};
_men = [getMarkerPos _mkr, 50, _side, 0, 10, TOUR_EnemyInfMen] call TOUR_fnc_enemyHouse;
_rumbled = false;

while {!isNull _evidence} do 
{
	if (_side == RESISTANCE) then 
	{
		if !(_rumbled) then 
		{
			if ({(alive _x) && (_x distance (getMarkerPos _mkr) < 50)} count (playableUnits + switchableUnits) > 0) then 
			{
				if (random 200 > 199) then 
				{
					{
						if ((!isNull _x)&&(alive _x)) then 
						{
							_grp = createGroup EAST;
							_x joinAsSilent [_grp, count units _grp];
						};
					}forEach _men;
					_rumbled = true;
				};
			}
		};
	};
	sleep 1;
};

sleep 2;
["TOUR_objRaid", "SUCCEEDED", true] call BIS_fnc_taskSetState;

TOUR_tskCount = TOUR_tskCount + 1;

sleep 60;

"TOUR_objRaid" call BIS_fnc_deleteTask;

sleep 2;

TOUR_taskLocations deleteAt (TOUR_taskLocations find _location);

waitUntil {sleep 1; (({(alive _x) && (_location distance _x < 200)} count (playableUnits + switchableUnits)) == 0)};

{
	_man = _x;
	if (!isNull _x) then 
	{
		if (({(alive _x) && (_man distance _x < 300)} count (playableUnits + switchableUnits)) == 0) then 
		{
			deleteVehicle _x;
		};
	};
	sleep 0.5;
	if ({!isNull _x}count _men == 0) exitwith {};
}forEach _men;