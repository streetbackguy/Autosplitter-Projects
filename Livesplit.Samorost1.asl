state("Samorost1")
{
    uint Level: "Adobe AIR.dll", 0x00DCD3FC, 0xFC8, 0xCAC, 0xC, 0xA18, 0xD8, 0x268, 0x264;
    uint Start: "Adobe AIR.dll", 0xDCBDA0;
}

startup
{
    settings.Add("SAM", true, "Samorost 1");
        settings.Add("LEVEL1", true, "Level 1", "SAM");
        settings.Add("LEVEL2", true, "Level 2", "SAM");
        settings.Add("LEVEL3", true, "Level 3", "SAM");
        settings.Add("LEVEL4", true, "Level 4", "SAM");
        settings.Add("LEVEL5", true, "Level 5", "SAM");
}

start
{
    return current.Start == 8 && old.Start == 5;
}

split
{
    if (current.Level == 2 && old.Level == 1)
    {
        return settings["LEVEL1"];
    }

    if (current.Level == 3 && old.Level == 2)
    {
        return settings["LEVEL2"];
    }

    if (current.Level == 4 && old.Level == 3)
    {
        return settings["LEVEL3"];
    }

    if (current.Level == 5 && old.Level == 4)
    {
        return settings["LEVEL4"];
    }

    if (current.Level == 6 && old.Level == 5)
    {
        return settings["LEVEL5"];
    }
}
