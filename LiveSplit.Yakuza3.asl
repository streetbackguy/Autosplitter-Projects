state("Yakuza3", "Steam") 
{
    byte EnemyCount:  0x1198218, 0x200, 0x491;
    short HPSlot0:    0x1198218, 0x200, 0xD0, 0x138, 0x1AC;
    short HPSlot0Max: 0x1198218, 0x200, 0xD0, 0x138, 0x1AE;
    byte Loads: 0x1198218, 0x310, 0x210;
    string255 TitleCard: 0x1198218, 0x560, 0xC8, 0x108, 0x5C;
    short Paradigm: 0x119D778;
    byte Start: 0x11AB360;
    string255 Objective: 0x11B7898, 0x264, 0xFB0;
    int FileTimer: 0x11C6518;
}

state("Yakuza3", "Game Pass") 
{
    byte EnemyCount:  0x144D1C0, 0x200, 0x491;
    short HPSlot0:    0x144D1C0, 0x200, 0xD0, 0x138, 0x1AC;
    short HPSlot0Max: 0x144D1C0, 0x200, 0xD0, 0x138, 0x1AE;
    byte Loads: 0x144D1C0, 0x310, 0x210;
    string255 TitleCard: 0x11B9850, 0x108, 0x1B0, 0x52; // TODO: Find Game Pass address for this!
    short Paradigm: 0x1452738;
    byte Start: 0x1460340;
    string255 Objective: 0x11B7898, 0x264, 0xFB0; // TODO: Find Game Pass address for this!
    int FileTimer: 0x147B498;
}

init {
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 78782464:
            version = "Game Pass";
            break; 
        case 47144960:
            version = "Steam";
            break;
    }
}

startup
{   
    settings.Add("yak3", true, "Yakuza 3");
        settings.Add("er/2d_mn_syotitle_01.dds", false, "Chapter 1: New Beginnings", "yak3");
        settings.Add("er/2d_mn_syotitle_02.dds", false, "Chapter 2: The Ryudo Encounter", "yak3");
        settings.Add("er/2d_mn_syotitle_03.dds", false, "Chapter 3: Power Struggle", "yak3");
        settings.Add("er/2d_mn_syotitle_04.dds", false, "Chapter 4: The Man in the Sketch", "yak3");
        settings.Add("er/2d_mn_syotitle_05.dds", false, "Chapter 5: The Curtain Rises", "yak3");
        settings.Add("er/2d_mn_syotitle_06.dds", false, "Chapter 6: Gameplan", "yak3");
        settings.Add("er/2d_mn_syotitle_07.dds", false, "Chapter 7: The Mad Dog", "yak3");
        settings.Add("er/2d_mn_syotitle_08.dds", false, "Chapter 8: Conspirators", "yak3");
        settings.Add("er/2d_mn_syotitle_09.dds", false, "Chapter 9: The Plot", "yak3");
        settings.Add("er/2d_mn_syotitle_10.dds", false, "Chapter 10: Unfinished Business", "yak3");
        settings.Add("er/2d_mn_syotitle_11.dds", false, "Chapter 11: Crisis", "yak3");
        settings.Add("er/2d_mn_syotitle_12.dds", false, "Chapter 12: The End of Ambition", "yak3");

    settings.SetToolTip("yak3", "Auto Splitter does not currently work on Game Pass version!");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Yakuza 3",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
    print(modules.First().ModuleMemorySize.ToString());
}

start
{
    // Starts after the Ukiyo Bell OK
    return (current.Start > 0 && version == "Steam");

    // Starts after the disclaimer
    // return (current.Loads == 1 && old.Loads == 0 && version == "Steam");
}

// Pause the timer while the screen is black, but only if IGT has stopped.
isLoading 
{
    return (current.Start == 2 && current.FileTimer == old.FileTimer && version == "Steam");
}

// Currently autosplits on every chapter's title card, and on the last hit on Mine
split
{   
    if (current.TitleCard != old.TitleCard && !vars.Splits.Contains(current.TitleCard) && version == "Steam")
    {
        vars.Splits.Add(current.TitleCard);
        return settings[current.TitleCard];
    }

    if (current.HPSlot0Max == 3000 && current.Objective.EndsWith("2d_mn_bc_em_hakuhou.dds") && version == "Steam")
        return (current.HPSlot0 == 1); // Mine stays at 1 HP after the final hit
}

exit
{
    timer.IsGameTimePaused = true;
}
