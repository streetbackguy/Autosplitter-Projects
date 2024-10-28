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
        vars.Helper["GearTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "GearTask", 0x18, 0x11);
        vars.Helper["ThickInkTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "ThickInkTask", 0x18, 0x11);
        vars.Helper["PowerCoreTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "PowerCoreTask", 0x18, 0x11);
        vars.Helper["CutoutTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "CutoutTask", 0x18, 0x11);
        vars.Helper["ButcherGangTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "ButcherGangTask", 0x11);
        vars.Helper["HeartTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "HeartTask", 0x18, 0x11);

        //Chapter 4
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
        vars.Helper["SafehouseObjective2"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH5Data", "SafehouseObjective", 0x11);
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

    vars.CompletedSplits = new HashSet<string>();
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
        vars.CompletedSplits.Add("ch" + old.Chapters);
	}

    //Chapter 1
    if(current.Inkwell && !old.Inkwell && !vars.CompletedSplits.Contains("Inkwell"))
    {
        return settings["Inkwell"];
        vars.CompletedSplits.Add("Inkwell");
    }

    if(current.Doll && !old.Doll && !vars.CompletedSplits.Contains("Doll"))
    {
        return settings["Doll"];
        vars.CompletedSplits.Add("Doll");
    }

    if(current.Record && !old.Record && !vars.CompletedSplits.Contains("Record"))
    {
        return settings["Record"];
        vars.CompletedSplits.Add("Record");
    }

    if(current.Book && !old.Book && !vars.CompletedSplits.Contains("Book"))
    {
        return settings["Book"];
        vars.CompletedSplits.Add("Book");
    }

    if(current.Wrench && !old.Wrench && !vars.CompletedSplits.Contains("Wrench"))
    {
        return settings["Wrench"];
        vars.CompletedSplits.Add("Wrench");
    }

    if(current.Gear && !old.Gear && !vars.CompletedSplits.Contains("Gear"))
    {
        return settings["Gear"];
        vars.CompletedSplits.Add("Gear");
    }

    if(current.InkMachineRevealObjective && !old.InkMachineRevealObjective && !vars.CompletedSplits.Contains("InkMachineRevealObjective"))
    {
        return settings["InkMachineRevealObjective"];
        vars.CompletedSplits.Add("InkMachineRevealObjective");
    }

    if(current.CollectablesObjective && !old.CollectablesObjective && !vars.CompletedSplits.Contains("CollectablesObjective"))
    {
        return settings["CollectablesObjective"];
        vars.CompletedSplits.Add("CollectablesObjective");
    }

    if(current.TheatreObjective && !old.TheatreObjective && !vars.CompletedSplits.Contains("TheatreObjective"))
    {
        return settings["TheatreObjective"];
        vars.CompletedSplits.Add("TheatreObjective");
    }

    if(current.InkMachineObjective && !old.InkMachineObjective && !vars.CompletedSplits.Contains("InkMachineObjective"))
    {
        return settings["InkMachineObjective"];
        vars.CompletedSplits.Add("InkMachineObjective");
    }

    if(current.BendyChaseObjective && !old.BendyChaseObjective && !vars.CompletedSplits.Contains("BendyChaseObjective"))
    {
        return settings["BendyChaseObjective"];
        vars.CompletedSplits.Add("BendyChaseObjective");
    }

    if(current.BendyChaseObjective && !old.BendyChaseObjective && !vars.CompletedSplits.Contains("BendyChaseObjective"))
    {
        return settings["BasementObjective"];
        vars.CompletedSplits.Add("BasementObjective");
    }

    //Chapter 2
    if(current.RitualObjective && !old.RitualObjective && !vars.CompletedSplits.Contains("RitualObjective"))
    {
        return settings["RitualObjective"];
        vars.CompletedSplits.Add("RitualObjective");
    }

    if(current.GateObjective && !old.GateObjective && !vars.CompletedSplits.Contains("GateObjective"))
    {
        return settings["GateObjective"];
        vars.CompletedSplits.Add("GateObjective");
    }

    if(current.MusicDepartmentObjective && !old.MusicDepartmentObjective && !vars.CompletedSplits.Contains("MusicDepartmentObjective"))
    {
        return settings["MusicDepartmentObjective"];
        vars.CompletedSplits.Add("MusicDepartmentObjective");
    }

    if(current.LostKeysObjective && !old.LostKeysObjective && !vars.CompletedSplits.Contains("LostKeysObjective"))
    {
        return settings["LostKeysObjective"];
        vars.CompletedSplits.Add("LostKeysObjective");
    }

    if(current.MusicPuzzleObjective && !old.MusicPuzzleObjective && !vars.CompletedSplits.Contains("MusicPuzzleObjective"))
    {
        return settings["MusicPuzzleObjective"];
        vars.CompletedSplits.Add("MusicPuzzleObjective");
    }

    if(current.SanctuaryObjective && !old.SanctuaryObjective && !vars.CompletedSplits.Contains("SanctuaryObjective"))
    {
        return settings["SanctuaryObjective"];
        vars.CompletedSplits.Add("SanctuaryObjective");
    }

    if(current.InfirmaryObjective && !old.InfirmaryObjective && !vars.CompletedSplits.Contains("InfirmaryObjective"))
    {
        return settings["InfirmaryObjective"];
        vars.CompletedSplits.Add("InfirmaryObjective");
    }

    if(current.SewersObjective && !old.SewersObjective && !vars.CompletedSplits.Contains("SewersObjective"))
    {
        return settings["SewersObjective"];
        vars.CompletedSplits.Add("SewersObjective");
    }

    if(current.SammysOfficeObjective && !old.SammysOfficeObjective && !vars.CompletedSplits.Contains("SammysOfficeObjective"))
    {
        return settings["SammysOfficeObjective"];
        vars.CompletedSplits.Add("SammysOfficeObjective");
    }

    //Chapter 3
    if(current.SqueakyToys && !old.SqueakyToys && !vars.CompletedSplits.Contains("SqueakyToys"))
    {
        return settings["SqueakyToys"];
        vars.CompletedSplits.Add("SqueakyToys");
    }

    if(current.AccountingRoom && !old.AccountingRoom && !vars.CompletedSplits.Contains("AccountingRoom"))
    {
        return settings["AccountingRoom"];
        vars.CompletedSplits.Add("AccountingRoom");
    }

    if(current.SafehouseObjective && !old.SafehouseObjective && !vars.CompletedSplits.Contains("SafehouseObjective"))
    {
        return settings["SafehouseObjective"];
        vars.CompletedSplits.Add("SafehouseObjective");
    }

    if(current.DarkHallwayObjective && !old.DarkHallwayObjective && !vars.CompletedSplits.Contains("DarkHallwayObjective"))
    {
        return settings["DarkHallwayObjective"];
        vars.CompletedSplits.Add("DarkHallwayObjective");
    }

    if(current.HeavenlyToysObjective && !old.HeavenlyToysObjective && !vars.CompletedSplits.Contains("HeavenlyToysObjective"))
    {
        return settings["HeavenlyToysObjective"];
        vars.CompletedSplits.Add("HeavenlyToysObjective");
    }

    if(current.AliceRevealObjective && !old.AliceRevealObjective && !vars.CompletedSplits.Contains("AliceRevealObjective"))
    {
        return settings["AliceRevealObjective"];
        vars.CompletedSplits.Add("AliceRevealObjective");
    }

    if(current.DecisionObjective && !old.DecisionObjective && !vars.CompletedSplits.Contains("DecisionObjective"))
    {
        return settings["DecisionObjective"];
        vars.CompletedSplits.Add("DecisionObjective");
    }

    if(current.BorisJumpscareObjective && !old.BorisJumpscareObjective && !vars.CompletedSplits.Contains("BorisJumpscareObjective"))
    {
        return settings["BorisJumpscareObjective"];
        vars.CompletedSplits.Add("BorisJumpscareObjective");
    }
    
    if(current.PosterPiperObjective && !old.PosterPiperObjective && !vars.CompletedSplits.Contains("PosterPiperObjective"))
    {
        return settings["PosterPiperObjective"];
        vars.CompletedSplits.Add("PosterPiperObjective");
    }
    
    if(current.EnterLiftObjective && !old.EnterLiftObjective && !vars.CompletedSplits.Contains("EnterLiftObjective"))
    {
        return settings["EnterLiftObjective"];
        vars.CompletedSplits.Add("EnterLiftObjective");
    }
    
    if(current.AliceLairObjective && !old.AliceLairObjective && !vars.CompletedSplits.Contains("AliceLairObjective"))
    {
        return settings["AliceLairObjective"];
        vars.CompletedSplits.Add("AliceLairObjective");
    }
    
    if(current.AliceTasksObjective && !old.AliceTasksObjective && !vars.CompletedSplits.Contains("AliceTasksObjective"))
    {
        return settings["AliceTasksObjective"];
        vars.CompletedSplits.Add("AliceTasksObjective");
    }
    
    if(current.GearTask && !old.GearTask && !vars.CompletedSplits.Contains("GearTask"))
    {
        return settings["GearTask"];
        vars.CompletedSplits.Add("GearTask");
    }
    
    if(current.ThickInkTask && !old.ThickInkTask && !vars.CompletedSplits.Contains("ThickInkTask"))
    {
        return settings["ThickInkTask"];
        vars.CompletedSplits.Add("ThickInkTask");
    }
    
    if(current.PowerCoreTask && !old.PowerCoreTask && !vars.CompletedSplits.Contains("PowerCoreTask"))
    {
        return settings["PowerCoreTask"];
        vars.CompletedSplits.Add("PowerCoreTask");
    }
    
    if(current.CutoutTask && !old.CutoutTask && !vars.CompletedSplits.Contains("CutoutTask"))
    {
        return settings["CutoutTask"];
        vars.CompletedSplits.Add("CutoutTask");
    }
    
    if(current.ButcherGangTask && !old.ButcherGangTask && !vars.CompletedSplits.Contains("ButcherGangTask"))
    {
        return settings["ButcherGangTask"];
        vars.CompletedSplits.Add("ButcherGangTask");
    }
    
    if(current.HeartTask && !old.HeartTask && !vars.CompletedSplits.Contains("HeartTask"))
    {
        return settings["HeartTask"];
        vars.CompletedSplits.Add("HeartTask");
    }

    //Chapter 4    
    if(current.AccountingObjective && !old.AccountingObjective && !vars.CompletedSplits.Contains("AccountingObjective"))
    {
        return settings["AccountingObjective"];
        vars.CompletedSplits.Add("AccountingObjective");
    }
    
    if(current.BridgeMachineObjective && !old.BridgeMachineObjective && !vars.CompletedSplits.Contains("BridgeMachineObjective"))
    {
        return settings["BridgeMachineObjective"];
        vars.CompletedSplits.Add("BridgeMachineObjective");
    }
    
    if(current.LostOnesObjective && !old.LostOnesObjective && !vars.CompletedSplits.Contains("LostOnesObjective"))
    {
        return settings["LostOnesObjective"];
        vars.CompletedSplits.Add("LostOnesObjective");
    }
    
    if(current.VentObjective && !old.VentObjective && !vars.CompletedSplits.Contains("VentObjective"))
    {
        return settings["VentObjective"];
        vars.CompletedSplits.Add("VentObjective");
    }
    
    if(current.MapRoomObjective && !old.MapRoomObjective && !vars.CompletedSplits.Contains("MapRoomObjective"))
    {
        return settings["MapRoomObjective"];
        vars.CompletedSplits.Add("MapRoomObjective");
    }

    if(current.WarehouseObjective && !old.WarehouseObjective && !vars.CompletedSplits.Contains("WarehouseObjective"))
    {
        return settings["WarehouseObjective"];
        vars.CompletedSplits.Add("WarehouseObjective");
    }
    
    if(current.FairGamesObjective && !old.FairGamesObjective && !vars.CompletedSplits.Contains("FairGamesObjective"))
    {
        return settings["FairGamesObjective"];
        vars.CompletedSplits.Add("FairGamesObjective");
    }

    if(current.ResearchObjective && !old.ResearchObjective && !vars.CompletedSplits.Contains("ResearchObjective"))
    {
        return settings["ResearchObjective"];
        vars.CompletedSplits.Add("ResearchObjective");
    }
    
    if(current.RideStorageObjective && !old.RideStorageObjective && !vars.CompletedSplits.Contains("RideStorageObjective"))
    {
        return settings["RideStorageObjective"];
        vars.CompletedSplits.Add("RideStorageObjective");
    }
    
    if(current.MaintenanceObjective && !old.MaintenanceObjective && !vars.CompletedSplits.Contains("MaintenanceObjective"))
    {
        return settings["MaintenanceObjective"];
        vars.CompletedSplits.Add("MaintenanceObjective");
    }
    
    if(current.HauntedHouseObjective && !old.HauntedHouseObjective && !vars.CompletedSplits.Contains("HauntedHouseObjective"))
    {
        return settings["HauntedHouseObjective"];
        vars.CompletedSplits.Add("HauntedHouseObjective");
    }

    //Chapter 5
    if(current.PipePuzzleBasic && !old.PipePuzzleBasic && !vars.CompletedSplits.Contains("PipePuzzleBasic"))
    {
        return settings["PipePuzzleBasic"];
        vars.CompletedSplits.Add("PipePuzzleBasic");
    }
    
    if(current.PipePuzzleCorner && !old.PipePuzzleCorner && !vars.CompletedSplits.Contains("PipePuzzleCorner"))
    {
        return settings["PipePuzzleCorner"];
        vars.CompletedSplits.Add("PipePuzzleCorner");
    }
    
    if(current.PipePuzzleThreeWay && !old.PipePuzzleThreeWay && !vars.CompletedSplits.Contains("PipePuzzleThreeWay"))
    {
        return settings["PipePuzzleThreeWay"];
        vars.CompletedSplits.Add("PipePuzzleThreeWay");
    }

    if(current.SafehouseObjective2 && !old.SafehouseObjective2 && !vars.CompletedSplits.Contains("SafehouseObjective2"))
    {
        return settings["SafehouseObjective2"];
        vars.CompletedSplits.Add("SafehouseObjective2");
    }
    
    if(current.CavesObjective && !old.CavesObjective && !vars.CompletedSplits.Contains("CavesObjective"))
    {
        return settings["CavesObjective"];
        vars.CompletedSplits.Add("CavesObjective");
    }
    
    if(current.DockObjective && !old.DockObjective && !vars.CompletedSplits.Contains("DockObjective"))
    {
        return settings["DockObjective"];
        vars.CompletedSplits.Add("DockObjective");
    }
    
    if(current.TunnelsObjective && !old.TunnelsObjective && !vars.CompletedSplits.Contains("TunnelsObjective"))
    {
        return settings["TunnelsObjective"];
        vars.CompletedSplits.Add("TunnelsObjective");
    }
    
    if(current.LostHarbourObjective && !old.LostHarbourObjective && !vars.CompletedSplits.Contains("LostHarbourObjective"))
    {
        return settings["LostHarbourObjective"];
        vars.CompletedSplits.Add("LostHarbourObjective");
    }
    
    if(current.AdministrationObjective && !old.AdministrationObjective && !vars.CompletedSplits.Contains("AdministrationObjective"))
    {
        return settings["AdministrationObjective"];
        vars.CompletedSplits.Add("AdministrationObjective");
    }
    
    if(current.VaultObjective && !old.VaultObjective && !vars.CompletedSplits.Contains("VaultObjective"))
    {
        return settings["VaultObjective"];
        vars.CompletedSplits.Add("VaultObjective");
    }
    
    if(current.GiantInkMachineObjective && !old.GiantInkMachineObjective && !vars.CompletedSplits.Contains("GiantInkMachineObjective"))
    {
        return settings["GiantInkMachineObjective"];
        vars.CompletedSplits.Add("GiantInkMachineObjective");
    }
    
    if(current.ThroneRoomObjective && !old.ThroneRoomObjective && !vars.CompletedSplits.Contains("ThroneRoomObjective"))
    {
        return settings["ThroneRoomObjective"];
        vars.CompletedSplits.Add("ThroneRoomObjective");
    }

    if(current.BendyArenaObjective && !old.BendyArenaObjective && !vars.CompletedSplits.Contains("BendyArenaObjective"))
    {
        return settings["BendyArenaObjective"];
        vars.CompletedSplits.Add("BendyArenaObjective");
    }
}

onStart
{
    vars.CompletedSplits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
