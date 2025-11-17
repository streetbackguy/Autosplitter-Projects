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
    vars.Resolver.Watch<byte>("InCutscene", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2D8, 0x1280, 0x1A4);
    vars.Resolver.Watch<int>("HUDFades", vars.Utils.GEngine, 0xEA8, 0x3F8, 0x58);
    vars.Resolver.Watch<int>("ActiveMissionCount", vars.Utils.GEngine, 0xEA8, 0x6F8, 0xF4);

    vars.Resolver.Watch<bool>("HUDStateStoryPlayer", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x0, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateCutscene", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x8, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateQuestDelivery", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x10, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateCredits", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x18, 0xA0);
    vars.Resolver.Watch<bool>("HUDStatePauseMenu", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x20, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateFatality", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x28, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateRespawning", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x30, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateDowned", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x38, 0xA0);
    vars.Resolver.Watch<bool>("HUDStatePlaceHeadRecovery", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x40, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateHidden", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x48, 0xA0);
    vars.Resolver.Watch<bool>("HUDStatePlayerMenu", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x50, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateWorkbench", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x58, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateLoadingScene", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x60, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateWheel", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x68, 0xA0);
    vars.Resolver.Watch<bool>("HUDStateEmoteWheel", vars.Utils.GEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x100, 0x70, 0xA0);

    vars.Resolver.Watch<ulong>("RequestFadeStart", vars.Events.FunctionFlag("HUDFaderArbiterPlayerComponent", "HUDFaderArbiterPlayerComponent", "ClientRequestFade"));
    vars.Resolver.Watch<ulong>("RequestFadeEnd", vars.Events.FunctionFlag("HUDFaderArbiterPlayerComponent", "HUDFaderArbiterPlayerComponent", "ClientDiscardFader"));
    
    vars.Resolver.Watch<ulong>("QuitToMenuStart", vars.Events.FunctionFlag("GFxSavingIcon", "GFxSavingIcon", "OnShowSaveIcon"));
    vars.Resolver.Watch<ulong>("QuitToMenuEnd", vars.Events.FunctionFlag("MenuNewsFeedDownloadedTexture", "MenuNewsFeedDownloadedTexture", "OnSuccess"));

    vars.Resolver.Watch<ulong>("MenuName", vars.Utils.GEngine, 0xEA8, 0x3E0, 0x58, 0x0, 0x18);

    vars.Resolver.Watch<ulong>("MissionComplete", vars.Events.FunctionFlag("MissionFlowNode_Mission", "MissionFlowNode_Mission", "OnMissionStateChangedInternal"));
    vars.Resolver.Watch<ulong>("MissionComplete2", vars.Events.FunctionFlag("BP_HUDObject_CurrentMission_C", "BP_HUDObject_CurrentMission_C", "OnTrackedQuestChanged"));

    current.World = "";
    current.Menu = "";

    vars.Splits = new HashSet<string>();
    vars.Loading = false;
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

        if(vars.Resolver.CheckFlag("RequestFadeStart") || vars.Resolver.CheckFlag("QuitToMenuStart"))
    {  
        vars.Loading = true;
    }
    else if(vars.Resolver.CheckFlag("RequestFadeEnd") || current.HUDStateStoryPlayer)
    {
        vars.Loading = false;
    }
}

split
{
    return vars.Resolver.CheckFlag("MissionComplete") && vars.Resolver.CheckFlag("MissionComplete2") && !current.HUDStateLoadingScene;
}

isLoading
{
    return current.GSync
        || current.HUDFades >= 1065000000
        || current.World == "EntryMap"
        || !current.HUDStateStoryPlayer && !current.HUDStateDowned && !current.HUDStateWorkbench && !current.HUDStateRespawning && !current.HUDStateWheel
        && !current.HUDStateEmoteWheel && !current.HUDStatePauseMenu && !current.HUDStatePlaceHeadRecovery && !current.HUDStateFatality && !current.HUDStatePlayerMenu
        || vars.Loading;
}

exit
{
    timer.IsGameTimePaused = true;
}
