state("BearNoGrudge-Win64-Shipping")
{
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/uhara10")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();
	vars.Uhara.EnableDebug();

    settings.Add("BNG", true, "Bear No Grudge");

    vars.WorldSplits = new Dictionary<string, string>()
    {
        { "1", "Race" },
        { "Hospital", "Hospital Intro" },
        { "TutMap", "Tutorial" },
        { "OfficeEntry", "Office Entry" },
        { "Office1", "Office Floor 1" },
        { "Office2", "Office Floor 2" },
        { "Office4", "Office Floor 3" },
        { "Office3", "Office Floor 4" },
        { "SkateCity", "Skateboarding" },
        { "HarbourEntry", "Harbour Warehouse" },
        { "Hoverboat_Level", "Hoverboat" },
        { "Farm1", "Farm" },
        { "Farm2Boss", "Helicopter Boss" },
        { "SSB_Map", "Sidescroller" },
        { "RoboStage", "Robot Stage" },
        { "Forest3", "Forest of Illusion" }
        // { "Lava", "Lava" }
    };

    settings.Add("Level Splits", true, "Level Splits", "BNG");

    foreach (var split in vars.WorldSplits)
    {
        settings.Add(split.Key,true,split.Value,"Level Splits");
    }

    vars.Splits = new HashSet<string>();
}

init
{
	vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");

	vars.Resolver.Watch<uint>("GWorldName", vars.Utils.GWorld, 0x18);
    vars.Resolver.Watch<bool>("GSync", vars.Utils.GSync);

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
}

start
{
    return current.World == "1" && old.World == "NewMainMenu";
}

onStart
{
    vars.Splits.Clear();
}

split
{
    if(old.World != current.World && !vars.Splits.Contains(old.World))
    {
        return settings[old.World] && vars.Splits.Add(old.World);
    }
}

reset
{
    if(old.World != "NewMainMenu" && current.World == "NewMainMenu")
    {
        return true;
    }
}

isLoading
{
	return current.GSync;
}

exit
{
	timer.IsGameTimePaused = true;
}
