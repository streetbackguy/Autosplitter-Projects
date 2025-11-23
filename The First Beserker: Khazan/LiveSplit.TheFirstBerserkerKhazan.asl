state("BBQ-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();
	vars.Uhara.EnableDebug();

    vars.CompletedSplits = new HashSet<string>();

    settings.Add("TFBK", true, "The First Berserker: Khazan");
        settings.Add("MM", true, "Main Missions", "TFBK");
            settings.Add("MI_101", true, "Beat Banished Hero Mission", "MM");
            settings.Add("MI_201", true, "Beat Trials of the Frozen Mountain Mission", "MM");
            settings.Add("MI_401", true, "Beat Forgotten Temple Mission", "MM");
            settings.Add("MI_301", true, "Beat First Act of Revenge Mission", "MM");
            settings.Add("MI_501", true, "Beat Strange Stench Mission", "MM");
            settings.Add("MI_601", true, "Beat Traitor Revealed Mission", "MM");
            settings.Add("MI_701", true, "Beat Veiled Knives Mission", "MM");
            settings.Add("MI_801", true, "Beat Devoured Village Mission", "MM");
            settings.Add("MI_901", true, "Beat Inconceivable Truth Mission", "MM");
            settings.Add("MI_1001", true, "Beat Witch's Castle Mission", "MM");
            settings.Add("MI_1101", true, "Beat Hermit Mountains Mission", "MM");
            settings.Add("MI_1201", true, "Beat Corruptors' Fortress Mission", "MM");
            settings.Add("MI_1301", true, "Beat Strange Melody Mission", "MM");
            settings.Add("MI_1401", true, "Beat Fall of the Empire Mission", "MM");
            settings.Add("MI_1501", true, "Beat Bloodied Sanctuary Mission", "MM");
            settings.Add("MI_1600_A", true, "Beat Master of Chaos Mission", "MM");
        settings.Add("SM", true, "Side Missions", "TFBK");
            settings.Add("MI_202", true, "Beat Stormpass' Phantom of Combat Mission", "SM");
            settings.Add("MI_304", true, "Beat Jar Enthusiasts Mission", "SM");
            settings.Add("MI_302", true, "Beat Night of Tragedy Mission", "SM");
            settings.Add("MI_502", true, "Beat Blacksmith's Heirloom Mission", "SM");
            settings.Add("MI_403", true, "Beat Kaleido Mission", "SM");
            settings.Add("MI_402", true, "Beat Human Xilence Mission", "SM");
            settings.Add("MI_702", true, "Beat Final Conquest Mission", "SM");
            settings.Add("MI_604", true, "Beat Pavel's Final Words Mission", "SM");
            settings.Add("MI_903", true, "Beat Escaping Linon Mine Mission", "SM");
            settings.Add("MI_902", true, "Beat Last Command Mission", "SM");
            settings.Add("MI_2201", true, "Beat Why Have You Forsaken Us? Mission", "SM");
            settings.Add("MI_1002", true, "Beat Lacrima Mission", "SM");
            settings.Add("MI_1003", true, "Beat Unrequited Love Mission", "SM");
            settings.Add("MI_803", true, "Beat Valus's Axe Mission", "SM");
            settings.Add("MI_1102", true, "Beat Atlante the Precise Mission", "SM");
            settings.Add("MI_1302", true, "Beat Centurial Order Mission", "SM");
            settings.Add("MI_802", true, "Beat Remnants of Chaos Mission", "SM");
            settings.Add("MI_1202", true, "Beat Crimson Trace Mission", "SM");
            settings.Add("MI_1203", true, "Beat Last Sentinel Mission", "SM");
            settings.Add("MI_2401", true, "Beat Transcendental Sword Mission", "SM");
            settings.Add("MI_1402", true, "Beat Disobedience Mission", "SM");
            settings.Add("MI_1404", true, "Beat Charon's Chains Mission", "SM");
            settings.Add("MI_1403", true, "Beat Birth of Evil Mission", "SM");
            settings.Add("MI_2101", true, "Beat The Vow Mission", "SM");
}

