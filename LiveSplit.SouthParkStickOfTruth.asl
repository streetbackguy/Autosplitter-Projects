state("South Park - The Stick of Truth")
{
	bool Loads:  0x0108598, 0x0;
	bool UnpatchedLoads: 0x00108708, 0x0; 
	int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
	int Quest: 0x0E49C00, 0x780, 0x510;
	int Friends: 0x1C7660C;
	int Chinpokomon: 0x1C765C0;
	int MainMenu: 0x1D2AC70;
}

init
{
    vars.Splits = new HashSet<string>();
}

startup
{
    settings.Add("quests", false, "Split after each Quest Complete notification");
    settings.Add("friends", false, "Split after each Friend Request");
    settings.Add("chinpokomon", false, "Split after each Chinpokomon firgure and Key Item picked up");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | South Park: The Stick of Truth",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
	if (current.MainMenu == 0 && old.MainMenu != 0) 
    { 
        vars.Splits.Clear(); 
    }
}

start
{
    return (current.ScreenChange == 0 && old.ScreenChange == 2);
}

isLoading 
{
	return (current.Loads || current.UnpatchedLoads || current.ScreenChange == 16);
}

split
{
    if (current.Quest == 2 && old.Quest == 1)
    {
        return settings["quests"];
    }

    if (current.Chinpokomon == 6 && old.Chinpokomon != 6)
    {
        return settings["chinpokomon"];
    }

    if (current.Friends == 5 && old.Friends == 0)
    {
        return settings["friends"];
    }
}

onStart
{
    timer.IsGameTimePaused = true;
}

reset
{
    return (current.MainMenu == 0 && old.MainMenu == 1);
}

onReset
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
