state("Stack")
{
    byte Loading: 0x5CF38C;
    int LevelID: 0x55142C;
    int Starter: 0x5CB9BC;
}

startup
{
    settings.Add("STACK", true, "Stacking");
        settings.Add("TS", true, "Split after Royal Train Station", "STACK");
        settings.Add("GS", true, "Split after Gilded Steamship", "STACK");
        settings.Add("ZC", true, "Split after Zeppelin of Consequence", "STACK");
        settings.Add("TD", true, "Split after Triple Decker Tank Engine", "STACK");
}

split
{
    if(current.LevelID != old.LevelID && old.LevelID == 62)
    {
        return settings["TS"];
    }

    if(current.LevelID != old.LevelID && old.LevelID == 68)
    {
        return settings["GS"];
    }

    if(current.LevelID != old.LevelID && old.LevelID == 66)
    {
        return settings["ZC"];
    }

    if(current.LevelID != old.LevelID && old.LevelID == 116)
    {
        return settings["TD"];
    }
}

start
{
    return current.Starter == 4 && current.LevelID == 62;
}

isLoading
{
    return current.Loading == 1;
}

reset
{
    return current.LevelID == 0;
}
