state("TheGrinch")
{
    byte FirstInput: 0xD6BB9;
    byte JumpInput: 0xD6C03;
    byte Map: 0xD3D14;
    bool Loads: 0xD45BA;
}

startup
{
    settings.Add("TG", true, "The Grinch (PC) Splits");
        settings.Add("LEVEL", true, "Room/Level Splits", "TG");
        // settings.Add("MISSION", true, "Mission Splits", "TG");

    vars.Levels = new Dictionary<byte, string>
    {
        { 0, "Title Screen" },
        { 2, "Language Select" },
        { 5, "Mt. Crumpit" },
        { 7, "Downtown Whoville" },
        { 8, "Whoville City Hall" },
        { 9, "Countdown to Christmas Tower" },
        { 10, "Whoville Post Office" },
        { 11, "Whoforest" },
        { 12, "Mountain Ski Resort" },
        { 13, "Mountain Civic Center" },
        { 14, "Whoville Dump" },
        { 15, "Generator Building" },
        { 16, "Whoville Power Plant" },
        { 17, "Minefield" },
        { 18, "Wholake South Shore" },
        { 19, "Lakemaster's Cabin" },
        { 20, "Wholake North Shore" },
        { 22, "Mayor's Villa" },
        { 23, "Wholake Submarine World" },
        { 25, "Sleigh Ride" },
    };

    // vars.Missions = new Dictionary<string, string>
    // {
    //     { "Mail", "Shuffling The Mail" },
    //     { "Snowmen", "Smashing Snowmen" },
    //     { "Posters", "Painting The Mayor's Posters" },
    //     { "Eggs", "Launching Eggs Into Houses" },
    //     { "Statue", "Modifying The Mayor's Statue" },
    //     { "Countdown", "Advancing The Countdown To Christmas Clock" },
    //     { "WhovilleGifts", "Squashing All The Gifts" },
    //     { "Trees", "Making Christmas Trees Droop" },
    //     { "Glue", "Sabotaging Snow Cannon With Glue" },
    //     { "Beehives", "Putting Beehives Into Cabins" },
    //     { "Skis", "Sliming The Mayor's Skis" },
    //     { "Cake", "Replacing The Candles On The Cake With Fireworks" },
    //     { "ForestGifts", "Squashing All Gifts" },
    //     { "Birds", "Stealing Food From Birds" },
    //     { "Computer", "Feeding Computer With Robots Parts" },
    //     { "Rats", "Infesting The Mayor's House With Rats" },
    //     { "Gas", "Conducting The Stinky Gas To Who-Bris' Shack" },
    //     { "Guardian", "Shaving The Dump Guardian" },
    //     { "PowerPlant", "Short-Circuiting Power Plant" },
    //     { "DumpGifts", "Squashing All Gifts" },
    //     { "Shorts", "Putting Thistles In Shorts" },
    //     { "Tents", "Sabotaging The Tents" },
    //     { "Canoes", "Drilling Holes In Canoes" },
    //     { "Marinemobile", "Modifying The Marinemobile" },
    //     { "Bed", "Hooking The Mayor's Bed To The Motorboat" },
    //     { "LakeGifts", "Squashing All Gifts" },
    //     { "Parts", "Getting The Parts For The Sleigh" },
    //     { "Santa", "Santa Defeated" }
    // };

    foreach (var Tag in vars.Levels)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "LEVEL");
    	};

    // foreach (var Tag in vars.Missions)
	// 	{
	// 		settings.Add(Tag.Key, true, Tag.Value, "MISSION");
    // 	};

    vars.Splits = new HashSet<string>();
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
    if(current.Map != old.Map && !vars.Splits.Contains(old.Map))
    {
        if(current.Map != old.Map && old.Map == 5 && current.Map != 6)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }
        
        if(current.Map == 8 && old.Map == 7)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 9 && old.Map == 7)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 10 && old.Map == 7)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 12 && old.Map == 11)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 13 && old.Map == 11)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 15 && old.Map == 14)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 16 && old.Map == 14)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 20 && old.Map == 18)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 23 && old.Map == 20)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
        }

        if(current.Map == 25)
        {
            return settings[current.Map.ToString()] && vars.Splits.Add(current.Map.ToString());
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
}

reset
{
    return current.Map == 64;
}

exit
{
    timer.IsGameTimePaused = true;
}