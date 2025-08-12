state("SHINOBI_AOV_DEMO")
{
    int CurrentGameMode: "GameAssembly.dll", 0x233A640, 0x198;
}

startup
{
    vars.Log = (Action<object>)(output => print("[Shinobi: Art of Vengeance] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");

    vars.Helper.GameName = "Shinobi: Art of Vengeance";
    vars.Helper.LoadSceneManager = true;

    settings.Add("AOV", true, "Shinobi: Art of Vengeance");
        settings.Add("Story", true, "Story Mode Splits", "AOV");
            settings.Add("StoryDEMO_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "Story");
            settings.Add("StoryDEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "Story");
            settings.Add("StoryDEMO_Temple_Scene_Gameplay", true, "Temple", "Story");
            settings.Add("StoryEndDEMO_Boss_Scene_Gameplay", true, "Kozaru", "Story");
        settings.Add("Arcade", true, "Arcade Mode Splits", "AOV");
            settings.Add("ArcadeDEMO_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "Arcade");
            settings.Add("ArcadeDEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "Arcade");
            settings.Add("ArcadeDEMO_Temple_Scene_Gameplay", true, "Temple", "Arcade");
            settings.Add("ArcadeEndDEMO_Boss_Scene_Gameplay", true, "Kozaru", "Arcade");

    vars.Splits = new HashSet<string>();
}

init
{
    // vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    // {
    //     // var gmm = mono["GameManager"];
    //     // vars.Helper["GameMode"] = gmm.Make<bool>("Instance", "_IsInCutscene");

    //     // return true;
    // });
}

update
{
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
    return current.GameMode != 0 && old.GameMode == 0 && current.activeScene != "MainMenu";
}

onStart
{
    vars.Splits.Clear();
}

split
{
    if(current.CurrentGameMode == 1 && !current.activeScene.Contains("Gameplay") && old.activeScene.Contains("Gameplay") && old.loadingScene.Contains("DEMO") && !vars.Splits.Contains("Story"+old.activeScene))
    {
        vars.Log("Story Mode Split");
        return settings["Story"+old.activeScene] && vars.Splits.Add("Story"+old.activeScene);
    }

    if(current.CurrentGameMode == 3 && !current.activeScene.Contains("Gameplay") && old.activeScene.Contains("Gameplay") && old.loadingScene.Contains("DEMO") && !vars.Splits.Contains("Arcade"+old.activeScene))
    {
        vars.Log("Arcade Mode Split");
        return settings["Arcade"+old.activeScene] && vars.Splits.Add("Arcade"+old.activeScene);
    }

    if(old.CurrentGameMode == 1 && !current.activeScene.Contains("Gameplay") && old.activeScene.Contains("Gameplay") && old.loadingScene.Contains("DEMO") && !vars.Splits.Contains("StoryEnd"+old.activeScene))
    {
        vars.Log("Story Mode Split");
        return settings["StoryEnd"+old.activeScene] && vars.Splits.Add("StoryEnd"+old.activeScene);
    }

    if(old.CurrentGameMode == 3 && current.activeScene == "WorldMap" && old.activeScene == "Global" && old.loadingScene.Contains("DEMO") && !vars.Splits.Contains("ArcadeEnd"+old.activeScene))
    {
        vars.Log("Arcade Mode Split");
        return settings["ArcadeEnd"+old.activeScene] && vars.Splits.Add("ArcadeEnd"+old.activeScene);
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
