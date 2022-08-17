_orders = _this select 0;
_sleep = _this select 1;

_sound = format ["TOUR_snd_mission_%1", _orders];
[[_sound],{TOUR_cmdRadio say3d ["TOUR_snd_line_5", 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
if (missionNameSpace getVariable "TOUR_backpacRadioON") then
{
	[[_sound],{TOUR_radioSound say3d ["TOUR_snd_line_5", 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
};
sleep 2;
[[_sound],{TOUR_cmdRadio say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
if (missionNameSpace getVariable "TOUR_backpacRadioON") then
{
	[[_sound],{TOUR_radioSound say3d [_this select 0, 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
};
sleep _sleep;
[[],{TOUR_cmdRadio say3d ["TOUR_snd_mission_details", 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
if (missionNameSpace getVariable "TOUR_backpacRadioON") then
{
	[[],{TOUR_radioSound say3d ["TOUR_snd_mission_details", 50];}] remoteExecCall ["BIS_fnc_spawn", 0, false];
};
sleep 2;