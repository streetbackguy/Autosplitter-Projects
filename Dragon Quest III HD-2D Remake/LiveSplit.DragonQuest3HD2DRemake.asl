state("DQIIIHD2DRemake")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "Dragon Quest III HD-2D Remake";
	vars.Helper.AlertLoadless();
}

init
{
    var exe = modules.First();

    if (File.Exists(Path.Combine(Path.GetDirectoryName(exe.FileName), "Binaries", "Win64", "DQIIIHD2DRemake.exe")))
    {
        var allComponents = timer.Layout.Components;
        // Grab the autosplitter from splits
        if (timer.Run.AutoSplitter != null && timer.Run.AutoSplitter.Component != null)
        {
            allComponents = allComponents.Append(timer.Run.AutoSplitter.Component);
        }
        foreach (var component in allComponents) 
        {
            var type = component.GetType();
            if (type.Name == "ASLComponent") 
            {
                // Could also check script path, but renaming the script breaks that, and
                //  running multiple autosplitters at once is already just asking for problems
                var script = type.GetProperty("Script").GetValue(component);
                script.GetType().GetField(
                    "_game",
                    BindingFlags.NonPublic | BindingFlags.Instance
                ).SetValue(script, null);
            }
        }
        return;
    }

    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 3B C? 48 0F 44 C? 48 89 05 ???????? E8");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 89 05 ???????? 48 85 c9 74 ?? e8 ???????? 48 8d 4d");
	IntPtr fNames = vars.Helper.ScanRel(3, "48 8d 05 ???????? eb ?? 48 8d 0d ???????? e8 ???????? c6 05");
    IntPtr gSync = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    // GWorld.Name
	vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSync);
    vars.Helper["CurrentLevelPendingVisibility"] = vars.Helper.Make<int>(gWorld, 0xD0);
    vars.Helper["CurrentLevelPendingVisibility"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    vars.Helper["MovementMode"] = vars.Helper.Make<byte>(gEngine, 0xD48, 0x38, 0x0, 0x30, 0x2A0, 0x288, 0x168);
    vars.Helper["BattleManager"] = vars.Helper.Make<int>(gEngine, 0xD48, 0x418, 0x7C8, 0x50);

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

	vars.FNameToShortString = (Func<ulong, string>)(fName =>
	{
		string name = vars.FNameToString(fName);

		int dot = name.LastIndexOf('.');
		int slash = name.LastIndexOf('/');

		return name.Substring(Math.Max(dot, slash) + 1);
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
    return current.GSync || current.MovementMode == 3 || current.CurrentLevelPendingVisibility != 0 || current.BattleManager == 1;
}

exit
{
	timer.IsGameTimePaused = true;
}
