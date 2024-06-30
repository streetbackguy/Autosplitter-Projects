/*
    Documentation for sanity! Ghidra hates the Steam version, but the GOG version works well enough.

    EnemyCount has always used the pointer for CActionFighterManager, but it was previously going outside
    that instance's boundaries to land on EnemyManager instead, which is usually (not always) contiguous in memory.
    This explains why this pointer sometimes can seem to sour and not work... probably.
    But FighterManager has a pointer to EnemyManager, which we're now using instead. Blame Cheat Engine.

    Chapter: CActionManager -> CActionRandomEncount ptr -> 0x204
    It only increments when gameplay first resumes after a chapter begins (i.e. after title card and cutscenes),
    which is fine for our use case of determining the final boss split.

    TitleCard: Former series of pointers, no idea.
    Now it's CActionManager -> CActionChapter ptr -> CFileTexture ptr 0x1b0 -> 0x14 which is the .dds texture filepath.
    CActionChapter is instantiated on demand between chapters to display title cards, then destroyed afterwards,
    so this pointer won't ever show strings other than title cards, and only during those moments.

    Character: Static value, not sure yet what shepherds it.

    Paradigm: Static value inc/decremented by CSE interfaces. I think it's just a count (possibly of CSEObj?).
    I need to find something to replace this, because we've had one instance of values being different than expected
    for one player in particular.

    Start: Static value written through CActionLoadGame. It's set to values of 0, 1, or 2.
    It's a mode (or steps?) somewhere in the screen fade process.

    FileTimer: IGT, just a value in CSaveData which is a static instance.
*/

state("Yakuza4", "Steam")
{
    byte EnemyCount: 0x197C440, 0x368, 0x33;
    string255 TitleCard: 0x197C838, 0x3f8, 0x1b0, 0x14;
    byte Chapter: 0x197C838, 0x640, 0x204;
    byte Character: 0x19806D0;      // 0 - 3: Kiryu, Akiyama, Saejima, Tanimura
    short Paradigm: 0x1980D94;      // Unique value for different gameplay modes, menus, etc.
    byte Start: 0x198C624;          // Black screen / screen fade flag
    int FileTimer: 0x19A3AC8;       // In-game timer
}

state("Yakuza4", "Game Pass")
{
    byte EnemyCount: 0x1C590F0, 0x368, 0x33;
    string255 TitleCard: 0x1C594E8, 0x3f8, 0x1b0, 0x14;
    byte Chapter: 0x1C594E8, 0x640, 0x204;
    byte Character: 0x1C5D4A0;
    short Paradigm: 0x1C5DB64;
    byte Start: 0x1C693F4;
    int FileTimer: 0x1C80888;
}

state("Yakuza4", "GOG")
{
    byte EnemyCount: 0x18F68C0, 0x368, 0x33;
    string255 TitleCard: 0x18F6CB8, 0x3f8, 0x1b0, 0x14;
    byte Chapter: 0x18F6CB8, 0x640, 0x204;
    byte Character: 0x18FAB50;
    short Paradigm: 0x18FB214;
    byte Start: 0x1906AA4;
    int FileTimer: 0x191DF38;
}

startup
{   
    settings.Add("yak4", true, "Yakuza 4 - Chapter End Splits");
        settings.Add("sa", true, "Shun Akiyama", "yak4");
            settings.Add("01_02.dds", false, "Chapter 1: The Infamous Loan Shark", "sa");
            settings.Add("01_03.dds", false, "Chapter 2: The One", "sa");
            settings.Add("01_04.dds", false, "Chapter 3: Trouble in the Tojo Clan", "sa");
            settings.Add("1_kan.dds", false, "Chapter 4: The Promise", "sa");
        settings.Add("ts", true, "Taiga Saejima", "yak4");
            settings.Add("02_02.dds", false, "Chapter 1: To the Truth", "ts");
            settings.Add("02_03.dds", false, "Chapter 2: Tiger and Dragon", "ts");
            settings.Add("02_04.dds", false, "Chapter 3: The 25 Year Vacuum", "ts");
            settings.Add("2_kan.dds", false, "Chapter 4: Oath of Brotherhood", "ts");
        settings.Add("mt", true, "Masayoshi Tanimura", "yak4");
            settings.Add("03_02.dds", false, "Chapter 1: The Kamurocho Parasite", "mt");
            settings.Add("03_03.dds", false, "Chapter 2: The Perpetrator", "mt");
            settings.Add("03_04.dds", false, "Chapter 3: Door to the Truth", "mt");
            settings.Add("3_kan.dds", false, "Chapter 4: A Detective's Honor", "mt");
        settings.Add("kk", true, "Kazuma Kiryu", "yak4");
            settings.Add("04_02.dds", false, "Chapter 1: Reunion", "kk");
            settings.Add("04_03.dds", false, "Chapter 2: To Kamurocho", "kk");
            settings.Add("04_04.dds", false, "Chapter 3: Encounter", "kk");
            settings.Add("4_kan.dds", false, "Chapter 4: Chain of Betrayal", "kk");
        settings.Add("end", false, "Finale: Requiem", "yak4");

    settings.SetToolTip("end", "Splits on the last hit of the final boss.");

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
        case 78782464:
            version = "Game Pass";
            break; 
        case 60833792:
            version = "Steam";
            break;
        case 60022784:
            version = "GOG";
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
    if (current.TitleCard != old.TitleCard && !vars.Splits.Contains(current.TitleCard))
    {
        vars.Splits.Add(current.TitleCard);
        return settings[current.TitleCard.Substring(current.TitleCard.Length - 9)];
    }

    if (current.Chapter == 17 && current.Character == 3 && old.EnemyCount > 0 && current.EnemyCount == 0 && !vars.Splits.Contains("end"))
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
