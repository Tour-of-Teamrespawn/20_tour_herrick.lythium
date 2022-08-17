/* 
###MISSION_VERSION 0.001
*/

_d = execVM "scripts\general\debugRPT.sqf";
waitUntil {scriptDone _d};

_p = execVM "params.sqf";
waitUntil {scriptDone _p};

_a = TOUR_logic execVM "a2s_multitask.sqf";
waitUntil {scriptDone _a};


enableRadio false;
{
	_x setVariable ["BIS_noCoreConversations",true];
} forEach allUnits;

TOUR_HQ = [WEST, "HQ"];

_f = execVM "scripts\functions\fn_init.sqf";
waitUntil {scriptDone _f};

_siAction = if (true) then
{
	" 
	((toLower (backpack player)) in	[""uk3cb_baf_b_bergen_mtp_radio_h_a"",""uk3cb_baf_b_bergen_mtp_radio_h_b"",""uk3cb_baf_b_bergen_mtp_radio_l_a"",""uk3cb_baf_b_bergen_mtp_radio_l_b""])"
}else
{
	"(alive player) && (""ItemRadio"" in (assignedItems player))"
};

_si = 
[
	TOUR_logic,
	WEST,
	_siAction,
	"false",
	false,
	[
		[
			"artillery",
			"Harbinger",
			[
				["6rnd_155mm_mo_smoke", 100]
			]
		],
		[
			"helicopter",
			TOUR_chopper_1,
			"Bishop Four",
			[
				"Circle",
				"Land",
				"Land (Engine Off)",
				"Move To",
				"Pickup",
				"Return To Base",
				"toggle engine"
			],
			getPosATL TOUR_chopper_1
		]
	]
] execVM "scripts\TOUR_SI\TOUR_SI_init.sqf";

TOUR_init_complete = true;



