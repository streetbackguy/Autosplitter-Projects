state("P5R", "Steam") 
{
    byte Loads: 0x29B5918;
    byte Transitions: 0x2AA1983;
    byte SceneLoads: 0x2AA1970;
    byte Fades: 0x2AA45F0;
    byte NGStart: 0x29B4AC8;
    byte Cutscene: 0x26E4AA8;
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 405430272:
            version = "Steam Version 1.0";
            break; 

        case 395833344:
            version = "Steam Version 1.03";
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
    return (current.Transitions == 4 || current.Loads == 0 && old.Loads == 40 && current.Cutscene == 0 || current.Loads == 0 && old.Loads == 40);
}

start
{
    return (current.NGStart == 39 && old.NGStart == 80);
}
