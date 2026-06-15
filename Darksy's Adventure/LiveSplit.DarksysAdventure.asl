state("DarksysAdventure")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Darksy's Adventure";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    vars.Splits = new HashSet<string>();

    settings.Add("DA", true, "Darksy's Adventure");
        settings.Add("Level1", true, "Level 1-1: Darksy and the adventure", "DA");
        settings.Add("Level2", true, "Level 1-2: Log out", "DA");
        settings.Add("Level3", true, "Level 1-3: Gump's Little Forrest Secret", "DA");
        settings.Add("Boss1level4", true, "Level 1-4: Foxin Boxin", "DA");
        settings.Add("Level5", true, "Level 2-1: Welcome to the pirate's ocean", "DA");
        settings.Add("Level6", true, "Level 2-2: Under the Coffin's Ship", "DA");
        settings.Add("Level8", true, "Level 2-3: Pirate caracaling around", "DA");
        settings.Add("TrainLevel1", true, "Level 3-1: It's High Noon", "DA");
        settings.Add("Level10", true, "Level 3-2: Saturn's Patterns", "DA");
        settings.Add("TrainLevel2", true, "Level 3-3: Texas trainsaw massacre", "DA");
        settings.Add("Boss3", true, "Level 3-4: Runaway furry", "DA");
        settings.Add("Level11", true, "Level 4-1: Toppin' the Metropin", "DA");
        settings.Add("Level12", true, "Level 4-2: Catastrophic City", "DA");
        settings.Add("Level13", true, "Level 4-3: Bossin' Around", "DA");
        settings.Add("Level14", true, "Level 5-1: Construtions for instrutions", "DA");
        settings.Add("Level15", true, "Level 5-2: Heavy Metals", "DA");
        settings.Add("Level16", true, "Level 5-3: Chilling fury", "DA");
        settings.Add("Level18", true, "Level 5-1: Domestic Dome", "DA");
        settings.Add("Level19", true, "Level 5-2: The Final Battle", "DA");
}

init
{
    vars.Helper.TryLoad  = (Func<dynamic, bool>)(mono =>
	{

		return true;
	});
}

update
{
    if(!String.IsNullOrWhiteSpace(vars.Helper.Scenes.Active.Name))
    {
        current.activeScene = vars.Helper.Scenes.Active.Name;
    }

	if(!String.IsNullOrWhiteSpace(vars.Helper.Scenes.Loaded[0].Name))
    {
        current.loadingScene = vars.Helper.Scenes.Loaded[0].Name;
    }

	if(current.activeScene != old.activeScene)
    {
        vars.Log("active: Old: \"" + old.activeScene + "\", Current: \"" + current.activeScene + "\"");
    }

	if(current.loadingScene != old.loadingScene)
    {
        vars.Log("loading: Old: \"" + old.loadingScene + "\", Current: \"" + current.loadingScene + "\"");
    }
}

start
{
    if(old.activeScene == "IntroScene" && current.activeScene == "Level1")
    {
        return true;
    }
}

split
{
    if(!current.activeScene.Contains("Scene") && !current.activeScene.Contains("Select") && current.loadingScene == "LevelSelect" && !vars.Splits.Contains(current.activeScene))
    {
        return settings[current.activeScene] && vars.Splits.Add(current.activeScene);
    }
}

isLoading
{
    return current.activeScene.Contains("Scene") || current.activeScene.Contains("Select") || current.activeScene.Contains("Intro") || current.loadingScene.Contains("Scene") || current.loadingScene.Contains("Select") || current.loadingScene.Contains("Intro");
}
