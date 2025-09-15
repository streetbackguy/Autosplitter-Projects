state("retroarch")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("Genesis");
    vars.Log = (Action<object>)(output => print("[LandStalkers - The Treasure of King Nole] " + output));

    vars.RedJewel = vars.Helper.Make<byte>(0x1054);
    vars.Lithograph = vars.Helper.Make<byte>(0x1086);
    vars.SafetyPass = vars.Helper.Make<byte>(0x1059);
    vars.MagicSword = vars.Helper.Make<byte>(0x1197);
    vars.SteelBreastplate = vars.Helper.Make<byte>(0xf9a);
    vars.EinsteinWhistle = vars.Helper.Make<byte>(0x1050);
    vars.SunStone = vars.Helper.Make<byte>(0x104f);
    vars.ChromeShellBreastplate = vars.Helper.Make<byte>(0x1045);
    vars.MarsStoneHyperBreastplate = vars.Helper.Make<byte>(0x1046);
    vars.IronHealingBoots = vars.Helper.Make<byte>(0x1043);
    vars.SwordofIce = vars.Helper.Make<byte>(0x1041);
    vars.AxeMagic = vars.Helper.Make<byte>(0x104b);
    vars.ThunderSword = vars.Helper.Make<byte>(0x1098);
    vars.SwordofGaiaFireproofBoots = vars.Helper.Make<byte>(0x1042);
    vars.SaturnMoonStone = vars.Helper.Make<byte>(0x1047);
    vars.GolaEye = vars.Helper.Make<byte>(0x1055);
    vars.GolaNail = vars.Helper.Make<byte>(0x108f);
    vars.VenusStone = vars.Helper.Make<byte>(0x1048);
    vars.SnowSpikes = vars.Helper.Make<byte>(0x1044);
    vars.GolaFangHorn = vars.Helper.Make<byte>(0x1090);
    vars.DeathStatue = vars.Helper.Make<byte>(0x1056);
    vars.Map = vars.Helper.Make<short>(0x1204);
    vars.GolaHealth = vars.Helper.Make<byte>(0x553e);
    vars.KingNoleHealth = vars.Helper.Make<short>(0x55bd);
    vars.NewGame = vars.Helper.Make<byte>(0x505);

    settings.Add("LTTOKN", true, "Landstalkers: The Treasure of King Nole (Genesis) Splits");
        settings.Add("ANY", true, "Any% Splits", "LTTOKN");

    vars.MapSplits = new Dictionary<string, string>
    {
        { "426177", "Enter Waterfall Shrine" },
        { "177426", "Leave Waterfall Shrine" },
        { "4335", "Enter Swamp Shrine" },
        { "5433", "Leave Swamp Shrine" },
        { "RedJewel", "Obtain Red Jewel"},
        { "183185", "Enter Hideout" },
        { "Lithograph", "Obtain Lithograph" },
        { "186183", "Leave Hideout" },
        { "SafetyPass", "Obtain Safety Pass" },
        { "533815", "Enter Tibor" },
        { "815533", "Leave Tibor" },
        { "MagicSword", "Obtain Magic Sword"},
        { "475751", "Enter Mirs Tower" },
        { "781475", "Leave Mirs Tower" },
        { "8091", "Enter Castle Dungeon" },
        { "11035", "Leave Castle Dungeon" },
        { "SteelBreastplate", "Obtain Steel Breastplate" },
        { "DeathStatue", "Obtain Death Statue" },
        { "EinsteinWhistle", "Obtain Einstein Whistle" },
        { "SunStone", "Obtain Sun Stone" },
        { "470238", "Enter Verla Mines" },
        { "ChromeShellBreastplate", "Obtain Chrome Breastplate" },
        { "471472", "Leave Verla Mines" },
        { "MarsStone", "Obtain Mars Stone" },
        { "726271", "Enter Destel Well" },
        { "HealingBoots", "Obtain Healing Boots" },
        { "290545", "Leave Destel Well" },
        { "524308", "Enter Lake Shrine" },
        { "SwordofIce", "Obtain Sword of Ice" },
        { "ShellBreastplate", "Obtain Shell Breastplate" },
        { "AxeMagic", "Obtain Axe Magic" },
        { "ThunderSword", "Obtain Thunder Sword" },
        { "460506", "Maze Skip" },
        { "492509", "Death Statue Skip" },
        { "592804", "Enter Massan Dungeon" },
        { "FireproofBoots", "Obtain Fireproof Boots" },
        { "441480", "Enter Witch Helga's Hut" },
        { "SaturnStone", "Obtain Saturn Stone" },
        { "GolaEye", "Obtain Gola's Eye" },
        { "MoonStone", "Obtain Moon Stone" },
        { "737738", "Enter Last Dungeon" },
        { "SwordOfGaia", "Obtain Sword of Gaia" },
        { "IronBoots", "Obtain Iron Boots" },
        { "GolaNail", "Obtain Gola's Nail" },
        { "VenusStone", "Obtain Venus Stone" },
        { "SnowSpikes", "Obtain Snow Spikes" },
        { "GolaFang", "Obtain Gola's Fang" },
        { "HyperBreastplate", "Obtain Hyper Breastplate" },
        { "GolaHorn", "Obtain Gola's Horn" },
        { "422122", "Enter Nole's Palace" },
        { "121114", "Finished Nole's Palace" },
        { "KingNole", "King Nole's Death" },
        { "Gola", "Defeat Gola" },
    };

    foreach (var Tag in vars.MapSplits)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "ANY");
    	};

    vars.Splits = new HashSet<string>();
}

