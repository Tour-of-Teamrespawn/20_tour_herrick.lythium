waitUntil {!isNil "TOUR_init_complete"};

createCenter WEST; WEST setFriend [EAST, 0]; WEST setFriend [RESISTANCE, 1]; WEST setFriend [CIVILIAN, 1];
createCenter EAST; EAST setFriend [WEST, 0]; EAST setFriend [RESISTANCE, 1]; EAST setFriend [CIVILIAN, 1];
createCenter RESISTANCE; RESISTANCE setFriend [WEST, 1]; RESISTANCE setFriend [EAST, 1]; RESISTANCE setFriend [CIVILIAN, 1];
createCenter CIVILIAN; CIVILIAN setFriend [WEST, 1]; CIVILIAN setFriend [EAST, 1]; CIVILIAN setFriend [RESISTANCE, 1];
SIDELOGIC setFriend [WEST, 1]; SIDELOGIC setFriend [EAST, 1]; SIDELOGIC setFriend [RESISTANCE, 1];

execVM "scripts\control\setupObjectives.sqf";

tour_garbagearray = [];
tour_mission_units = [];


_cp = ["TOUR_mkr_civArea1", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea2", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea3", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea4", 7, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea5", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea6", 10, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";

[]spawn 
{
	for "_i" from 1 to 6 do 
	{
		_cd = [8, 1] execVM "scripts\ambientLife\createVehicles.sqf";
		_cd = [8, 2] execVM "scripts\ambientLife\createVehicles.sqf";
		sleep 60;
	};
};

execVM "scripts\ambientLife\flybyLoop.sqf";

TOUR_initServer_complete = true;