state("South Park - The Stick of Truth")
{
    bool Loads:  0x0108598, 0x0;
    bool UnpatchedLoads: 0x00108708, 0x0;
    int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
    int Lightning: 0x1CA80D0;
    int MainMenu: 0x1D2AC70;
    int QuestComplete: 0x00E49C00, 0x780, 0x510;
    int EndSplit: 0x1CC5D3C;
    int Chinpokomon: 0x00E49C10, 0x1C0, 0x9F4;
    int NewFriend: 0x1C765C0;
}

startup
{
    vars.QuestTimer = new Stopwatch();
    vars.Qminimumtime = TimeSpan.FromSeconds(10);

    vars.FriendTimer = new Stopwatch();
    vars.Fminimumtime = TimeSpan.FromSeconds(10);

    settings.Add("sot", true, "South Park: The Stick of Truth");
        settings.Add("quests", false, "Split after each Quest", "sot");
        settings.Add("end", false, "Split on the final button prompt", "sot");
        settings.Add("friends", false, "Split after each new Friend", "sot");
        settings.Add("chin", false, "Split after each collected Chinpokomon", "sot");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | South Park: The Stick of Truth",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
    if (vars.QuestTimer.Elapsed >= vars.Qminimumtime) vars.QuestTimer.Stop();
    if (vars.FriendTimer.Elapsed >= vars.Fminimumtime) vars.FriendTimer.Stop();
}

start
{
    return (current.ScreenChange == 0 && old.ScreenChange == 2);
}

isLoading 
{
    return (current.Loads || current.UnpatchedLoads || current.ScreenChange == 16 || current.Lightning == 1);
}

split
{
    if (current.QuestComplete == 2 && old.QuestComplete == 1)
    {
        return !vars.QuestTimer.IsRunning;
        return settings["quests"];
    }

    if (current.NewFriend == 4 && old.NewFriend == 0)
    {
        return !vars.FriendTimer.IsRunning;
        return settings["friends"];
    }

    if (current.EndSplit == 18 && old.EndSplit == 0)
    {
        return settings["end"];
    }

    if (current.Chinpokomon == 2 && old.Chinpokomon == 1)
    {
        return settings["chin"];
    }
}

onStart
{
    vars.FriendTimer.Restart();
    vars.QuestTimer.Restart();
    timer.IsGameTimePaused = true;
}

onSplit
{
    vars.QuestTimer.Restart();
    vars.FriendTimer.Restart();
}

exit
{
    timer.IsGameTimePaused = true;
}
