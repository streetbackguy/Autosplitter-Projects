state("Barbie Horse")
{
    int Loads: 0x376FD8;
    int Minigame: 0x169EF0;
    int MainMenu: 0x35B4B4;
    int AreaID: 0x36F5ED;
}

startup
{
    vars.Splits = new HashSet<string>();

    settings.Add("BMR", true, "Barbie Horse Adventures: Mystery Ride");
        settings.Add("minigame", true, "Split after each Minigame", "BMR");
        settings.Add("river", true, "Split on entering the River area", "BMR");
        settings.Add("cave", true, "Split on entering the Cave area", "BMR");
        settings.Add("desert", true, "Split on entering the Desert area after Canyon Race", "BMR");
        settings.Add("desert2", true, "Alternate Canyon Race Split after exiting Fruit Puzzle", "BMR");
        settings.Add("end", true, "Split on exiting the final stable", "BMR");
}

start
{
    return (old.Loads == 1 && current.Loads == 0);
}

split
{
    if (current.AreaID == 1144862801 && old.AreaID == 1010645073 && !vars.Splits.Contains("river"))
    {
        vars.Splits.Add("river");
        return settings["river"];
    }

    if (current.AreaID == 1279080529 && old.AreaID == 943536209 && !vars.Splits.Contains("cave"))
    {
        vars.Splits.Add("cave");
        return settings["cave"];
    }

    if (current.AreaID == 943536209 && old.AreaID == 1413298257 && !vars.Splits.Contains("desert"))
    {
        vars.Splits.Add("desert");
        return settings["desert"];
    }

    if (current.AreaID == 943536209 && old.Minigame == 1 && !vars.Splits.Contains("desert"))
    {
        vars.Splits.Add("desert2");
        return settings["desert2"];
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
