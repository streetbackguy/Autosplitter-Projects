state("Bloodline")
{
    byte Starter: 0x2CB35D;
    uint Loads: 0x01026FC, 0x220;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Bloodline",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

isLoading
{
    return current.Loads == 1095393201;
}

start
{
    return current.Loads == 1095481451 && old.Loads == 1095393201 && current.Starter != 1;
}

split
{
    //Work in Progress for Final Split
}

exit
{
    timer.IsGameTimePaused = true;
}3
