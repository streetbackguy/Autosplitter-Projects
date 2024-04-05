state("DDDA")
{
    bool LoadScreen: 0x14D09E0, 0xBAC;
    bool CharScreen: 0x14D09E0, 0x634;
    bool Inventory: 0x15A97A9;
    int PlayerControl: 0x14FA4F8, 0x20;
    int CompletedQuests: 0x14FA4F0, 0x140;
}

startup
{
    settings.Add("DDDA", true, "Dragons Dogma: Dark Arisen");
        settings.Add("MGQ", true, "Main Game Quest Splits", "DDDA");
            settings.Add("COMPLETEQUEST", true, "Split upon each Quest Completion", "MGQ");
}

isLoading
{
    return current.LoadScreen || current.CharScreen || current.Inventory;
}

start
{
    return current.PlayerControl != 0 && old.PlayerControl == 0;
}

split
{
    if(current.CompletedQuests > old.CompletedQuests)
    {
        return settings["COMPLETEQUEST"];
    }
}

exit
{
    timer.IsGameTimePaused = true;
}