// Collaborative effort by streetbackguy, hoxi and PlayingLikeAss

/* Some documentation, for sanity:

    The presence and absence of a CActionTitle instance dictates autoreset.
    This class is only instantiated by the game when the main menu is required.
    The two main menu values used for autostart are values within CActionTitle.

    The two QTE values are in CActionHactManager and track Heat action states.

    I don't care enough to document TitleCard! It tracks subtitle texture filenames on load.
    I will say, I'd like to move to a sequence-based thing like with 3 and 4 so we can add more splits.

    "Chapter" is more likely a sequence index, but chapters in the game have linear sequence indices,
     so it amounts to the same thing.
     
    "Loads" is a value set from 0 to 2 based on a float related to screen fade. It's probably controlled by CCC.
    We use it in conjunction with IGT to recognize non-gameplay segments. (Same as in 3 and 4.)
    This combination catches gameplay, and throws away all non-gameplay segments with variable lengths based on hardware.
*/


state("Yakuza5", "Steam") 
{
    long CActionTitle: 0x1D9B128, 0x478;
    byte MenuConfirm:  0x1D9B128, 0x478, 0x1ec;
    byte AutoAssignmentMenu: 0x1D9B128, 0x478, 0x334;
    string255 QTE: 0x20071E0, 0x83A;
    byte QTEPassfail: 0x20071E0, 0x1304;
    string255 TitleCard: 0x2008438, 0x98, 0x11C, 0x2EC, 0x180, 0x1D4, 0xE0, 0x5B4;
    byte Chapter: 0x2008A92;
    byte Loads: 0x28ECC5C;
    int FileTimer: 0x28ED098;
}

state("Yakuza5", "Game Pass")
{
    // Currently no auto-start or reset for Game Pass
    string255 QTE: 0x21CD390, 0x83A;
    byte QTEPassfail: 0x21CD390, 0x1304;
    string255 TitleCard: 0x21CE5E8, 0x98, 0x11C, 0x2EC, 0x180, 0x1D4, 0xE0, 0x5B4;
    byte Chapter: 0x21CEC52;
    byte Loads: 0x2AB2DF4;
    int FileTimer: 0x2AB3228;
}

state("Yakuza5", "GOG")
{
    long CActionTitle: 0x1D13F78, 0x478;
    byte MenuConfirm:  0x1D13F78, 0x478, 0x1ec;
    byte AutoAssignmentMenu: 0x1D13F78, 0x478, 0x334;
    string255 QTE: 0x1F80060, 0x83A;
    byte QTEPassfail: 0x1F80060, 0x1304;
    string255 TitleCard: 0x1F812B8, 0x98, 0x11C, 0x2EC, 0x180, 0x1D4, 0xE0, 0x5B4;
    byte Chapter: 0x1F81912;
    byte Loads: 0x2865ADC;
    int FileTimer: 0x2865F18;
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 76271616:
            version = "GOG";
            break;
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
            settings.Add("syotitle_04_03.dds", false, "The Price of Truth", "tsh");
            settings.Add("syotitle_04_04.dds", false, "Fleeting Triumph", "tsh");
        settings.Add("fin", true, "Finale", "yak5");
            settings.Add("syotitle_05.dds", false, "Final Part", "fin");
            settings.Add("syotitle_05_01.dds", false, "A Legend Returns", "fin");
            settings.Add("syotitle_05_02.dds", false, "A Hidden Past", "fin");
            settings.Add("syotitle_05_03.dds", false, "The Survivors", "fin");
            settings.Add("syotitle_05_04.dds", false, "Crossroads", "fin");
            settings.Add("syotitle_05_05.dds", false, "Dreams Fulfilled", "fin");
            settings.Add("RUN OVER", false, "End of the Run", "fin");

    settings.SetToolTip("RUN OVER", "Splits on the last QTE of the final boss.");

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

isLoading 
{
    return current.Loads == 2 && current.FileTimer == old.FileTimer;
}

start
{
    return current.AutoAssignmentMenu == 1 && current.MenuConfirm != 0;
}

// Currently autosplits on every end of chapter save screen, and on the final QTE.
split
{
    if (current.Chapter == 21 && current.QTE == "h10340_aizawa_last" && current.QTEPassfail == 1 && !vars.Splits.Contains("RUN OVER"))
    {
        vars.Splits.Add("RUN OVER");
        return settings["RUN OVER"];
    }

    if (current.TitleCard != old.TitleCard && !vars.Splits.Contains(current.TitleCard))
    {
        vars.Splits.Add(current.TitleCard);
        return settings[current.TitleCard];
    }
}

reset
{
    return current.CActionTitle != 0 && old.CActionTitle == 0;
}

onStart
{
    timer.IsGameTimePaused = true;
}

onReset
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
