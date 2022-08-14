state("Yakuza4", "Steam") 
{
    int Start: 0x198C624;
    byte Loads: 0x362D400;
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

isLoading 
{
    return (current.Loads == 1 && current.Start == 2);
}

onStart
{
    timer.IsGameTimePaused = true;
}

start 
{
    return (current.Start == 2);
}

exit
{
    timer.IsGameTimePaused = true;
}
