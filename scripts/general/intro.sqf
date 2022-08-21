if (!isdedicated) then
{
	cutText ["Loading Intro","BLACK FADED", 0];
	0 fadeSound 0;
	waituntil {player == player};
	sleep 1;
	_pos1  = [(getMarkerPos "TOUR_mkr_intro_1") select 0, (getMarkerPos "TOUR_mkr_intro_1") select 1 , 35];
	_pos2  = [(getMarkerPos "TOUR_mkr_intro_2") select 0, (getMarkerPos "TOUR_mkr_intro_2") select 1 , 0];
	_pos3  = [(getMarkerPos "TOUR_mkr_FOBFlag") select 0, (getMarkerPos "TOUR_mkr_FOBFlag") select 1 , 20];
	_pos4  = [(getMarkerPos "TOUR_mkr_intro_3") select 0, (getMarkerPos "TOUR_mkr_intro_3") select 1 , 0];
	_pos5 = [(getPosATL player) select 0, (getPosATL player) select 1 , ((getPosATL player select 2) + 1.85)];

	//playSound "TOUR_introMusic";
	_cam1 = "camera" camCreate _pos1;
	_cam1 camprepareTarget _pos2; 
	_cam1 camCommitprepared 0;
	_cam1 cameraEffect ["internal", "back"];
	"dynamicBlur" ppEffectEnable true;
	"dynamicBlur" ppEffectAdjust [5];
	"dynamicBlur" ppEffectCommit 0;
	sleep 7;
	cutText ["","BLACK FADED", 0];		
	doStop player;
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 8;
	5 fadeSound 1;
	sleep 6;
	[]spawn 
	{
		sleep 4;
		_text = ["M","i","k","i","s"," ","F","O","B","\n","A","f","g","h","a","n","i","s","t","a","n"];
		_display = "";
		_pointer = 0;
		_sleepTime = 0.1;
		while {_pointer < count _text} do
		{
			_sleepTime = 0.1 + (random 0.05);
			_display = _display + (_text select _pointer);
			titleText [_display,"PLAIN down",_sleepTime];
			_pointer = _pointer + 1;
			if (_pointer == count _text) then
			{
				cutText [_display,"PLAIN UP",1];
			}
			else
			{
				playSound "TOUR_key_noise";
			};
			sleep _sleepTime;
		};		

	};
	sleep 10;
	_cam1 camprepareTarget (_pos1 getpos [1000, (getDir _cam1) + 90]); 
	_cam1 camCommitprepared 8;
	_cam1 camSetPos _pos3;
	_cam1 camCommit 30;
	sleep 8;
	_cam1 camprepareTarget ((getpos _cam1) getpos [1000, (getDir _cam1) + 90]); 
	_cam1 camCommitprepared 8;
	sleep 8;
	_cam1 camprepareTarget ((getpos _cam1) getpos [1000, (getDir _cam1) + 90]); 
	_cam1 camCommitprepared 8;
	sleep 8;
	_cam1 camprepareTarget ((getpos _cam1) getpos [1000, (getDir _cam1) + 90]); 
	_cam1 camCommitprepared 8;
	sleep 4;
	cutText [" ","BLACK OUT", 2];
	sleep 0.5;
	"dynamicBlur" ppEffectAdjust [3];
	"dynamicBlur" ppEffectCommit 1;
	sleep 7;
	_cam1 cameraEffect ["TERMINATE", "back"];
	"dynamicBlur" ppEffectAdjust [0];
	"dynamicBlur" ppEffectCommit 3;
	cutText [" ","BLACK IN", 2];
	sleep 5;
	_date = date;
	_year = _date select 0;
	_month = _date select 1;
	_day = _date select 2;
	_hour = _date select 3;
	_min = _date select 4;
	_text_date = [];

	if (_min < 10) then 
	{ 
		_text_date = format ["%1-%2-%3  %4h0%5m", _month, _day, _year, _hour, _min]; 
	} 
	else 
	{  
		if (_min == 60) then
		{
			_hour = _hour + 1;
			_min = 0;
			_text_date = format ["%1-%2-%3  %4h0%5m", _month, _day, _year, _hour, _min];
		}
		else
		{
			_text_date = format ["%1-%2-%3  %4h%5m", _month, _day, _year, _hour, _min]; 
		};
	};
	_text_1 = "Duke of Lancasters";
	_text_2 = "Regiment";
	[_text_1, _text_2, _text_date] spawn TOUR_fnc_infoText;	
	camdestroy _cam1;

	waitUntil {!(player inArea "TOUR_mkr_FOB") && (time < 600)};

	private _text = "<t font='PuristaBold' size='4'>30 [Tour] Herrick</t><br /><t font='PuristaBold' size='1.5'>by Mr.Ben &amp; Zero</t>";
	[parseText _text, true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
};