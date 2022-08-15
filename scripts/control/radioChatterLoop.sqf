private ["_time"];

while {true} do 
{
	_status = (missionNameSpace getVariable "TOUR_enemyEvent");
	if (missionNameSpace getVariable "TOUR_enemyEvent" == "low") then 
	{
		hint "bla bla low";
		_time = time + 90;
		sleep 10;
	};
	if (missionNameSpace getVariable "TOUR_enemyEvent" == "medium") then 
	{
		hint "bla bal medium";
		_time = time + 60;
		sleep 10;
	};
	if (missionNameSpace getVariable "TOUR_enemyEvent" == "high") then 
	{
		hint "bla bla high";
		_time = time + 30;
		sleep 10;
	};
	if (missionNameSpace getVariable "TOUR_enemyEvent" == "danger") then 
	{
		hint "bla bla danger";
		_time = time + 15;
		sleep 10;
	};
	waitUntil {(missionNameSpace getVariable "TOUR_enemyEvent") != _status or (time > _time)};
};