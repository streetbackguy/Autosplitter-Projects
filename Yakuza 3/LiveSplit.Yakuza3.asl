state("Yakuza3", "Steam") 
{
    byte Loads:   0x1198218, 0x310, 0x210;
    uint NewGame: 0x1198218, 0x3B0, 0x220;
    byte LoadHelper: 0x11AB360;
    int FileTimer: 0x11C6518;
    uint    StateCount:   0x122f268, 0x0;
    byte384 StateEntries: 0x122f268, 0x4;
    byte MusicSlot1State: 0x128B040, 0x40;
    string255 MusicSlot1: 0x128B040, 0x5C;
    byte MusicSlot2State: 0x128B048, 0x40;
    string255 MusicSlot2: 0x128B048, 0x5C;
}

state("Yakuza3", "Game Pass")
{
    byte Loads:   0x144D1C0, 0x310, 0x210;
    uint NewGame: 0x144D1C0, 0x3B0, 0x220;
    byte LoadHelper: 0x1460340;
    int FileTimer: 0x147B498;
    uint    StateCount:   0x14E4338, 0x0;
    byte384 StateEntries: 0x14E4338, 0x4;
    byte MusicSlot1State: 0x153FE30, 0x40;
    string255 MusicSlot1: 0x153FE30, 0x5C;
    byte MusicSlot2State: 0x153FE38, 0x40;
    string255 MusicSlot2: 0x153FE38, 0x5C;
}

state("Yakuza3", "GOG")
{
    byte Loads:   0x1132918, 0x310, 0x210;  // CActionManager -> CCCC -> 0x210
    uint NewGame: 0x1132918, 0x3B0, 0x220;  // CActionManager -> CActionTitle -> 0x220
    byte LoadHelper: 0x1145A60;
    int FileTimer: 0x1160BC8;
    uint    StateCount:   0x11c9958, 0x0;
    byte384 StateEntries: 0x11c9958, 0x4;
    byte MusicSlot1State: 0x1225710, 0x40;
    string255 MusicSlot1: 0x1225710, 0x5C;
    byte MusicSlot2State: 0x1225718, 0x40;
    string255 MusicSlot2: 0x1225718, 0x5C;
}

init
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 47144960:
            version = "Steam";
            break;
        case 46473216:
            version = "GOG";
            break;
        default: // 49774592?
            version = "Game Pass";
            break; 
    }
}

