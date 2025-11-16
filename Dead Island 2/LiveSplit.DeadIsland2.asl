state("DeadIsland-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
    vars.Uhara.AlertLoadless();
}

init
{
    vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");
    vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");

    // GWorld.FName
	vars.Resolver.Watch<ulong>("GWorldName", vars.Utils.GWorld, 0x18);
    vars.Resolver.Watch<bool>("GSync", vars.Utils.GSync);

    vars.Resolver.WatchString("ActiveMission", vars.Utils.GEngine, 0xEA8, 0x6F8, 0xE8, 0x0, 0x78, 0x28, 0x28, 0x0);
    vars.Resolver.Watch<bool>("LoadingScreen", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x60, 0xA0);
    vars.Resolver.Watch<byte>("InCutscene", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2D8, 0x1280, 0x1A4);
    vars.Resolver.Watch<int>("HUDFades", vars.Utils.GEngine, 0xEA8, 0x3F8, 0x58);
    vars.Resolver.Watch<int>("ActiveMissionCount", vars.Utils.GEngine, 0xEA8, 0x6F8, 0xF4);

    vars.Resolver.Watch<bool>("HUDStateCutscene", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x8, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateQuestDelivery", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x10, 0xA0);

    vars.Resolver.Watch<bool>("HUDStateStoryPlayer", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x0, 0x18);

    vars.Resolver.Watch<ulong>("MenuName", vars.Utils.GEngine, 0xEA8, 0x3E0, 0x58, 0x0, 0x18);

    vars.Resolver.Watch<ulong>("MissionComplete", vars.Events.FunctionFlag("MissionFlowNode_Mission", "MissionFlowNode_Mission", "OnMissionStateChangedInternal"));

    current.World = "";
    current.Menu = "";

    vars.Splits = new HashSet<string>();
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
    vars.Uhara.Update();

    var world = vars.Utils.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;
	
	if (old.World != current.World)
		vars.Uhara.Log("GWorldName: " + current.World.ToString());

    var menu = vars.Utils.FNameToString(current.MenuName);
	if (!string.IsNullOrEmpty(menu) && menu != "None")
		current.Menu = menu;
	
	if (old.Menu != current.Menu)
		vars.Uhara.Log("Menu: " + current.Menu.ToString());
}

split
{
    return vars.Resolver.CheckFlag("MissionComplete");
}

isLoading
{
    return current.GSync
        || current.HUDFades >= 1065000000
        || current.World == "EntryMap"
        || current.LoadingScreen
        || current.HUDStateCutscene
        || !current.HUDStateStoryPlayer
        || current.HUDStateQuestDelivery;
}

exit
{
    timer.IsGameTimePaused = true;
}
