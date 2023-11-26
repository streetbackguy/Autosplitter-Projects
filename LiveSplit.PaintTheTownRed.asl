state("PaintTheTownRed")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Paint the Town Red";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var ls = mono["LoadingScreen"];
        vars.Helper["Loads"] = ls.Make<bool>("Instance");

        var gm = mono["GameManager"];
        vars.Helper["LevelComplete"] = gm.Make<bool>("HasWon");
        vars.Helper["HasNotFinishedLoadingNewLevel"] = gm.Make<bool>("HasNotFinishedLoadingNewLevel");
        vars.Helper["isBeneath"] = gm.Make<bool>("IsBeneath");

        var bn = mono["ModuleLevelGenerator"];
        vars.Helper["BeneathLoads"] = bn.Make<bool>("GeneratingLevel");

        return true;
    });
}

start
{
    return !current.Loads && old.Loads;
}

isLoading
{
    return current.Loads || current.HasNotFinishedLoadingNewLevel || current.BeneathLoads && current.isBeneath;
}

split
{
    return current.LevelComplete && !old.LevelComplete;
}
