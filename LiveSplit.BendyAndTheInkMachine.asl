//Original ASL by Rythin
//Updated 2024 with asl-help by Streetbackguy
state("Bendy and the Ink Machine")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Bendy and the Ink Machine";
    vars.Helper.AlertLoadless();
    
    settings.Add("Chapter 1", true);
		settings.Add("CH1", true, "Chapter Splits", "Chapter 1");
			settings.Add("Inkwell", false, "Inkwell", "CH1");
			settings.Add("Doll", false, "Doll", "CH1");
			settings.Add("Record", false, "Record", "CH1");
			settings.Add("Book", false, "Book", "CH1");
			settings.Add("Wrench", false, "Wrench", "CH1");
			settings.Add("Gear", false, "Gear", "CH1");
			settings.Add("InkMachineRevealObjective", false, "InkMachineRevealObjective", "CH1");
			settings.Add("CollectablesObjective", false, "CollectablesObjective", "CH1");
			settings.Add("TheatreObjective", false, "TheatreObjective", "CH1");
			settings.Add("InkMachineObjective", false, "InkMachineObjective", "CH1");
			settings.Add("BendyChaseObjective", false, "BendyChaseObjective", "CH1");
			settings.Add("BasementObjective", false, "BasementObjective", "CH1");
		settings.Add("ch1", true, "Chapter Completion", "Chapter 1");
	settings.Add("Chapter 2", true);
		settings.Add("CH2", true, "Chapter Splits", "Chapter 2");
			settings.Add("RitualObjective", false, "RitualObjective", "CH2");
			settings.Add("GateObjective", false, "GateObjective", "CH2");
			settings.Add("MusicDepartmentObjective", false, "MusicDepartmentObjective", "CH2");
			settings.Add("LostKeysObjective", false, "LostKeysObjective", "CH2");
			settings.Add("MusicPuzzleObjective", false, "MusicPuzzleObjective", "CH2");
			settings.Add("SanctuaryObjective", false, "SanctuaryObjective", "CH2");
			settings.Add("InfirmaryObjective", false, "InfirmaryObjective", "CH2");
			settings.Add("SewersObjective", false, "SewersObjective", "CH2");
			settings.Add("SammysOfficeObjective", false, "SammysOfficeObjective", "CH2");
		settings.Add("ch2", true, "Chapter Completion");
	settings.Add("Chapter 3", true);
		settings.Add("CH3", true, "Chapter Splits", "Chapter 3");
			settings.Add("SqueakyToys", false, "SqueakyToys", "CH3");
			settings.Add("AccountingRoom", false, "AccountingRoom", "CH3");
			settings.Add("SafehouseObjective", false, "SafehouseObjective", "CH3");
			settings.Add("DarkHallwayObjective", false, "DarkHallwaysObjective", "CH3");
			settings.Add("HeavenlyToysObjective", false, "HeavenlyToysObjective", "CH3");
			settings.Add("AliceRevealObjective", false, "AliceRevealObjective", "CH3");
			settings.Add("DecisionObjective", false, "DecisionObjective", "CH3");
			settings.Add("BorisJumpscareObjective", false, "BorisJumpscareObjective", "CH3");
			settings.Add("PosterPiperObjective", false, "PosterPiperObjective", "CH3");
			settings.Add("EnterLiftObjective", false, "EnterLiftObjective", "CH3");
			settings.Add("AliceLairObjective", false, "AliceLairObjective", "CH3");
			settings.Add("AliceTasksObjective", false, "AliceTasksObjective", "CH3");
			settings.Add("GearTask", false, "GearTask", "CH3");
			settings.Add("ThickInkTask", false, "ThickInkTask", "CH3");
			settings.Add("PowerCoreTask", false, "PowerCoreTask", "CH3");
			settings.Add("CutoutTask", false, "CutoutTask", "CH3");
			settings.Add("ButcherGangTask", false, "ButcherGangTask", "CH3");
			settings.Add("HeartTask", false, "HeartTask", "CH3");
		settings.Add("ch3", true, "Chapter Completion");
	settings.Add("Chapter 4", true);
		settings.Add("CH4", true, "Chapter Splits", "Chapter 4");
			settings.Add("AccountingObjective", false, "AccountingObjective", "CH4");
			settings.Add("BridgeMachineObjective", false, "BridgeMachineObjective", "CH4");
			settings.Add("LostOnesObjective", false, "LostOnesObjective", "CH4");
			settings.Add("VentObjective", false, "VentObjective", "CH4");
			settings.Add("MapRoomObjective", false, "MapRoomObjective", "CH4");
			settings.Add("WarehouseObjective", false, "WarehouseObjective", "CH4");
			settings.Add("FairGamesObjective", false, "FairGamesObjective", "CH4");
			settings.Add("ResearchObjective", false, "ResearchObjective", "CH4");
			settings.Add("RideStorageObjective", false, "RideStorageObjective", "CH4");
			settings.Add("MaintenanceObjective", false, "MaintenanceObjective", "CH4");
			settings.Add("HauntedHouseObjective", false, "HauntedHouseObjective", "CH4");
		settings.Add("ch4", true, "Chapter Completion");
	settings.Add("Chapter 5", true);
		settings.Add("CH5", true, "Chapter Splits", "Chapter 5");
			settings.Add("PipePuzzleBasic", false, "PipePuzzleBasic", "CH5");
			settings.Add("PipePuzzleCorner", false, "PipePuzzleCorner", "CH5");
			settings.Add("PipePuzzleThreeWay", false, "PipePuzzleThreeWay", "CH5");
			settings.Add("SafehouseObjective2", false, "SafehouseObjective", "CH5");
			settings.Add("CavesObjective", false, "CavesObjective", "CH5");
			settings.Add("DockObjective", false, "DockObjective", "CH5");
			settings.Add("TunnelsObjective", false, "TunnelsObjective", "CH5");
			settings.Add("LostHarbourObjective", false, "LostHarbourObjective", "CH5");
			settings.Add("AdministrationObjective", false, "AdministrationObjective", "CH5");
			settings.Add("VaultObjective", false, "VaultObjective", "CH5");
			settings.Add("GiantInkMachineObjective", false, "GiantInkMachineObjective", "CH5");
			settings.Add("ThroneRoomObjective", false, "ThroneRoomObjective", "CH5");
			settings.Add("BendyArena", false, "BendyArena", "CH5");
		settings.Add("ch5", true, "Chapter Completion");
}

