_radio = _this select 0;
_function = _this select 1;
_tune = "";

if !(isNil {_radio getVariable "TOUR_soundSource"}) then 
{
	_tune = _radio getVariable "TOUR_musicPlaying";
	deleteVehicle (_radio getVariable "TOUR_soundSource");
	_radio setVariable ["TOUR_soundSource", nil, true];
	sleep 1; 
};

if (_function != "off") then 
{
	_nextTune = switch (toLower _tune) do 
	{
		case "tour_music_theverve_bitter": {["tour_music_808state_pacificstate", 393]};	
		case "tour_music_808state_pacificstate": {["tour_music_happymondays_stepon",276]};
		case "tour_music_happymondays_stepon": {["tour_music_hotpots_chippytea",168]};
		case "tour_music_hotpots_chippytea": {["tour_music_insprialcarpets_feels",198]};
		case "tour_music_insprialcarpets_feels": {["tour_music_macclads_blackpool",156]};
		case "tour_music_macclads_blackpool": {["tour_music_neworder_bluemonday",446]};
		case "tour_music_neworder_bluemonday": {["tour_music_oasis_cigs",288]};
		case "tour_music_oasis_cigs": {["tour_music_thebeetles_sgtpepper",122]};
		case "tour_music_thebeetles_sgtpepper": {["tour_music_thebuzzocks_everfallen",162]};
		case "tour_music_thebuzzocks_everfallen": {["tour_music_thesmiths_howsoon",216]};
		case "tour_music_thesmiths_howsoon": {["tour_music_thestoneroses_foolsgold",256]};
		case "tour_music_thestoneroses_foolsgold": {["tour_music_theverve_bitter",275]};
		default {["tour_music_theverve_bitter",275]};
	};

	_musicSource = "Land_heliPadEmpty_f" createVehicle (getpos _radio);
	_radio setVariable ["TOUR_soundSource", _musicSource, true];
	_radio setVariable ["TOUR_musicPlaying", _nextTune select 0, true];
	sleep 1;
	[[_nextTune select 0, _musicSource],{(_this select 1) say3d [(_this select 0), 50];}] remoteExecCall ["spawn", 0, false];
	[[_nextTune select 1, _radio],
	{
		_time = time + (_this select 0);
		_radio = _this select 1;
		waitUntil {(isNil {_radio getVariable "TOUR_soundSource"}) or (time > _time)};
		if !(isNil {_radio getVariable "TOUR_soundSource"}) then 
		{
			[_radio, "next"] execVM "scripts\general\music.sqf";
		};
	}] remoteExecCall ["spawn", 2, false];
};