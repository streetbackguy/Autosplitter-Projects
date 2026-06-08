state("Killer Bean")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/uhara10")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();

    vars.Splits = new HashSet<string>();
}

init
{
    vars.Utils = vars.Uhara.CreateTool("Unity", "IL2CPP", "Utils");
    vars.Instance = vars.Uhara.CreateTool("Unity", "IL2CPP", "Instance");

    vars.Instance.Watch<bool>("LoadingScreen", "LoadingScreenManager", "isLoading");
}

update
{
    vars.Uhara.Update();
	
	current.ActiveScene = vars.Utils.GetActiveSceneName() ?? current.ActiveScene;
	current.SolidScene = vars.Utils.GetActiveSceneName2() ?? current.SolidScene;
	current.LoadingScene = vars.Utils.GetLoadingSceneName() ?? current.LoadingScene;
	
	if (current.SolidScene != old.SolidScene)
	{
		print("Solid: " + current.SolidScene);
	}

    if (current.ActiveScene != old.ActiveScene)
	{
		print("Active: " + current.ActiveScene);
	}

    if (current.LoadingScene != old.LoadingScene)
	{
		print("Loading: " + current.LoadingScene);
	}
}

start
{
    return current.LoadingScene == "KB_Cutscene_Intro" && old.ActiveScene == "Play_Test_Main_Menu";
}

onStart
{
    vars.Splits.Clear();
}

isLoading
{
    return current.LoadingScreen;
}

exit
{
	timer.IsGameTimePaused = true;
}
