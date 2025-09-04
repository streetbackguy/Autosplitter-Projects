state("TheGrinch")
{
    byte FirstInput: 0xD6BB9;
    byte JumpInput: 0xD6C03;
    byte Map: 0xD3D14;
    bool Loads: 0xD45BA;
    int SantaHealth: 0x0;
}

startup
{
    settings.Add("TG", true, "The Grinch (PC) Splits");
        settings.Add("ANY", true, "Any% Splits", "TG");
        settings.Add("100", false, "100% Splits", "TG");

    vars.LevelsAny = new Dictionary<string, string>
    {
        { "AnyTutorial", "Finish Mt. Crumpit Tutorial" },
        { "AnyDW1", "First Visit to Downtown Whoville" },
        { "AnyRE", "Obtain Rotten Egg Lanucher and Enter Whoforest" },
        { "AnyWF1", "First Visit to Whoforest" },
        { "AnyRS", "Obtain Rocket Spring and Enter Whoforest" },
        { "AnyWF2", "Second Visit to Whoforest" },
        { "AnyDG", "Dump Guardian Shaved" },
        { "AnyD1", "First Visit to Dump" },
        { "AnySS1", "Enter Wholake's North Shore" },
        { "AnyNS1", "First Visit to Wholake's North Shore" },
        { "AnyMM", "Obtain Marine Mobile and Enter Downtown Whoville" },
        { "AnySS", "All Sleigh Parts" },
        { "AnySanta", "Santa Defeated" }
    };

    // vars.Levels100 = new Dictionary<string, string>
    // {
    //     { "Tutorial", "Finish Mt. Crumpit Tutorial" },
    //     { "DW1", "First Visit to Downtown Whoville" },
    //     { "RE", "Obtain Rotten Egg Launcher" },
    //     { 9, "Countdown to Christmas Tower" },
    //     { 10, "Whoville Post Office" },
    //     { 11, "Whoforest" },
    //     { 12, "Mountain Ski Resort" },
    //     { 13, "Mountain Civic Center" },
    //     { 14, "Whoville Dump" },
    //     { 15, "Generator Building" },
    //     { 16, "Whoville Power Plant" },
    //     { 17, "Minefield" },
    //     { 18, "Wholake South Shore" },
    //     { 19, "Lakemaster's Cabin" },
    //     { 20, "Wholake North Shore" },
    //     { 22, "Mayor's Villa" },
    //     { 23, "Wholake Submarine World" },
    //     { 25, "Sleigh Ride" },
    //     { "Santa", "Santa Defeated" }
    // };

    vars.Missions100 = new Dictionary<string, string>
    {
        { "Mail", "Shuffling The Mail" },
        { "Snowmen", "Smashing Snowmen" },
        { "Posters", "Painting The Mayor's Posters" },
        { "Eggs", "Launching Eggs Into Houses" },
        { "Statue", "Modifying The Mayor's Statue" },
        { "Countdown", "Advancing The Countdown To Christmas Clock" },
        { "WhovilleGifts", "Squashing All The Gifts" },
        { "Trees", "Making Christmas Trees Droop" },
        { "Glue", "Sabotaging Snow Cannon With Glue" },
        { "Beehives", "Putting Beehives Into Cabins" },
        { "Skis", "Sliming The Mayor's Skis" },
        { "Cake", "Replacing The Candles On The Cake With Fireworks" },
        { "ForestGifts", "Squashing All Gifts" },
        { "Birds", "Stealing Food From Birds" },
        { "Computer", "Feeding Computer With Robots Parts" },
        { "Rats", "Infesting The Mayor's House With Rats" },
        { "Gas", "Conducting The Stinky Gas To Who-Bris' Shack" },
        { "Guardian", "Shaving The Dump Guardian" },
        { "PowerPlant", "Short-Circuiting Power Plant" },
        { "DumpGifts", "Squashing All Gifts" },
        { "Shorts", "Putting Thistles In Shorts" },
        { "Tents", "Sabotaging The Tents" },
        { "Canoes", "Drilling Holes In Canoes" },
        { "Marinemobile", "Modifying The Marinemobile" },
        { "Bed", "Hooking The Mayor's Bed To The Motorboat" },
        { "LakeGifts", "Squashing All Gifts" },
        { "Parts", "Getting The Parts For The Sleigh" },
        { "Santa", "Santa Defeated" }
    };

    foreach (var Tag in vars.LevelsAny)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "ANY");
    	};

    // foreach (var Tag in vars.Levels100)
	// 	{
    //         settings.Add(Tag.Key.ToString(), true, Tag.Value, "100");
    // 	};

    foreach (var Tag in vars.Missions100)
		{
			settings.Add(Tag.Key, true, Tag.Value, "100");
    	};

    vars.Splits = new HashSet<string>();
    vars.WhovilleVisits = 0;
    vars.WhoforestVisits = 0;
    vars.DumpVisits = 0;
    vars.WholakeVisits = 0;
}

