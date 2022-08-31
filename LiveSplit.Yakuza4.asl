state("Yakuza4", "Steam")
{
    byte EventFlag: 0x16EF028;      // 0 during gameplay, 2 during most textboxes, can be other values
    byte EnemyCount: 0x197C440, 0x4B3;
    byte Chapter: 0x197C838, 0x640, 0x204;
    byte Character: 0x19806D0;      // 0 - 3: Kiryu, Akiyama, Saejima, Tanimura
    short Paradigm: 0x1980D94;      // Unique value for different gameplay modes, menus, etc.
    byte Start: 0x198C624;          // Black screen / screen fade flag
    short DiffFlag1: 0x1993F30;     // Value to help exclude certain black screens
    short DiffFlag2: 0x1993F38;     // Value to help exclude certain black screens
    int FileTimer: 0x19A3AC8;       // In-game timer
}

state("Yakuza4", "Game Pass")
{
    int Loads: 0x2AB2DF4;
}

init 
{
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

/* Pause the timer while the screen is black,
// but only if IGT has stopped, or if we're not within excluded events. */
isLoading 
{
    return current.Start == 2
    &&  (current.FileTimer == old.FileTimer
        ||  (current.EventFlag == 2
            && ((current.Chapter == 3 && current.DiffFlag1 != 19204 && current.DiffFlag2 != 19204)  // Sky Finance
            ||  (current.Chapter == 7 && current.DiffFlag1 != 13124 && current.DiffFlag2 != 19972)  // Sake delivery
            ||  (current.Chapter == 8 && current.DiffFlag1 != 26884 && current.DiffFlag2 != 26884)) // Meeting Sasai
    ));
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
    if (current.Chapter < 17)
        return (old.Paradigm == 200 && current.Paradigm != 200);    // Split after save prompts

    else if (current.Chapter == 17)
        return (current.Character == 3 && old.EnemyCount > 0 && current.EnemyCount == 0); // End of the run

    return false;
}

reset
{
    return (old.Paradigm == 209 && current.Paradigm == 221);
}

exit
{
    timer.IsGameTimePaused = true;
}
