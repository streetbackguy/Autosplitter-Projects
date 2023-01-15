state("Yakuza3", "Steam") 
{
    byte EnemyCount:  0x1198218, 0x200, 0x491;
    short HPSlot0:    0x1198218, 0x200, 0xD0, 0x138, 0x1AC;
    short HPSlot0Max: 0x1198218, 0x200, 0xD0, 0x138, 0x1AE;
    byte Loads: 0x1198218, 0x310, 0x210;
    string255 TitleCard: 0x1198218, 0x560, 0xC8, 0x108, 0x57;
    short Paradigm: 0x119D778;
    byte Start: 0x11C6524;
    byte LoadHelper: 0x11AB360;
    string255 GolfResults: 0x011C3470, 0x28, 0x5D4;
    string255 Objective: 0x11B7898, 0x264, 0xFB0;
    int FileTimer: 0x11C6518;
    string255 MusicSlot2: 0x128B040, 0x5C;
    byte MusicCursor2: 0x2A2BC60, 0x30, 0x68, 0x10, 0x18, 0x0;
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
    byte LoadHelper: 0x11AB360; // TODO: Find Game Pass address for this!
    string255 GolfResults: 0x011C3470, 0x28, 0x5D4; // TODO: Find Game Pass address for this!
    string255 Objective: 0x11B7898, 0x264, 0xFB0; // TODO: Find Game Pass address for this!
    int FileTimer: 0x147B498;
    string255 MusicSlot2: 0x128B040, 0x5C; // TODO: Find Game Pass address for this!
    byte MusicCursor2: 0x2A2BC60, 0x30, 0x68, 0x10, 0x18, 0x0; // TODO: Find Game Pass address for this!
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
    settings.Add("yak3", true, "Yakuza 3 - Chapter End Splits");
        settings.Add("tle_02.dds", true, "Chapter 1: New Beginnings", "yak3");
        settings.Add("tle_03.dds", true, "Chapter 2: The Ryudo Encounter", "yak3");
        settings.Add("tle_04.dds", true, "Chapter 3: Power Struggle", "yak3");
            settings.Add("golf", false, "Split after Golf", "tle_04.dds");
        settings.Add("tle_05.dds", true, "Chapter 4: The Man in the Sketch", "yak3");
        settings.Add("tle_06.dds", true, "Chapter 5: The Curtain Rises", "yak3");
        settings.Add("tle_07.dds", true, "Chapter 6: Gameplan", "yak3");
        settings.Add("tle_08.dds", true, "Chapter 7: The Mad Dog", "yak3");
        settings.Add("tle_09.dds", true, "Chapter 8: Conspirators", "yak3");
        settings.Add("tle_10.dds", true, "Chapter 9: The Plot", "yak3");
        settings.Add("tle_11.dds", true, "Chapter 10: Unfinished Business", "yak3");
        settings.Add("tle_12.dds", true, "Chapter 11: Crisis", "yak3");
        settings.Add("RUN OVER", true, "Chapter 12: The End of Ambition", "yak3");

    settings.SetToolTip("yak3", "Auto Splitter does not currently work on Game Pass version!");
    settings.SetToolTip("RUN OVER", "Splits on the last hit on the final boss.");

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

    vars.GolfCaddy = new Stopwatch();
    vars.minimumtime = TimeSpan.FromSeconds(5);
}

update
{
    print(modules.First().ModuleMemorySize.ToString());

    if (vars.GolfCaddy.Elapsed >= vars.minimumtime) vars.GolfCaddy.Stop();
}

start
{
    // Starts after Selecting Game Difficulty
    return (version == "Steam" && current.Start == 0 && old.Start == 1);

    // Starts after the disclaimer
    // return (current.Loads == 1 && old.Loads == 0 && version == "Steam");
}

// Pause the timer while the screen is black, but only if IGT has stopped.
isLoading 
{
    return (version == "Steam" && current.LoadHelper == 2 && current.FileTimer == old.FileTimer);
}

// Currently autosplits on every chapter's title card, and on the last hit on Mine.
split
{   
    if (version != "Steam")
        return false;

    if (current.TitleCard != old.TitleCard && !vars.Splits.Contains(current.TitleCard))
    {
        vars.Splits.Add(current.TitleCard);
        return settings[current.TitleCard.Substring(current.TitleCard.Length - 10)];
    }

    if (current.MusicSlot2.EndsWith("btlbgm_vs_mine2_fin.adx") && current.MusicCursor2 != old.MusicCursor2)
        return settings["RUN OVER"];

    if (old.GolfResults == "on/mng19golf.par" && current.GolfResults != "on/mng19golf.par")
        return settings["golf"] && !vars.GolfCaddy.IsRunning;
}

onStart
{
    vars.GolfCaddy.Restart();
}

onSplit
{
    vars.GolfCaddy.Restart();
}

exit
{
    timer.IsGameTimePaused = true;
}
