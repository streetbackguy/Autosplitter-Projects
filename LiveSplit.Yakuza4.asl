/*
    Documentation for sanity! Ghidra hates the Steam version, but the GOG version works well enough.

    EnemyCount has always used the pointer for CActionFighterManager, but it was previously going outside
    that instance's boundaries to land on EnemyManager instead, which is usually (not always) contiguous in memory.
    This explains why this pointer sometimes can seem to sour and not work... probably.
    But FighterManager has a pointer to EnemyManager, which we're now using instead. Blame Cheat Engine.

    Chapter: CActionManager -> CActionRandomEncount ptr -> 0x204
    It only increments when gameplay first resumes after a chapter begins (i.e. after title card and cutscenes),
    which is fine for our use case of determining the final boss split.

    Character: Static value, not sure yet what shepherds it.

    Paradigm: Static value inc/decremented by CSE interfaces. I think it's just a count (possibly of CSEObj?).
    I need to find something to replace this, because we've had one instance of values being different than expected
    for one player in particular.

    Start: Static value written through CActionLoadGame. It's set to values of 0, 1, or 2.
    It's a mode (or steps?) somewhere in the screen fade process.

    FileTimer: IGT, just a value in CSaveData which is a static instance.

    States: We're tracking when the game sets scenario values, which are one-to-one with the file scenario_state.bin.
    The count is the number of new states set in this frame, and the entries are the states in an array.
    This is not the only way that the game sets these states, but this is the method for most cases.
*/

state("Yakuza4", "Steam")
{
    byte EnemyCount: 0x197C440, 0x368, 0x33;
    byte Chapter: 0x197C838, 0x640, 0x204;
    byte Character: 0x19806D0;      // 0 - 3: Kiryu, Akiyama, Saejima, Tanimura
    short Paradigm: 0x1980D94;      // Unique value for different gameplay modes, menus, etc.
    byte Start: 0x198C624;          // Black screen / screen fade flag
    int FileTimer: 0x19A3AC8;       // In-game timer
    uint    StateCount:   0x1A1FA20, 0x0;
    byte384 StateEntries: 0x1A1FA20, 0x4;
}

state("Yakuza4", "M Store")
{
    byte EnemyCount: 0x1C590F0, 0x368, 0x33;
    byte Chapter: 0x1C594E8, 0x640, 0x204;
    byte Character: 0x1C5D4A0;
    short Paradigm: 0x1C5DB64;
    byte Start: 0x1C693F4;
    int FileTimer: 0x1C80888;
    uint    StateCount:   0x1CFC5C0, 0x0;
    byte384 StateEntries: 0x1CFC5C0, 0x4;
}

state("Yakuza4", "GOG")
{
    byte EnemyCount: 0x18F68C0, 0x368, 0x33;
    byte Chapter: 0x18F6CB8, 0x640, 0x204;
    byte Character: 0x18FAB50;
    short Paradigm: 0x18FB214;
    byte Start: 0x1906AA4;
    int FileTimer: 0x191DF38;
    uint    StateCount:   0x1999ea0, 0x0;
    byte384 StateEntries: 0x1999ea0, 0x4;
}

