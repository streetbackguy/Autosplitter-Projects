state("BearNoGrudge")
{
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/uhara10")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();
	vars.Uhara.EnableDebug();
}

init
{
	vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");

	vars.Resolver.Watch<uint>("GWorldName", vars.Utils.GWorld, 0x18);
	vars.Resolver.Watch<float>("SpeedrunTimer", vars.Utils.GEngine, 0xD28, 0x1F4);

	current.World = "";
	vars.TotalTime = new TimeSpan();
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

gameTime
{
    if(old.SpeedrunTimer > current.SpeedrunTimer)
    {
        vars.TotalTime += TimeSpan.FromSeconds(old.SpeedrunTimer);
    }
    
    return vars.TotalTime + TimeSpan.FromSeconds(current.SpeedrunTimer);
}

onStart
{
	vars.TotalTime = TimeSpan.Zero;
}

isLoading
{
	return old.SpeedrunTimer == current.SpeedrunTimer;
}

exit
{
	timer.IsGameTimePaused = true;
}
