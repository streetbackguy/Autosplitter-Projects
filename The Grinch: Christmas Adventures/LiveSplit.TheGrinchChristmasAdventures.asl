state("TheGrinch")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/uhara10")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();

}

init
{
    vars.Utils = vars.Uhara.CreateTool("Unity", "Mono", "Utils");
    vars.Instance = vars.Uhara.CreateTool("Unity", "Mono", "Instance");

    vars.Instance.Watch<bool>("LoadingScreen", "Grinch:Statics", "IsLoading");
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
    return current.LoadingScene== "Reload" && old.ActiveScene == "Menu (Start)";
}

isLoading
{
    return current.LoadingScreen;
}

reset
{
	return current.ActiveScene == "Menu (Start)" && old.ActiveScene == "Reload";
}

exit
{
	timer.IsGameTimePaused = true;
}
