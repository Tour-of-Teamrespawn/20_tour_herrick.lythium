_state = true;
while {true} do 
{
	if ((_state == false) && (missionNamespace getVariable "TOUR_backpacRadioON")) then 
	{
		if (!isNil "TOUR_player_3") then 
		{
			if (!isNull TOUR_player_3) then 
			{
				_state = true;
				TOUR_radioSound attachTo [TOUR_player_3, [0,0,1]];
			};
		};
	};
	if ((_state == true) && !(missionNamespace getVariable "TOUR_backpacRadioON")) then 
	{
		if (!isNil "TOUR_player_3") then 
		{
			if (!isNull TOUR_player_3) then 
			{
				_state = false;
				detach TOUR_radioSound;
				TOUR_radioSound setpos [0,0,0];
			};
		};
	};
	sleep 0.1;
};