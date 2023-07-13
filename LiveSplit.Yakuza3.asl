state("Yakuza3", "Steam") 
{
    byte EnemyCount:  0x1198218, 0x200, 0x491;
    byte Loads: 0x1198218, 0x310, 0x210;
    string255 TitleCard: 0x1198218, 0x560, 0xC8, 0x108, 0x14;
    // short Paradigm: 0x119D778;
    byte LoadHelper: 0x11AB360;
    // string255 GolfResults: 0x11C3470, 0x28, 0x5D4;
    int FileTimer: 0x11C6518;
    byte Start: 0x11C6524;
    byte MusicSlot2State: 0x128B048, 0x40;
    string255 MusicSlot2: 0x128B048, 0x5C;
    string255 MusicSlot3: 0x128B048, 0x25C;
}
state("Yakuza3", "Game Pass")
{
    byte EnemyCount:  0x144D1C0, 0x200, 0x491;
    byte Loads: 0x144D1C0, 0x310, 0x210;
    string255 TitleCard: 0x144D1C0, 0x560, 0xC8, 0x108, 0x14;
    // short Paradigm: 0x1452738;
    byte LoadHelper: 0x1460340;
    // string255 GolfResults: 0x11C3470, 0x28, 0x5D4; // TODO: Find Game Pass address for this!
    int FileTimer: 0x147B498;
    byte Start: 0x147B4A4;
    byte MusicSlot2State: 0x153FE10, 0x40;
    string255 MusicSlot2: 0x153FE10, 0x5C;
    string255 MusicSlot3: 0x153FE10, 0x25C;
}

state("Yakuza3", "GOG") //- 65900
{
    byte EnemyCount: 0x1132918, 0x200, 0x491;
    byte Loads: 0x1132918, 0x310, 0x210;
    string255 TitleCard: 0x1132918, 0x560, 0xC8, 0x108, 0x14;
    // short Paradigm: 0x1137E78;
    byte LoadHelper: 0x1145A60;
    // string255 GolfResults: 0x115DB70, 0x28, 0x5A9;
    int FileTimer: 0x1160BC8;
    byte Start: 0x1160BD4;
    byte MusicSlot2State: 0x1225718, 0x40;
    string255 MusicSlot2: 0x1225718, 0x5C;
    string255 MusicSlot3: 0x1225718, 0x25C;
}

init
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 78782464:
            version = "Game Pass";
            break; 
        case 47144960:
            version = "Steam";
            break;
        case 46473216:
            version = "GOG";
            break;
    }

}

startup
{   
    settings.Add("yak3", true, "Yakuza 3 - Chapter End Splits");
        settings.Add("syotitle_02.dds", true, "Chapter 1: New Beginnings", "yak3");
        settings.Add("syotitle_03.dds", true, "Chapter 2: The Ryudo Encounter", "yak3");
        settings.Add("syotitle_04.dds", true, "Chapter 3: Power Struggle", "yak3");
            settings.Add("golf", false, "Split after Golf", "syotitle_04.dds");
        settings.Add("syotitle_05.dds", true, "Chapter 4: The Man in the Sketch", "yak3");
        settings.Add("syotitle_06.dds", true, "Chapter 5: The Curtain Rises", "yak3");
        settings.Add("syotitle_07.dds", true, "Chapter 6: Gameplan", "yak3");
        settings.Add("syotitle_08.dds", true, "Chapter 7: The Mad Dog", "yak3");
        settings.Add("syotitle_09.dds", true, "Chapter 8: Conspirators", "yak3");
        settings.Add("syotitle_10.dds", true, "Chapter 9: The Plot", "yak3");
        settings.Add("syotitle_11.dds", true, "Chapter 10: Unfinished Business", "yak3");
        settings.Add("syotitle_12.dds", true, "Chapter 11: Crisis", "yak3");
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
}

start
{
    // Starts after Selecting Game Difficulty
    return (current.Start == 0 && old.Start == 1);

    // Starts after the disclaimer
    // return (current.Loads == 1 && old.Loads == 0);
}

// Pause the timer while the screen is black, but only if IGT has stopped.
isLoading 
{
    return (current.LoadHelper == 2 && current.FileTimer == old.FileTimer);
}

// Currently autosplits on every chapter's title card, and on the last hit on Mine.
split
{
    if(current.MusicSlot2.Contains("vs_mine2") && old.MusicSlot2State == 2 && current.MusicSlot2State == 4)
    {
        return settings["RUN OVER"];
    }

    if (current.TitleCard != old.TitleCard && !vars.Splits.Contains(current.TitleCard))
    {
        vars.Splits.Add(current.TitleCard);
        return settings[current.TitleCard.Substring(current.TitleCard.Length - 15)];
    }

    if (!vars.Splits.Contains("golf")
    && old.MusicSlot3.EndsWith("amb_golf.aix") && !current.MusicSlot3.EndsWith("amb_golf.aix"))
    {
        vars.Splits.Add("golf");
        return settings["golf"];
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
