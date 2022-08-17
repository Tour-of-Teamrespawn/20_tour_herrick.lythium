private ["_time"];

TOUR_enemyChatter = 1;

while {true} do 
{
	_status = TOUR_enemyChatter;
	if (TOUR_enemyChatter == 1) then 
	{
		hint "bla bla low";
		_time = time + 90;
		sleep 10;
	};
	if (TOUR_enemyChatter == 2) then 
	{
		hint "bla bal medium";
		_time = time + 60;
		sleep 10;
	};
	if (TOUR_enemyChatter == 3) then 
	{
		hint "bla bla high";
		_time = time + 30;
		sleep 10;
	};
	if (TOUR_enemyChatter == 4) then 
	{
		hint "bla bla danger";
		_time = time + 15;
		sleep 10;
	};
	waitUntil {(TOUR_enemyChatter != _status) or (time > _time)};
};