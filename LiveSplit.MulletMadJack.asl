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
            // settings.Add("CH1", true, "Split on Completing Chapter 1", "CAMPAIGN");
            // settings.Add("CH2", true, "Split on Completing Chapter 2", "CAMPAIGN");
            // settings.Add("CH3", true, "Split on Completing Chapter 3", "CAMPAIGN");
            // settings.Add("CH4", true, "Split on Completing Chapter 4", "CAMPAIGN");
            // settings.Add("CH5", true, "Split on Completing Chapter 5", "CAMPAIGN");
            // settings.Add("CH6", true, "Split on Completing Chapter 6", "CAMPAIGN");
            // settings.Add("CH7", true, "Split on Completing Chapter 7", "CAMPAIGN");
            // settings.Add("CH8", true, "Split on Defeating Chapter 8's Boss", "CAMPAIGN");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["StageIGT"] = mono.Make<float>("MainPlayer", "instance", 0x31C);

        vars.Helper["Floor"] = mono.Make<int>("MMC", "instance", "floorNumber");
        // vars.Helper["Chapter"] = mono.Make<int>("MMC", "instance", "currentChapter");
        // vars.Helper["FinalBoss"] = mono.Make<int>("FinalbossMastermind", "stPartIIIdefeat");
        
        // vars.Helper["ChapterComplete"] = mono.Make<int>("MMC", "instance", "nextChapterExtra");
        // vars.Helper["PlayerData"] = mono.Make<bool>("PlayerDataHelper", "instance");

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

    vars.Log(current.Floor);
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

    // if(current.Chapter != old.Chapter)
    // {
    //     return settings["CH" + old.Chapter];
    // }

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
