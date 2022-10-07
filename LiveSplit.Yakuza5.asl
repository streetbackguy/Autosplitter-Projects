//Collaborative effort by streetbackguy and hoxi
state("Yakuza5", "Steam") 
{
    int Loads: 0x28ECC5C;
    int MainMenu: 0x28A0938, 0x3C;
    int chapter: 0x3073166;
    string255 TitleCard: 0x2008438, 0x98, 0x11C, 0x2EC, 0x180, 0x1D4, 0xE0, 0x5B4;
}

state("Yakuza5", "Game Pass") 
{
    int Loads: 0x2AB2DF4;
    int chapter: 0x2C51C24;
    string255 TitleCard: 0x21CE5E8, 0x98, 0x11C, 0x2EC, 0x180, 0x1D4, 0xE0, 0x5B4;
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 78782464:
            version = "Game Pass";
            break; 
        case 77086720:
            version = "Steam";
            break;
    }
}

startup
{   
    settings.Add("yak5", true, "Yakuza 5");
        settings.Add("kk", true, "Kiryu Kazuma", "yak5");
            settings.Add("syotitle_01.dds", false, "Part 1", "kk");
            settings.Add("syotitle_01_01.dds", false, "The Wanderer", "kk");
            settings.Add("syotitle_01_02.dds", false, "Uninvited Guests", "kk");
            settings.Add("syotitle_01_03.dds", false, "The Plot Unfolds", "kk");
            settings.Add("syotitle_01_04.dds", false, "Destinations", "kk");
        settings.Add("ts", true, "Taiga Saejima", "yak5");
            settings.Add("syotitle_02.dds", false, "Part 2", "ts");
            settings.Add("syotitle_02_01.dds", false, "Ends of the Earth", "ts");
            settings.Add("syotitle_02_02.dds", false, "The Way of Resolve", "ts");
            settings.Add("syotitle_02_03.dds", false, "Frozen Roar", "ts");
            settings.Add("syotitle_02_04.dds", false, "Reckless Encounter", "ts");
        settings.Add("ha", true, "Haruka Sakamura & Shun Akiyama", "yak5");
            settings.Add("syotitle_03.dds", false, "Part 3", "ha");
            settings.Add("syotitle_03_01.dds", false, "Backstage Dreams", "ha");
            settings.Add("syotitle_03_02.dds", false, "Hope Lives On", "ha");
            settings.Add("syotitle_0302.dds", false, "Closing In", "ha");
            settings.Add("syotitle_03_04.dds", false, "Beyond the Dream", "ha");
        settings.Add("tsh", true, "Tatsuo Shinada", "yak5");
            settings.Add("syotitle_04.dds", false, "Part 4", "tsh");
            settings.Add("syotitle_04_01.dds", false, "Abandoned Glory", "tsh");
            settings.Add("syotitle_04_02.dds", false, "Confronting the Past", "tsh");
            settings.Add("syotitle_04_03.dds", false, "The Price of truth", "tsh");
            settings.Add("syotitle_04_04.dds", false, "Fleeting Triumph", "tsh");
        settings.Add("fin", true, "Finale", "yak5");
            settings.Add("syotitle_05.dds", false, "Final Part", "fin");
            settings.Add("syotitle_05_01.dds", false, "A Legend Returns", "fin");
            settings.Add("syotitle_05_02.dds", false, "A Hidden Past", "fin");
            settings.Add("syotitle_05_03.dds", false, "The Survivors", "fin");
            settings.Add("syotitle_05_04.dds", false, "Crossroads", "fin");
            settings.Add("syotitle_05_05.dds", false, "Dreams Fulfilled", "fin");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Yakuza 5",
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

isLoading 
{
    return (current.chapter != 34 && current.Loads == 2 && version == "Steam" || current.chapter != 2228224 && current.Loads == 2 && version == "Game Pass");
}

start
{
    return (current.Loads == 2 && old.MainMenu == 4352);
}

//Currently autosplits on every end of chapter save screen
split
{   
    if (current.TitleCard != old.TitleCard && !vars.Splits.Contains(current.TitleCard))
    {
        vars.Splits.Add(current.TitleCard);
        return settings[current.TitleCard];
    }
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}
