//Original ASL by Streetbackguy. Unreal Engine coding updated by Kuno Demetries. Version 2 by Streetbackguy.
state("Monke-Win64-Shipping", "Steam 1.0")
{
}
state("Monke-Win64-Shipping", "Steam 1.1")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    vars.Helper.GameName = "Skull Island: Rise of Kong";
	vars.Helper.AlertLoadless();

    settings.Add("KONG", true, "Skull Island: Rise of Kong");
        settings.Add("SPLITS", true, "Game Splits", "KONG");
            settings.Add("Tutorial", false, "Split on final hit from Gaw in the Tutorial", "SPLITS");
            settings.Add("Worm", false, "Split on final hit on Gijja", "SPLITS");
            settings.Add("Wetlands", false, "Split on exiting to the Wetlands", "SPLITS");
            settings.Add("Crab", false, "Split on final hit on King Dengiz", "SPLITS");
            settings.Add("Jungle", false, "Split on exiting to the Dark Jungle", "SPLITS");
            settings.Add("Raptors", false, "Split on final hit on the Three Deathrunner Raptors", "SPLITS");
            settings.Add("Caverns", false, "Split on exiting to the Great Caverns", "SPLITS");
            settings.Add("Spider", false, "Split on final hit on Queen Oyoq", "SPLITS");
            settings.Add("Wasteland", false, "Split on exiting to the Wasteland", "SPLITS");
            settings.Add("Gaw", false, "Split on final hit to Gaw", "SPLITS");
}

init
{
    vars.Splits = new HashSet<string>();
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
    {
        case "6078F5B401713C903662F9F71B1FD613": version = "Steam 1.0"; break;
        case "65C4BBF8765B9012F40F9386F7E90B49": version = "Steam 1.1"; break;
        default: version = "Unknown"; break;
    }

    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 0F 1F 84 ?????????? 49 8B 0C D1");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ???????? 48 8B D3 E8 ????????");
	IntPtr fNames = vars.Helper.ScanRel(3, "48 8D 0D ???????? E8 ???????? C6 05 ?????????? 0F 10 07");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    vars.FNameToString = (Func<ulong, string>)(fName =>
	{
		var nameIdx = (fName & 0x000000000000FFFF) >> 0x00;
		var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
		var number = (fName & 0xFFFFFFFF00000000) >> 0x20;

		IntPtr chunk = vars.Helper.Read<IntPtr>(fNames + 0x10 + (int)chunkIdx * 0x8);
		IntPtr entry = chunk + (int)nameIdx * sizeof(short);

		int length = vars.Helper.Read<short>(entry) >> 6;
		string name = vars.Helper.ReadString(length, ReadStringType.UTF8, entry + sizeof(short));

		return number == 0 ? name : name + "_" + number;
	});

	vars.GEngine = gEngine;
	
    vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    // KongGameEngine.GameInstance.Subsystems(0x108).LoadingScreenManager
    vars.Helper["Loads"] = vars.Helper.Make<bool>(gEngine, 0xFC0, 0x108, 0x20, 0x50);

    // KongGameEngine.GameInstance.BP_GameInstance_C.MainMenu.bIsActive
	vars.Helper["MainMenuActive"] = vars.Helper.Make<bool>(gEngine, 0xFC0, 0x270, 0x310);

    // KongGameEngine.GameInstance.Subsystems(0x108).SequenceSubsystem.MainSequencePlayer.Sequence.Name
    vars.Helper["Sequence"] = vars.Helper.Make<ulong>(gEngine, 0xFC0, 0x108, 0x170, 0x30, 0x290, 0x18);
    vars.Helper["Sequence"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    current.World = "";
    current.Cutscene = "";

    // print("Gworld: " + gWorld.ToString("X"));
    // print("Gengine: " + gEngine.ToString("X"));
    // print("Fnames: " + fNames.ToString("X"));
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();

    string world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None") current.World = world;

    string cutscene = vars.FNameToString(current.Sequence);
	if (!string.IsNullOrEmpty(cutscene) && cutscene != "None") current.Cutscene = cutscene;

    print("World: " + current.World.ToString());
    // print("Sequence: " + current.Cutscene.ToString());
}

isLoading
{
    return current.Loads;
}

start
{
    return old.World == "MainMenu_SkullIsland" && current.World == "Stage_0_Intro" && !current.MainMenuActive;
}

split
{
    if(current.World == "Stage_1" && current.Cutscene == "Seq_0_04" && old.Cutscene != "Seq_0_04_OmegaDeath" && !vars.Splits.Contains("Tutorial"))
    {
        print("Tutorial Split");
        vars.Splits.Add("Tutorial");
        return settings["Tutorial"];
    }

    if(current.World == "Stage_2" && current.Cutscene == "Seq_1_04" && old.Cutscene != "Seq_1_04" && !vars.Splits.Contains("Worm"))
    {
        print("Worm Split");
        vars.Splits.Add("Worm");
        return settings["Worm"];
    }

    if(current.World == "Stage3_Intro" && old.World != "Stage3_Intro" && !vars.Splits.Contains("Wetlands"))
    {
        print("Wetlands Split");
        vars.Splits.Add("Wetlands");
        return settings["Wetlands"];
    }

    if(current.World == "Stage_3" && current.Cutscene == "Seq_2_04" && old.Cutscene != "Seq_2_04" && !vars.Splits.Contains("Crab"))
    {
        print("Crab Split");
        vars.Splits.Add("Crab");
        return settings["Crab"];
    }

    if(current.World == "Stage_4" && old.World != "Stage_4" && !vars.Splits.Contains("Jungle"))
    {
        print("Jungle Split");
        vars.Splits.Add("Jungle");
        return settings["Jungle"];
    }

    if(current.World == "Stage_4" && current.Cutscene == "Seq_3_SC03_OmegaDeath" && old.Cutscene != "Seq_3_SC03_OmegaDeath" && !vars.Splits.Contains("Raptors"))
    {
        print("Raptors Split");
        vars.Splits.Add("Raptors");
        return settings["Raptors"];
    }

    if(current.World == "Stage5_Intro" && old.World != "Stage5_Intro" && !vars.Splits.Contains("Caverns"))
    {
        vars.Splits.Add("Caverns");
        return settings["Caverns"];
        print("Caverns Split");
    }

    if(current.World == "Stage_5" && current.Cutscene == "Seq_4_03" && old.Cutscene != "Seq_4_03" && !vars.Splits.Contains("Spider"))
    {
        print("Spider Split");
        vars.Splits.Add("Spider");
        return settings["Spider"];
    }

    if(current.World == "Stage6_Intro" && old.World != "Stage6_Intro" && !vars.Splits.Contains("Wasteland"))
    {
        print("Wasteland Split");
        vars.Splits.Add("Wasteland");
        return settings["Wasteland"];
    }

    if(current.World == "Stage_6" && current.Cutscene == "Seq_5_03" && old.Cutscene != "Seq_5_03" && !vars.Splits.Contains("Gaw"))
    {
        print("Gaw Split");
        vars.Splits.Add("Gaw");
        return settings["Gaw"];
    }
}

onStart
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}

reset
{
    return current.World == "MainMenu_SkullIsland" && current.MainMenuActive;
}

exit
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}

