if (isDedicated) exitWith {};

waitUntil { ([] call acre_api_fnc_isinitialized) };
sleep 1;
private ["_channel"];
_channel = switch (toLower (groupID (group player))) do 
{
	case "broadsword": {1};
	case "broadsword one": {2};
	case "broadsword two": {3};
	case "broadsword three": {4};
	default {1};
};
waitUntil {[player, "ACRE_PRC343"] call acre_api_fnc_hasKindOfRadio};
sleep 1;
[(["ACRE_PRC343"] call acre_api_fnc_getRadioByType), _channel] call acre_api_fnc_setRadioChannel;