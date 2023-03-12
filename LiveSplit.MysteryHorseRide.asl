state("Barbie Horse")
{
    int Loads: 0x376FD8;
    int AreaID: 0x1A8970;
    int Minigame: 0x169EF0;
    int MainMenu: 0x35B4B4;
}

startup
{
    vars.Splits = new HashSet<string>();

    settings.Add("BMR", true, "Barbie Horse Adventures: Mystery Ride");
        settings.Add("minigame", true, "Split after each Minigame", "BMR");
        settings.Add("river", true, "Split on entering the River area", "BMR");
        settings.Add("cave", true, "Split on entering the Cave area", "BMR");
        settings.Add("end", true, "Split on exiting the final Stable", "BMR");
}

start
{
    return (old.Loads == 1 && current.Loads == 0);
}

split
{
    if (current.AreaID == 13872 && old.AreaID == 49 && !vars.Splits.Contains("river"))
    {
        vars.Splits.Add("river");
        return settings["river"];
    }

    if (current.AreaID == 13872 && old.AreaID == 13824 && !vars.Splits.Contains("cave"))
    {
        vars.Splits.Add("cave");
        return settings["cave"];
    }

    if (current.Minigame == 0 && old.Minigame == 1)
    {
        vars.Splits.Add("minigame");
        return settings["minigame"];
    }

    if (current.Minigame == 0 && old.Minigame == 4)
    {
        vars.Splits.Add("end");
        return settings["end"];
    }
}

reset
{
    return (current.MainMenu == 1 && old.MainMenu == 0);
}

onReset
{
    vars.Splits.Clear();
}

isLoading
{
    return (current.Loads == 1 && current.Minigame == 0);
}

exit
{
    vars.Splits.Clear();
}