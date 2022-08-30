state("dp")
{
    int Loading: 0x106E8B4;
    int Radio: 0x4C5644;
}

start
{
    return (current.Loading == 0);
}

onStart
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return (current.Loading == 0 && old.Loading == 1 || current.Radio != 12);
}

exit
{
    timer.IsGameTimePaused = true;
}
