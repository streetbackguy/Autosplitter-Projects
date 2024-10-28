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
        var gm = mono["GameManager"];
        vars.Helper["Chapters"] = mono.Make<int>(gm, "m_Instance", "CurrentChapter", "m_Chapter");
        vars.Helper["Objectives"] = mono.MakeString(gm, "m_Instance", "m_ObjectiveController", "m_DataVO", "Objective");

        //Chapter 1
        vars.Helper["Inkwell"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Inkwell", "IsStarted");
        vars.Helper["Doll"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Doll", "IsStarted");
        vars.Helper["Record"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Record", "IsStarted");
        vars.Helper["Book"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Book", "IsStarted");
        vars.Helper["Wrench"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Wrench", "IsStarted");
        vars.Helper["Gear"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "Gear", "IsStarted");
        vars.Helper["InkMachineRevealObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "InkMachineRevealObjective", "IsComplete");
        vars.Helper["CollectablesObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "CollectablesObjective", "IsComplete");
        vars.Helper["TheatreObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "TheatreObjective", "IsComplete");
        vars.Helper["InkMachineObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "InkMachineObjective", "IsComplete");
        vars.Helper["BendyChaseObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "BendyChaseObjective", "IsComplete");
        vars.Helper["BasementObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH1Data", "BasementObjective", "IsComplete");

        //Chapter 2
        // vars.Helper["RitualObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "RitualObjective", "IsComplete");
        // vars.Helper["GateObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "GateObjective", "IsComplete");
        // vars.Helper["MusicDepartmentObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "MusicDepartmentObjective", "IsComplete");
        // vars.Helper["LostKeysObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "LostKeysObjective", "IsComplete");
        // vars.Helper["MusicPuzzleObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "MusicPuzzleObjective", "IsComplete");
        // vars.Helper["SanctuaryObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "SanctuaryObjective", "IsComplete");
        // vars.Helper["InfirmaryObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "InfirmaryObjective", "IsComplete");
        // vars.Helper["SewersObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "SewersObjective", "IsComplete");
        // vars.Helper["SammysOfficeObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH2Data", "SammysOfficeObjective", "IsComplete");

        //Chapter 3
        // vars.Helper["SqueakyToys"] = mono.MakeList(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "SqueakyToys", "IsComplete");
        // vars.Helper["AccountingRoom"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AccountingRoom", "IsComplete");
        // vars.Helper["SafehouseObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "SafehouseObjective", "IsComplete");
        // vars.Helper["DarkHallwayObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "DarkHallwayObjective", "IsComplete");
        // vars.Helper["HeavenlyToysObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "HeavenlyToysObjective", "IsComplete");
        // vars.Helper["AliceRevealObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AliceRevealObjective", "IsComplete");
        // vars.Helper["DecisionObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "DecisionObjective", "IsComplete");
        // vars.Helper["BorisJumpscareObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "BorisJumpscareObjective", "IsComplete");
        // vars.Helper["PosterPiperObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "PosterPiperObjective", "IsComplete");
        // vars.Helper["EnterLiftObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "EnterLiftObjective", "IsComplete");
        // vars.Helper["AliceLairObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AliceLairObjective", "IsComplete");
        // vars.Helper["AliceTasksObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "AliceTasksObjective", "IsComplete");
        // vars.Helper["GearTask"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "GearTask", "Status", "IsComplete");
        // vars.Helper["ThickInkTask"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "ThickInkTask", "Status", "IsComplete");
        // vars.Helper["PowerCoreTask"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "PowerCoreTask", "Status","IsComplete");
        // vars.Helper["CutoutTask"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "CutoutTask", "Status", "IsComplete");
        // vars.Helper["ButcherGangTask"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "ButcherGangTask", "IsComplete");
        // vars.Helper["HeartTask"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "HeartTask", "Status", "IsComplete");

        //Chapter 4
        // vars.Helper["InternecionBools"] = mono.Make<int>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "InternecionBools", "IsComplete");
        // vars.Helper["AccountingObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "AccountingObjective", "IsComplete");
        // vars.Helper["BridgeMachineObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "BridgeMachineObjective", "IsComplete");
        // vars.Helper["LostOnesObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "LostOnesObjective", "IsComplete");
        // vars.Helper["VentObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "VentObjective", "IsComplete");
        // vars.Helper["MapRoomObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "MapRoomObjective", "IsComplete");
        // vars.Helper["WarehouseObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "WarehouseObjective", "IsComplete");
        // vars.Helper["FairGamesObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "FairGamesObjective", "IsComplete");
        // vars.Helper["ResearchObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "ResearchObjective", "IsComplete");
        // vars.Helper["RideStorageObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "RideStorageObjective", "IsComplete");
        // vars.Helper["MaintenanceObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "MaintenanceObjective", "IsComplete");
        // vars.Helper["HauntedHouseObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH4Data", "HauntedHouseObjective", "IsComplete");

        //Chapter 5
        // vars.Helper["PipePuzzleBasic"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "PipePuzzleBasic", "IsComplete");
        // vars.Helper["PipePuzzleCorner"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "PipePuzzleCorner", "IsComplete");
        // vars.Helper["PipePuzzleThreeWay"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "PipePuzzleThreeWay", "IsComplete");
        // vars.Helper["SafehouseObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "SafehouseObjective", "IsComplete");
        // vars.Helper["CavesObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "CavesObjective", "IsComplete");
        // vars.Helper["DockObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "DockObjective", "IsComplete");
        // vars.Helper["TunnelsObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "TunnelsObjective", "IsComplete");
        // vars.Helper["LostHarbourObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "LostHarbourObjective", "IsComplete");
        // vars.Helper["AdministrationObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "AdministrationObjective", "IsComplete");
        // vars.Helper["VaultObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "VaultObjective", "IsComplete");
        // vars.Helper["GiantInkMachineObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "GiantInkMachineObjective", "IsComplete");
        // vars.Helper["ThroneRoomObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "ThroneRoomObjective", "IsComplete");
        // vars.Helper["BendyArenaObjective"] = mono.Make<bool>(gm, "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "BendyArenaObjective", "IsComplete");

        vars.Helper["IGT"] = mono.Make<float>(gm, "m_Instance", "GameData", "CurrentSaveFile", "PlayTime");

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
    return current.Chapters == 1 && current.IGT == 0.0f && old.IGT > 0.0f;
}

split 
{
	if (current.Chapters > old.Chapters)
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
