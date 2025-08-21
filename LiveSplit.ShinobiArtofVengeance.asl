state("SHINOBI_AOV_DEMO")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Shinobi: Art of Vengeance] " + output));

    Assembly.Load(File.ReadAllBytes("Components/unity-help")).CreateInstance("Unity");

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
        settings.Add("DemoRifts", true, "Rift Splits", "AOV");
                settings.Add("RiftDEMO_RIFT-01_TEMPLE_Gameplay", true, "Completed the Stage 1 Ankou Rift", "DemoRifts");
        settings.Add("EliteSquad", true, "Elite Squad Splits", "AOV");
                settings.Add("StoryEliteSquadDEMO_Temple_Scene_Gameplay", true, "Defeat the Elite Squad in the Temple", "EliteSquad");
                settings.Add("StoryEliteSquadDEMO_CaveTemple_Scene_Gameplay", true, "Defeat the Elite Squad in the Temple Cave", "EliteSquad");
            
    vars.Splits = new HashSet<string>();

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Shinobi: Art of Vengeance",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

init
{
    vars.GameMode = vars.Helper.Make<int>("GameModeManager", 0, "Instance", "CurrentGameMode");
    vars.Loading = vars.Helper.Make<int>("StageManager", 0, "Instance", "State");
    vars.Ninjutsu = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_NinjutsuCount");
    vars.Ninpo = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_NinpoCount");
    vars.Ningi = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_NingiCount");
    vars.NinpoCell = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_NinpoCellUpgradeCount");
    vars.HealthUpgrade = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_HealthUpgradeCount");
    vars.KunaiUpgrade = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_KunaiUpgradeCount");
    vars.OboroRelic = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_OboroRelicCount");
    vars.SecretKey = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_SecretKeyCount");
    vars.DarkKatana = vars.Helper.Make<int>("CharacterUpgradeManager", 0, "Instance", "_DarkKatanaCount");
    vars.Menu = vars.Helper.Make<int>("MenuManager", 0, "Instance", "MenuWithFocus");
}

update
{
    current.SceneName = vars.Helper.SceneManager.Current.Name;

    //print("Game Mode: " + vars.GameMode.Current.ToString());
    // print("Loading Enum: " + vars.Loading.Current.ToString());
    //print("Stage Complete?: " + vars.StageComplete.Current.ToString());
    // print("Arcade Stage Complete?: " + vars.ArcadeStageComplete.Current.ToString());
    // print("Stage: " + current.SceneName.ToString());

    if(current.SceneName != old.SceneName)
    {
        print(current.SceneName);
    }
}

start
{
    return old.SceneName == "WorldMap" && current.SceneName == "Global" || old.SceneName == "MainMenu" && current.SceneName == "Global";
}

split
{
    if(current.SceneName != old.SceneName && vars.GameMode.Current == 1 && !vars.Splits.Contains("Story" + old.SceneName))
    {
        return settings["Story" + old.SceneName] && vars.Splits.Add("Story" + old.SceneName);
    }

    if(current.SceneName != old.SceneName && vars.GameMode.Current == 3 && !vars.Splits.Contains("Arcade" + old.SceneName))
    {
        return settings["Arcade" + old.SceneName] && vars.Splits.Add("Arcade" + old.SceneName);
    }

    if(current.SceneName == "DEMO_Boss_Scene_Gameplay" && vars.GameMode.Current == 1 && vars.Menu.Current == 23 && !vars.Splits.Contains("StoryEnd" + old.SceneName))
    {
        return settings["StoryEnd" + old.SceneName] && vars.Splits.Add("StoryEnd" + old.SceneName);
    }

    if(current.SceneName == "DEMO_Boss_Scene_Gameplay" && vars.GameMode.Current == 3 && vars.Menu.Current == 22 && !vars.Splits.Contains("ArcadeEnd" + old.SceneName))
    {
        return settings["ArcadeEnd" + old.SceneName] && vars.Splits.Add("ArcadeEnd" + old.SceneName);
    }

    if(old.SceneName == "DEMO_RIFT-01_TEMPLE_Gameplay" && current.SceneName != "DEMO_RIFT-01_TEMPLE_Gameplay" && !vars.Splits.Contains("Rift" + old.SceneName))
    {
        return settings["Rift" + old.SceneName] && vars.Splits.Add("Rift" + old.SceneName);
    }

    if(current.SceneName.Contains("Gameplay") && vars.GameMode.Current == 1 && vars.Menu.Current == 10 && vars.Menu.Old == 0 && !vars.Splits.Contains("Story" + "EliteSquad" + current.SceneName))
    {
        return settings["Story" + "EliteSquad" + current.SceneName] && vars.Splits.Add("Story" + "EliteSquad" + current.SceneName);
    }
}

isLoading
{
    return vars.Loading.Current > 1;
}

onStart
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}
