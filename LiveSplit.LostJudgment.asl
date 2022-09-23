state("LostJudgment", "Steam") 
{
    bool LogoLoads: 0x41E9C44;
    bool GameState: 0x41EA74C;
    int Transitions: 0x1495D950;
    int Autostart: 0x532EEFC;
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 77086720:
            version = "Steam";
            break;
    }
}

startup
{   
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Lost Judgment",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
    print(modules.First().ModuleMemorySize.ToString());
}

isLoading 
{
    return current.LogoLoads || current.Transitions == 0;
}

start
{
    return current.Autostart == 0 && old.Autostart == 1;
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}