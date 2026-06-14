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
    if(!String.IsNullOrWhiteSpace(vars.Helper.Scenes.Active.Name))	current.activeScene = vars.Helper.Scenes.Active.Name;
	if(!String.IsNullOrWhiteSpace(vars.Helper.Scenes.Loaded[0].Name))	current.loadingScene = vars.Helper.Scenes.Loaded[0].Name;

	if(current.activeScene != old.activeScene) vars.Log("active: Old: \"" + old.activeScene + "\", Current: \"" + current.activeScene + "\"");
	if(current.loadingScene != old.loadingScene) vars.Log("loading: Old: \"" + old.loadingScene + "\", Current: \"" + current.loadingScene + "\"");
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
    return current.activeScene.Contains("Scene") || current.activeScene.Contains("Select") || current.loadingScene.Contains("Scene") || current.loadingScene.Contains("Select");
}
