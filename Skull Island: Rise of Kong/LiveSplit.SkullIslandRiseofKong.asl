state("Monke-Win64-Shipping")
{
    float KongHealth: 0x6F07EC0, 0x0098, 0x00B8; // GWorld -> BossListener -> HealthComponent -> Health
    float BossHealth: 0x6F07EC0, 0x0038, 0x0040; // GWorld -> BossMusicData -> PhaseThreeHealthPercent
    bool BossActive: 0x6F07EC0, 0x0080; // GWorld -> WaitBossBattlePhaseStep -> BossActorClassToWait (Replace 0x0080 with actual offset for BossActive logic)
    bool Loading: 0x6DB1D90, 0x01A0; // GEngine -> LoadingScreenState
    string255 LevelName: 0x6F07EC0, 0x1234; // GWorld -> LevelName (Replace with actual offsets)
}

init
{
    vars.Splits = new HashSet<string>(); // Track which splits have been triggered
}

startup
{
    settings.Add("MonkeGame", true, "Monke Game Speedrun");
    settings.Add("LevelSplits", true, "Enable Level Splits", "MonkeGame");
        settings.Add("Phase 1 Complete", true, "Boss Phase 1", "LevelSplits");
        settings.Add("Phase 2 Complete", true, "Boss Phase 2", "LevelSplits");
        settings.Add("Final Phase Complete", true, "Boss Final Phase", "LevelSplits");
        settings.Add("Kong Dies", true, "Split when Kong’s health reaches 0", "LevelSplits");
}

isLoading
{
    return current.Loading;
}

split
{
    // Boss Phase 1 Split
    if (current.BossActive && current.BossHealth != old.BossHealth && current.BossHealth <= 0.50 && !vars.Splits.Contains("Phase 1 Complete"))
    {
        return settings["Phase 1 Complete"] && vars.Splits.Add("Phase 1 Complete");
    }

    // Boss Phase 2 Split
    if (current.BossActive && current.BossHealth != old.BossHealth && current.BossHealth <= 0.25 && !vars.Splits.Contains("Phase 2 Complete"))
    {
        return settings["Phase 2 Complete"] && vars.Splits.Add("Phase 2 Complete");
    }

    // Boss Final Phase Split
    if (current.BossActive && current.BossHealth != old.BossHealth && current.BossHealth <= 0.10 && !vars.Splits.Contains("Final Phase Complete"))
    {
        return settings["Final Phase Complete"] && vars.Splits.Add("Final Phase Complete");
    }

    // Kong Dies Split
    if (current.KongHealth == 0 && old.KongHealth > 0 && !vars.Splits.Contains("Kong Dies"))
    {
        return settings["Kong Dies"] && vars.Splits.Add("Kong Dies");
    }

    return false;
}

start
{
    return current.KongHealth > 0 && old.KongHealth <= 0; // Starts when Kong's health is initialized
}

onStart
{
    vars.Splits.Clear(); // Reset splits on start
}
