state("Yakuza4", "Steam")
{
    byte EnemyCount: 0x197C440, 0x4B3;
    byte Chapter: 0x197C838, 0x640, 0x204;
    string255 TitleCard: 0x01993C38, 0x150, 0x1E4, 0x16C, 0x88, 0x28, 0x148, 0x5C;
    float BossHealth: 0x01993DD0, 0x10, 0x25C;
    byte Character: 0x19806D0;      // 0 - 3: Kiryu, Akiyama, Saejima, Tanimura
    short Paradigm: 0x1980D94;      // Unique value for different gameplay modes, menus, etc.
    byte Start: 0x198C624;          // Black screen / screen fade flag
    int FileTimer: 0x19A3AC8;       // In-game timer
}

state("Yakuza4", "Game Pass")
{
    byte EnemyCount: 0x197C440, 0x4B3;
    byte Chapter: 0x197C838, 0x640, 0x204;
    string255 TitleCard: 0x01993C38, 0x150, 0x1E4, 0x16C, 0x88, 0x28, 0x148, 0x5C;
    float BossHealth: 0x01993DD0, 0x10, 0x25C;
    byte Character: 0x19806D0;      // 0 - 3: Kiryu, Akiyama, Saejima, Tanimura
    short Paradigm: 0x1980D94;      // Unique value for different gameplay modes, menus, etc.
    byte Start: 0x198C624;          // Black screen / screen fade flag
    int FileTimer: 0x19A3AC8;       // In-game timer
}

startup
{   
    settings.Add("yak4", true, "Yakuza 5");
        settings.Add("sa", true, "Shun Akiyama", "yak4");
            settings.Add("er/2d_mn_syotitle_01_02.dds", false, "Chapter 1: The Infamous Loanshark", "sa");
            settings.Add("er/2d_mn_syotitle_01_03.dds", false, "Chapter 2: The One", "sa");
            settings.Add("er/2d_mn_syotitle_01_04.dds", false, "Chapter 3: Trouble in the Tojo Clan", "sa");
            settings.Add("er/2d_mn_syotitle_1_kan.dds", false, "Chapter 4: The Promise", "sa");
        settings.Add("ts", true, "Taiga Saejima", "yak4");
            settings.Add("er/2d_mn_syotitle_02_02.dds", false, "Chapter 1: To the Truth", "ts");
            settings.Add("er/2d_mn_syotitle_02_03.dds", false, "Chapter 2: Tiger and Dragon", "ts");
            settings.Add("er/2d_mn_syotitle_02_04.dds", false, "Chapter 3: The 25 Year Vacuum", "ts");
            settings.Add("er/2d_mn_syotitle_02_kan.dds", false, "Chapter 4: Oath of Brotherhood", "ts");
        settings.Add("mt", true, "Masayoshi Tanimura", "yak4");
            settings.Add("er/2d_mn_syotitle_03_02.dds", false, "Chapter 1: The Kamurocho Parasite", "mt");
            settings.Add("er/2d_mn_syotitle_03_03.dds", false, "Chapter 2: The Perpetrator", "mt");
            settings.Add("er/2d_mn_syotitle_03_04.dds", false, "Chapter 3: Door to the Truth", "mt");
            settings.Add("er/2d_mn_syotitle_03_kan.dds", false, "Chapter 4: A Detective's Honor", "mt");
        settings.Add("kk", true, "Kazuma Kiryu", "yak4");
            settings.Add("er/2d_mn_syotitle_04_02.dds", false, "Chapter 1: Reunion", "kk");
            settings.Add("er/2d_mn_syotitle_04_03.dds", false, "Chapter 2: To Kamurocho", "kk");
            settings.Add("er/2d_mn_syotitle_04_04.dds", false, "Chapter 3: Encounter", "kk");
            settings.Add("er/2d_mn_syotitle_04_kan.dds", false, "Chapter 4: Chain of Betrayal", "kk");
        settings.Add("end", false, "Finale: Requiem (Work in Progress - Do Not Use)", "yak4");

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
    }
}

update
{
    print(modules.First().ModuleMemorySize.ToString());
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
    return (current.FileTimer == 0 && current.Paradigm == 212);

    // Start at the first title card, i.e. after the disclaimer in English
    // return (current.Paradigm == 185);
}

split
{
    if (current.TitleCard != old.TitleCard && !vars.Splits.Contains(current.TitleCard))
    {
        vars.Splits.Add(current.TitleCard);
        return settings[current.TitleCard];
    }

    if (current.Chapter == 17 && current.Character == 3 && old.EnemyCount > 0 && current.EnemyCount == 0 && !vars.Splits.Contains("end"))
    {
        vars.Splits.Add("end");
        return settings["end"];
    }
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
