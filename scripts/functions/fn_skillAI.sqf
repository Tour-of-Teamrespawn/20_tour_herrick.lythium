/*
	Title: fn_skillAI
	
	Description: Sets the skill level of the unit passed to the function to Tour of Teamrespawn default values, including the option to improve stats with special forces and snipers
	
	Usage:
	[_this, ["lowercase_specialforces_classname_1", "lowercase_specialforces_classname_2"], ["lowercase_sniper_classname_1", "lowercase_sniper_classname_1"]] call MYTAG_fn_skillAI;

	Author: Mr.Ben
	Version: 1.0
*/

private ["_sf", "_sniper", "_guy", "_skillgeneral", "_skillaccuracy", "_skills", "_skillArray"];
params ["_guy", "_sf", "_sniper"];

if (count _this < 1) exitWith {hint "You need to pass parameters for fn_skillAI to work"}; 

_guy = _this select 0;

_sf = if (count _this < 2) then 
{
	[];
}else
{
	_this select 1;
};

_sniper = if (count _this < 3) then 
{
	[];
}else
{
	_this select 2;
};

_skillArray = [["aimingShake",0.3],["aimingSpeed",0.35],["commanding",0.85],["courage",0.5],["reloadSpeed",1],["spotDistance",0.60],["spotTime",0.65],["aimingAccuracy", 0.225],["general", 0.85]];

if ((toLower (typeof _guy)) in _sf) then
{
	// requires skill multiplyer & accuracy setting
	{
		_value = _x select 1;
		if ((_x select 0) == "general") then
		{
			_value = 1;
		};
		if ((_x select 0) == "aimingAccuracy") then
		{
			_value = 0.3;
		};
		if ((_x select 0) == "commanding") then
		{
			_value = 1;
		};
		if ((_x select 0) == "courage") then
		{
			_value = 0.9;
		};
		_skillArray set [_forEachIndex, [(_x select 0), _value]];	
	}forEach _skillArray;
}else
{
		// requires general skill and accuracy setting as -per new parameter
	{
		_value = _x select 1;
		if ((toLower (typeof _guy)) in _sniper) then
		{
			if ((_x select 0) == "general") then
			{
				_value = 0.9;
			};
			if ((_x select 0) == "aimingAccuracy") then
			{	
				_value = 0.4;
			};
		};
		_skillArray set [_forEachIndex, [(_x select 0), _value]];
	}forEach _skillArray;
};

if (!isNil "Vcm_ActivateAI") then
{
	(group _guy) setVariable ["VCM_Skilldisable",true]; //This command will disable an AI group from being impacted by Vcom AI skill changes.
	(group _guy) setVariable ["Vcm_Disable",true];	//This command will disable an AI group from running Vcom scripts.
};

if (local _guy) then 
{
	{
		_guy setSkill _x;
	}forEach _skillArray;
	_guy setvariable ["bis_nocoreconversations",true];
};
