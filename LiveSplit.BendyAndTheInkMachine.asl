state("Bendy and the Ink Machine")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Bendy and the Ink Machine";
    vars.Helper.AlertLoadless();
    vars.Helper.Settings.CreateFromXml("Components/BATIM.Settings.xml");
}

init
{	
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        //Current Chapter ID
        vars.Helper["Chapters"] = mono.Make<int>("GameManager", "m_Instance", "CurrentChapter", "m_Chapter");
        vars.Helper["Objectives"] = mono.MakeString("GameManager", "m_Instance", "m_ObjectiveController", "m_DataVO", "Objective");

        //Chapter 1
        vars.Helper["Inkwell"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Inkwell", "IsStarted");
        vars.Helper["Doll"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Doll", "IsStarted");
        vars.Helper["Record"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Record", "IsStarted");
        vars.Helper["Book"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Book", "IsStarted");
        vars.Helper["Wrench"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Wrench", "IsStarted");
        vars.Helper["Gear"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Gear", "IsStarted");
        vars.Helper["InkMachineRevealObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "InkMachineRevealObjective", 0x11);
        vars.Helper["CollectablesObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "CollectablesObjective", 0x11);
        vars.Helper["TheatreObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "TheatreObjective", 0x11);
        vars.Helper["InkMachineObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "InkMachineObjective", 0x11);
        vars.Helper["BendyChaseObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "BendyChaseObjective", 0x11);
        vars.Helper["BasementObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "BasementObjective", 0x11);

        //Chapter 2
        vars.Helper["RitualObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "RitualObjective", 0x11);
        vars.Helper["GateObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "GateObjective", 0x11);
        vars.Helper["MusicDepartmentObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "MusicDepartmentObjective", 0x11);
        vars.Helper["LostKeysObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "LostKeysObjective", 0x11);
        vars.Helper["MusicPuzzleObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "MusicPuzzleObjective", 0x11);
        vars.Helper["SanctuaryObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "SanctuaryObjective", 0x11);
        vars.Helper["InfirmaryObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "InfirmaryObjective", 0x11);
        vars.Helper["SewersObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "SewersObjective", 0x11);
        vars.Helper["SammysOfficeObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "SammysOfficeObjective", 0x11);

        //Chapter 3
        vars.Helper["SqueakyToys"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "SqueakyToys", 0x11);
        vars.Helper["AccountingRoom"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AccountingRoom", 0x11);
        vars.Helper["SafehouseObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "SafehouseObjective", 0x11);
        vars.Helper["DarkHallwayObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "DarkHallwayObjective", 0x11);
        vars.Helper["HeavenlyToysObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "HeavenlyToysObjective", 0x11);
        vars.Helper["AliceRevealObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AliceRevealObjective", 0x11);
        vars.Helper["DecisionObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "DecisionObjective", 0x11);
        vars.Helper["BorisJumpscareObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "BorisJumpscareObjective", 0x11);
        vars.Helper["PosterPiperObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "PosterPiperObjective", 0x11);
        vars.Helper["EnterLiftObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "EnterLiftObjective", 0x11);
        vars.Helper["AliceLairObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AliceLairObjective", 0x11);
        vars.Helper["AliceTasksObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AliceTasksObjective", 0x11);
        vars.Helper["GearTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "GearTask", 0x11);
        vars.Helper["ThickInkTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "ThickInkTask", 0x11);
        vars.Helper["PowerCoreTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "PowerCoreTask", 0x11);
        vars.Helper["CutoutTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "CutoutTask", 0x11);
        vars.Helper["ButcherGangTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "ButcherGangTask", 0x11);
        vars.Helper["HeartTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "HeartTask", 0x11);

        //Chapter 4
        vars.Helper["InternecionBools"] = mono.Make<int>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "InternecionBools", 0x11);
        vars.Helper["AccountingObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "AccountingObjective", 0x11);
        vars.Helper["BridgeMachineObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "BridgeMachineObjective", 0x11);
        vars.Helper["LostOnesObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "LostOnesObjective", 0x11);
        vars.Helper["VentObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "VentObjective", 0x11);
        vars.Helper["MapRoomObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "MapRoomObjective", 0x11);
        vars.Helper["WarehouseObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "WarehouseObjective", 0x11);
        vars.Helper["FairGamesObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "FairGamesObjective", 0x11);
        vars.Helper["ResearchObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "ResearchObjective", 0x11);
        vars.Helper["RideStorageObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "RideStorageObjective", 0x11);
        vars.Helper["MaintenanceObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "MaintenanceObjective", 0x11);
        vars.Helper["HauntedHouseObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "HauntedHouseObjective", 0x11);

        //Chapter 5
        vars.Helper["PipePuzzleBasic"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "PipePuzzleBasic", 0x11);
        vars.Helper["PipePuzzleCorner"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "PipePuzzleCorner", 0x11);
        vars.Helper["PipePuzzleThreeWay"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "PipePuzzleThreeWay", 0x11);
        vars.Helper["SafehouseObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "SafehouseObjective", 0x11);
        vars.Helper["CavesObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "CavesObjective", 0x11);
        vars.Helper["DockObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "DockObjective", 0x11);
        vars.Helper["TunnelsObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "TunnelsObjective", 0x11);
        vars.Helper["LostHarbourObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "LostHarbourObjective", 0x11);
        vars.Helper["AdministrationObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "AdministrationObjective", 0x11);
        vars.Helper["VaultObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "VaultObjective", 0x11);
        vars.Helper["GiantInkMachineObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "GiantInkMachineObjective", 0x11);
        vars.Helper["ThroneRoomObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "ThroneRoomObjective", 0x11);
        vars.Helper["BendyArenaObjective"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "BendyArenaObjective", 0x11);

        //Save File Playtime
        vars.Helper["IGT"] = mono.Make<float>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "PlayTime");

        return true;

    });

    vars.CompletedSplits = new Dictionary<string, bool>();
    vars.ResetSplits = (Action)(() => { foreach(var split in new List<string>(vars.CompletedSplits.Keys)) vars.CompletedSplits[split] = false; });
}

update
{
    if(old.Objectives != current.Objectives)
    {
        vars.Log("Objective: " + current.Objectives);
    }

    if(old.Chapters != current.Chapters)
    {
        vars.Log("Chapter: " + current.Chapters);
    }
}

gameTime
{
    return TimeSpan.FromSeconds(current.IGT);
}

start 
{
	return current.Chapters == 1 && current.IGT > 0.0f && old.IGT == 0.0f;
}

reset
{
    return old.Chapters == 0 && current.IGT == 0.0f && old.IGT > 0.0f;
}

split 
{
	if(current.Chapters > old.Chapters)
    {
		return settings["ch" + old.Chapters];
        vars.CompletedSplits["ch" + old.Chapters] = true;
	}
}

onStart
{
    vars.ResetSplits();
}

exit
{
    timer.IsGameTimePaused = true;
}
