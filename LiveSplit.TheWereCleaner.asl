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
        settings.Add("ANY", true, "Splits after Each Completed Level", "TWC");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["LevelStart"] = mono.Make<bool>("GameManager", "instance", "clockInScript", "levelDoorController", "isInteractable");
        vars.Helper["LevelEnd"] = mono.Make<bool>("GameManager", "instance", "levelEndStarted");
        vars.Helper["Transitions"] = mono.Make<bool>("LevelLoader", "slider");
        
        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

    print(current.loadingScene.ToString());
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
    return current.loadingScene == "LevelLoader";
}