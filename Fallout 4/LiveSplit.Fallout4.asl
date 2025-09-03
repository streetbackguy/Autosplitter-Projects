// Steam Version 1.10.984 (Next Gen Update 2)
state("Fallout4")
{
    bool isLoadingScreen: 0x2E66416;
    bool isQuickLoading: 0x2CBFB50;
    bool isMiscLoad: 0x3584CF4;
    string26 isInstituteEntry: 0x0313B9F0, 0x0, 0x50, 0x30, 0x6E0;
}

isLoading
{
	return current.isLoadingScreen || current.isQuickLoading || current.isMiscLoad && current.isInstituteEntry != "Use the Signal Interceptor";
}

exit
{
	timer.IsGameTimePaused = true;
}