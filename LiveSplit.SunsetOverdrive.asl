state("Sunset", "Steam") 
{
    bool Loads: 0x42ACC48;
    int Starter: 0x45AA825;
    int MissionSuccess: 0x3C199B4;
}

state("Sunset", "Windows Store") 
{
    bool Loads: 0x45BADF0;
    int Starter: 0x3EF82D8;
    int MissionSuccess: 0x3EA2764;
}

init
{
    switch(modules.First().ModuleMemorySize)
    {
        case 80991232: version = "Steam"; break;
        case 83477504: version = "Windows Store"; break;

        default: version = "Unknown"; break;
    }
}

startup
{   
    settings.Add("SO", true, "Sunset Overdrive");
        settings.Add("MISSIONS", true, "Split on each Mission Success Screen", "SO");
        //settings.Add("END", true, "Split when the Fizzco Building is defeated", "SO");

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
    return current.Starter == 2 && old.Starter == 0 && !current.Loads;
}

split
{
    if(current.MissionSuccess == 3 && old.MissionSuccess != 3)
    {
        return settings["MISSIONS"];
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
