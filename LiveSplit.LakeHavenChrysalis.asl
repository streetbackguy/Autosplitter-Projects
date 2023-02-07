state("Lake Haven - Chrysalis") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Lake Haven - Chrysalis";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["nextRoom"] = mono.MakeString("SceneChangeManager", "Instance", "nextRoom");
        vars.Helper["igt"] = mono.Make<float>("SavedDataManager", "IGT");

        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

    if (old.nextRoom != current.nextRoom)
    {
        vars.Log("NextRoom changed: " + old.nextRoom + " -> " + current.nextRoom);
    }
}

start
{
    return current.activeScene == "FarmHouse_Exterior" && old.igt == 0f && current.igt > 0f;
}

reset
{
    return current.activeScene == "MainMenu" || current.loadingScene == "WarningScreen";
}

gameTime
{
    return TimeSpan.FromSeconds(current.igt);
}

isLoading
{
    return true;
}

exit
{
    timer.IsGameTimePaused = true;
}
