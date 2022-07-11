state("Yakuza5", "Steam") 
{
    int isLoading: 0x28ECC5C;
}

state("Yakuza5", "Game Pass") 
{
    int isLoading: 0x2AB2DF4;
}

init 
{
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

isLoading 
{
    return current.isLoading == 2;
}

start
{
    return current.isLoading == 1;
}
