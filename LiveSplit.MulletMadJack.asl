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
            settings.Add("CHAPTERS", false, "Split on each Chapter Select Screen", "CAMPAIGN");

}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["StageIGT"] = mono.Make<float>("MainPlayer", "instance", 0x324);

        vars.Helper["Floor"] = mono.Make<int>("MMC", "instance", "floorNumber");
        vars.Helper["ChapComplete"] = mono.Make<bool>("MadMulletCopTM", "instance", "onChapterCompleteScreen");

        return true;
    });
}

update
{
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? old.ActiveScene;

    // if(current.CurrentChapter != old.CurrentChapter)
    // {
    //     vars.Log(old.CurrentChapter + " -> " + current.CurrentChapter);
    // }
}

start
{
    return current.StageIGT > 0.0f && old.StageIGT == 0.0f;
}

onStart
{
    vars.totalIGT = TimeSpan.Zero;
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

    // if(current.FinalBoss == 6 && old.FinalBoss == 5)
    // {
    //     return settings["CH8"] && vars.Log("Final Boss Defeated!");
    // }
}

gameTime
{
    if (old.StageIGT > current.StageIGT)
    {
        vars.totalIGT += TimeSpan.FromSeconds(old.StageIGT);
    }
    
    return vars.totalIGT + TimeSpan.FromSeconds(current.StageIGT);
}

reset
{
    return current.ActiveScene == "TITLE" && old.ActiveScene != "TITLE";
}
