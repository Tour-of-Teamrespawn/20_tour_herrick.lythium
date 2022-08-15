waitUntil {!isNil "TOUR_init_complete"};
waitUntil {player == player};

execVM "scripts\general\dust.sqf";

{
	_x execVM "scripts\Virtual_arsenal\init.sqf";
}forEach [TOUR_AmmoBox_1];

[] call A2S_tasksSync;