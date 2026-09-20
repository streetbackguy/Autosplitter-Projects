state("The Grinch 2 Saving Christmas")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/uhara10")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();

	settings.Add("GRINCH", true, "The Grinch 2: Saving Christmas Splits");
		settings.Add("TUT", true, "Tutorials", "GRINCH");
			settings.Add("(Lv01)_GrinchsCave_00_T", true, "Memory of Grinch's Cave", "TUT");
			settings.Add("(Lv02)_MountCrumpit_00_T", true, "Memory of Mt. Crumpit", "TUT");
			settings.Add("(Lv03)_WhoVille_00_T", true, "Memory of Who-ville", "TUT");
		settings.Add("CAVE", true, "Grinch's Cave", "GRINCH");
			settings.Add("(Lv05)_GrinchsCave_01", true, "Rocky Route", "CAVE");
			settings.Add("(Lv06)_GrinchsCave_02", true, "Twisty Trail", "CAVE");
			settings.Add("(Lv07)_GrinchsCave_03", true, "Funnel Tunnels", "CAVE");
			settings.Add("(Lv08)_GrinchsCave_04", true, "Jolly Hollow", "CAVE");
			settings.Add("(Lv09)_GrinchsCave_05", true, "Drafty Depths", "CAVE");
		settings.Add("MT", true, "Mt. Crumpit", "GRINCH");
			settings.Add("(Lv10)_MountCrumpit_01", true, "Wintry Way", "MT");
			settings.Add("(Lv11)_MountCrumpit_02", true, "Loot Route", "MT");
			settings.Add("(Lv12)_MountCrumpit_03", true, "Mighty Heights", "MT");
			settings.Add("(Lv13)_MountCrumpit_04", true, "Avalanche Alley", "MT");
			settings.Add("(Lv14)_MountCrumpit_05", true, "Plummety Summit", "MT");
		settings.Add("WOOD", true, "Who Wood", "GRINCH");
			settings.Add("(Lv04)_Who_Wood_01", true, "Winding Woods", "WOOD");
			settings.Add("(Lv20)_Who_Wood_02", true, "Trickety Thicket", "WOOD");
			settings.Add("(Lv21)_Who_Wood_03", true, "Breezy Trees", "WOOD");
			settings.Add("(Lv22)_Who_Wood_04", true, "Piny Path", "WOOD");
			settings.Add("(Lv23)_Who_Wood_05", true, "Hightail Trail", "WOOD");
		settings.Add("WHOVILLE", true, "Who-Ville", "GRINCH");
			settings.Add("(Lv15)_WhoVille_01", true, "Candy Cane Corner", "WHOVILLE");
			settings.Add("(Lv16)_WhoVille_02", true, "Sleigh-Day Way", "WHOVILLE");
			settings.Add("(Lv17)_WhoVille_03", true, "Snowed-In Road", "WHOVILLE");
			settings.Add("(Lv18)_WhoVille_04", true, "Bauble Block", "WHOVILLE");
			settings.Add("(Lv19)_WhoVille_05", true, "Sweet-Treat Street", "WHOVILLE");
		settings.Add("(Hub)_Main", true, "Final Ornament Placed on Tree", "GRINCH");
		settings.Add("PLACE", false, "Split on Each Ornament Placed on Tree", "GRINCH");

    vars.Splits = new HashSet<string>();
}

init
{
    vars.Utils = vars.Uhara.CreateTool("Unity", "Mono", "Utils");
    vars.Instance = vars.Uhara.CreateTool("Unity", "Mono", "Instance");

    vars.Instance.Watch<bool>("LoadingScreen", "CasualBrothers:GameManager", "IsLoading");
	vars.Instance.Watch<int>("NewGame", "Game:PressStartManager", "cameraIndex");
	vars.Instance.Watch<int>("TreeOrnaments", "Game:OrnamentViewerTreeCounter", "currentNumber");
	vars.Instance.Watch<bool>("LevelFinish", "Game:LevelManager", "levelCompleted");
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

	//print(current.TreeOrnaments.ToString());
}

start
{
    return current.ActiveScene.StartsWith("(Start)") && current.NewGame == 3;
}

onStart
{
    vars.Splits.Clear();
}

split
{
	if(current.LevelFinish && !old.LevelFinish && !vars.Splits.Contains(current.ActiveScene))
	{
		return settings[current.ActiveScene] && vars.Splits.Add(current.ActiveScene);
	}

	if(current.TreeOrnaments == 23 && old.TreeOrnaments == 22 && !vars.Splits.Contains(current.ActiveScene))
	{
		return settings[current.ActiveScene] && vars.Splits.Add(current.ActiveScene) && print("All Ornaments Placed on Tree!");
	}

	if(current.TreeOrnaments == old.TreeOrnaments + 1 && current.TreeOrnaments != old.TreeOrnaments && current.ActiveScene == "(Hub)_Main")
	{
		return settings["PLACE"] && print("Ornaments Placed: " + current.TreeOrnaments.ToString());
	}
}

isLoading
{
    return current.LoadingScreen;
}

reset
{
	return current.LoadingScene.StartsWith("(Start)") && old.LoadingScene.StartsWith("SysReload");
}

exit
{
	timer.IsGameTimePaused = true;
}
