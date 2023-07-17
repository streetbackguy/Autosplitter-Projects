state("Viva Pinata")
{
    byte Start: 0x7D85BF;
    byte Loads: 0x82B84C;
    int GardenLevel: 0xB9A384;
    byte GameState: 0xAEC72C;
}

init
{
    vars.Splits = new HashSet<string>();
}

startup
{
    settings.Add("VP", true, "Viva Pinata");
        settings.Add("GLVL10", true, "Garden Level 10", "VP");
            settings.Add("LVL2", false, "Level 2", "GLVL10");
            settings.Add("LVL3", false, "Level 3", "GLVL10");
            settings.Add("LVL4", false, "Level 4", "GLVL10");
            settings.Add("LVL5", false, "Level 5", "GLVL10");
            settings.Add("LVL6", false, "Level 6", "GLVL10");
            settings.Add("LVL7", false, "Level 7", "GLVL10");
            settings.Add("LVL8", false, "Level 8", "GLVL10");
            settings.Add("LVL9", false, "Level 9", "GLVL10");
            settings.Add("LVL10", false, "Level 10", "GLVL10");
        settings.Add("GPERCENT", true, "Garden%", "VP");
            settings.Add("LVL21", false, "Split upon reaching Level 21", "GPERCENT");
        settings.Add("MPERCENT", true, "Master%", "VP");
            settings.Add("LVL31", false, "Split upon reaching Level 31", "MPERCENT");
}

split
{
    if (current.GardenLevel != old.GardenLevel && old.GameState == 1 && !vars.Splits.Contains(current.GardenLevel.ToString()))
    {
        vars.Splits.Add("LVL" + current.GardenLevel.ToString());
        return settings["LVL" + current.GardenLevel.ToString()];
    }
}

isLoading
{
    return current.Loads != 0;
}

start
{
    return current.Loads == 0 && current.Start == 56 && old.Start == 57;
}

onReset
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
