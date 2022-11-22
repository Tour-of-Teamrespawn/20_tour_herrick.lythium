waitUntil {!isNil "TOUR_init_complete"};
waitUntil {player == player};

execVM "scripts\general\dust.sqf";

{
	_x execVM "scripts\Virtual_arsenal\init.sqf";
}forEach [TOUR_AmmoBox_1];

#include "hpp\briefing.hpp"

[] execVM "scripts\TOUR_IED\init.sqf";

TOUR_campfire_1 execVM "scripts\general\flicker.sqf";

execVM "scripts\general\playerActions.sqf";

execVM "scripts\general\radioChannelSetup.sqf";

if (TOUR_introEnable) then 
{
	execVM "scripts\general\intro.sqf";
	waitUntil {!isNil "TOUR_introComplete"};
}else 
{
	sleep 1;
};

[player,"QLR"] call BIS_fnc_setUnitInsignia;