init
{
	vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");
    vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");
	
    // GWorld.FName
	vars.Resolver.Watch<uint>("GWorldName", vars.Utils.GWorld, 0x18);

    // xxGameEngine.GameInstance.LocalPlayers[0].PlayerController.AcknowledgedPawn.bBindingLevelSequence
	vars.Resolver.Watch<bool>("BindingLevelSequence", vars.Utils.GEngine, 0xD78, 0x38, 0x0, 0x30, 0x2C0, 0x14C9);

    // xxGameEngine.GameInstance.Subsystems(0xF0).xxContentsManager(0x140).ContentsDataModels[7].xxMissionDM.CurrentMissionInfo.Name
	vars.Resolver.Watch<uint>("CurrentMissionName", vars.Utils.GEngine, 0xD78, 0xF0, 0x140, 0x138, 0xB0, 0x50, 0x18);
    vars.Resolver["CurrentMissionName"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    // xxGameEngine.GameInstance.Subsystems(0xF0).xxFadeInOutManager(0x1A0).FadeWidget.ActiveSequencePlayers
    vars.Resolver.Watch<bool>("ActiveSequencePlayers", vars.Utils.GEngine, 0xD78, 0xF0, 0x1A0, 0x70, 0x1B0);
    vars.Resolver["ActiveSequencePlayers"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    // xxGameEngine.GameInstance.Subsystems(0xF0).xxFadeInOutManager(0x1A0).FadeWidget.BG.RenderOpacity
    vars.Resolver.Watch<float>("RenderOpacity", vars.Utils.GEngine, 0xD78, 0xF0, 0x1A0, 0x70, 0x4E8, 0xC4);

    // xxGameEngine.GameInstance.Subsystems(0xF0).xxContentsManager(0x140).ContentsViewModels[2]
    vars.Resolver.Watch<uint>("PlayerActive", vars.Utils.GEngine, 0xD78, 0xF0, 0x140, 0x48, 0x38, 0xC8);

	// ---
    vars.Resolver.Watch<bool>("GSync", vars.Utils.GSync);
    
    vars.Resolver.Watch<ulong>("OnMissionCleared", vars.Events.FunctionFlag("W_MissionResult_C", "W_MissionResult_C", "OnMissionCleared"));
    vars.Resolver.Watch<ulong>("LoadingStart", vars.Events.FunctionFlag("W_Loading_C", "W_Loading_C", "OnFinishBeginUMG"));
    vars.Resolver.Watch<ulong>("LoadingEnd", vars.Events.FunctionFlag("Loading_All_C", "Loading_All_C", "ReceiveEndPlay"));
    vars.Resolver.Watch<ulong>("CutsceneStart", vars.Events.FunctionFlag("xxCutSceneSequenceVM", "xxCutSceneSequenceVM", "OnBeginUMG"));
    vars.Resolver.Watch<ulong>("CutsceneEnd", vars.Events.FunctionFlag("xxCutSceneSequenceVM", "xxCutSceneSequenceVM", "OnEndUMG"));
    vars.Resolver.Watch<ulong>("SkoffaBossDead", vars.Events.FunctionFlag("SkoffaCave_Spawn_Main01_C", "SkoffaCave_Spawn_Main01_C", "BndEvt__SkoffaCave_Spawn_Main01_SA_BigSpiderBoss_88_K2Node_ActorBoundEvent_0_SpawnedActorDead__DelegateSignature"));
    vars.Resolver.Watch<ulong>("VaisarBossDead", vars.Events.FunctionFlag("Vaisar_Spawn_Main01_C", "Vaisar_Spawn_Main01_C", "BndEvt__Vaisar_Spawn_Main01_SA_PicaroonBoss_183_K2Node_ActorBoundEvent_1_SpawnedActorDead__DelegateSignature"));
    vars.Resolver.Watch<ulong>("VitalonBossDead", vars.Events.FunctionFlag("VitalonCity_Spawn_Main01_C", "VitalonCity_Spawn_Main01_C", "BndEvt__SkoffaCave_Spawn_Main01_SA_BigSpiderBoss_88_K2Node_ActorBoundEvent_13_SpawnedActorDead__DelegateSignature"));
    vars.Resolver.Watch<ulong>("ImperialBossDead", vars.Events.FunctionFlag("ImperialPalace_Spawn_Main01_C", "ImperialPalace_Spawn_Main01_C", "BndEvt__ImperialPalace_Spawn_Main01_SA_Ozma_Phase2_2_K2Node_ActorBoundEvent_7_SpawnedActorSendSignal__DelegateSignature"));
    vars.Resolver.Watch<ulong>("ZoneEnterStart", vars.Events.FunctionFlag("W_ZoneEnter*", "W_ZoneEnter*", "OnPlayAnimStart"));
    vars.Resolver.Watch<ulong>("CutsceneAltStart", vars.Events.FunctionFlag("W_Movie_C", "W_Movie_C", "OnInitialized"));
    vars.Resolver.Watch<ulong>("CutsceneAltEnd", vars.Events.FunctionFlag("W_CutSceneSequence_C", "W_CutSceneSequence_C", "OnFinishEndUMG"));

    current.World = "";
    current.Mission = "";
    vars.LoadingFlag = false;
}

update
{
    vars.Uhara.Update();

    var world = vars.Utils.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;
	
	if (old.World != current.World)
		vars.Uhara.Log("GWorldName: " + current.World.ToString());
	
    var mission = vars.Utils.FNameToString(current.CurrentMissionName);
	if (!string.IsNullOrEmpty(mission) && mission != "None")
		current.Mission = mission;
	
	if (old.Mission != current.Mission)
		vars.Uhara.Log("Mission Name: " + current.Mission.ToString());

    if(vars.Resolver.CheckFlag("LoadingStart") || vars.Resolver.CheckFlag("CutsceneStart") || vars.Resolver.CheckFlag("CutsceneAltStart"))
    {  
        vars.LoadingFlag = true;
    }
    else if(vars.Resolver.CheckFlag("CutsceneEnd") || vars.Resolver.CheckFlag("ZoneEnterStart") || vars.Resolver.CheckFlag("LoadingEnd") || vars.Resolver.CheckFlag("CutsceneAltEnd"))
    {
        vars.LoadingFlag = false;
    }
}

isLoading
{
    return
    current.BindingLevelSequence ||
	current.World == "None" ||
    current.World == "LB_LobbyLevel" ||
    current.World == "Untitled" ||
    current.GSync ||
    current.ActiveSequencePlayers ||
    current.RenderOpacity != 0.0f && current.PlayerActive == 0 ||
    vars.LoadingFlag;
}

start
{
    return !current.BindingLevelSequence && old.BindingLevelSequence && current.World == "HeinMach_All";
}

onStart
{
    vars.CompletedSplits.Clear();
    vars.LoadingFlag = false;
}

split
{
	bool SplitsContainMission = vars.CompletedSplits.Contains(current.Mission);
	
    return
	vars.Resolver.CheckFlag("OnMissionCleared") && current.Mission != "MI_1201" && !SplitsContainMission ||
    vars.Resolver.CheckFlag("SkoffaBossDead") && !SplitsContainMission ||
    vars.Resolver.CheckFlag("VaisarBossDead") && vars.Resolver.CheckFlag("OnMissionCleared") && !SplitsContainMission ||
    vars.Resolver.CheckFlag("VitalonBossDead") && !SplitsContainMission ||
    vars.Resolver.CheckFlag("ImperialBossDead") && !SplitsContainMission;
}

exit
{
    timer.IsGameTimePaused = true;
}

// Useful paths:
// xxGameEngine.GameInstance.LocalPlayers[0].PlayerController.AcknowledgedPawn.Equips
// xxGameEngine.GameInstance.LoadedObjects[10].W_Loading_C
// xxGameEngine.GameInstance.Subsystems(0xF0).xxContentsManager(0x140).ContentsDataModels[1].xxCharacterInfoDM
// xxGameEngine.GameInstance.Subsystems(0xF0).xxContentsManager(0x140).ContentsDataModels[7].xxMissionDM
// xxGameEngine.GameInstance.Subsystems(0xF0).xxContentsManager(0x140).ContentsViewModels[2].xxBattleHUDVM
