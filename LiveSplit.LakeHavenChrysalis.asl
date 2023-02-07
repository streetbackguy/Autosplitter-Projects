state("Lake Haven - Chrysalis")
{

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
        var sl = mono["SceneLoader"];

        vars.Helper["Loading"] = sl.MakeString("sceneNames");

        return true;
    });
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name == null ? current.activeScene : vars.Helper.Scenes.Active.Name;
	current.loadingScene = vars.Helper.Scenes.Loaded[0].Name == null ? current.loadingScene : vars.Helper.Scenes.Loaded[0].Name;

	// if(current.activeScene != old.activeScene) vars.Log("a: " + old.activeScene + ", " + current.activeScene);
	// if(current.loadingScene != old.loadingScene) vars.Log("l: " + old.loadingScene + ", " + current.loadingScene);
}

start
{
    return current.activeScene == "FarmHouse_Exterior";
}

isLoading
{
    return current.loadingScene != current.activeScene;
}

reset
{
    return current.activeScene == "MainMenu" && old.loadingScene != current.loadingScene;
}

onReset
{
    vars.Helper.Dispose();
}

exit
{
    vars.Helper.Dispose();
}
