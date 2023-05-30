state("Hearthstone") 
{
    bool LoadingBar: "mono-2.0-bdwgc.dll", 0x0586A44, 0x400, 0xCA8, 0x18, 0x108, 0x658, 0x24, 0x804;
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Hearthstone";
	vars.Helper.LoadSceneManager = true;

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Hearthstone",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

init
{
        vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var sm = mono.GetClass("SceneMgr");
        var gm = mono.GetClass("GameMgr");

        vars.Helper["Transitioning"] = sm.Make<bool>("s_instance", "m_transitioning");

        return true;
    });
}

isLoading
{
    return current.Transitioning || current.LoadingBar;
}

exit
{
	timer.IsGameTimePaused = true;
    vars.Helper.Dispose();
}

shutdown
{
    vars.Helper.Dispose();
}
