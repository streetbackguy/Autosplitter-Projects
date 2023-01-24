state("LostJudgment", "Steam") 
{
    byte Loads: 0x4322CE0, 0x310, 0x544;
    byte Autostart: 0x151D3DA2;
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 77086720:
            version = "Steam 1.0";
            break;

        case 472219648:
            version = "Steam 1.11";
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
    return current.Loads == 1;
}

//Autostarts after the checkpoint information prompt
start
{
    return current.Autostart != old.Autostart;
}

onStart
{
    timer.IsGameTimePaused = true;
}
