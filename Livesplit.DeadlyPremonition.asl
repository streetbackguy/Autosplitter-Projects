state("dp")
{
    int Loading: 0x106E8B4;
}

start
{
    return (current.Loading == 0 && old.Loading == 1);
}

onStart
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return (current.Loading == 0);
}

exit
{
    timer.IsGameTimePaused = true;
}