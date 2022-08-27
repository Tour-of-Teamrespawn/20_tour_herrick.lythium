missionNameSpace setVariable ["TOUR_tskRadioState", "replying", true];
if (_this != TOUR_cmdRadio) then 
{
	[[],{TOUR_cmdRadio say3d ["TOUR_snd_line_16", 50];}] remoteExecCall ["spawn", 0, false];
};

[[player],{(_this select 0) say3d ["TOUR_snd_line_17", 50]; (_this select 0) setRandomLip true; sleep 2.6; (_this select 0) setRandomLip false; }] remoteExecCall ["spawn", 0, false];

sleep 5;
missionNameSpace setVariable ["TOUR_tskRadioState", "accepted", true];