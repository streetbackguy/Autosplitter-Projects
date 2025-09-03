state("retroarch")
{}

init
{
    vars.Splits = new HashSet<string>();
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("Genesis");

    
    vars.RoundFinish = vars.Helper.Make<short>(0x37A7);
    vars.RoundStage = vars.Helper.Make<short>(0x37AC);
    vars.LastBossDeath = vars.Helper.Make<byte>(0x984F);
    vars.Start = vars.Helper.Make<bool>(0x42);

    settings.Add("SHIN3", true, "Shinobi 3: Return of the Ninja Master");
        settings.Add("ZeedsResurrection", true, "Beat Round 1: Zeed's Resurrection", "SHIN3");
        settings.Add("SecretEntry", true, "Beat Round 2: Secret Entry", "SHIN3");
        settings.Add("BodyWeapon", true, "Beat Round 3: Body Weapon", "SHIN3");
        settings.Add("Destruction", true, "Beat Round 4: Destruction", "SHIN3");
        settings.Add("ElectricDemon", true, "Beat Round 5: Electric Demon", "SHIN3");
        settings.Add("Traps", true, "Beat Round 6: Traps", "SHIN3");
        settings.Add("TheFinalConfrontation", true, "Beat Round 7: The Final Confrontation", "SHIN3");
}

start
{
    return vars.Start.Current && !vars.Start.Old;
}

onStart
{
    vars.Splits.Clear();
}

update
{
    if(vars.LastBossDeath.Current != vars.LastBossDeath.Old)
    {
        print(vars.LastBossDeath.Current.ToString());
    }
}

split
{
    if(vars.RoundFinish.Current == 1792 && vars.RoundFinish.Old == 1794 && vars.RoundStage.Current == 2 && !vars.Splits.Contains("ZeedsResurrection"))
    {
        return settings["ZeedsResurrection"] && vars.Splits.Add("ZeedsResurrection");
    }

    if(vars.RoundFinish.Current == 1792 && vars.RoundFinish.Old == 1794 && vars.RoundStage.Current == 258 && !vars.Splits.Contains("SecretEntry"))
    {
        return settings["SecretEntry"] && vars.Splits.Add("SecretEntry");
    }

    if(vars.RoundFinish.Current == 1792 && vars.RoundFinish.Old == 1794 && vars.RoundStage.Current == 514 && !vars.Splits.Contains("BodyWeapon"))
    {
        return settings["BodyWeapon"] && vars.Splits.Add("BodyWeapon");
    }

    if(vars.RoundFinish.Current == 1792 && vars.RoundFinish.Old == 1794 && vars.RoundStage.Current == 770 && !vars.Splits.Contains("Destruction"))
    {
        return settings["Destruction"] && vars.Splits.Add("Destruction");
    }

    if(vars.RoundFinish.Current == 1792 && vars.RoundFinish.Old == 1794 && vars.RoundStage.Current == 1026 && !vars.Splits.Contains("ElectricDemon"))
    {
        return settings["ElectricDemon"] && vars.Splits.Add("ElectricDemon");
    }

    if(vars.RoundFinish.Current == 1792 && vars.RoundFinish.Old == 1794 && vars.RoundStage.Current == 1282 && !vars.Splits.Contains("Traps"))
    {
        return settings["Traps"] && vars.Splits.Add("Traps");
    }

    if(vars.LastBossDeath.Current == 0 && vars.RoundStage.Old == 1538 && !vars.Splits.Contains("TheFinalConfrontation"))
    {
        return settings["TheFinalConfrontation"] && vars.Splits.Add("TheFinalConfrontation");
    }
}

exit
{
    timer.IsGameTimePaused = true;
}