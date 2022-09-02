_radio = _this select 0;
_function = _this select 1;
_tune = "";

if !(isNil {_radio getVariable "TOUR_soundSource"}) then 
{
	_tune = _radio getVariable "TOUR_musicPlaying";
	deleteVehicle (_radio getVariable "TOUR_soundSource");
	_radio setVariable ["TOUR_soundSource", nil, true];
};

if (_function != "off") then 
{
	_nextTune = switch (toLower _tune) do 
	{
		case "tour_music_theverve_bitter": {"tour_music_808state_pacificstate"};	
		case "tour_music_808state_pacificstate": {"tour_music_happymondays_stepon"};
		case "tour_music_happymondays_stepon": {"tour_music_hotpots_chippytea"};
		case "tour_music_hotpots_chippytea": {"tour_music_insprialcarpets_feels"};
		case "tour_music_insprialcarpets_feels": {"tour_music_macclads_blackpool"};
		case "tour_music_macclads_blackpool": {"tour_music_neworder_bluemonday"};
		case "tour_music_neworder_bluemonday": {"tour_music_oasis_cigs"};
		case "tour_music_oasis_cigs": {"tour_music_thebeetles_sgtpepper"};
		case "tour_music_thebeetles_sgtpepper": {"tour_music_thebuzzocks_everfallen"};
		case "tour_music_thebuzzocks_everfallen": {"tour_music_thesmiths_howsoon"};
		case "tour_music_thesmiths_howsoon": {"tour_music_thestoneroses_foolsgold"};
		case "tour_music_thestoneroses_foolsgold": {"tour_music_theverve_bitter"};
		default {"tour_music_theverve_bitter"};
	};

	_musicSource = "Land_heliPadEmpty_f" createVehicle (getpos _radio);
	_radio setVariable ["TOUR_soundSource", _musicSource, true];
	_radio setVariable ["TOUR_musicPlaying", _nextTune, true];
	sleep 1;
	[[_nextTune, _musicSource],{(_this select 1) say3d [(_this select 0), 50];}] remoteExecCall ["spawn", 0, false];
};