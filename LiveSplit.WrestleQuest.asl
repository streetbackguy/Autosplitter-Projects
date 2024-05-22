state("WrestleQuest")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "WrestleQuest";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("remove_pause", true, "Pauses Timer on Pause Menu");
}

init
{
    vars.CompletedSplits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["SceneLoader"] = mono.Make<bool>("SceneLoader", "_instance", "isLoadingScene");
        vars.Helper["PauseGame"] = mono.Make<bool>("PauseGame", "Instance", "GamePaused");

        return true;
    });
}

update
{
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? old.ActiveScene;
    current.LoadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.LoadingScene;
}

start
{
    return old.ActiveScene == "TitlescreenNew" && current.ActiveScene == "WorldMap";
}

isLoading
{
    return current.SceneLoader || settings["remove_pause"] && current.PauseGame;
}

reset
{
    return current.ActiveScene == "TitlescreenNew" && old.ActiveScene != "TitlescreenNew";
}