startup
{
    settings.Add("CHAPTER", true, "Chapter End Splits");
        settings.Add("5-0", true, "Chapter 1: New Beginnings*", "CHAPTER");
            settings.SetToolTip("5-0", "Splits when Chapter 2 begins, and so on down the line.");
        settings.Add("6-0", true, "Chapter 2: The Ryudo Encounter", "CHAPTER");
        settings.Add("7-0", true, "Chapter 3: Power Struggle", "CHAPTER");
        settings.Add("8-0", true, "Chapter 4: The Man in the Sketch", "CHAPTER");
        settings.Add("9-0", true, "Chapter 5: The Curtain Rises", "CHAPTER");
        settings.Add("10-0", true, "Chapter 6: Gameplan", "CHAPTER");
        settings.Add("11-0", true, "Chapter 7: The Mad Dog", "CHAPTER");
        settings.Add("12-0", true, "Chapter 8: Conspirators", "CHAPTER");
        settings.Add("13-0", true, "Chapter 9: The Plot", "CHAPTER");
        settings.Add("14-0", true, "Chapter 10: Unfinished Business", "CHAPTER");
        settings.Add("15-0", true, "Chapter 11: Crisis", "CHAPTER");

    settings.Add("FIGHT", false, "Fight Splits");
        settings.Add("4-18", false, "Tutorial 1", "FIGHT");
        settings.Add("4-35", false, "Tutorial 2 (in front of lockers)", "FIGHT");
        settings.Add("4-46", false, "Majima 1", "FIGHT");
        settings.Add("5-20", false, "Rikiya", "FIGHT");
        settings.Add("6-80", false, "Convenience Store Fight", "FIGHT");
        settings.Add("6-87", false, "Office Antics", "FIGHT");
        settings.Add("6-89", false, "Tamashiro 1", "FIGHT");
        settings.Add("7-92", false, "Hasebe", "FIGHT");
        settings.Add("8-22", false, "Richardson 1", "FIGHT");
        settings.Add("9-73", false, "Park Fight", "FIGHT");
        settings.Add("9-82", false, "Hallway Fight", "FIGHT");
        settings.Add("9-104", false, "Kanda", "FIGHT");
        settings.Add("10-16", false, "Majima 2", "FIGHT");
        settings.Add("11-16", false, "West Park Fight*", "FIGHT");
            settings.SetToolTip("11-16", "After the textboxes.");
        settings.Add("11-21", false, "Purple Shirt Guy 2", "FIGHT");
        settings.Add("11-30", false, "Red Shirt Guy", "FIGHT");
        settings.Add("11-32", false, "Lau Ka Long", "FIGHT");
        settings.Add("12-41", false, "Cops", "FIGHT"); // Slight guess
        settings.Add("13-25", false, "Ricky Mask", "FIGHT");
        settings.Add("13-50", false, "Counterfeit Card Cads", "FIGHT");
        settings.Add("13-87", false, "Joji Kazama", "FIGHT");
        settings.Add("14-15", false, "Tamashiro 2", "FIGHT");
        settings.Add("15-17", false, "Lobby Fight*", "FIGHT");
            settings.SetToolTip("15-17", "After the textboxes.");
        settings.Add("15-25", false, "Richardson 2", "FIGHT");
        settings.Add("15-28", false, "Richardson 3*", "FIGHT");
            settings.SetToolTip("15-28", "After getting to the elevator.");
        settings.Add("RUN OVER", false, "Mine*", "FIGHT");
            settings.SetToolTip("RUN OVER", "Splits on the last hit on the final boss.");

    settings.Add("GOLF", false, "Golf Splits");
        settings.Add("6-25", false, "Golf Begins", "GOLF");
        settings.Add("6-31", false, "Hole 1 Results", "GOLF");
        settings.Add("6-35", false, "Hole 2 Results", "GOLF");
        settings.Add("6-39", false, "Hole 3 Results", "GOLF");
        settings.Add("6-40", false, "Leaving the Course*", "GOLF");
            settings.SetToolTip("6-40", "Alternative to Hole 3");

    settings.Add("CHASE", false, "Chase Splits");
        settings.Add("8-28", false, "Chase Mack", "CHASE");
        settings.Add("11-24", false, "Chase Purple Shirt Guy", "CHASE");
        settings.Add("13-78", false, "Chase Ayako", "CHASE");


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
    // Starts after selecting game difficulty.
    return (current.NewGame == 1 && old.NewGame == 0);

    // Starts after the disclaimer
    // return (current.Loads == 1 && old.Loads == 0);
}

// Pause the timer while the screen is black, but only if IGT has stopped.
isLoading 
{
    return (current.LoadHelper == 2 && current.FileTimer == old.FileTimer);
}

split
{
    if(current.MusicSlot2.Contains("vs_mine2") && old.MusicSlot2State == 2 && current.MusicSlot2State == 4)
    {
        return settings["RUN OVER"];
    }

    // For each scenario state being changed:
    for(int i = 0; i < current.StateCount; i++)
    {
        int adj = i * 12;

        // If the state is being set to true:
        if (current.StateEntries[8 + adj] == 1)
        {
            string s = string.Format("{0}-{1}",
                BitConverter.ToUInt32(current.StateEntries, adj),       // Scenario section
                BitConverter.ToUInt32(current.StateEntries, 4 + adj));  // Scenario state

            if (!vars.Splits.Contains(s))
            {
                vars.Splits.Add(s);
                return settings[s];
            }
        }
    }
}

reset
{
    return current.MusicSlot1 == "data/sound/stream/title_def.adx" && current.MusicSlot1State == 4
        || current.MusicSlot2 == "data/sound/stream/title_def.adx" && current.MusicSlot2State == 4;
}

onReset
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
