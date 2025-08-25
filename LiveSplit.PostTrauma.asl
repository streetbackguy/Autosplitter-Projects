state("UE5_PostTrauma-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    vars.Helper.GameName = "Post Trauma";

    settings.Add("PT", true, "Post Trauma");
        settings.Add("LC", true, "Level Completion Splits", "PT");
            settings.Add("Act_01_02", true, "Train Station", "PT");
            settings.Add("Act_02_01_PoliceStation", true, "Police Station", "PT");
            settings.Add("Act_02_02", true, "Hospital", "PT");
            settings.Add("Act_02_01_PoliceStation_Part_3", true, "Police Station Part 2", "PT");
            settings.Add("Act_03_01_School", true, "School", "PT");
            settings.Add("Act_03_01_School_Garden", true, "School Garden", "PT");
            settings.Add("JillTrain", true, "Train Cutscene", "PT");
            settings.Add("Act_03_01_SchoolMaze", true, "School Maze", "PT");
            settings.Add("Act_03_04_Maze", true, "Ruins Maze", "PT");
            settings.Add("Act_04_01_MetroReturn", true, "Return to Train Station", "PT");
            settings.Add("Act_05_01_CityExterior_Blockout", true, "City", "PT");

}

init
{
    vars.CompletedSplits = new HashSet<string>();

    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 1D ???????? 48 85 DB 74 ?? 41 B0 01");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ???????? 66 0F 5A C9 E8");
	IntPtr fNames = vars.Helper.ScanRel(7, "8B D9 74 ?? 48 8D 15 ???????? EB");
    IntPtr gSyncLoadCount = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    // GWorld.FName
    vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSyncLoadCount);

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

    current.World = "";
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();

    var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;
}

start
{
    return current.World == "MainMenu_Prologue" && old.World == "MainMenu";
}

split
{
    if(current.World != old.World && !vars.CompletedSplits.Contains(old.World))
    {
        return settings[old.World] && vars.CompletedSplits.Add(old.World);
    }
}

onStart
{
    vars.CompletedSplits.Clear();
}

reset
{

}

isLoading
{
    return current.GSync;
}

exit
{
    timer.IsGameTimePaused = true;

}
