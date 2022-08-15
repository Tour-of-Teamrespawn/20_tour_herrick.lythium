private ["_time"];

while {true} do 
{
	if (missionNameSpace getVariable "TOUR_tskAccept" == "calling") then 
	{
		hint "calling, please pickup";
		_time = time + 25;
		sleep 5;
	};
	waitUntil {(missionNameSpace getVariable "TOUR_tskAccept" != "calling") or (time > _time)};
	if (missionNameSpace getVariable "TOUR_tskAccept" == "accepted") then 
	{
		hint "I accept the mission";
		sleep 5;
		missionNameSpace setVariable ["TOUR_tskAccept", "silent", true];
	};
};