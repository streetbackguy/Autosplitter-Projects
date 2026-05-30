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
            settings.Add("2", true, "Tutorial Stage", "DEMO");
            settings.Add("3", true, "Water Orb Tutorial", "DEMO");
            settings.Add("Bastion", true, "Bastion Activated", "DEMO");
            settings.Add("ZoneBastion", true, "Reach Volcano", "DEMO");
            settings.Add("WaterDimension1", true, "Exit First Water Dimension", "DEMO");
            settings.Add("VolcanoSource", true, "Reach Volcano Source", "DEMO");
            settings.Add("WaterDimension2", true, "Exit Second Water Dimension", "DEMO");
            settings.Add("DemoEnding", true, "End of Demo", "DEMO");
    settings.Add("ResetOnMainMenu", false, "Reset on Backing out to Main Menu");

    vars.Splits = new HashSet<string>();
}

init
{
	vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");
    vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");

    vars.Resolver.Watch<bool>("GSync", vars.Utils.GSync);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> LoadingStep
    vars.Resolver.Watch<uint>("LoadingStep", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x588);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> LevelZone
    vars.Resolver.Watch<uint>("LevelZone", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x4C1);
    // GEngine -> Game Instance -> LocalPlayer[0] -> PlayerController -> LevelLoader -> NewZoneToLoad -> Zone Name
    vars.Resolver.Watch<uint>("LevelZoneName", vars.Utils.GEngine, 0x1248, 0x38, 0x0, 0x30, 0x830, 0x2F8, 0x30);
    vars.Uhara["LevelZoneName"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    // GWorld -> AuthorityGameMode -> CurrentCutscene[0] -> CutsceneIndex
    vars.Resolver.Watch<uint>("CutsceneIndex", vars.Utils.GWorld, 0x1A8, 0x4B0, 0x380);
    vars.Uhara["CutsceneIndex"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    // GWorld -> AuthorityGameMode -> MF_QuestCpt -> Managers[0] -> FNodeStates[0] -> CurrentState
    vars.Resolver.Watch<uint>("QuestState", vars.Utils.GWorld, 0x1A8, 0x3F8, 0x110, 0x50, 0x308, 0x60, 0x128);
    vars.Uhara["QuestState"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

    // Reach Bastion Activation
    vars.Events.FunctionFlag("BastionActivated", "IrisSystem_C", "IrisSystem_C", "CenterAnimation__FinishedFunc");
    // Exit First Volcano Water Dimension
    vars.Events.FunctionFlag("WaterDimension1", "YGRO_Volcano_Sh0_Narra_C", "YGRO_Volcano_Sh0_Narra_C", "OnPortalTravelEnd_Event");
    // Reach Volcano Source
    vars.Events.FunctionFlag("VolcanoSource", "YGRO_Global_Gameplay_C", "YGRO_Global_Gameplay_C", "RE_AethericSourceTuto");
    // Reach Exit Second Water Dimension
    vars.Events.FunctionFlag("WaterDimension2", "YGRO_Volcano_SH1_Geo_02_C", "YGRO_Volcano_SH1_Geo_02_C", "RE_ItemEnigmaS1Disconnected");
    // End of Demo
    vars.Events.FunctionFlag("DemoEnd", "W_ClosedAlphaEndPanel_C", "W_ClosedAlphaEndPanel_C", "ExecuteUbergraph_W_ClosedAlphaEndPanel");

    current.World = "";
}

update
{
	vars.Uhara.Update();

    var world = vars.Utils.FNameToString(current.LevelZoneName);
	if (!string.IsNullOrEmpty(world) && world != "None")
    {
        current.World = world;
    }

    if(old.LevelZone != current.LevelZone)
	{
		vars.Uhara.Log("LevelZone: " + current.LevelZone);
	}

    if(old.LoadingStep != current.LoadingStep)
	{
		vars.Uhara.Log("LoadingStep: " + current.LoadingStep);
	}

    if(old.World != current.World)
	{
		vars.Uhara.Log("World: " + old.World + " -> " + current.World);
	}

    if(old.CutsceneIndex != current.CutsceneIndex)
	{
		vars.Uhara.Log("CutsceneIndex: " + current.CutsceneIndex);
	}
}

start
{
    return current.World == "ZoneTutorial" && old.CutsceneIndex == 1 && current.LevelZone == 5;
}

onStart
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}

split
{
    if(old.CutsceneIndex != current.CutsceneIndex && !vars.Splits.Contains(current.CutsceneIndex.ToString()))
    {
        return settings[current.CutsceneIndex.ToString()] && vars.Splits.Add(current.CutsceneIndex.ToString());
    }

    if(vars.Resolver.CheckFlag("BastionActivated") && !vars.Splits.Contains("Bastion"))
    {
        return settings["Bastion"] && vars.Splits.Add("Bastion");
    }

    if(vars.Resolver.CheckFlag("WaterDimension1") && !vars.Splits.Contains("WaterDimension1"))
    {
        return settings["WaterDimension1"] && vars.Splits.Add("WaterDimension1");
    }

    if(vars.Resolver.CheckFlag("VolcanoSource") && !vars.Splits.Contains("VolcanoSource"))
    {
        return settings["VolcanoSource"] && vars.Splits.Add("VolcanoSource");
    }

    if(vars.Resolver.CheckFlag("WaterDimension2") && !vars.Splits.Contains("WaterDimension2"))
    {
        return settings["WaterDimension2"] && vars.Splits.Add("WaterDimension2");
    }
    
    if(vars.Resolver.CheckFlag("DemoEnd") && !vars.Splits.Contains("DemoEnding"))
    {
        return settings["DemoEnding"] && vars.Splits.Add("DemoEnding");
    }

    if(old.World != current.World && !vars.Splits.Contains(old.World))
	{
		return settings[old.World] && vars.Splits.Add(old.World);
	}
}

reset
{
    if(current.World == "ZoneMainMenu" && old.World != "ZoneMainMenu")
    {
        return settings["ResetOnMainMenu"];
    }
}

isLoading
{
	return current.GSync || current.LoadingStep < 4 || current.CutsceneIndex > 0;
}

exit
{
	timer.IsGameTimePaused = true;
}
