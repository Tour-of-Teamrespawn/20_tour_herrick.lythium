waitUntil {!isNil "TOUR_init_complete"};

createCenter WEST; WEST setFriend [EAST, 0]; WEST setFriend [RESISTANCE, 1]; WEST setFriend [CIVILIAN, 1];
createCenter EAST; EAST setFriend [WEST, 0]; EAST setFriend [RESISTANCE, 1]; EAST setFriend [CIVILIAN, 1];
createCenter RESISTANCE; RESISTANCE setFriend [WEST, 1]; RESISTANCE setFriend [EAST, 1]; RESISTANCE setFriend [CIVILIAN, 1];
createCenter CIVILIAN; CIVILIAN setFriend [WEST, 1]; CIVILIAN setFriend [EAST, 1]; CIVILIAN setFriend [RESISTANCE, 1];
SIDELOGIC setFriend [WEST, 1]; SIDELOGIC setFriend [EAST, 1]; SIDELOGIC setFriend [RESISTANCE, 1];

execVM "scripts\control\setupObjectives.sqf";

tour_garbagearray = [];
tour_mission_units = [];

execVM "scripts\control\garbageLoop.sqf";

execVM "scripts\control\mastertask.sqf";

_cp = ["TOUR_mkr_civArea1", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea2", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea3", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea4", 7, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea5", 15, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";
_cp = ["TOUR_mkr_civArea6", 10, "TOUR_mkr_FOBArea"] execVM "scripts\ambientLife\createPedestrians.sqf";

[]spawn 
{
	for "_i" from 1 to 6 do 
	{
		_cd = [1, 1] execVM "scripts\ambientLife\createVehicles.sqf";
		_cd = [1, 2] execVM "scripts\ambientLife\createVehicles.sqf";
		sleep 60;
	};
};

execVM "scripts\ambientLife\flybyLoop.sqf";

execVM "scripts\control\eventloop.sqf";

["TOUR_mkr_AO", 4, 6, WEST] execVM "scripts\TOUR_IED\bombsCreateArea.sqf";

clearMagazineCargoGlobal TOUR_decAmmo; 
clearMagazineCargoGlobal TOUR_decAmmo;
clearitemCargoGlobal TOUR_decAmmo;

TOUR_EnemyInfMen = [
	"UK3CB_TKM_O_SL",
	"UK3CB_TKM_O_TL",
	"UK3CB_TKM_O_MD",
	"UK3CB_TKM_O_MG",
	"UK3CB_TKM_O_MG_ASST",
	"UK3CB_TKM_O_AR",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT",
	"UK3CB_TKM_O_AT_ASST",
	"UK3CB_TKM_O_AA",
	"UK3CB_TKM_O_MK",
	"UK3CB_TKM_O_SNI",
	"UK3CB_TKM_O_SPOT",
	"UK3CB_TKM_O_ENG",
	"UK3CB_TKM_O_DEM",
	"UK3CB_TKM_O_IED",
	"UK3CB_TKM_O_RIF_1",
	"UK3CB_TKM_O_RIF_2",
	"UK3CB_TKM_O_GL"
];

TOUR_EnemySFs = [];

TOUR_EnemySnipers = ["UK3CB_TKM_O_MK", "UK3CB_TKM_O_SNI"];

TOUR_EnemyInfGrp = 
[
	["infantry", "UK3CB_TKM_O_RIF_Sentry"],
	["infantry", "UK3CB_TKM_O_IED_Sentry"],
	["infantry", "UK3CB_TKM_O_AT_Sentry"],
	["infantry", "UK3CB_TKM_O_AR_Sentry"],
	["infantry", "UK3CB_TKM_O_MG_Sentry"],
	["infantry", "UK3CB_TKM_O_UGL_Sentry"],
	["infantry", "UK3CB_TKM_O_AA_FireTeam"],
	["infantry", "UK3CB_TKM_O_AT_FireTeam"],
	["infantry", "UK3CB_TKM_O_UGL_FireTeam"],
	["infantry", "UK3CB_TKM_O_MG_FireTeam"],
	["infantry", "UK3CB_TKM_O_RIF_FireTeam"],
	["infantry", "UK3CB_TKM_O_MK_FireTeam"],
	["infantry", "UK3CB_TKM_O_AR_FireTeam"],
	["infantry", "UK3CB_TKM_O_AT_Squad"],
	["infantry", "UK3CB_TKM_O_AR_Squad"],
	["infantry", "UK3CB_TKM_O_MG_Squad"],
	["infantry", "UK3CB_TKM_O_RIF_Squad"],
	["infantry", "UK3CB_TKM_O_AT_Squad"],
	["infantry", "UK3CB_TKM_O_AR_Squad"],
	["infantry", "UK3CB_TKM_O_MG_Squad"],
	["infantry", "UK3CB_TKM_O_RIF_Squad"],
	["infantry", "UK3CB_TKM_O_AT_Squad"],
	["infantry", "UK3CB_TKM_O_AR_Squad"],
	["infantry", "UK3CB_TKM_O_MG_Squad"],
	["infantry", "UK3CB_TKM_O_RIF_Squad"],
	["infantry", "UK3CB_TKM_O_AT_Squad"],
	["infantry", "UK3CB_TKM_O_AR_Squad"],
	["infantry", "UK3CB_TKM_O_MG_Squad"],
	["infantry", "UK3CB_TKM_O_RIF_Squad"],
	["specops", "UK3CB_TKM_O_IED_Team"],
	["specops", "UK3CB_TKM_O_Sniper_Team"],
	["support", "UK3CB_TKM_O_Support_AGS30"],
	["support", "UK3CB_TKM_O_Support_DSHKM_HIGH"],
	["support", "UK3CB_TKM_O_Support_DSHKM_LOW"],
	["support", "UK3CB_TKM_O_Support_KORD"],
	["support", "UK3CB_TKM_O_Support_NSV"],
	["support", "UK3CB_TKM_O_Support_PODNOS"],
	["support", "UK3CB_TKM_O_Support_SPG9"]
];

TOUR_enemyGrpSpawns = 
[
	[9324,11341,0],[9450,11350,0],[8686.78,12220.6,0],[8427.14,11976,0],[8587.74,11036.9,0],[8638.03,10703.9,0],[8988.35,10597.8,0],[9016.32,10287.4,0],[9782.07,10364.2,0],[9640.71,10109.4,0],[10176.2,10229.9,0],[10094.4,10002.8,0],[10457.9,10392.5,0],[10879.9,10753,0],[10967.7,11414.2,0],[10916.9,11754,0],[10546.9,11987,0],[10414.6,12444.3,0],[10030.7,12592.8,0],[9644.04,12611.4,0],[9010.4,12370.8,0],[9452.07,11771.4,0],[9392.2,12226,0],[9755.45,11705,0],[9277.21,11534.1,0],[9290.26,11670.4,0],[9484.22,11304.7,0],[9999.14,11312.2,0],[10543.3,11343.8,0],[10276.2,11604.2,0],[9971.89,11849.4,0],[9663.24,12387.7,0],[10191.6,11253.1,0],[10079.6,11014.6,0],[10275.5,10624.5,0],[10493.1,10600.6,0],[10533.5,10775.4,0],[10658.2,10903.5,0],[10523.9,10990.2,0],[9784.25,10425.2,0],[9702.94,10501.2,0],[9870.51,10593.9,0],[9448.42,10616.3,0],[9618.29,10898.8,0],[9193.88,10729.5,0],[9235.37,10838,0],[9017.65,10746.7,0],[8868.27,10883.4,0],[8890.98,10959.1,0]
];

TOUR_initServer_complete = true;