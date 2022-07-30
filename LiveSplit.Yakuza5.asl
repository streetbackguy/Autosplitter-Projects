//Collaborative effort by streetbackguy and hoxi
state("Yakuza5", "Steam") 
{
    int Loads: 0x28ECC5C;
    byte chapter: 0x2D79F90, 0x240, 0xC94;
}

state("Yakuza5", "Game Pass") 
{
    int Loads: 0x2AB2DF4;
}

init 
{
    switch(modules.First().ModuleMemorySize) 
    {
        case 78782464:
            version = "Game Pass";
            break; 
        case 77086720:
            version = "Steam";
            break;
    }
}

startup
{
    vars.SkipSplit = new Stopwatch();
    vars.LastSplit = TimeSpan.FromSeconds(1000);

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Yakuza 5",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
    if (vars.SkipSplit.Elapsed >= vars.LastSplit) vars.SkipSplit.Stop();
    print(modules.First().ModuleMemorySize.ToString());
}

isLoading 
{
    return (current.chapter != 255 && current.Loads == 2);
}

start
{
    return (current.Loads == 2);
}

//Currently autosplits on every Title Card after the first two
split
{
    if (current.chapter == 255 && current.Loads == 2)
    {
        return !vars.SkipSplit.IsRunning;
        return true;
    }
}

onSplit
{
    vars.SkipSplit.Restart();
}

onStart
{
    timer.IsGameTimePaused = true;
    vars.SkipSplit.Restart();
}

exit
{
    timer.IsGameTimePaused = true;
}
