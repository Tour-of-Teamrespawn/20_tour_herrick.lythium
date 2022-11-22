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

	//Play time
	TOUR_playTime = (paramsArray select 3);

	//Start Time
	TOUR_StartTime = switch (paramsArray select 4) do 
	{
		case 1: {[2013,6,7,3,30]};
		case 2: {[2013,6,7,12,00]};
		case 3: {[2013,6,7,17,30]};
		case 4: {[2013,6,7,09,0]};
		default {[2013,6,7,3,30]};
	};

	//Fog
	TOUR_fogSettings = switch (paramsArray select 5) do 
	{
		case 1: {[0,0,0]};
		case 2: {[0.853501,0.0448707,33.3216]};
		case 3: {[0.224897,0.0668833,141.619]};
		case 4: {[0.493459,0.0647013,141.619]};
	};

	//Weather
	TOUR_weatherSettings = (paramsArray select 6);

	//Base Attack
	TOUR_baseAttackProbability = (paramsArray select 7);

	//Random Attack
	TOUR_randomEventProbability = (paramsArray select 8);

}else
{
	//singleplayer
	
	//Respawn time
	TOUR_respawnTime = 30;
	
	//lives
	TOUR_respawnTickets = [1,1,1,1];

	//Enable Intro
	TOUR_introEnable = false;

	//Play time
	TOUR_playTime = 1;

	//Start Time
	TOUR_StartTime = [2013,6,7,12,00];

	//Fog
	TOUR_fogSettings = [0,0,0];

	//Weather
	TOUR_weatherSettings = 0;

	//Base Attack
	TOUR_baseAttackProbability = 0;

	//Random Attack
	TOUR_randomEventProbability = 100;
};

if (isServer) then 
{
	[TOUR_StartTime] remoteExec ["setDate"];
	[0, TOUR_fogSettings] remoteExec ["setFog"];
	[0, TOUR_weatherSettings] remoteExec ["setOvercast"];
	[] remoteExec ["forceWeatherChange"];

	[]spawn 
	{
		sleep 5;
		[((TOUR_playTime * 60) * 60), TOUR_fogSettings] remoteExec ["setFog"];
		[((TOUR_playTime * 60) * 60), TOUR_weatherSettings] remoteExec ["setOvercast"];
	};
};

setViewDistance 5000;

_rc = [TOUR_respawnTickets, TOUR_respawnTime]execVM "scripts\TOUR_RC\init.sqf";
waitUntil {scriptDone _rc};