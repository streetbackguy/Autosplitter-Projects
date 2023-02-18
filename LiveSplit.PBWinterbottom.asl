state("WinterBottom")
{
    bool Loading: 0x00281B04, 0x2C;
    int Autostart: 0x0001ACD0, 0xD0, 0xE58;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | The Misadventures of P.B. Winterbottom",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

start
{
    return !current.Loading && current.Autostart == 1693748;
}

isLoading 
{
    return !current.Loading;
}

onStart
{
    timer.IsGameTimePaused = true;
}