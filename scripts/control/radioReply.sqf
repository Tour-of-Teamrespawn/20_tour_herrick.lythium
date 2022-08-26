missionNameSpace setVariable ["TOUR_tskRadioState", "replying", true];
if (_this != TOUR_cmdRadio) then 
{
	[[],{TOUR_cmdRadio say3d ["TOUR_snd_line_16", 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
};
/*
if (!isNil "TOUR_player_3") then
{		
	TOUR_player_3 kbAddTopic ["TOUR_radio_Speach", "scripts\texts\radioMan.bikb", "", ""];
};
if (!isNil "TOUR_player_3") then
{
	if (player == TOUR_player_3) then
	{
		TOUR_player_3 kbTell [TOUR_medic, "TOUR_radio_Speach", "TOUR_radioManSpeak", "DIRECT"];
	};
};
*/
[[player],{player say3d ["TOUR_snd_line_17", 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];

sleep 5;
missionNameSpace setVariable ["TOUR_tskRadioState", "accepted", true];