startup
{
    settings.Add("CHAPTER", false, "Chapter End Splits");
        settings.Add("sa", true, "Shun Akiyama", "CHAPTER");
            settings.Add("4-0", true, "Chapter 1: The Infamous Loan Shark", "sa");
            settings.Add("5-0", true, "Chapter 2: The One", "sa");
            settings.Add("6-0", true, "Chapter 3: Trouble in the Tojo Clan", "sa");
            settings.Add("6-89", true, "Chapter 4: The Promise", "sa");
        settings.Add("ts", true, "Taiga Saejima", "CHAPTER");
            settings.Add("8-0",  true, "Chapter 1: To the Truth", "ts");
            settings.Add("9-0",  true, "Chapter 2: Tiger and Dragon", "ts");
            settings.Add("10-0", true, "Chapter 3: The 25 Year Vacuum", "ts");
            settings.Add("10-82", true, "Chapter 4: Oath of Brotherhood", "ts");
        settings.Add("mt", true, "Masayoshi Tanimura", "CHAPTER");
            settings.Add("12-0", true, "Chapter 1: The Kamurocho Parasite", "mt");
            settings.Add("13-0", true, "Chapter 2: The Perpetrator", "mt");
            settings.Add("14-0", true, "Chapter 3: Door to the Truth", "mt");
            settings.Add("14-31", true, "Chapter 4: A Detective's Honor", "mt");
        settings.Add("kk", true, "Kazuma Kiryu", "CHAPTER");
            settings.Add("16-0", true, "Chapter 1: Reunion", "kk");
            settings.Add("17-0", true, "Chapter 2: To Kamurocho", "kk");
            settings.Add("18-0", true, "Chapter 3: Encounter", "kk");
            settings.Add("18-27", true, "Chapter 4: Chain of Betrayal", "kk");

    settings.Add("FIGHT", false, "Fight Splits");
        settings.Add("3-11", false, "Akiyama Tutorial 1", "FIGHT");
        settings.Add("3-20", false, "Akiyama Tutorial 2", "FIGHT");
        settings.Add("3-25", false, "Ihara", "FIGHT");
        settings.Add("4-21", false, "Ch.2 Rooftop", "FIGHT");
        settings.Add("5-31", false, "Champion District", "FIGHT"); // Guess
        settings.Add("6-59", false, "Midorikawa", "FIGHT");
        settings.Add("6-88", false, "Minami 1", "FIGHT");
        settings.Add("7-7",  false, "Saejima Tutorial", "FIGHT");
        settings.Add("7-22", false, "Prison Yard Chain", "FIGHT"); // Fight is 20
        settings.Add("7-30", false, "Prison Yard Hoe", "FIGHT"); // Fight is 29
        settings.Add("7-41", false, "Saito 1 (leaving)", "FIGHT");
        settings.Add("7-43", false, "Saito 2 (leaving)", "FIGHT");
        settings.Add("7-51", false, "Prison Rooftop", "FIGHT");
        settings.Add("7-53", false, "Bottom of the Staircase Gang", "FIGHT");
        settings.Add("7-58", false, "Saito 3", "FIGHT");
        settings.Add("8-9",  false, "Kiryu", "FIGHT");
        settings.Add("9-42", false, "Park Fight", "FIGHT");
        settings.Add("9-52", false, "Ibrahimovic", "FIGHT");
        settings.Add("10-66", false, "Minami 2", "FIGHT");
        settings.Add("10-71", false, "Majima", "FIGHT");
        settings.Add("11-29", false, "Outside Midori", "FIGHT");
        settings.Add("11-36", false, "Sword and Gun at the Docks", "FIGHT");
        settings.Add("12-38", false, "Briefcase Fights", "FIGHT");
        settings.Add("12-44", false, "Rooftop Briefcase Fight", "FIGHT");
        settings.Add("12-50", false, "Toyosaki", "FIGHT");
        settings.Add("14-21", false, "Sugiuchi", "FIGHT");
        settings.Add("15-22", false, "Sayonara, Saito", "FIGHT");
        settings.Add("17-31", false, "AkiMura", "FIGHT");
        settings.Add("18-15", false, "Entering the Mall Proper", "FIGHT");
        settings.Add("18-16", false, "Kamurocho Hills Elevator", "FIGHT");
        settings.Add("18-17", false, "Kamurocho Hills Rooftop Key", "FIGHT");
        settings.Add("18-20", false, "Kamurocho Hills Rooftop Fight", "FIGHT");
        settings.Add("19-18", false, "Arai", "FIGHT");
        settings.Add("19-21", false, "Balls Out", "FIGHT");
        settings.Add("19-24", false, "Daigo", "FIGHT");
        settings.Add("end", false, "Munakata", "FIGHT");
            settings.SetToolTip("end", "Splits on the last hit of the final boss.");

    // Setpiece 1-4: 6-57

    settings.Add("OTHER", false, "Other Splits");
        settings.Add("315-5", false, "Saigo Tutorial Chase", "OTHER");
        // settings.Add("6-67", false, "Club Elise 2", "OTHER"); // Guess
        settings.Add("9-13", false, "Kido Chase", "OTHER"); // 9-12 also fine
        settings.Add("12-35", false, "Walk and Talk", "OTHER");
        settings.Add("12-41", false, "Briefcase Chase", "OTHER");
        settings.Add("12-48", false, "Briefcase Chase 2", "OTHER");
        settings.Add("14-18", false, "Boat Chase", "OTHER");


    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Yakuza 4",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize)
    {
        case 60833792:
            version = "Steam";
            break;
        case 60022784:
            version = "GOG";
            break;
        default: // 63631360?
            version = "M Store";
            break; 
    }
}


// Pause the timer while the screen is black, but only if IGT has stopped.
isLoading 
{
    return current.Start == 2 && current.FileTimer == old.FileTimer;
}

onStart
{
    timer.IsGameTimePaused = true;
}

start
{
    // Start at choosing difficulty
    return (current.FileTimer == 0 && (current.Paradigm == 212 || current.Paradigm == 213));

    // Start at the first title card, i.e. after the disclaimer in English
    // return (current.Paradigm == 185);
}

split
{
    // For each scenario state being changed:
    for(int i = 0; i < current.StateCount; i++)
    {
        int adj = i * 12; // Adjust for the size of the structs

        // If the state is being set to true:
        if (current.StateEntries[8 + adj] == 1)
        {
            string s = string.Format("{0}-{1}",
                BitConverter.ToUInt32(current.StateEntries, adj),       // Scenario section
                BitConverter.ToUInt32(current.StateEntries, 4 + adj));  // Scenario state

            if (!vars.Splits.Contains(s))
            {
                print(s);
                vars.Splits.Add(s);
                return settings[s];
            }
        }
    }

    if (current.Chapter == 17 && current.Character == 3 && vars.Splits.Contains("19-26") && old.EnemyCount > 0 && current.EnemyCount == 0 && !vars.Splits.Contains("end"))
    {
        vars.Splits.Add("end");
        return settings["end"];
    }
}

reset
{
    return (old.Paradigm == 209 && current.Paradigm == 221);
}

onReset
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
}
