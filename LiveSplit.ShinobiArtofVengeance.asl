state("SHINOBI_AOV_DEMO")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Shinobi: Art of Vengeance] " + output));

    Assembly.Load(File.ReadAllBytes("Components/unity-help")).CreateInstance("Unity");

    settings.Add("AOV", true, "Shinobi: Art of Vengeance");
        settings.Add("Setup", false, "Setup", "AOV");
        settings.Add("Story", true, "Story Mode Splits", "AOV");
            settings.Add("StoryDEMO_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "Story");
            settings.Add("StoryDEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "Story");
            settings.Add("StoryDEMO_Temple_Scene_Gameplay", true, "Temple", "Story");
            settings.Add("StoryEndDEMO_Boss_Scene_Gameplay", true, "Kozaru", "Story");
            settings.Add("DEMO_RIFT-01_TEMPLE_Gameplay", true, "Completed the Ankou Rift", "Story");
        settings.Add("Arcade", true, "Arcade Mode Splits", "AOV");
            settings.Add("ArcadeDEMO_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "Arcade");
            settings.Add("ArcadeDEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "Arcade");
            settings.Add("ArcadeDEMO_Temple_Scene_Gameplay", true, "Temple", "Arcade");
            settings.Add("ArcadeEndDEMO_Boss_Scene_Gameplay", true, "Kozaru", "Arcade");
            
    vars.Splits = new HashSet<string>();
}

init
{
    vars.GameMode = vars.Helper.Make<int>("GameModeManager", 0, "Instance", "CurrentGameMode");
    vars.Loading = vars.Helper.Make<int>("StageManager", 0, "Instance", "State");
    vars.StageComplete = vars.Helper.Make<int>("MenuManager", 0, "Instance", "MenuWithFocus");
}

update
{
    current.SceneName = vars.Helper.SceneManager.Current.Name;

    //print("Game Mode: " + vars.GameMode.Current.ToString());
    // print("Loading Enum: " + vars.Loading.Current.ToString());
    //print("Stage Complete?: " + vars.StageComplete.Current.ToString());
    // print("Arcade Stage Complete?: " + vars.ArcadeStageComplete.Current.ToString());
    print("Stage: " + current.SceneName.ToString());

    if(current.SceneName != old.SceneName)
    {
        print(current.SceneName);
    }
}

start
{
    return vars.GameMode.Current != 0 && vars.GameMode.Old == 0 && current.SceneName == "Global";
}

split
{
    if(vars.GameMode.Current != 0 && vars.GameMode.Old == 0 && current.SceneName == "Global")
    {
        return settings["Setup"] && vars.Splits.Add("Setup");
    }

    if(current.SceneName != old.SceneName && vars.GameMode.Current == 1 && !vars.Splits.Contains("Story" + old.SceneName))
    {
        return settings["Story" + old.SceneName] && vars.Splits.Add("Story" + old.SceneName);
    }

    if(current.SceneName != old.SceneName && vars.GameMode.Current == 3 && !vars.Splits.Contains("Arcade" + old.SceneName))
    {
        return settings["Arcade" + old.SceneName] && vars.Splits.Add("Arcade" + old.SceneName);
    }

    if(current.SceneName == "DEMO_Boss_Scene_Gameplay" && vars.GameMode.Current == 1 && vars.StageComplete.Current == 23 && !vars.Splits.Contains("StoryEnd" + old.SceneName))
    {
        return settings["StoryEnd" + old.SceneName] && vars.Splits.Add("StoryEnd" + old.SceneName);
    }

    if(current.SceneName == "DEMO_Boss_Scene_Gameplay" && vars.GameMode.Current == 3 && vars.StageComplete.Current == 22 && !vars.Splits.Contains("ArcadeEnd" + old.SceneName))
    {
        return settings["ArcadeEnd" + old.SceneName] && vars.Splits.Add("ArcadeEnd" + old.SceneName);
    }

    if(old.SceneName == "DEMO_RIFT-01_TEMPLE_Gameplay" && current.SceneName != "DEMO_RIFT-01_TEMPLE_Gameplay" && !vars.Splits.Contains("AnkouRiftComplete"))
    {
        return settings["DEMO_RIFT-01_TEMPLE_Gameplay"] && vars.Splits.Add("DEMO_RIFT-01_TEMPLE_Gameplay");
    }
}

isLoading
{
    return vars.Loading.Current > 1;
}

onStart
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
