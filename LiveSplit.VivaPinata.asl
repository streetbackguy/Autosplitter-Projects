state("Viva Pinata")
{
    byte Start: 0x7D85BF;
    byte Loads: 0x82B84C;
    int GardenLevel: 0xB9A384;
    string255 Awards: 0xB9D9A8;
}

startup
{
    vars.Splits = new HashSet<int>();

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
            settings.Add("LVL11", false, "Level 11", "GPERCENT");
            settings.Add("LVL12", false, "Level 12", "GPERCENT");
            settings.Add("LVL13", false, "Level 13", "GPERCENT");
            settings.Add("LVL14", false, "Level 14", "GPERCENT");
            settings.Add("LVL15", false, "Level 15", "GPERCENT");
            settings.Add("LVL16", false, "Level 16", "GPERCENT");
            settings.Add("LVL17", false, "Level 17", "GPERCENT");
            settings.Add("LVL18", false, "Level 18", "GPERCENT");
            settings.Add("LVL19", false, "Level 19", "GPERCENT");
            settings.Add("LVL20", false, "Level 20", "GPERCENT");
            settings.Add("LVL21", false, "Level 21", "GPERCENT");
        settings.Add("MPERCENT", true, "Master%", "VP");
            settings.Add("LVL22", false, "Level 22", "MPERCENT");
            settings.Add("LVL23", false, "Level 23", "MPERCENT");
            settings.Add("LVL24", false, "Level 24", "MPERCENT");
            settings.Add("LVL25", false, "Level 25", "MPERCENT");
            settings.Add("LVL26", false, "Level 26", "MPERCENT");
            settings.Add("LVL27", false, "Level 27", "MPERCENT");
            settings.Add("LVL28", false, "Level 28", "MPERCENT");
            settings.Add("LVL29", false, "Level 29", "MPERCENT");
            settings.Add("LVL30", false, "Level 30", "MPERCENT");
            settings.Add("LVL31", false, "Level 31", "MPERCENT");
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
    return current.Loads == 0 && current.Start == 56 && old.Start == 57;
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