update
{
    if(vars.Map.Current != vars.Map.Old)
    {
        vars.Log("Map: " + vars.Map.Current);
    }

    if(vars.GolaHealth.Current != vars.GolaHealth.Old)
    {
        vars.Log("Item: " + vars.GolaHealth.Current);
    }
}

split
{
    // Map Change Splits
    if(vars.Map.Current != vars.Map.Old && !vars.Splits.Contains(vars.Map.Old.ToString()+vars.Map.Current.ToString()))
    {
        return settings[vars.Map.Old.ToString()+vars.Map.Current.ToString()] && vars.Splits.Add(vars.Map.Old.ToString()+vars.Map.Current.ToString());
    }

    // Red Jewel
    if(vars.RedJewel.Current == 2 && vars.Map.Current == 593 && !vars.Splits.Contains("RedJewel"))
    {
        return settings["RedJewel"] && vars.Splits.Add("RedJewel");
    }

    // Lithograph
    if(vars.Lithograph.Current == 216 && vars.Map.Current == 224 && !vars.Splits.Contains("Lithograph"))
    {
        return settings["Lithograph"] && vars.Splits.Add("Lithograph");
    }

    // // Safety Pass
    if(vars.SafetyPass.Current == 35 && vars.Map.Current == 622 && !vars.Splits.Contains("SafetyPass"))
    {
        return settings["SafetyPass"] && vars.Splits.Add("SafetyPass");
    }

    // // Magic Sword
    if(vars.MagicSword.Current == 1 && vars.Map.Current == 475 && !vars.Splits.Contains("MagicSword"))
    {
        return settings["MagicSword"] && vars.Splits.Add("MagicSword");
    }

    // Steel Breastplate
    if(vars.SteelBreastplate.Current == 2 && vars.Map.Current == 679 && !vars.Splits.Contains("SteelBreastplate"))
    {
        return settings["SteelBreastplate"] && vars.Splits.Add("SteelBreastplate");
    }

    // Death Statue
    if(vars.DeathStatue.Current == 2 && vars.Map.Current == 697 && !vars.Splits.Contains("DeathStatue"))
    {
        return settings["DeathStatue"] && vars.Splits.Add("DeathStatue");
    }

    // Einstein Whistle
    if(vars.EinsteinWhistle.Current == 2 && vars.Map.Current == 560 && !vars.Splits.Contains("EinsteinWhistle"))
    {
        return settings["EinsteinWhistle"] && vars.Splits.Add("EinsteinWhistle");
    }
    
    // Sun Stone
    if(vars.SunStone.Current == 2 && vars.Map.Current == 564 && !vars.Splits.Contains("SunStone"))
    {
        return settings["SunStone"] && vars.Splits.Add("SunStone");
    }

    // // Chrome Breastplate
    if(vars.ChromeShellBreastplate.Current != vars.ChromeShellBreastplate.Old && vars.Map.Current == 263 && !vars.Splits.Contains("ChromeShellBreastplate"))
    {
        return settings["ChromeShellBreastplate"] && vars.Splits.Add("ChromeShellBreastplate");
    }

    // Mars Stone
    if(vars.MarsStoneHyperBreastplate.Current == 32 && vars.Map.Current == 483 && !vars.Splits.Contains("MarsStone"))
    {
        return settings["MarsStone"] && vars.Splits.Add("MarsStone");
    }

    // Healing Boots
    if(vars.IronHealingBoots.Current == 32 && vars.Map.Current == 288 && !vars.Splits.Contains("HealingBoots"))
    {
        return settings["HealingBoots"] && vars.Splits.Add("HealingBoots");
    }

    // Sword of Ice
    if(vars.SwordofIce.Current == 2 && vars.Map.Current == 345 && !vars.Splits.Contains("SwordofIce"))
    {
        return settings["SwordofIce"] && vars.Splits.Add("SwordofIce");
    }

    // // Shell Breastplate
    if(vars.ChromeShellBreastplate.Current == 32 && vars.Map.Current == 333 && !vars.Splits.Contains("ShellBreastplate"))
    {
        return settings["ShellBreastplate"] && vars.Splits.Add("ShellBreastplate");
    }

    // Axe Magic
    if(vars.AxeMagic.Current == 32 && vars.Map.Current == 784 && !vars.Splits.Contains("AxeMagic"))
    {
        return settings["AxeMagic"] && vars.Splits.Add("AxeMagic");
    }

    // Thunder Sword
    if(vars.ThunderSword.Current == 101 && vars.Map.Current == 712 && !vars.Splits.Contains("ThunderSword"))
    {
        return settings["ThunderSword"] && vars.Splits.Add("ThunderSword");
    }

    // Fireproof Boots
    if(vars.SwordofGaiaFireproofBoots.Current == 32 && vars.Map.Current == 807 && !vars.Splits.Contains("FireproofBoots"))
    {
        return settings["FireproofBoots"] && vars.Splits.Add("FireproofBoots");
    }

    // // Saturn Stone
    if(vars.SaturnMoonStone.Current == 32 && vars.Map.Current == 479 && !vars.Splits.Contains("SaturnStone"))
    {
        return settings["SaturnStone"] && vars.Splits.Add("SaturnStone");
    }

    // Gola's Eye
    if(vars.GolaEye.Current == 33 && vars.Map.Current == 492 && !vars.Splits.Contains("GolaEye"))
    {
        return settings["GolaEye"] && vars.Splits.Add("GolaEye");
    }

    // Moon Stone
    if(vars.SaturnMoonStone.Current == 34 && vars.Map.Current == 553 && !vars.Splits.Contains("MoonStone"))
    {
        return settings["MoonStone"] && vars.Splits.Add("MoonStone");
    }

    // Sword of Gaia
    if(vars.SwordofGaiaFireproofBoots.Current == 2 && vars.Map.Current == 363 && !vars.Splits.Contains("SwordOfGaia"))
    {
        return settings["SwordOfGaia"] && vars.Splits.Add("SwordOfGaia");
    }

    // Iron Boots
    if(vars.IronHealingBoots.Current == 2 && vars.Map.Current == 374 && !vars.Splits.Contains("IronBoots"))
    {
        return settings["IronBoots"] && vars.Splits.Add("IronBoots");
    }

    // Gola's Nail
    if(vars.GolaNail.Current == 28 && vars.Map.Current == 404 && !vars.Splits.Contains("GolaNail"))
    {
        return settings["GolaNail"] && vars.Splits.Add("GolaNail");
    }

    // Venus Stone
    if(vars.VenusStone.Current == 2 && vars.Map.Current == 399 && !vars.Splits.Contains("VenusStone"))
    {
        return settings["VenusStone"] && vars.Splits.Add("VenusStone");
    }

    // Snow Spikes
    if(vars.SnowSpikes.Current == 2 && vars.Map.Current == 418 && !vars.Splits.Contains("VenusStone"))
    {
        return settings["SnowSpikes"] && vars.Splits.Add("SnowSpikes");
    }

    // Gola's Fang
    if(vars.GolaFangHorn.Current == 226 && vars.Map.Current == 410 && !vars.Splits.Contains("GolaFang"))
    {
        return settings["GolaFang"] && vars.Splits.Add("GolaFang");
    }

    // Hyper Breastplate
    if(vars.MarsStoneHyperBreastplate.Current == 2 && vars.Map.Current == 411 && !vars.Splits.Contains("HyperBreastplate"))
    {
        return settings["HyperBreastplate"] && vars.Splits.Add("HyperBreastplate");
    }

    // Gola's Horn
    if(vars.GolaFangHorn.Current == 246 && vars.Map.Current == 417 && !vars.Splits.Contains("GolaHorn"))
    {
        return settings["GolaHorn"] && vars.Splits.Add("GolaHorn");
    }

    // King Nole
    if(vars.KingNoleHealth.Current < 100 && vars.KingNoleHealth.Old >= 100 && vars.Map.Current == 111 && !vars.Splits.Contains("KingNole"))
    {
        return settings["KingNole"] && vars.Splits.Add("KingNole");
    }

    // Gola
    if(vars.GolaHealth.Current < 100 && vars.GolaHealth.Old >= 100 && vars.Map.Current == 112)
    {
        return settings["Gola"] && vars.Splits.Add("Gola");
    }
}

start
{
    return vars.NewGame.Current != 0 && vars.NewGame.Old == 0;
}

onStart
{
    vars.Splits.Clear();
}
