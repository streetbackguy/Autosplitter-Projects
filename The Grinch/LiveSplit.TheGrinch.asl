state("TheGrinch")
{
    byte FirstInput: 0xD6BB9;
    byte JumpInput: 0xD6C03;
    byte Map: 0xD3D14;
    bool Loads: 0xD45BA;
    sbyte SantaHealth: 0xD4A20;
}

startup
{
    settings.Add("TG", true, "The Grinch (PC) Splits");

    vars.LevelsAny = new Dictionary<string, string>
    {
        { "Crumpit", "Split on each time Leaving Mt. Crumpit" },
        { "Level", "Split on each time Leaving a Level" },
        { "Santa", "Santa Defeated" }
    };

    foreach (var Tag in vars.LevelsAny)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "TG");
    	};
}

update
{
    if(current.Map != old.Map)
    {
        print("Map: " + current.Map);
    }
}

split
{
    // Split when accessing a new area/map
    if(current.Map != old.Map && old.Map == 5 && current.Map != 6)
    {
        return settings["Crumpit"];
    }

    if(current.Map == 5 && old.Map != 5 && old.Map != 6)
    {
        return settings["Level"];
    }

    if(current.Map == 25 && current.SantaHealth == 0 && old.SantaHealth > 0)
    {
        return settings["Santa"];
    }
}

start
{
    return current.Map == 5 && current.FirstInput == 15 && old.FirstInput == 16 || current.Map == 5 && current.JumpInput == 255 && old.JumpInput == 0;
}

isLoading
{
    return current.Loads;
}

reset
{
    return current.Map == 64;
}

exit
{
    timer.IsGameTimePaused = true;
}
