state("Bloodline")
{
    byte Starter: 0x2CB35D;
    byte Loads: 0x01026FC, 0x220;
    string255 Dialogue: 0x01CB7D8, 0x94, 0x8, 0x9B0, 0x4A8, 0xC, 0x0, 0xD4;
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

update
{
    if (current.Dialogue != old.Dialogue)
    {
        print(current.Dialogue);
    }
}

isLoading
{
    return current.Loads == 177;
}

start
{
    return current.Starter == 0 && current.Loads != old.Loads;
}

split
{
    return current.Dialogue == "\nSomething is happening to me... " && old.Dialogue =="\nBell. ";
}

exit
{
    timer.IsGameTimePaused = true;
}