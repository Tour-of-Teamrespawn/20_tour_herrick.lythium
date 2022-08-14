params ["_player"];
if (!isDedicated) then
{
	if (str player == _player) then
	{	
		setPlayerRespawnTime 0;
	};
};
