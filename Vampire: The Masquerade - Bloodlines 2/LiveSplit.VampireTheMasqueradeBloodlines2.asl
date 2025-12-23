state("Bloodlines2-Win64-Shipping"){}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "Vampire the Masquerain: Bloodlines 2";
	vars.Helper.AlertLoadless();
}

init
{
	IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 1D ???????? 48 85 DB 74 ?? 41 B0 01");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ???????? 66 0F 5A C9 E8");
	IntPtr fNames = vars.Helper.ScanRel(7, "8B D9 74 ?? 48 8D 15 ???????? EB");
    IntPtr gSync = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

	if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
		throw new Exception("Not all required addresses could be found by scanning.");

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

	vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    vars.Helper["GameState"] = vars.Helper.Make<ulong>(gWorld, 0x158, 0x2F0);
    // GEngine -> GameInstance -> Subsystems(0x108) -> LoadingScreenManager
    vars.Helper["LoadingScreenManager"] = vars.Helper.Make<byte>(gEngine, 0x1080, 0x108, 0x80, 0xE8);
    vars.Helper["InCutscene"] = vars.Helper.Make<bool>(gEngine, 0x1080, 0x38, 0x0, 0x30, 0x340, 0x969);
    vars.Helper["InDialogue"] = vars.Helper.Make<bool>(gEngine, 0x1080, 0x38, 0x0, 0x30, 0x340, 0x968);
	vars.Helper["GSync"] = vars.Helper.Make<bool>(gSync);

	current.World = "";
    current.State = "";
}

start
{
    return current.World == "LV_RE_Pro_Escape" && old.World == "FrontEndSelection";
}

onStart
{
	vars.CompletedSplits.Clear();
	timer.IsGameTimePaused = true;
}

update
{
	vars.Helper.Update();
	vars.Helper.MapPointers();

	string world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None") current.World = world;
	if (old.World != current.World) vars.Log("/// World Log: " + current.World);

    string state = vars.FNameToString(current.GameState);
	if (!string.IsNullOrEmpty(state) && state != "None") current.State = state;
	if (old.State != current.State) vars.Log("/// State Log: " + current.State);
}

isLoading
{
	return current.GSync || current.State != "InProgress" || current.LoadingScreenManager == 0 || current.InCutscene && current.World != "LV_RE_Pro_Escape";
}

reset
{
    return current.World == "FrontEndSelection" && old.World != "FrontEndSelection";
}

exit
{
	timer.IsGameTimePaused = true;
}
