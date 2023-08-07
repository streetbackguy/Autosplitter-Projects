state("Viva Pinata")
{
    byte Start: 0xAEC8E8;
    byte Loads: 0x82B84C;
    int GardenLevel: 0xB9A384;
    string255 Awards: 0xB9D9A8;
}

startup
{
    vars.Splits = new HashSet<int>();

    settings.Add("VP", true, "Viva Pinata");
        settings.Add("GLVL10", true, "Garden Level 10", "VP");
            settings.Add("LVL2", true, "Level 2", "GLVL10");
            settings.Add("LVL3", true, "Level 3", "GLVL10");
            settings.Add("LVL4", true, "Level 4", "GLVL10");
            settings.Add("LVL5", true, "Level 5", "GLVL10");
            settings.Add("LVL6", true, "Level 6", "GLVL10");
            settings.Add("LVL7", true, "Level 7", "GLVL10");
            settings.Add("LVL8", true, "Level 8", "GLVL10");
            settings.Add("LVL9", true, "Level 9", "GLVL10");
            settings.Add("LVL10", true, "Level 10", "GLVL10");
        settings.Add("GPERCENT", true, "Garden%", "VP");
            settings.Add("LVL11", true, "Level 11", "GPERCENT");
            settings.Add("LVL12", true, "Level 12", "GPERCENT");
            settings.Add("LVL13", true, "Level 13", "GPERCENT");
            settings.Add("LVL14", true, "Level 14", "GPERCENT");
            settings.Add("LVL15", true, "Level 15", "GPERCENT");
            settings.Add("LVL16", true, "Level 16", "GPERCENT");
            settings.Add("LVL17", true, "Level 17", "GPERCENT");
            settings.Add("LVL18", true, "Level 18", "GPERCENT");
            settings.Add("LVL19", true, "Level 19", "GPERCENT");
            settings.Add("LVL20", true, "Level 20", "GPERCENT");
            settings.Add("LVL21", true, "Level 21", "GPERCENT");
        settings.Add("MPERCENT", true, "Master%", "VP");
            settings.Add("LVL22", true, "Level 22", "MPERCENT");
            settings.Add("LVL23", true, "Level 23", "MPERCENT");
            settings.Add("LVL24", true, "Level 24", "MPERCENT");
            settings.Add("LVL25", true, "Level 25", "MPERCENT");
            settings.Add("LVL26", true, "Level 26", "MPERCENT");
            settings.Add("LVL27", true, "Level 27", "MPERCENT");
            settings.Add("LVL28", true, "Level 28", "MPERCENT");
            settings.Add("LVL29", true, "Level 29", "MPERCENT");
            settings.Add("LVL30", true, "Level 30", "MPERCENT");
            settings.Add("LVL31", true, "Level 31", "MPERCENT");
}

split
{
    //Code clean-up for splitting by ero
    const string IMPROVING = "Your gardening is improving! Well done! You just seem to get better and better.";
    const string LEVEL_UP = "Level up.";

    return old.Awards != current.Awards
        && (current.Awards == IMPROVING || current.Awards == LEVEL_UP)
        && settings["LVL" + current.GardenLevel]
        && vars.Splits.Add(current.GardenLevel);
}

isLoading
{
    return current.Loads != 0;
}

start
{
    return current.Loads == 0 && current.Start == 1 && old.Start == 0;
}

reset
{
    return current.Awards == "[VERSION] Game Experience May Change During Online Play.";
}

onStart
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
