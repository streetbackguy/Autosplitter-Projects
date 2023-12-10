state("P5R", "Steam 1.02") 
{
    int Transitions: 0x02AA20F0, 0x48, 0x4;
    int Prompts: 0x26CEB00;
    int NGStart: 0x10EC18C8, 0x14, 0x88, 0xD3C;
}

state("P5R", "Steam 1.03") 
{
    int Transitions: 0x02AA2100, 0x48, 0x4;
    int Prompts: 0x26CEB00;
    int NGStart: 0x02AA1CB8, 0x48, 0xD0, 0x2E0, 0x68, 0x408, 0x78C;
}

state("P5R", "Steam 1.03B") 
{
    int Transitions: 0x02AA2100, 0x48, 0x4;
    int Prompts: 0x26CEB00;
    int NGStart: 0x02AA1C98, 0x80, 0x48, 0xD0, 0x2E0, 0x68, 0x408, 0x78C;
}

init 
{
    switch(modules.First().ModuleMemorySize) 
    {
        case 405430272:
            version = "Steam 1.02";
            break;

        case 395833344:
            version = "Steam 1.03";
            break;
        
        case 404893696:
            version = "Steam 1.03B";
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
    return (current.Transitions != 3);
}

start
{
    return (current.NGStart != 0 && old.NGStart == 0 && current.Transitions == 3 && version == "Steam 1.03" ||
            current.NGStart != 0 && old.NGStart == 0 && current.Transitions == 3 && version == "Steam 1.03B");
}

exit
{
    timer.IsGameTimePaused = true;
}
