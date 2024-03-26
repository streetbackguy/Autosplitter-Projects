state("SnowDay-Win64-Shipping")
{
    byte Loads: 0x536AD00, 0x354;
}

isLoading
{
	return current.Loads != 0;
}

exit
{
    timer.IsGameTimePaused = true;
}