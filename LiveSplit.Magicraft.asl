state("Magicraft")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Magicraft";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("MC", true, "Magicraft Splits");
        settings.Add("ELBO", false, "Split after each Elite and Boss room", "MC");
        settings.Add("FINAL", true, "Split on the run end screen after defeating the final boss", "MC");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["IGT"] = mono.Make<float>("DataMgr", "selectedWorldData", "timeuse");
        vars.Helper["InBattle"] = mono.Make<bool>("DataMgr", "selectedWorldData", "inBattle7");
        vars.Helper["Stage"] = mono.Make<int>("DataMgr", "selectedWorldData", "battleData7", "currentStage");
        vars.Helper["FinishGame"] = mono.Make<bool>("UIBattleMgr", "Inst", "uiFinishBuildShow", "IsOpen");

        return true;
    });
}

start
{
    return current.InBattle && !old.InBattle;
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;
}

split
{
    if(current.Stage == old.Stage + 1)
    {
        return settings["ELBO"];
    }

    if(current.FinishGame && !old.FinishGame)
    {
        return settings["FINAL"];
    }
}

isLoading
{
    return current.IGT == old.IGT;
}

gameTime
{
    return TimeSpan.FromSeconds(current.IGT);
}

reset
{
    return current.activeScene == "MainMenu" || current.activeScene == "Camp";
}
