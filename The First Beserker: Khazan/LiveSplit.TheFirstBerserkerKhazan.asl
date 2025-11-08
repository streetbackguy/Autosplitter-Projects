state("BBQ-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "The First Berserker: Khazan";
	vars.Helper.AlertLoadless();

    vars.CompletedSplits = new HashSet<string>();
}

init
{
    IntPtr gWorld = vars.Helper.ScanRel(8, "0F 2E ?? 74 ?? 48 8B 1D ?? ?? ?? ?? 48 85 DB 74");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ?? ?? ?? ?? 48 85 C9 74 ?? E8");
	IntPtr fNames = vars.Helper.ScanRel(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		string Msg = "Not all required addresses could be found by scanning.\nGWorld: " + gWorld + "\nGEngine: " + gEngine + "\nFNames: " + fNames;
		throw new Exception(Msg);
	}

    // GWorld.FName
    vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    // GWorld.StreamingLevelsToConsider.ArrayNum
    vars.Helper["StreamingLevelsToConsider"] = vars.Helper.Make<int>(gWorld, 0xA0);

    // GWorld.CurrentLevelPendingVisibility
    vars.Helper["CurrentLevelPendingVisibility"] = vars.Helper.Make<int>(gWorld, 0x100);
    vars.Helper["CurrentLevelPendingVisibility"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    // xxGameEngine.GameInstance.LocalPlayers[0].PlayerController.AcknowledgedPawn.bBindingLevelSequence
    vars.Helper["BindingLevelSequence"] = vars.Helper.Make<bool>(gEngine, 0xD78, 0x38, 0x0, 0x30, 0x2C0, 0x14C9);

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
	if (old.World != current.World) vars.Log("GWorldName: " + current.World.ToString());
}

isLoading
{
    return current.BindingLevelSequence || current.StreamingLevelsToConsider != 0 || current.World == "LB_LobbyLevel" || current.CurrentLevelPendingVisibility != 0;
}

start
{
    return !current.BindingLevelSequence && current.World == "HeinMach_All" && old.BindingLevelSequence;
}

exit
{
    timer.IsGameTimePaused = true;
}

// Useful paths:
// xxGameEngine.GameInstance.LocalPlayers[0].PlayerController.AcknowledgedPawn.Equips
