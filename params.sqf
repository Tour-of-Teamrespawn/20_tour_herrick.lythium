if (isMultiplayer) then 
{
	//mulitplayer

	//Respawn time
	TOUR_respawnTime = (paramsArray select 0);
	
	//Lives
	TOUR_respawnTickets = [(paramsArray select 1),(paramsArray select 1),(paramsArray select 1),(paramsArray select 1)];

	//Enable Intro
	TOUR_introEnable = switch (paramsArray select 2) do
	{
		case 0: {false};
		case 1: {true};
		default {true};
	};

	//Automatic Parachute Opening At 150m
	TOUR_autochute = switch (paramsArray select 3) do
	{
		case 0: {false};
		case 1: {true};
		default {false};
	};
}else
{
	//singleplayer
	
	//Respawn time
	TOUR_respawnTime = 30;
	
	//lives
	TOUR_respawnTickets = [1,1,1,1];

	//Enable Intro
	TOUR_introEnable = false;

	//Automatic Parachute Opening At 150m
	TOUR_autochute = false;
};

_rc = [TOUR_respawnTickets, TOUR_respawnTime]execVM "scripts\TOUR_RC\init.sqf";
waitUntil {scriptDone _rc};