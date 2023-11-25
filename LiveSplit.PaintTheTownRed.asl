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

        return true;
    });
}

start
{
    return !current.Loads && old.Loads;
}

isLoading
{
    return current.Loads;
}

split
{
    return current.LevelComplete && !old.LevelComplete;
}
