[[player], 
{

_player = _this select 0;
_textToHint = parseText format
["
	<t size='1.25' font='puristaMedium' color='#0080ff' align='center' valign='top'>MISSION DEBUG:</t>
	<br/>
	<br/>
	Danger Event = %1
	<br/>
	<br/>
	Enemy Chatter Level = %2
	<br/>
	<br/>
	Current Time = %5
	<br/>
	<br/>
	Next Event Time = %3
	<br/>
	<br/>
	Base Assault Time = %4 - %6
	<br/>
	<br/>
", (missionNameSpace getVariable "TOUR_dangerEvent"), (missionNameSpace getVariable "TOUR_enemyChatter"), TOUR_randomEventTimes select 0, TOUR_baseAttackBuildStartTime, date, if (TOUR_baseAttack) then {"Enabled"}else{"Disabled"}];

[_textToHint]remoteExeccall["hint", _player, false];

}]remoteExecCall["spawn", 2, false];