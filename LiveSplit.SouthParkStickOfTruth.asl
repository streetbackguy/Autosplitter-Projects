state("South Park - The Stick of Truth")
{
	bool Loads:  0x0108598, 0x0;
    bool UnpatchedLoads: 0x00108708, 0x0; 
    int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
}

start
{
    return (current.ScreenChange == 0 && old.ScreenChange == 2);
}

isLoading 
{
		return (current.Loads || current.UnpatchedLoads || current.ScreenChange == 16);
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}