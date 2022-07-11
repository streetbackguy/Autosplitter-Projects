state("Yakuza3", "Steam") 
{
    int isLoading: 0x1198218, 0x310, 0x210;
}

state("Yakuza3", "Game Pass") 
{
    int isLoading: 0x2AB2DF4;
}

init {
    switch(modules.First().ModuleMemorySize) 
    {
        case 78782464:
            version = "Game Pass";
            break; 
        case 47144960:
            version = "Steam";
            break;
    }
}

update
{
    print(modules.First().ModuleMemorySize.ToString());
}

start
{
    return current.isLoading != 0;
}

isLoading 
{
    return current.isLoading == 0;
}

exit
{
    timer.IsGameTimePaused = true;
}
