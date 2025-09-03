state("PaintTheTownRed")
{
    byte BeneathLoads: "UnityPlayer.dll", 0x1A46258, 0xDA8, 0x18, 0xA8, 0x0;
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

        return true;
    });
}

start
{
    return !current.Loads && old.Loads;
}

update
{
    if(current.Loads != old.Loads)
    {
        print("Loading: " + old.Loads + " -> " + current.Loads);
    }
}

isLoading
{
    return current.Loads || current.BeneathLoads == 1 && current.isBeneath;

}

split
{
    return current.LevelComplete && !old.LevelComplete;
}

exit
{
    timer.IsGameTimePaused = true;
}