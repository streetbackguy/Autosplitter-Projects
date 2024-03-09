state("METANIA")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Metania";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("TheHouse", true, "The House");
    settings.Add("Alley", true, "Alley");
    settings.Add("Level3", true, "Cave");
    settings.Add("Level4", true, "Passage");
    settings.Add("Level5", true, "The Hole");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        //var cld = mono["TriggerObjective"];
		//vars.Helper["isControllable"] = cld.Make<bool>("TriggerObjective", "isTriggered");
		
        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

    if(current.activeScene != old.activeScene)
    {
        vars.Log("Current Scene: " + current.activeScene + " <- " + old.activeScene);
    }

    if(current.loadingScene != old.loadingScene)
    {
        vars.Log("Loading?: " + current.loadingScene);
    }
}

start
{
    
}

split
{
    if(current.activeScene != old.activeScene && !vars.Splits.Contains(old.activeScene))
    {
        return vars.Splits.Add(old.activeScene) && settings[old.activeScene];
    }
}

isLoading
{
    return current.loadingScene == "SceneLoader";
}

onStart
{
    vars.Splits.Clear();
}