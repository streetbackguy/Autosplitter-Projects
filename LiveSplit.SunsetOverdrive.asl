state("Sunset") 
{
    bool Loads: 0x42ACC48;
    int Starter: 0x45AA825;
    int Autoreset: 0x433B878;
    int MissionSuccess: 0x3C18FE0;
}

startup
{   
    settings.Add("SO", true, "Sunset Overdrive");
        settings.Add("MISSIONS", true, "Split after each Mission is completed", "SO");
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
    if(current.MissionSuccess != 0 && old.MissionSuccess == 0)
    {
        return settings["MISSIONS"];
    }
}

reset
{
    return current.Autoreset == 2 && old.Autoreset == 3;
}

exit
{
    timer.IsGameTimePaused = true;
}
