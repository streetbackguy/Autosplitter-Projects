state("South Park - The Stick of Truth", "Current Patch")
{
	bool Loads:  0x0108598, 0x0;
	int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
	int Quest: 0x0E49C00, 0x690, 0x5AC;
	int Friends: 0x1C7660C;
	int Chinpokomon: 0x1C765C0;
    int Lightning: 0x1CA80D0;
	int MainMenu: 0x1D2AC70;
    int QuestComplete: 0x1C76600;
}

state("South Park - The Stick of Truth", "Unpatched")
{
	bool Loads: 0x00108708, 0x0; 
	int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
	int Quest: 0x0E49C00, 0x690, 0x5AC;
	int Friends: 0x1C7660C;
	int Chinpokomon: 0x1C765C0;
    int Lightning: 0x1CA80D0;
	int MainMenu: 0x1D2AC70;
    int QuestComplete: 0x1C76600;
}

init
{
    switch(modules.First().ModuleMemorySize) 
    {
        case 31830016:
            version = "Current Patch";
            break;

        case 472219648:
            version = "Unpatched";
            break;
    }
}

startup
{
    vars.QuestTimer = new Stopwatch();
    vars.minimumtime = TimeSpan.FromSeconds(10);

    settings.Add("Anyquests", true, "Any% Quests");
        settings.Add("quests", false, "Split after each completed quest", "Anyquests");

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
    print(modules.First().ModuleMemorySize.ToString());

    if (vars.QuestTimer.Elapsed >= vars.minimumtime) vars.QuestTimer.Stop();
}

start
{
    return (current.ScreenChange == 0 && old.ScreenChange == 2);
}

isLoading 
{
	return (current.Loads || current.ScreenChange == 16 || current.Lightning == 1);
}

split
{
    if (current.QuestComplete != 0 && old.QuestComplete == 0)
    {
        return !vars.QuestTimer.IsRunning;
        return settings["quests"];
    }
}

onStart
{
    vars.QuestTimer.Restart();
}

onSplit
{
    vars.QuestTimer.Restart();
}

exit
{
    timer.IsGameTimePaused = true;
}
