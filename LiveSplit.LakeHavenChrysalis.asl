state("Lake Haven - Chrysalis")
{
    float IGT: "UnityPlayer.dll", 0x19B3730, 0x40, 0x10, 0x38, 0xDE4;
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    	vars.Helper.GameName = "Lake Haven - Chrysalis";
	vars.Helper.LoadSceneManager = true;
    	vars.Helper.AlertLoadless();

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Lake Haven - Chrysalis",
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
        vars.Helper["Fades"] = mono.Make<bool>("Transition", "To");

        return true;
    });
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name == null ? current.activeScene : vars.Helper.Scenes.Active.Name;
	current.loadingScene = vars.Helper.Scenes.Loaded[0].Name == null ? current.loadingScene : vars.Helper.Scenes.Loaded[0].Name;

	//if(current.activeScene != old.activeScene) vars.Log("a: " + old.activeScene + ", " + current.activeScene);
	//if(current.loadingScene != old.loadingScene) vars.Log("l: " + old.loadingScene + ", " + current.loadingScene);

}

start
{
    return current.activeScene == "FarmHouse_Exterior" && current.IGT > 0.0f;
}

isLoading
{
    return current.Fades;
}

reset
{
    return current.activeScene == "MainMenu" || current.loadingScene == "WarningScreen";
}

onReset
{
    vars.Helper.Dispose();
}

exit
{
    timer.IsGameTimePaused = true;
    vars.Helper.Dispose();
}
