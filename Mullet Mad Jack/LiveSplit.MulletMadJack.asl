state("Mullet Mad Jack")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Mullet Mad Jack";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    vars.totalIGT = new TimeSpan();

    settings.Add("MMJ", true, "Mullet Mad Jack");
        settings.Add("CAMPAIGN", true, "Campaign Splits", "MMJ");
            settings.Add("FLOORS", false, "Split after each Floor", "CAMPAIGN");
            settings.Add("CHAPTERS", true, "Split on each Chapter Select Screen", "CAMPAIGN");
            // settings.Add("FINALBOSS", true, "Split on Defeating the Final Boss", "CAMPAIGN");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Floor"] = mono.Make<int>("MMC", "instance", "floorNumber");
        vars.Helper["ChapComplete"] = mono.Make<bool>("MadMulletCopTM", "instance", "onChapterCompleteScreen");

        vars.Helper["GameSession"] = mono.Make<float>("MainPlayer", "totalGameSessionTime");

        return true;
    });

    
}

update
{
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? old.ActiveScene;
}

start
{
    return current.GameSession > 0.0f && old.GameSession == 0.0f;
}

split
{
    if(current.Floor > old.Floor && settings["FLOORS"])
    {
        return true && vars.Log("Floor Cleared");
    }

    if(current.ChapComplete && !old.ChapComplete && settings["CHAPTERS"])
    {
        return true;
    }
}

gameTime
{
    return TimeSpan.FromSeconds(current.GameSession);
}

reset
{
    return current.ActiveScene == "TITLE" && old.ActiveScene != "TITLE";
}