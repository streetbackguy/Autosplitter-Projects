state("kaneandlynch")
{
    bool Starter: 0x888398;
    byte GameFlag: 0x68C6AE;
    bool Loads: 0x788020;
    byte Chapters: 0x025468C, 0xE00, 0x7E8;
}

startup
{
    
}

start
{
    return current.Starter && current.GameFlag == 168;
}

onStart
{
    timer.IsGameTimePaused = true;
}

split
{
    return current.GameFlag != old.GameFlag && current.GameFlag == 168;
}

isLoading
{
    return current.Loads;
}

exit
{
    timer.IsGameTimePaused = true;
}