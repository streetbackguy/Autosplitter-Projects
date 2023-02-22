state("South Park - The Stick of Truth")
{
	bool Loads:  0x0108598, 0x0;
	bool UnpatchedLoads: 0x00108708, 0x0;
	int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
	int Lightning: 0x1CA80D0;
	int MainMenu: 0x1D2AC70;
	int QuestComplete: 0x1C76600;
	int EndSplit: 0x1CC5D3C;
	int Chinpokomon: 0x1C76080;
}

startup
{
    vars.QuestTimer = new Stopwatch();
    vars.minimumtime = TimeSpan.FromSeconds(10);

    settings.Add("Anyquests", true, "Quests");
        settings.Add("quests", false, "Split after each Quest and Friend", "Anyquests");
        settings.Add("end", false, "Split on the final button prompt", "Anyquests");
        settings.Add("chin", false, "Split after each collected Chinpokomon", "Anyquests");

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
	return (current.Loads || current.UnpatchedLoads || current.ScreenChange == 16 || current.Lightning == 1);
}

split
{
    if (current.QuestComplete != 0 && old.QuestComplete == 0)
    {
        return !vars.QuestTimer.IsRunning;
        return settings["quests"];
    }

    if (current.EndSplit == 18 && old.EndSplit == 0)
    {
        return settings["end"];
    }

    if (current.Chinpokomon == 1347209379 && old.Chinpokomon == 0)
    {
        return settings["chin"];
    }
}

onStart
{
    vars.QuestTimer.Restart();
    timer.IsGameTimePaused = true;
}

onSplit
{
    vars.QuestTimer.Restart();
}

exit
{
    timer.IsGameTimePaused = true;
}
