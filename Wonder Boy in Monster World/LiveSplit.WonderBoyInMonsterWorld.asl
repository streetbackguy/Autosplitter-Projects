state("RetroArch")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("SMS");
    
    vars.Log = (Action<object>)(output => print("[Wonder Boy in Monster World] " + output));
    vars.Splits = new HashSet<string>();
    
    vars.GameStart      = vars.Helper.Make<byte>(0xC033);
    vars.GameReset      = vars.Helper.Make<byte>(0xD600);
    vars.RoomId         = vars.Helper.Make<byte>(0xC600);
    vars.LeatherBoots   = vars.Helper.Make<byte>(0xC5AB);
    vars.FirestormMagic = vars.Helper.Make<byte>(0xCD14);
    vars.KnightSword    = vars.Helper.Make<byte>(0xC599);
    vars.Trident        = vars.Helper.Make<byte>(0xC59A);
    vars.DesertBoots    = vars.Helper.Make<byte>(0xC5AC);
    vars.CeramicBoots   = vars.Helper.Make<byte>(0xC5AD);
    vars.AxeOfAncients  = vars.Helper.Make<byte>(0xC5BE);
    vars.SacredFlame    = vars.Helper.Make<byte>(0xC0EC);
    vars.LegendarySword = vars.Helper.Make<byte>(0xC59C);
    vars.LegendaryBoots = vars.Helper.Make<byte>(0xC5AE);
    vars.LegendaryArmor = vars.Helper.Make<byte>(0xC5A3);
    vars.BossBioMeka    = vars.Helper.Make<byte>(0xC6AE);

    settings.Add("WBIMW", true, "Wonder Boy in Monster World (Sega Master System) splits:");
        settings.Add("S1", true, "Get Leather Boots", "WBIMW");
        settings.Add("S2", true, "Get Firestorm", "WBIMW");
        settings.Add("S3", true, "Get Knight Sword", "WBIMW");
        settings.Add("S4", true, "Get Trident", "WBIMW");
        settings.Add("S5", true, "Get Desert Boots", "WBIMW");
        settings.Add("S6", true, "Get Ceramic Boots", "WBIMW");
        settings.Add("S7", true, "Get Axe of the Ancients", "WBIMW");
        settings.Add("S8", true, "Get Sacred Flame", "WBIMW");
        settings.Add("S9", true, "Get Legendary Sword", "WBIMW");
        settings.Add("S10", true, "Get Legendary Boots", "WBIMW");
        settings.Add("S11", true, "Get Legendary Armor", "WBIMW");
        settings.Add("S12", true, "Final Boss Dead", "WBIMW");
}

update
{
  
}

split
{
    if(vars.LeatherBoots.Current == 1 && vars.LeatherBoots.Old == 0)
        return settings["S1"] && vars.Splits.Add("S1");
    if(vars.FirestormMagic.Current == 1 && vars.FirestormMagic.Old == 0)
        return settings["S2"] && vars.Splits.Add("S2");
    if(vars.KnightSword.Current == 1 && vars.KnightSword.Old == 0)
        return settings["S3"] && vars.Splits.Add("S3");
    if(vars.Trident.Current == 1 && vars.Trident.Old == 0)
        return settings["S4"] && vars.Splits.Add("S4");
    if(vars.DesertBoots.Current == 1 && vars.DesertBoots.Old == 0)
        return settings["S5"] && vars.Splits.Add("S5");
    if(vars.CeramicBoots.Current == 1 && vars.CeramicBoots.Old == 0)
        return settings["S6"] && vars.Splits.Add("S6");
    if(vars.AxeOfAncients.Current == 1 && vars.AxeOfAncients.Old == 0)
        return settings["S7"] && vars.Splits.Add("S7");
    if(vars.SacredFlame.Current == 1 && vars.SacredFlame.Old == 0)
        return settings["S8"] && vars.Splits.Add("S8");
    if(vars.LegendarySword.Current == 1 && vars.LegendarySword.Old == 0)
        return settings["S9"] && vars.Splits.Add("S9");
    if(vars.LegendaryBoots.Current == 1 && vars.LegendaryBoots.Old == 0)
        return settings["S10"] && vars.Splits.Add("S10");
    if(vars.LegendaryArmor.Current == 1 && vars.LegendaryArmor.Old == 0)
        return settings["S11"] && vars.Splits.Add("S11");
    if(vars.RoomId.Current == 47 && vars.BossBioMeka.Current == 1 && vars.BossBioMeka.Old == 0)
        return settings["S12"] && vars.Splits.Add("S12");
}

start
{
    return vars.GameStart.Old == 23 && vars.GameStart.Current != 23;
}

onStart
{
    vars.Splits.Clear();
}

reset
{
    return vars.GameReset.Current == 0 && vars.GameReset.Old != 0;
}
