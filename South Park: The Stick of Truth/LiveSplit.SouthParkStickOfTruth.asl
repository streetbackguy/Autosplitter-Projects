state("South Park - The Stick of Truth")
{
	byte Loads:  0x8F6814;
    byte UnpatchedLoads: 0x00108708, 0x0;
	int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
    int Lightning: 0x1CA80D0;

    int QuestObjectives: 0x1BF84BC;
}

startup
{
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

start
{
    return (current.ScreenChange == 0 && old.ScreenChange == 2);
}

split
{
    if(current.QuestObjectives != old.QuestObjectives)
    {
        return true;
    }
}

isLoading 
{
	return (current.Loads == 1 || current.UnpatchedLoads == 1 || current.ScreenChange == 16 || current.Lightning == 1);
}