init
{	
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        //Current Chapter ID
        vars.Helper["Chapters"] = mono.Make<int>("GameManager", "m_Instance", "CurrentChapter", "m_Chapter");

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
        vars.Helper["GearTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "GearTask", 0x18, 0x10);
        vars.Helper["ThickInkTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "ThickInkTask", 0x18, 0x10);
        vars.Helper["PowerCoreTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "PowerCoreTask", 0x18, 0x10);
        vars.Helper["CutoutTask"] = mono.Make<bool>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "CH3Data", "CutoutTask", 0x18, 0x10);
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

        vars.CheckWatcher = (Func<string, bool>)(watcher =>
        {
            if(!vars.Helper[watcher].Old && vars.Helper[watcher].Current && !vars.CompletedSplits.Contains(watcher))
            {
                vars.CompletedSplits.Add(watcher);
                return settings[watcher];
                print(watcher + "has split!");
            }
            return false;
        });

        return true;
    });

    vars.CompletedSplits = new HashSet<string>();
}

update
{
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

split 
{
	if(current.Chapters == old.Chapters + 1)
    {
		return settings["ch" + old.Chapters];
        vars.CompletedSplits.Add("ch" + old.Chapters);
	}

    //Chapter 1
    if (vars.CheckWatcher("Inkwell")) return true;
    if (vars.CheckWatcher("Doll")) return true;
    if (vars.CheckWatcher("Record")) return true;
    if (vars.CheckWatcher("Book")) return true;
    if (vars.CheckWatcher("Wrench")) return true;
    if (vars.CheckWatcher("Gear")) return true;
    if (vars.CheckWatcher("InkMachineRevealObjective")) return true;
    if (vars.CheckWatcher("CollectablesObjective")) return true;
    if (vars.CheckWatcher("TheatreObjective")) return true;
    if (vars.CheckWatcher("InkMachineObjective")) return true;
    if (vars.CheckWatcher("BendyChaseObjective")) return true;
    if (vars.CheckWatcher("BasementObjective")) return true;

    //Chapter 2
    if (vars.CheckWatcher("RitualObjective")) return true;
    if (vars.CheckWatcher("GateObjective")) return true;
    if (vars.CheckWatcher("MusicDepartmentObjective")) return true;
    if (vars.CheckWatcher("LostKeysObjective")) return true;
    if (vars.CheckWatcher("MusicPuzzleObjective")) return true;
    if (vars.CheckWatcher("SanctuaryObjective")) return true;
    if (vars.CheckWatcher("InfirmaryObjective")) return true;
    if (vars.CheckWatcher("SewersObjective")) return true;
    if (vars.CheckWatcher("SammysOfficeObjective")) return true;

    //Chapter 3
    if (vars.CheckWatcher("SqueakyToys")) return true;
    if (vars.CheckWatcher("AccountingRoom")) return true;
    if (vars.CheckWatcher("SafehouseObjective")) return true;
    if (vars.CheckWatcher("DarkHallwayObjective")) return true;
    if (vars.CheckWatcher("HeavenlyToysObjective")) return true;
    if (vars.CheckWatcher("AliceRevealObjective")) return true;
    if (vars.CheckWatcher("DecisionObjective")) return true;
    if (vars.CheckWatcher("BorisJumpscareObjective")) return true;
    if (vars.CheckWatcher("PosterPiperObjective")) return true;
    if (vars.CheckWatcher("EnterLiftObjective")) return true;
    if (vars.CheckWatcher("AliceLairObjective")) return true;
    if (vars.CheckWatcher("AliceTasksObjective")) return true;
    if (vars.CheckWatcher("GearTask")) return true;
    if (vars.CheckWatcher("ThickInkTask")) return true;
    if (vars.CheckWatcher("PowerCoreTask")) return true;
    if (vars.CheckWatcher("CutoutTask")) return true;
    if (vars.CheckWatcher("ButcherGangTask")) return true;
    if (vars.CheckWatcher("HeartTask")) return true;

    //Chapter 4    
    if (vars.CheckWatcher("AccountingObjective")) return true;
    if (vars.CheckWatcher("BridgeMachineObjective")) return true;
    if (vars.CheckWatcher("LostOnesObjective")) return true;
    if (vars.CheckWatcher("VentObjective")) return true;
    if (vars.CheckWatcher("MapRoomObjective")) return true;
    if (vars.CheckWatcher("WarehouseObjective")) return true;
    if (vars.CheckWatcher("FairGamesObjective")) return true;
    if (vars.CheckWatcher("ResearchObjective")) return true;
    if (vars.CheckWatcher("RideStorageObjective")) return true;
    if (vars.CheckWatcher("MaintenanceObjective")) return true;
    if (vars.CheckWatcher("HauntedHouseObjective")) return true;

    //Chapter 5
    if (vars.CheckWatcher("PipePuzzleBasic")) return true;
    if (vars.CheckWatcher("PipePuzzleCorner")) return true;
    if (vars.CheckWatcher("PipePuzzleThreeWay")) return true;
    if (vars.CheckWatcher("SafehouseObjective2")) return true;
    if (vars.CheckWatcher("CavesObjective")) return true;
    if (vars.CheckWatcher("DockObjective")) return true;
    if (vars.CheckWatcher("TunnelsObjective")) return true;
    if (vars.CheckWatcher("LostHarbourObjective")) return true;
    if (vars.CheckWatcher("AdministrationObjective")) return true;
    if (vars.CheckWatcher("VaultObjective")) return true;
    if (vars.CheckWatcher("GiantInkMachineObjective")) return true;
    if (vars.CheckWatcher("ThroneRoomObjective")) return true;
    if (vars.CheckWatcher("BendyArenaObjective")) return true;
}

onStart
{
    vars.CompletedSplits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
