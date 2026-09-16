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
        var gwsc = mono["FallenAces.CSharp", "FallenAces.GameworldSceneController"];
        vars.Helper["Loads"] = mono.Make<bool>(gwsc, "Instance", "_worldLoader", "_isLoading");

        var tsm = mono["FallenAces.CSharp", "FallenAces.TimeScaleManager"];
        vars.Helper["Paused"] = mono.Make<bool>(tsm, "Instance", "_paused");

        var mmm = mono["FallenAces.CSharp", "FallenAces.MainMenuManager"];
        vars.Helper["MenuID"] = mono.Make<int>(mmm, "Instance", "_currentMenuId");
        vars.Helper["ContextID"] = mono.Make<int>(mmm, "Instance", "_context");

        return true;
    });
}

isLoading
{
    return current.Loads || current.Paused;
}

start
{
    return current.MenuID == 0 && !current.Paused;
}

split
{
    if(current.ContextID == 4 && old.ContextID != 4)
    {
        return true && settings["CHAPTERS"];
    }
}
