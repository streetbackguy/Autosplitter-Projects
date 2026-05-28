state("UE_YGRO-Win64-Shipping")
{
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/uhara10")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();
	vars.Uhara.EnableDebug();

    settings.Add("FE", true, "Fading Echo");
        settings.Add("DEMO", true, "Demo Splits", "FE");
            settings.Add("2", true, "Tutorial Stage", "FE");
            settings.Add("3", true, "Water Orb Tutorial", "FE");
            settings.Add("Bastion", true, "Bastion", "FE");
            settings.Add("PreVolcano", true, "Before The Volcano", "FE");
            settings.Add("WaterVolcano", true, "Reach Volcano Water Dimension", "FE");
            settings.Add("DemoEnding", true, "Volcano Source (End of Demo)", "FE");

    vars.Splits = new HashSet<string>();
    vars.BastionActivated = false;
    vars.VolcanoReached = false;
    vars.VolcanoWaterReached = false;
    vars.DemoEnd = false;
}

init
{
	vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");
    vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");

	vars.Resolver.Watch<uint>("GWorldName", vars.Utils.GWorld, 0x18);
    vars.Resolver.Watch<bool>("GSync", vars.Utils.GSync);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> LoadingStep
    vars.Resolver.Watch<uint>("LoadingStep", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x588);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> IndexLevelLoading
    vars.Resolver.Watch<bool>("IndexLevelLoading", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x2B8);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> NewZoneToLoad -> TransitionLevel[0] -> FName
    vars.Resolver.Watch<bool>("TransitionLevel", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x2F8, 0x1B8, 0x18);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> NewZoneToLoad -> All Level To Load[0] -> FName
    vars.Resolver.Watch<bool>("AllLevelToLoad", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x2F8, 0x370, 0x18);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> LevelZone
    vars.Resolver.Watch<uint>("LevelZone", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x4C1);
    // GWorld -> AuthorityGameMode -> CurrentCutscene[0] -> CutsceneIndex
    vars.Resolver.Watch<uint>("CutsceneIndex", vars.Utils.GWorld, 0x1A8, 0x4B0, 0x380);
    vars.Uhara["CutsceneIndex"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> AcknowledgedPawn -> CurrentAetherCore -> IsPowerCore
    vars.Resolver.Watch<bool>("AetherCore", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x350, 0xA70, 0x591);
    vars.Uhara["AetherCore"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> AcknowledgedPawn -> CurrentAetherCore -> LastBase
    vars.Resolver.Watch<bool>("AetherCoreBase", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x350, 0xA70, 0x3B0, 0x18);
    vars.Uhara["AetherCore"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    // GWorld -> AuthorityGameMode -> MF_QuestCpt -> Managers[0] -> FNodeStates[0] -> CurrentState
    vars.Resolver.Watch<uint>("QuestState", vars.Utils.GWorld, 0x1A8, 0x3F8, 0x110, 0x50, 0x308, 0x60, 0x128);
    vars.Uhara["QuestState"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    // Reach Bastion
    vars.Resolver.Watch<ulong>("BastionActivated", vars.Events.FunctionFlag("PH_BP_PerkSystemInteraction_C", "PH_BP_PerkSystemInteraction_C", "FishBoidsDisappear__FinishedFunc"));
    // Reach Volcano
    vars.Resolver.Watch<ulong>("VolcanoReached", vars.Events.FunctionFlag("YGRO_Volcano_Sh0_Narra_C", "YGRO_Volcano_Sh0_Narra_C", "OnPortalTravelEnd_Event"));
    // Reach Volcano Water Dimension
    vars.Resolver.Watch<ulong>("VolcanoWaterReached", vars.Events.FunctionFlag("YGRO_Volcano_SH1_Narra_C", "YGRO_Volcano_SH1_Narra_C", "O n P o r t a l T r a v e l"));
    // End of Demo
    vars.Resolver.Watch<ulong>("DemoEnd", vars.Events.FunctionFlag("W_ClosedAlphaEndPanel_C", "W_ClosedAlphaEndPanel_C", "ExecuteUbergraph_W_ClosedAlphaEndPanel]"));

	current.World = "";
}

update
{
	vars.Uhara.Update();

	var world = vars.Utils.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;

	if(old.World != current.World)
	{
		vars.Uhara.Log("World: " + current.World);
	}

    if(old.LevelZone != current.LevelZone)
	{
		vars.Uhara.Log("LevelZone: " + current.LevelZone);
	}

    if(old.LoadingStep != current.LoadingStep)
	{
		vars.Uhara.Log("LoadingStep: " + current.LoadingStep);
	}

    if(old.CutsceneIndex != current.CutsceneIndex)
	{
		vars.Uhara.Log("CutsceneIndex: " + current.CutsceneIndex);
	}
    if (vars.Resolver.CheckFlag("BastionActivated"))
    {
        vars.BastionActivated = true;
        vars.Uhara.Log("Bastion Activated? " + current.BastionActivated);
    }

    if (vars.Resolver.CheckFlag("VolcanoReached"))
    {
        vars.VolcanoReached = true;
        vars.Uhara.Log("Volcano Reached? " + current.VolcanoReached);
    }

    if (vars.Resolver.CheckFlag("VolcanoWaterReached"))
    {
        vars.VolcanoWaterReached = true;
        vars.Uhara.Log("Volcano Water Dimension Reached? " + current.VolcanoWaterReached);
    }

    if (vars.Resolver.CheckFlag("DemoEnd"))
    {
        vars.DemoEnd = true;
        vars.Uhara.Log("Volcano Water Dimension Reached? " + current.DemoEnd);
    }
}

start
{
    return current.LevelZone == 5 && old.LevelZone == 7 && old.CutsceneIndex == 1;
}

onStart
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
    vars.BastionActivated = false;
    vars.VolcanoReached = false;
    vars.VolcanoWaterReached = false;
    vars.DemoEnd = false;
}

split
{
    if(old.CutsceneIndex != current.CutsceneIndex && !vars.Splits.Contains(current.CutsceneIndex.ToString()))
    {
        return settings[current.CutsceneIndex.ToString()] && vars.Splits.Add(current.CutsceneIndex.ToString());
    }

    if(vars.BastionActivated == true && !vars.Splits.Contains("Bastion"))
    {
        return settings["Bastion"] && vars.Splits.Add("Bastion");
    }

    if(vars.VolcanoReached == true && !vars.Splits.Contains("PreVolcano"))
    {
        return settings["PreVolcano"] && vars.Splits.Add("PreVolcano");
    }

    if(vars.VolcanoWaterReached == true && !vars.Splits.Contains("WaterVolcano"))
    {
        return settings["WaterVolcano"] && vars.Splits.Add("WaterVolcano");
    }

    if(vars.DemoEnd == true && !vars.Splits.Contains("DemoEnding"))
    {
        return settings["DemoEnding"] && vars.Splits.Add("DemoEnding");
    }
}

reset
{

}

isLoading
{
	return current.GSync || current.LoadingStep < 4 || current.CutsceneIndex > 0;
}

exit
{
	timer.IsGameTimePaused = true;
}