update
{
    if(current.Map != old.Map)
    {
        print("Map: " + current.Map);
    }

    if(current.Map == 7 && old.Map == 5)
    {
        vars.WhovilleVisits++;
    }

    if(current.Map == 11 && old.Map == 5)
    {
        vars.WhoforestVisits++;
    }

    if(current.Map == 14 && old.Map == 5)
    {
        vars.DumpVisits++;
    }

    if(current.Map == 18 && old.Map == 5)
    {
        vars.WholakeVisits++;
    }
}

split
{
    if(current.Map != old.Map && settings["ANY"])
    {
        if(current.Map != old.Map && old.Map == 5 && current.Map != 6 && current.Map == 7 && !vars.Splits.Contains("AnyTutorial"))
        {
            return settings["AnyTutorial"] && vars.Splits.Add("AnyTutorial");
        }

        if(current.Map == 5 && old.Map == 7 && vars.WhovilleVisits == 1 && vars.WhovilleVisits == 0 && !vars.Splits.Contains("AnyDW1"))
        {
            return settings["AnyDW1"] && vars.Splits.Add("AnyDW1");
        }
        
        if(current.Map == 11 && old.Map == 5 && !vars.Splits.Contains("AnyRE"))
        {
            return settings["AnyRE"] && vars.Splits.Add("AnyRE");
        }

        if(current.Map == 5 && old.Map == 11 && vars.WhoforestVisits == 1 && !vars.Splits.Contains("AnyWF1"))
        {
            return settings["AnyWF1"] && vars.Splits.Add("AnyWF1");
        }
        
        if(current.Map == 11 && old.Map == 5 && vars.WhoforestVisits == 2 && !vars.Splits.Contains("AnyRS"))
        {
            return settings["AnyRS"] && vars.Splits.Add("AnyRS");
        }

        // if(current.Map == 17 && old.Map == 14 && !vars.Splits.Contains("AnyDG"))
        // {
        //     return settings["AnyDG"] && vars.Splits.Add("AnyDG");
        // }

        if(current.Map == 5 && old.Map == 14 && vars.DumpVisits == 1 && !vars.Splits.Contains("AnyD1"))
        {
            return settings["AnyD1"] && vars.Splits.Add("AnyD1");
        }

        if(current.Map == 20 && old.Map == 18 && vars.WholakeVisits == 1 && !vars.Splits.Contains("AnySS1"))
        {
            return settings["AnySS1"] && vars.Splits.Add("AnySS1");
        }

        if(current.Map == 5 && old.Map == 20 && vars.WholakeVisits == 1 && !vars.Splits.Contains("AnyNS1"))
        {
            return settings["AnyNS1"] && vars.Splits.Add("AnyNS1");
        }

        if(current.Map == 7 && old.Map == 5 && vars.WholakeVisits == 1 && !vars.Splits.Contains("AnyMM"))
        {
            return settings["AnyMM"] && vars.Splits.Add("AnyMM");
        }

        if(current.Map == 5 && old.Map == 18 && vars.WholakeVisits == 2 && !vars.Splits.Contains("AnySP"))
        {
            return settings["AnySP"] && vars.Splits.Add("AnySP");
        }

        if(current.Map == 25 && current.SantaHealth == 0 && old.SantaHealth > 0 && !vars.Splits.Contains("AnySanta"))
        {
            return settings["AnySanta"] && vars.Splits.Add("AnySanta");
        }
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

onStart
{
    vars.Splits.Clear();
    vars.WhovilleVisits = 0;
    vars.WhoforestVisits = 0;
    vars.DumpVisits = 0;
    vars.WholakeVisits = 0;
}

reset
{
    return current.Map == 64;
}

exit
{
    timer.IsGameTimePaused = true;
}
