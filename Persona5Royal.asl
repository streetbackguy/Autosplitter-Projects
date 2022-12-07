state("P5R", "Steam") 
{
    bool Loads: 0x2AE7BD0;
    byte NGStart: 0x2AED0CF;
    byte Cutscene: 0x29B8D9C;
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 405430272:
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
            "LiveSplit | Persona 5 Royal",
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
    return !current.Loads && current.Cutscene != 35;
}

start
{
    return (current.NGStart == 59 && old.NGStart == 58);
}

exit
{
    timer.IsGameTimePaused = true;
}
