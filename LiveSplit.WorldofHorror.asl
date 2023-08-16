state("worldofhorror")
{
    int Starter: 0x252B1E8;
    byte Mystery: 0x25EB8A0, 0x10, 0x380, 0xD78;
}

startup
{
    settings.Add("WOH", true, "World of Horror");
        settings.Add("Mysteries", true, "Split on each Mystery Solved screen", "WOH"); 
}

split
{
    if (current.Mystery == 1 && old.Mystery == 0)
    {
        return settings["Mysteries"];
    }
}

start
{
    return current.Starter == 1018 && old.Starter == 1021;
}

reset
{
    return current.Starter == 1021 && old.Starter == 1018;
}