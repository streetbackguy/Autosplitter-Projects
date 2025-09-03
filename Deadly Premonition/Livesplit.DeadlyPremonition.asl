state("dp")
{
    int Loading: 0x106E8B4;
    int Radio: 0x4C5644;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Deadly Premonition",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}


start
{
    return (current.Loading == 0 && old.Loading == 1);
}

isLoading
{
    return (current.Loading == 0 || current.Radio != 12);
}

exit
{
    timer.IsGameTimePaused = true;
}