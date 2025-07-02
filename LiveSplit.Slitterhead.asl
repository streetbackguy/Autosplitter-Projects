state("YKS-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    vars.Helper.Settings.CreateFromXml("Components/Slitterhead.Settings.xml");
	vars.Helper.GameName = "Slitterhead";
	vars.Helper.AlertLoadless();

    vars.CompletedSplits = new HashSet<string>();
}

init
{
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

    // GEngine.GameInstance.LocalPlayers[0].PlayerController.IsPaused
    vars.Helper["IsPaused"] = vars.Helper.Make<bool>(gEngine, 0xFC0, 0x38, 0x0, 0x30, 0xC40);

    // GEngine.GameInstance.LocalPlayers[0].PlayerController.PosessionComponent.Is Event
    vars.Helper["IsEventPossession"] = vars.Helper.Make<bool>(gEngine, 0xFC0, 0x38, 0x0, 0x30, 0xC60, 0x281);

    // GEngine.GameInstance.LocalPlayers[0].PlayerController.MyHUD.InGameLoadingScreen
    // vars.Helper["InGameLoadingScreen"] = vars.Helper.Make<int>(gEngine, 0xFC0, 0x38, 0x0, 0x30, 0x348, 0x5C0, 0x2E8);

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

    if(current.World != old.World)
    {
        vars.Log(old.World + " -> " + current.World);
    }
}

start
{
    return old.World == "Title" && current.World != "Title";
}

onStart
{
    vars.CompletedSplits.Clear();
    current.World = "";
}

split
{
    if(current.World == "PL_InterMission" && old.World != "PL_InterMission" && !vars.CompletedSplits.Contains(old.World))
    {
        return settings[old.World] && vars.CompletedSplits.Add(old.World);
    }

    if(current.World == "PL_AL04v2" && current.IsEventPossession && !vars.CompletedSplits.Contains("PL_AL04v2"))
    {
        return settings["PL_AL04v2"] && vars.CompletedSplits.Add("PL_AL04v2");
    }
}

isLoading
{
    return current.GSync && !old.IsPaused || current.IsPaused;
}

reset
{
    return current.World == "Title" && old.World != "Title";
}

exit
{
    timer.IsGameTimePaused = true;
}