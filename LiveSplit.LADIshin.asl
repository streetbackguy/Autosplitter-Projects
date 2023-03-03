state("LikeaDragonIshin-Win64-Shipping", "Steam 1.02") 
{
    int Loads: 0x0625E968, 0x780, 0x6C; //Version 1.02
    int Autostart: 0x6239E78;
}

state("LikeaDragonIshin-Win64-Shipping", "Steam 1.03") 
{
    int Loads: 0x0625B398, 0x780, 0x6C; //Version 1.03
    int Autostart: 0x625ECD0;
}

startup
{   
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Like a Dragon: Ishin!",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

init
{
    switch(modules.First().ModuleMemorySize) 
    {
        case 341323776:
            version = "Steam 1.02";
            break;

        case 348905472:
            version = "Steam 1.03";
            break;
    }

    print(modules.First().ModuleMemorySize.ToString());
}

isLoading
{
    return current.Loads == 4;
}

start
{
    return current.Autostart == 1 && old.Autostart == 0;
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}
