state("WD-Win64-Shipping", "Patch 3.0")
{
    bool IsInGame: 0x4EC9938, 0x180, 0x434;
    bool IntroSkip: 0x4EC9938, 0x180, 0x435;
    float InputX: 0x4EC9938, 0x120, 0x238, 0x0, 0x280, 0x288, 0x250;
    float InputY: 0x4EC9938, 0x120, 0x238, 0x0, 0x280, 0x288, 0x254;
    float InputZ: 0x4EC9938, 0x120, 0x238, 0x0, 0x280, 0x288, 0x258;

    int Loads: 0x4EC5560;
    byte Episode: 0x4EC9938, 0x180, 0x1A8;
    byte LastEndingEpisode: 0x4EC9938, 0x180, 0x1AD;

    int ItemID: 0x4EC9938, 0x2E0;
}

init
{
    print("Module Memory is:" + modules.First().ModuleMemorySize.ToString());

    switch(modules.First().ModuleMemorySize) 
    {
        case 87719936:
            version = "Patch 3.0";
            break; 
    }
}

startup
{

}

start
{
    //Start for Episode 1
    return current.IsInGame && current.InputX != old.InputX && old.InputX == 5741.600098f || current.IsInGame && current.InputY != old.InputY && old.InputY == -268.6000061f ||
    //Start for Episode 2
    current.IsInGame && current.InputX != old.InputX && old.InputX == 456.7396851f || current.IsInGame && current.InputY != old.InputY && old.InputY == -5.599999905f ||
    //Start for Episode 3
    current.IsInGame && current.InputX != old.InputX && old.InputX == 10544.99707f || current.IsInGame && current.InputY != old.InputY && old.InputY == -3321.652832f;
}

split
{

}

isLoading
{
    return current.Loads != 20;
}

reset
{

}

exit
{
    timer.IsGameTimePaused = true;
}

