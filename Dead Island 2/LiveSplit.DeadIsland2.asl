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
        throw new Exception("Not all required addresses could be found by scanning.");

    vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSync);

    vars.Helper["ActiveMission"] = vars.Helper.MakeString(gEngine, 0xEA8, 0x6F8, 0xE8, 0x0, 0x78, 0x28, 0x28, 0x0);
    vars.Helper["LoadingScreen"] = vars.Helper.Make<bool>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x60, 0xA0);
    vars.Helper["InCutscene"] = vars.Helper.Make<byte>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2D8, 0x1280, 0x1A4);
    vars.Helper["HUDFades"] = vars.Helper.Make<int>(gEngine, 0xEA8, 0x3F8, 0x58);
    vars.Helper["ActiveMissionCount"] = vars.Helper.Make<int>(gEngine, 0xEA8, 0x6F8, 0xF4);

    vars.Helper["HUDStateCutscene"] = vars.Helper.Make<bool>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x8, 0xA0);
    vars.Helper["HUDStateQuestDelivery"] = vars.Helper.Make<bool>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x10, 0xA0);

    vars.Helper["HUDStateStoryPlayer"] = vars.Helper.Make<bool>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x0, 0x18);
    vars.Helper["HUDStateStoryPlayer"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    vars.Helper["MenuName"] = vars.Helper.Make<ulong>(gEngine, 0xEA8, 0x3E0, 0x58, 0x0, 0x18);
    vars.Helper["MenuName"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    vars.FNameToString = (Func<ulong, string>)(fName =>
    {
        var nameIdx = (fName & 0x000000000000FFFF);
        var chunkIdx = (fName & 0x00000000FFFF0000) >> 16;
        var number = (fName & 0xFFFFFFFF00000000) >> 32;

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
    current.MQMission = "";
    current.Menu = "";

    vars.Splits = new HashSet<string>();
    current.ActiveMQMissions = new List<string>();
    current.ActiveSQMissions = new List<string>();
    current.ActiveMissions = new List<string>();
    current._JustRemoved = new List<string>();

    vars.gEngine = gEngine;
}

start
{
    return current.ActiveMission == "MQ01 (WIP) DEATH FLIGHT 71"
        && old.InCutscene == 5
        && current.InCutscene == 1;
}

onStart
{
    vars.Splits.Clear();
}

update
{
    vars.Helper.Update();
    vars.Helper.MapPointers();

    var world = vars.FNameToString(current.GWorldName);
    if (!string.IsNullOrEmpty(world) && world != "None")
        current.World = world;

    var menu = vars.FNameToString(current.MenuName);
    if (!string.IsNullOrEmpty(menu) && menu != "None")
        current.Menu = menu;

    int count = Math.Max(0, current.ActiveMissionCount);

    var mqNow = new List<string>(count);
    var sqNow = new List<string>(count);

    for (int i = 0; i < count; i++)
    {
        string mission = vars.Helper.ReadString(
            128, ReadStringType.UTF16,
            vars.gEngine, 0xEA8, 0x6F8, 0xE8, (i * 0x8), 0x78, 0x28, 0x28, 0x0
        );

        if (string.IsNullOrEmpty(mission))
            continue;

        if (mission.StartsWith("MQ"))
            mqNow.Add(mission);
        else if (mission.StartsWith("SQ"))
            sqNow.Add(mission);
    }

    current.ActiveMQMissions = mqNow;
    current.ActiveSQMissions = sqNow;
    current.ActiveMissions = mqNow.Concat(sqNow).ToList();

    current._JustRemoved = new List<string>();
    if (old.ActiveMissions != null)
    {
        foreach (string m in old.ActiveMissions)
            if (!current.ActiveMissions.Contains(m))
                current._JustRemoved.Add(m);
    }
}

split
{
    if (!current.HUDStateStoryPlayer)
        return false;

    if (string.IsNullOrEmpty(current.World) 
        || current.World.Contains("FrontEnd") 
        || current.World.Contains("Menu")
        || current.World == "None")
        return false;

    if (current.GSync
        || current.HUDFades >= 1065000000
        || current.LoadingScreen
        || current.Menu.StartsWith("BP_MenuInstance_FrontEnd_C")
        || current.HUDStateCutscene
        || old.Menu.StartsWith("BP_MenuInstance_InGamePauseMenu_C")
        || !current.HUDStateStoryPlayer
        || current.HUDStateQuestDelivery)
        return false;

    if (current._JustRemoved == null || current._JustRemoved.Count == 0)
        return false;

    foreach (string mission in current._JustRemoved)
    {
        if (!vars.Splits.Contains(mission))
        {
            vars.Log("Quest Complete: " + mission);
            vars.Splits.Add(mission);
            return true;
        }
    }

    return false;
}

isLoading
{
    return current.GSync
        || current.HUDFades >= 1065000000
        || current.Menu.StartsWith("BP_MenuInstance_FrontEnd_C")
        || current.LoadingScreen
        || current.HUDStateCutscene
        || !current.HUDStateStoryPlayer
        || current.HUDStateQuestDelivery;
}

exit
{
    timer.IsGameTimePaused = true;
}
