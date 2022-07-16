//Collaborative effort by streetbackguy and hoxi
state("Yakuza5", "Steam") 
{
    int isLoading: 0x28ECC5C;
    int chapter: 0x4614FF0, 0x858, 0x9B8, 0x218, 0x4E8, 0xDB0;
}

state("Yakuza5", "Game Pass") 
{
    int isLoading: 0x2AB2DF4;
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
    vars.LastSplit = TimeSpan.FromSeconds(500);

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

//Starts when the game is booting up, but can be reset at main menu and then will autostart upon loading a New Game/New Game Plus file
start
{
    return (current.isLoading == 1);
}

//Pauses during Title and Chapter Cards also, but shouldn't be too much of an issue
isLoading 
{
    return (current.isLoading == 2);
}

//Currently autosplits on every Title Card
split
{
    if (current.chapter != 0 | current.chapter != 1 && current.isLoading == 2 && old.isLoading == 1)
    {
        return !vars.SkipSplit.IsRunning;
        return true;
    }
}

onSplit
{
    vars.SkipSplit.Restart();
}

onSplit
{
    vars.SkipSplit.Restart();
}

exit
{
    timer.IsGameTimePaused = true;
}
