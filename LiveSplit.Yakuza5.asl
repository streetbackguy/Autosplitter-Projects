//Collaborative effort by streetbackguy and hoxi
state("Yakuza5", "Steam") 
{
    int Loads: 0x28ECC5C;
    int MainMenu: 0x28A0938, 0x3C;
    byte chapter: 0x3073166;
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
    vars.doSplit = false;

    if (current.chapter == 34 && old.chapter == 35)
    {
        vars.doSplit = true;
    }

    print(modules.First().ModuleMemorySize.ToString());
}

isLoading 
{
    return (current.chapter != 34 && current.Loads == 2);
}

start
{
    return (current.Loads == 2 && old.MainMenu == 4352);
}

//Currently autosplits on every end of chapter save screen
split
{   
    return (vars.doSplit);
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}
