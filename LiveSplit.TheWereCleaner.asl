state("The WereCleaner")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "The WereCleaner";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("TWC", true, "The WereCleaner");
        settings.Add("ANY", true, "Split after Each Completed Level", "TWC");
        settings.Add("COL", true, "Split after Collecting Each Collectible", "TWC");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["LevelStart"] = mono.Make<bool>("GameManager", "instance", "clockInScript", "levelDoorController", "isInteractable");
        vars.Helper["LevelEnd"] = mono.Make<bool>("GameManager", "instance", "levelEndStarted");
        vars.Helper["LevelEndFade"] = mono.Make<bool>("GameManager", "instance", "screenTransitions", "isTransitioning");
        
        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;
}

start
{
    return !current.LevelStart && old.LevelStart && (current.loadingScene != "MainMenu" || current.loadingScene != "LevelSelect" || current.loadingScene != "LevelLoader");
}

split
{
    if(current.LevelEnd && current.LevelEnd != old.LevelEnd)
    {
        return settings["ANY"];
    };
}

isLoading
{
    return current.loadingScene == "LevelLoader" || current.LevelEndFade;
}
