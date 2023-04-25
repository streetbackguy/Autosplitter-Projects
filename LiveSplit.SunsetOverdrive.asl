state("Sunset") 
{
    bool Loads: 0x42ACC48;
    int Objective: 0x38E7270; //Originally found by Meta
    int Autoreset: 0x433B878;
}

startup
{   
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Sunset Overdrive",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

isLoading
{
    return current.Loads;
}

start
{
    return current.Objective == 1 && old.Objective == 0 && !current.Loads;
}

reset
{
    return current.Autoreset == 2 && old.Autoreset == 3;
}

exit
{
    timer.IsGameTimePaused = true;
}
