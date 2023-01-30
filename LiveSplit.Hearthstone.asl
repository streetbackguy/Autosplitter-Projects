state("Hearthstone") 
{

}

startup
{
	vars.Log = (Action<object>)(value => print(String.Concat("[Hearthstone] ", value)));
	vars.Unity = Assembly.Load(File.ReadAllBytes(@"Components\UnityASL.bin")).CreateInstance("UnityASL.Unity");
	vars.Unity.LoadSceneManager = true;

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
    vars.Unity.TryOnLoad = (Func<dynamic, bool>)(helper =>
	{
        var SM = helper.GetClass("Assembly-CSharp", "SceneMgr");
        var SMM = helper.GetParent(SM);
        var GP = helper.GetClass("Assembly-CSharp", "Gameplay");
        var LB = helper.GetClass("Assembly-CSharp", "LoadingScreen");

        vars.Unity.Make<bool>(GP.Static, GP["s_instance"]).Name = "Gameplay";
        vars.Unity.Make<bool>(LB.Static, LB["m_FadeInSec"]).Name = "isLoading";
        vars.Unity.Make<bool>(SM.Static, SM["m_reloadMode"]).Name = "LoadScreen";

		return true;
	});

    vars.Unity.Load(game);
}

update
{
    if (!vars.Unity.Loaded) return false;

    vars.Unity.Update();

    current.LoadingBar = vars.Unity["isLoading"].Current;
    current.Gameplay = vars.Unity["Gameplay"].Current;
    current.LoadScreen = vars.Unity["LoadScreen"].Current;
    current.Scene = vars.Unity.Scenes.Active.Index;
}

isLoading
{
    return !current.Gameplay;
}

onStart
{
    print("\nNew run started!\n----------------\n");
}

onReset
{
	print("\nRESET\n-----\n");
}

exit
{
	timer.IsGameTimePaused = true;
    vars.Unity.Reset();
}

shutdown
{
    vars.Unity.Reset();
}