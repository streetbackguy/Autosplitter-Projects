state("The WereCleaner")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "The WereCleaner";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    vars.TotalTime = new TimeSpan();

    settings.Add("TWC", true, "The WereCleaner");
        settings.Add("ANY", true, "Split after Each Completed Level", "TWC");
        // settings.Add("COL", true, "Split after Collecting Each Collectible", "TWC");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["LevelStart"] = mono.Make<bool>("GameManager", "instance", "clockInScript", "levelDoorController", "isInteractable");
        vars.Helper["LevelEnd"] = mono.Make<bool>("GameManager", "instance", "levelEndStarted");
        vars.Helper["LevelTimeTotal"] = mono.Make<float>("GameManager", "instance", "timeSinceLevelStart");
        
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

onStart
{
    vars.TotalTime = TimeSpan.Zero;
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
    return current.LevelTimeTotal == 0 || current.LevelTimeTotal == old.LevelTimeTotal;
}

gameTime
{
    if(old.LevelTimeTotal > current.LevelTimeTotal)
    {
        vars.TotalTime += TimeSpan.FromSeconds(old.LevelTimeTotal);
    }
    
    return vars.TotalTime + TimeSpan.FromSeconds(current.LevelTimeTotal);
}
