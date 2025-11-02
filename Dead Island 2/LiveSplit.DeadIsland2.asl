state("DeadIsland-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "Dead Island 2";
	vars.Helper.AlertLoadless();
}

init
{
    IntPtr gWorld = vars.Helper.ScanRel(8, "0F 2E ?? 74 ?? 48 8B 1D ?? ?? ?? ?? 48 85 DB 74");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 89 05 ?? ?? ?? ?? 48 85 c9 74 ?? e8 ?? ?? ?? ?? 48 8d 4d");
	IntPtr fNames = vars.Helper.ScanRel(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15");
    IntPtr gSync = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    // GWorld.Name
	vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSync);

    vars.Helper["ActiveMission"] = vars.Helper.MakeString(gEngine, 0xEA8, 0x6F8, 0xE8, 0x0, 0x78, 0x28, 0x28, 0x0);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.AcknowledgedPawn.PlayerMovementComponent.MovementMode
    vars.Helper["InCutscene"] = vars.Helper.Make<byte>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2D8, 0x1280, 0x1A4);

    // GEngine.GameInstance.MasterHUDFader
    vars.Helper["HUDFades"] = vars.Helper.Make<int>(gEngine, 0xEA8, 0x3F8, 0x58);

    // GEngine.GameInstance.ActiveMissions[0].MissionData.Count
    vars.Helper["ActiveMissionCount"] = vars.Helper.Make<int>(gEngine, 0xEA8, 0x6F8, 0xF4);

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
    current.Mission = "";
    vars.Splits = new HashSet<string>();
    vars.gEngine = gEngine;
}

start
{
    return current.ActiveMission == "MQ01 (WIP) DEATH FLIGHT 71" && old.InCutscene == 5 && current.InCutscene == 1;
}

onStart
{
    vars.Splits.Clear();
    current.Mission = "";
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();

    var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;
	if (old.World != current.World) vars.Log("GWorldName: " + current.World.ToString());

    current.ActiveMissions = new List<string>();
    int count = current.ActiveMissionCount;

    for (int i = 0; i < count; i++)
    {
        string mission = vars.Helper.ReadString(128, ReadStringType.UTF16, vars.gEngine, 0xEA8, 0x6F8, 0xE8, (i * 0x8), 0x78, 0x28, 0x28, 0x0);

        if (!string.IsNullOrEmpty(mission))
            current.ActiveMissions.Add(mission);
    }

    if (old.ActiveMissions != null)
    {
        for (int i = 0; i < current.ActiveMissions.Count; i++)
        {
            if (current.ActiveMissions[i].StartsWith("MQ"))
            {
                if (i >= old.ActiveMissions.Count || current.ActiveMissions[i] != old.ActiveMissions[i])
                {
                    current.Mission = current.ActiveMissions[i];
                    vars.Log("Current Mission: " + current.Mission);
                }
            }
        }
    }

    vars.Log(current.InCutscene);
}

split
{
    for (int i = 0; i < current.ActiveMissionCount; i++)
    { 
        if (old.Mission.StartsWith("MQ") && current.Mission.StartsWith("MQ") && current.Mission != old.Mission && !vars.Splits.Contains(old.Mission)) 
        { 
            vars.Log("Split Complete: " + old.Mission);
            return true && vars.Splits.Add(old.Mission); 
        } 
    }
}

isLoading
{
    return current.GSync || current.HUDFades >= 1065000000 || current.InCutscene == 5 || current.InCutscene == 0;
}

exit
{
    timer.IsGameTimePaused = true;
}
