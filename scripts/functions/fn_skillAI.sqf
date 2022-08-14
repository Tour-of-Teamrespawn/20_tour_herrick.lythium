/*
	Skill Level settings function by Mr.Ben
	
	Usage:
	_this should be a man unit
	_x call function;
	alter the _sniper or _sf units as per mission class names for enemies
*/

private ["_guy", "_skillgeneral", "_skillaccuracy", "_skills", "_skillArray"];

_guy = _this;
_skillArray = [["aimingShake",0.3],["aimingSpeed",0.35],["commanding",0.85],["courage",0.5],["reloadSpeed",1],["spotDistance",0.60],["spotTime",0.65],["aimingAccuracy", 0.225],["general", 0.85]];

_sf = 
[
	"rhs_vdv_rifleman",
	"rhs_vdv_rifleman",
	"rhs_vdv_rifleman",
	"rhs_vdv_arifleman_rpk",
	"rhs_vdv_arifleman_rpk",
	"rhs_vdv_arifleman",
	"rhs_vdv_AT",
	"rhs_vdv_medic",
	"rhs_vdv_marksman",
	"rhs_vdv_machinegunner",
	"rhs_vdv_grenadier",
	"rhs_vdv_lat"
];
_sniper = 
[
	"rhsgref_ins_militiaman_mosin",
	"rhsgref_ins_sniper",
	"rhs_vdv_marksman"
];

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
