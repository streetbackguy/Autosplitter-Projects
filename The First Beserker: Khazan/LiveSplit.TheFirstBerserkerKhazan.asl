state("BBQ-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
	vars.Helper.GameName = "The First Berserker: Khazan";
	vars.Helper.AlertLoadless();
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
            settings.Add("MI_1601", true, "Beat Master of Chaos Mission", "MM");
        settings.Add("SM", true, "Side Missions", "TFBK");
            settings.Add("MI_202", true, "Beat Stormpass' Phantom of Combat Mission", "SM");
            settings.Add("MI_304", true, "Beat Jar Enthusiasts Mission", "SM");
            settings.Add("MI_302", true, "Beat Night of Tragedy Mission", "SM");
            settings.Add("MI_502", true, "Beat Blacksmith's Heirloom Mission", "SM");
            settings.Add("MI_403", true, "Beat Kaleido Mission", "SM");
            settings.Add("MI_402", true, "Beat Human Xilence Mission", "SM");
            settings.Add("MI_702", true, "Beat Final Conquest Mission", "SM");
            settings.Add("MI_604", true, "Beat Pavel's Final Words Mission", "SM");
            settings.Add("MI_902", true, "Beat Escaping Linon Mine Mission", "SM");
            settings.Add("MI_1102", true, "Beat Last Command Mission", "SM");
            settings.Add("MI_1202", true, "Beat Why Have You Forsaken Us? Mission", "SM");
            settings.Add("MI_1302", true, "Beat Lacrima Mission", "SM");
            settings.Add("MI_1402", true, "Beat Unrequited Love Mission", "SM");
            settings.Add("MI_1502", true, "Beat Valus's Axe Mission", "SM");
            settings.Add("MI_1602", true, "Beat Atlante the Precise (Mission) Mission", "SM");
            settings.Add("MI_1702", true, "Beat Centurial Order Mission", "SM");
            settings.Add("MI_1802", true, "Beat Remnants of Chaos Mission", "SM");
            settings.Add("MI_1902", true, "Beat Crimson Trace Mission", "SM");
            settings.Add("MI_2002", true, "Beat Last Sentinel Mission", "SM");
            settings.Add("MI_2102", true, "Beat Transcendental Sword Mission", "SM");
            settings.Add("MI_2202", true, "Beat Disobedience Mission", "SM");
            settings.Add("MI_2302", true, "Beat Charon's Chains Mission", "SM");
            settings.Add("MI_2402", true, "Beat Birth of Evil Mission", "SM");
            settings.Add("MI_2502", true, "Beat The Vow Mission", "SM");
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

    // xxGameEngine.GameInstance.LocalPlayers[0].PlayerController.AcknowledgedPawn.bBindingLevelSequence
    vars.Helper["BindingLevelSequence"] = vars.Helper.Make<bool>(gEngine, 0xD78, 0x38, 0x0, 0x30, 0x2C0, 0x14C9);

    // xxGameEngine.GameInstance.Subsystems(0xF0).xxContentsManager(0x140).ContentsDataModels[7].xxMissionDM.CurrentMissionInfo.Name
    vars.Helper["CurrentMissionName"] = vars.Helper.Make<ulong>(gEngine, 0xD78, 0xF0, 0x140, 0x138, 0xB0, 0x50, 0x18);
    vars.Helper["CurrentMissionName"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

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

    vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");
    
    IntPtr OnMissionCleared = vars.Events.FunctionFlag("W_MissionResult_C", "W_MissionResult_C", "OnMissionCleared");
    print("ON_MISSION_CLEARED_PTR: " + OnMissionCleared.ToString("X"));
    vars.Resolver.Watch<ulong>("OnMissionCleared", OnMissionCleared);
    
    IntPtr LoadingStart = vars.Events.FunctionFlag("W_Loading_C", "W_Loading_C", "OnFinishBeginUMG");
    print("LOADING_START_PTR: " + LoadingStart.ToString("X"));
    vars.Resolver.Watch<ulong>("LoadingStart", LoadingStart);

    IntPtr LoadingEnd = vars.Events.FunctionFlag("Loading_All_C", "Loading_All_C", "ReceiveEndPlay");
    print("LOADING_END_PTR: " + LoadingEnd.ToString("X"));
    vars.Resolver.Watch<ulong>("LoadingEnd", LoadingEnd);

    IntPtr CutsceneStart = vars.Events.FunctionFlag("xxCutSceneSequenceVM", "xxCutSceneSequenceVM", "OnBeginUMG");
    print("CUTSCENE_START_PTR: " + CutsceneStart.ToString("X"));
    vars.Resolver.Watch<ulong>("CutsceneStart", CutsceneStart);

    IntPtr CutsceneEnd = vars.Events.FunctionFlag("xxCutSceneSequenceVM", "xxCutSceneSequenceVM", "OnEndUMG");
    print("CUTSCENE_END_PTR: " + CutsceneEnd.ToString("X"));
    vars.Resolver.Watch<ulong>("CutsceneEnd", CutsceneEnd);

    IntPtr FadeOut = vars.Events.FunctionFlag("W_FadeInOut_C", "W_FadeInOut_C", "OnAnimationStarted");
    print("FADE_OUT_PTR: " + FadeOut.ToString("X"));
    vars.Resolver.Watch<ulong>("FadeOut", FadeOut);

    IntPtr SkoffaBossDead = vars.Events.FunctionFlag("SkoffaCave_Spawn_Main01_C", "SkoffaCave_Spawn_Main01_C", "BndEvt__SkoffaCave_Spawn_Main01_SA_BigSpiderBoss_88_K2Node_ActorBoundEvent_0_SpawnedActorDead__DelegateSignature");
    print("SKOFFA_BOSS_END_PTR: " + SkoffaBossDead.ToString("X"));
    vars.Resolver.Watch<ulong>("SkoffaBossDead", SkoffaBossDead);

    current.World = "";
    current.Mission = "";
    vars.LoadingFlag = false;
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();
    vars.Uhara.Update();

    var world = vars.FNameToString(current.GWorldName);
	current.World = world;
	if (old.World != current.World) vars.Log("GWorldName: " + current.World.ToString());

    var mission = vars.FNameToString(current.CurrentMissionName);
	current.Mission = mission;
	if (old.Mission != current.Mission) vars.Log("Mission Name: " + current.Mission.ToString());

    if (vars.Resolver.CheckFlag("LoadingStart") || vars.Resolver.CheckFlag("CutsceneStart") || vars.Resolver.CheckFlag("FadeOut"))
    {  
        vars.LoadingFlag = true;
    }

	if (vars.Resolver.CheckFlag("LoadingEnd") || vars.Resolver.CheckFlag("CutsceneEnd"))
    {
        vars.LoadingFlag = false;
    }

    // vars.Log("\nOnMissionCleared: " + current.OnMissionCleared +"\nMissionCleared: " + current.MissionCleared);
}

isLoading
{
    return current.World == "None" ||
    current.World == "LB_LobbyLevel" ||
    current.World == "Untitled" ||
    vars.LoadingFlag;
}

start
{
    return !current.BindingLevelSequence && current.World == "HeinMach_All" && old.BindingLevelSequence;
}

onStart
{
    vars.CompletedSplits.Clear();
    vars.LoadingFlag = false;
}

split
{
    if(current.OnMissionCleared != old.OnMissionCleared && current.OnMissionCleared != 0 && !vars.CompletedSplits.Contains(current.Mission) ||
    current.SkoffaBossDead != old.SkoffaBossDead && current.SkoffaBossDead != 0 && !vars.CompletedSplits.Contains(current.Mission))
    {
        return settings[current.Mission] && vars.CompletedSplits.Add(current.Mission);
    }
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
