state("Livesplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS1");
    vars.Log = (Action<object>)(output => print("[The Grinch] " + output));

    vars.Map = vars.Helper.Make<byte>(0x80010000);
    vars.MovementInput = vars.Helper.Make<byte>(0x80010009);
    vars.JumpInput = vars.Helper.Make<byte>(0x80093f85);
    vars.Loading = vars.Helper.Make<bool>(0x8008f8dc);
    vars.SantaHealth = vars.Helper.Make<int>(0x80095305);
    vars.Missions1 = vars.Helper.Make<byte>(0x800100be);
    vars.Missions2 = vars.Helper.Make<byte>(0x800100bf);
    vars.Snowmen = vars.Helper.Make<byte>(0x800100c5);
    vars.MayorsPosters = vars.Helper.Make<byte>(0x800100c6);
    vars.WindowsEgged = vars.Helper.Make<byte>(0x800100c7);
    vars.ChristmasTrees = vars.Helper.Make<byte>(0x800100c8);
    vars.CabinBeehives = vars.Helper.Make<byte>(0x800100ca);
    vars.Birdfood = vars.Helper.Make<byte>(0x800100cb);
    vars.RobotParts = vars.Helper.Make<byte>(0x800100cc);
    vars.StinkyGas = vars.Helper.Make<byte>(0x800100cd);
    vars.Generators = vars.Helper.Make<byte>(0x800100df);
    vars.Thistles = vars.Helper.Make<byte>(0x800100e5);
    vars.Tents = vars.Helper.Make<byte>(0x800100e6);
    vars.Mail = vars.Helper.Make<byte>(0x800100e7);
    vars.Canoes = vars.Helper.Make<byte>(0x800100ee);
    vars.Rats = vars.Helper.Make<byte>(0x800100fe);

    settings.Add("TGPS1", true, "The Grinch (PS1) Splits");
        settings.Add("LEVEL", true, "Room/Level Splits", "TGPS1");
        settings.Add("MISSION", true, "Mission Splits", "TGPS1");

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

    vars.Missions = new Dictionary<string, string>
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

    foreach (var Tag in vars.Levels)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "LEVEL");
    	};

    foreach (var Tag in vars.Missions)
		{
			settings.Add(Tag.Key, true, Tag.Value, "MISSION");
    	};

    vars.Splits = new HashSet<string>();
}

init
{

}

update
{
    if(vars.Map.Current != vars.Map.Old)
    {
        vars.Log("Map: " + vars.Map.Current.ToString());
    }

    if(vars.Missions1.Current != vars.Missions1.Old)
    {
        vars.Log("Missions 1: " + vars.Missions1.Current.ToString());
    }

    if(vars.Missions2.Current != vars.Missions2.Old)
    {
        vars.Log("Missions 2: " + vars.Missions2.Current.ToString());
    }
}

