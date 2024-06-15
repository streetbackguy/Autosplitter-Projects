state("Fallen Aces")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Fallen Aces";
    vars.Helper.AlertLoadless();

    settings.Add("FA", true, "Fallen Aces");
        settings.Add("CHAPTERS", true, "Split on each Chapter End Screen", "FA");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["ScreenTransitions"] = mono.Make<bool>("MainMenuManager", "Instance", "_screenTransition", "_isTransitioning");
        
        vars.Helper["Loads"] = mono.Make<bool>("GameworldSceneController", "Instance", "_worldLoader", "_isLoading");

        vars.Helper["MenuID"] = mono.Make<int>("MainMenuManager", "Instance", "_currentMenuId");

        vars.Helper["LevelID"] = mono.Make<int>("PosterButton", "_levelIndex");

        vars.Helper["ContextID"] = mono.Make<int>("MainMenuManager", "Instance", "_context");

        return true;
    });
}

isLoading
{
    return current.ScreenTransitions || current.Loads;
}

start
{
    return old.ContextID == 0 && current.ContextID == 2 && current.MenuID == 0;
}

split
{
    if(current.ContextID == 4 && old.ContextID != 4)
    {
        return true && settings["CHAPTERS"];
    }
}