_caller = _this select 1;
_ied = (nearestobjects [vehicle player, ["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F","Land_GarbageHeap_03_F","Land_GarbageHeap_04_F"," Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_GarbageBags_F"], 10]) select 0;


_ied setVariable ["TOUR_IED_examined", true, true];
private _iedExplosiveMass = "";