split
{
    // Split when accessing a new area/map
    if(vars.Map.Current != vars.Map.Old && vars.Map.Old == 7 && vars.Map.Current == 8 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 7 && vars.Map.Current == 9 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 7 && vars.Map.Current == 10 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 11 && vars.Map.Current == 12 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 11 && vars.Map.Current == 13 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 11 && vars.Map.Current == 35 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 14 && vars.Map.Current == 15 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 14 && vars.Map.Current == 16 ||
    vars.Map.Current != vars.Map.Old && vars.Map.Old == 14 && vars.Map.Current == 17)
    {
        return settings[vars.Map.Current.ToString()];
    }

    // Mission Splits that require multiple things
    if(vars.Mail.Current == 5 && vars.Mail.Old < 5)
    {
        return settings["Mail"] && vars.Splits.Add("Mail");
    }
    if(vars.Snowmen.Current == 10 && vars.Snowmen.Old < 10)
    {
        return settings["Snowmen"] && vars.Splits.Add("Snowmen");
    }
    if(vars.MayorsPosters.Current == 10 && vars.MayorsPosters.Old < 10)
    {
        return settings["Posters"] && vars.Splits.Add("Posters");
    }
    if(vars.WindowsEgged.Current == 10 && vars.WindowsEgged.Old < 10)
    {
        return settings["Eggs"] && vars.Splits.Add("Eggs");
    }
    if(vars.ChristmasTrees.Current == 10 && vars.ChristmasTrees.Old < 10)
    {
        return settings["Trees"] && vars.Splits.Add("Trees");
    }
    if(vars.CabinBeehives.Current == 10 && vars.CabinBeehives.Old < 10)
    {
        return settings["Beehives"] && vars.Splits.Add("Beehives");
    }
    if(vars.Birdfood.Current == 10 && vars.Birdfood.Old < 10)
    {
        return settings["Birds"] && vars.Splits.Add("Birds");
    }
    if(vars.Thistles.Current == 10 && vars.Thistles.Old < 10)
    {
        return settings["Shorts"] && vars.Splits.Add("Shorts");
    }
    if(vars.Tents.Current == 10 && vars.Tents.Old < 10)
    {
        return settings["Tents"] && vars.Splits.Add("Tents");
    }
    if(vars.Canoes.Current == 10 && vars.Canoes.Old < 10)
    {
        return settings["Canoes"] && vars.Splits.Add("Canoes");
    }

    // Mission Splits that only have one objective
    if(vars.Missions1.Old != vars.Missions1.Current && vars.Missions1.Current == vars.Missions1.Old+2)
    {
        return settings["Statue"] && vars.Splits.Add("Statue");
    }
    if(vars.Missions1.Old != vars.Missions1.Current && vars.Missions1.Current == vars.Missions1.Old+4)
    {
        return settings["Countdown"] && vars.Splits.Add("Countdown");
    }
    if(vars.Missions1.Old != vars.Missions1.Current && vars.Missions1.Current == vars.Missions1.Old+8)
    {
        return settings["Glue"] && vars.Splits.Add("Glue");
    }
    if(vars.Missions1.Old != vars.Missions1.Current && vars.Missions1.Current == vars.Missions1.Old+16)
    {
        return settings["Skis"] && vars.Splits.Add("Skis");
    }
    if(vars.Missions1.Old != vars.Missions1.Current && vars.Missions1.Current == vars.Missions1.Old+32)
    {
        return settings["Cake"] && vars.Splits.Add("Cake");
    }
    if(vars.Missions1.Old != vars.Missions1.Current && vars.Missions1.Current == vars.Missions1.Old+64)
    {
        return settings["Rats"] && vars.Splits.Add("Rats");
    }
    if(vars.Missions1.Old != vars.Missions1.Current && vars.Missions1.Current == vars.Missions1.Old+128)
    {
        return settings["Gas"] && vars.Splits.Add("Gas");
    }
    if(vars.Missions2.Old != vars.Missions2.Current && vars.Missions2.Current == vars.Missions2.Old+1)
    {
        return settings["Guardian"] && vars.Splits.Add("Guardian");
    }
    if(vars.Missions2.Old != vars.Missions2.Current && vars.Missions2.Current == vars.Missions2.Old+2)
    {
        return settings["PowerPlant"] && vars.Splits.Add("PowerPlant");
    }
    if(vars.Missions2.Old != vars.Missions2.Current && vars.Missions2.Current == vars.Missions2.Old+4)
    {
        return settings["Computer"] && vars.Splits.Add("Computer");
    }
    if(vars.Missions2.Old != vars.Missions2.Current && vars.Missions2.Current == vars.Missions2.Old+8)
    {
        return settings["Bed"] && vars.Splits.Add("Bed");
    }
    if(vars.Missions2.Old != vars.Missions2.Current && vars.Missions2.Current == vars.Missions2.Old+16)
    {
        return settings["Marinemobile"] && vars.Splits.Add("Marinemobile");
    }

    // Split for defeating Santa at the end of the game
    if(vars.SantaHealth.Old > vars.SantaHealth.Current && vars.SantaHealth.Current == 0 && vars.Map.Current == 25)
    {
        return settings["Santa"] && vars.Splits.Add("Santa");
    }
}

start
{
    return vars.Map.Current == 5 && vars.MovementInput.Current != 0 && vars.MovementInput.Old == 0 || vars.Map.Current == 5 && vars.JumpInput.Current == 228;
}

isLoading
{
    return vars.Loading.Current;
}

onStart
{
    vars.Splits.Clear();
}

reset
{
    return vars.Map.Current == 0 && vars.Map.Old != 0;
}