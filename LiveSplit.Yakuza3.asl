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
        case 77086720:
            version = "Steam";
            break;
    }
}

isLoading {
    return current.isLoading == 0;
}
