// Steam Version 1.10.984 (Next Gen Update 2)
state("Fallout4")
{
    bool isLoadingScreen: 0x2E66416;
    bool isQuickLoading: 0x2CBFB50;
    bool isMiscLoad: 0x3584CF4;
}

isLoading
{
	return current.isLoadingScreen || current.isQuickLoading || current.isMiscLoad;
}

exit
{
	timer.IsGameTimePaused = true;
}

