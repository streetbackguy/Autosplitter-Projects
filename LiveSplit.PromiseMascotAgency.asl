state("MM-Win64-Shipping")
{

}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");

    settings.Add("PMA", true, "Promise Mascot Agency");
        settings.Add("AL", true, "Agency Fame Level Splits", "PMA");
            settings.Add("1", false, "Agency Fame Level 2", "AL");
            settings.Add("2", false, "Agency Fame Level 3", "AL");
            settings.Add("3", false, "Agency Fame Level 4", "AL");
            settings.Add("4", false, "Agency Fame Level 5", "AL");
            settings.Add("5", false, "Agency Fame Level 6", "AL");
            settings.Add("6", false, "Agency Fame Level 7", "AL");
            settings.Add("7", false, "Agency Fame Level 8", "AL");
            settings.Add("8", false, "Agency Fame Level 9", "AL");
            settings.Add("9", false, "Agency Fame Level 10", "AL");
            settings.Add("10", false, "Agency Fame Level 11", "AL");
            settings.Add("11", false, "Agency Fame Level 12", "AL");
            settings.Add("12", false, "Agency Fame Level 13", "AL");
            settings.Add("13", false, "Agency Fame Level 14", "AL");
            settings.Add("14", false, "Agency Fame Level 15", "AL");
            settings.Add("15", false, "Agency Fame Level 16", "AL");
            settings.Add("16", false, "Agency Fame Level 17", "AL");
            settings.Add("17", false, "Agency Fame Level 18", "AL");
            settings.Add("18", false, "Agency Fame Level 19", "AL");
            settings.Add("19", false, "Agency Fame Level 20", "AL");
            settings.Add("20", false, "Agency Fame Level 21", "AL");
            settings.Add("21", false, "Agency Fame Level 22", "AL");
            settings.Add("22", false, "Agency Fame Level 23", "AL");
            settings.Add("23", false, "Agency Fame Level 24", "AL");
            settings.Add("24", false, "Agency Fame Level 25", "AL");
            settings.Add("25", false, "Agency Fame Level 26", "AL");
            settings.Add("26", false, "Agency Fame Level 27", "AL");
            settings.Add("27", false, "Agency Fame Level 28", "AL");
            settings.Add("28", false, "Agency Fame Level 29", "AL");
            settings.Add("29", false, "Agency Fame Level 30", "AL");
}

init
{
    IntPtr gEngine = vars.Helper.ScanRel(3, "48 39 35 ?? ?? ?? ?? 0F 85 ?? ?? ?? ?? 48 8B 0D");
    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 3B C? 48 0F 44 C? 48 89 05 ???????? E8");
    IntPtr namePoolData = vars.Helper.ScanRel(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15");
    IntPtr gSyncLoadCount = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gEngine == IntPtr.Zero || gEngine == IntPtr.Zero || namePoolData == IntPtr.Zero || gSyncLoadCount == IntPtr.Zero)
    {
        throw new InvalidOperationException(
            "Not all required addresses found. Retrying.");
    }

    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSyncLoadCount);

    // GWorld.Name
    vars.Helper["Level"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.Pawn.KaizenPlayerRespawn.RespawnState
    vars.Helper["RespawnFade"] = vars.Helper.Make<int>(gEngine, 0xD48, 0x38, 0x0, 0x30, 0x250, 0x1040, 0x120);

    // GEngine.GameViewport.World.PersistentLevel.LevelScriptActor.LoadingFade.bIsActive
    vars.Helper["LoadingScreenFade"] = vars.Helper.Make<bool>(gEngine, 0x7A0, 0x78, 0x30, 0xE8, 0x230, 0x26B);

	// GEngine.GameViewport.World.CurrentLevelPendingVisibility
    vars.Helper["Fades"] = vars.Helper.Make<bool>(gEngine, 0x7A0, 0x78, 0xD0, 0x0);

    // GEngine.GameInstance.AgencySimulationManager.LevelingTable.CurrentLevel
    vars.Helper["AgencyLevel"] = vars.Helper.Make<int>(gEngine, 0xD48, 0xF0, 0x98, 0x88, 0xA8);

    vars.FNameToString = (Func<ulong, string>)(fName =>
	{
		var nameIdx = (fName & 0x000000000000FFFF) >> 0x00;
		var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
		var number = (fName & 0xFFFFFFFF00000000) >> 0x20;

		IntPtr chunk = vars.Helper.Read<IntPtr>(namePoolData + 0x10 + (int)chunkIdx * 0x8);
		IntPtr entry = chunk + (int)nameIdx * sizeof(short);

		int length = vars.Helper.Read<short>(entry) >> 6;
		string name = vars.Helper.ReadString(length, ReadStringType.UTF8, entry + sizeof(short));

		return number == 0 ? name : name + "_" + number;
	});

	vars.FNameToShortString = (Func<ulong, string>)(fName =>
	{
		string name = vars.FNameToString(fName);

		int dot = name.LastIndexOf('.');
		int slash = name.LastIndexOf('/');

		return name.Substring(Math.Max(dot, slash) + 1);
	});

	current.World = "";
    vars.CompletedSplits = new HashSet<string>();
}

update
{
    vars.Helper.Update();
    vars.Helper.MapPointers();

    var world = vars.FNameToString(current.Level);
	if (!string.IsNullOrEmpty(world) && world != "None")
        current.World = world;

    // vars.Log("Level: " + current.AgencyLevel);
}

start
{
    return current.World != "MainMenu" && old.World == "MainMenu";
}

split
{
    if(current.AgencyLevel != old.AgencyLevel && !vars.CompletedSplits.Contains(current.AgencyLevel.ToString()))
    {
        return settings[current.AgencyLevel.ToString()] && vars.CompletedSplits.Add(current.AgencyLevel.ToString());
    }
}

onStart
{
    vars.CompletedSplits.Clear();
}

isLoading
{
    return current.LoadingScreenFade || current.RespawnFade != 0 || current.Fades;
}

exit
{
    timer.IsGameTimePaused = true;
}




