if (isDedicated) exitWith {};

removeUniform player;
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removebackpack player;
removeVest player;
removeHeadGear player;
removeGoggles player;

private _uniform = "";

_uniform = switch (toLower TypeOf player) do 
{
	default {"UK3CB_BAF_U_CombatUniform_MTP_TShirt"};
};

player addUniform _uniform;

{
	player addItem _x;
	player assignItem _x;
}forEach ["ItemMap","ItemCompass","ItemWatch"];

{
	player addItemToUniform _x;
}forEach 
[
	"ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing","ACE_fieldDressing",
	"ACE_tourniquet",
	"ACE_morphine","ACE_morphine","ACE_morphine",
	"ACE_epinephrine",
	"ACE_bloodIV_500",
	"ACE_Earplugs",
	"ACRE_PRC343"
];

sleep 1;
[player,"uk3cb_baf_insignia_redcross"] call BIS_fnc_setUnitInsignia;

if (toLower TypeOf player != "uk3cb_baf_medic_mtp") then 
{
	[player,"QLR"] call BIS_fnc_setUnitInsignia;
};


