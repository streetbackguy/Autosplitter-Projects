state("BadWay")
{
    bool Gameplay: 0x4527230;
    int Autostart: 0x0;
}

isLoading
{
    return !current.Gameplay;
}

start
{
    
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}