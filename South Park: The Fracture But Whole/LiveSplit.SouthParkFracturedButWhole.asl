state("SouthPark_TFBW")
{
    bool Loads: 0x34A0320;
    byte CharCreate: 0x3780835;
    int MainMenu: 0x3AA25FD;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | South Park: The Fractured But Whole",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

start
{
    return (current.CharCreate == 178 && old.CharCreate == 0);
}

reset
{
    return (current.MainMenu == 0 && old.MainMenu != 0);
}

isLoading
{
    return (current.Loads);
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}