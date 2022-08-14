/* 
###MISSION_VERSION 0.001
*/

_d = execVM "scripts\general\debugRPT.sqf";
waitUntil {scriptDone _d};

_p = execVM "params.sqf";
waitUntil {scriptDone _p};

_a = TOUR_logic execVM "a2s_multitask.sqf";
waitUntil {scriptDone _a};

enableRadio false;
{
	_x setVariable ["BIS_noCoreConversations",true];
} forEach allUnits;

TOUR_HQ = [WEST, "HQ"];

_f = execVM "scripts\functions\fn_init.sqf";
waitUntil {scriptDone _f};

_siAction = if (true) then
{
	"(alive player) && ([player, ""ACRE_PRC148""] call acre_api_fnc_hasKindOfRadio)"
}else
{
	"(alive player) && (""ItemRadio"" in (assignedItems player))"
};

TOUR_init_complete = true;

// ben is a gey

