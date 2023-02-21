state("Judgment") 
{
    int Loads: 0x0240A528, 0x160, 0x88, 0x218, 0x74;
    int Autostart: 0x23F49F0;
}

isLoading
{
    return current.Loads != 0;
}

start
{
    return current.Autostart == 231 && old.Autostart == 243;
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}