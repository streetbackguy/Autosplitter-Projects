state("DP")
{
    byte MainMenu: 0x11E0A64;
    byte Loads : 0x1229C78, 0x28;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Loadless) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Loadless Time?",
            "LiveSplit | Deadpool",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

start
{
    //Added for the current.MainMenu to be greater than 0 to avoid autostarting when exiting the game
    return current.MainMenu != 200 && current.MainMenu > 0 && current.Loads == 0;
}

split
{

}

isLoading
{
    return current.Loads == 1;
}

reset
{
    return current.MainMenu == 200;
}

exit
{
    timer.IsGameTimePaused = true;
}