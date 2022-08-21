private ["_sleepIncrease"];
_sleepIncrease = _this;

missionNameSpace setVariable ["TOUR_enemyChatter", 1, true];
sleep _sleepIncrease;
missionNameSpace setVariable ["TOUR_enemyChatter", 2, true];
sleep _sleepIncrease;
missionNameSpace setVariable ["TOUR_enemyChatter", 3, true];
sleep _sleepIncrease;
missionNameSpace setVariable ["TOUR_enemyChatter", 4, true];