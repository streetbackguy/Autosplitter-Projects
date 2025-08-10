state("SHINOBI_AOV_DEMO")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Shinobi: Art of Vengeance] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");

    vars.Helper.GameName = "Shinobi: Art of Vengeance";
    vars.Helper.LoadSceneManager = true;

    settings.Add("AOV", true, "Shinobi: Art of Vengeance");
        settings.Add("Story", true, "Story Mode Splits", "AOV");
            settings.Add("DEMO_Oboro_Village_Scene_Gameplay", true, "Orobo Village", "Story");
            settings.Add("DEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "Story");
            settings.Add("DEMO_Temple_Scene_Gameplay", true, "Temple", "Story");
            settings.Add("DEMO_Boss_Scene_Gameplay", true, "Kozaru", "Story");
        settings.Add("Arcade", true, "Arcade Mode Splits", "AOV");
            settings.Add("DEMO_Oboro_Village_Scene_Gameplay", true, "Orobo Village", "Arcade");
            settings.Add("DEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "Arcade");
            settings.Add("DEMO_Temple_Scene_Gameplay", true, "Temple", "Arcade");
            settings.Add("DEMO_Boss_Scene_Gameplay", true, "Kozaru", "Arcade");

    vars.Splits = new HashSet<string>();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {

        return true;
    });
}

update
{
    vars.Helper.Update();
    vars.Helper.MapPointers();

    current.SceneCount = vars.Helper.Scenes.Count;
    current.activeScene = vars.Helper.Scenes.Active.Name == null ? current.activeScene : vars.Helper.Scenes.Active.Name;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name == null ? current.loadingScene : vars.Helper.Scenes.Loaded[0].Name;

    if(current.activeScene != old.activeScene)
    {
        vars.Log("Current Scene: " + current.activeScene + " <- " + old.activeScene);
    }

    if(current.loadingScene != old.loadingScene)
    {
        vars.Log("Loading?: " + current.loadingScene);
    }
}

isLoading
{
    return current.SceneCount <= 5 && current.activeScene == "Global";
}

start
{
    return current.activeScene == "Global" && old.activeScene == "MainMenu";
}

onStart
{
    vars.Splits.Clear();
}

split
{
    if(!current.activeScene.Contains("Gameplay") && old.activeScene.Contains("Gameplay") && !current.loadingScene.Contains("Gameplay"))
    {
        return settings[old.activeScene] && vars.Splits.Add(old.activeScene);
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
