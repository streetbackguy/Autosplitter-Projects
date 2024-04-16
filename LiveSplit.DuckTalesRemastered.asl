state("DuckTales")
{
    bool Loads: 0x5DAA14;
    int Starter: 0x7BD220;
    int LevelID: 0x7EC434;
}

init
{
    Thread.Sleep(5000);
    vars.LevelSplits = new HashSet<string>();
}

startup
{
    settings.Add("DTR", true, "DuckTales Remastered");
        settings.Add("LevelID3", true, "Money Bin", "DTR");
        settings.Add("LevelID6", true, "The Amazon", "DTR");
        settings.Add("LevelID2", true, "Transylvania", "DTR");
        settings.Add("LevelID7", true, "African Mines", "DTR");
        settings.Add("LevelID5", true, "The Himalayas", "DTR");
        settings.Add("LevelID4", true, "The Moon", "DTR");
        settings.Add("LevelID9", true, "Mount Vesuvius", "DTR");
}

isLoading
{
    return !current.Loads;
}

start
{
    return current.Starter != 0 && old.Starter == 0;
}

split
{
    if(current.LevelID != old.LevelID && !vars.LevelSplits.Contains("LevelID" + old.LevelID.ToString()))
    {
        return settings["LevelID" + old.LevelID.ToString()] && vars.LevelSplits.Add("LevelID" + old.LevelID.ToString());
    }
}

onStart
{
    vars.LevelSplits.Clear();
}