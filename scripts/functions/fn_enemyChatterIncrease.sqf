private ["_sleepIncrease", "_sleeptime"];
_sleepIncrease = _this;

if (isNil {missionNamespace getVariable "TOUR_tourComplete"}) then 
{
	missionNameSpace setVariable ["TOUR_enemyChatter", 1, true];
	_sleeptime = time + _sleepIncrease;
	waitUntil {!(isNil {missionNamespace getVariable "TOUR_tourComplete"})or(time >= _sleeptime)};
	if (isNil {missionNamespace getVariable "TOUR_tourComplete"}) then 
	{
		missionNameSpace setVariable ["TOUR_enemyChatter", 2, true];
		_sleeptime = time + _sleepIncrease;
		waitUntil {!(isNil {missionNamespace getVariable "TOUR_tourComplete"})or(time >= _sleeptime)};
		if (isNil {missionNamespace getVariable "TOUR_tourComplete"}) then 
		{
			missionNameSpace setVariable ["TOUR_enemyChatter", 3, true];
			_sleeptime = time + _sleepIncrease;
			waitUntil {!(isNil {missionNamespace getVariable "TOUR_tourComplete"})or(time >= _sleeptime)};
			if (isNil {missionNamespace getVariable "TOUR_tourComplete"}) then 
			{
				missionNameSpace setVariable ["TOUR_enemyChatter", 4, true];
				_sleeptime = time + _sleepIncrease;
				waitUntil {!(isNil {missionNamespace getVariable "TOUR_tourComplete"})or(time >=_sleeptime)};
			};
		};
	};
};