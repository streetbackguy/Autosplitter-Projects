state("SHINOBI_AOV", "Full Game")
{
}

state("SHINOBI_AOV_DEMO", "Demo")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Shinobi: Art of Vengeance] " + output));

    Assembly.Load(File.ReadAllBytes("Components/unity-help-shinobi")).CreateInstance("Unity");

    settings.Add("AOV", true, "Shinobi: Art of Vengeance");
        settings.Add("FullGame", true, "Full Game Splits", "AOV");
            settings.Add("FullStory", true, "Story Mode Splits", "FullGame");
                settings.Add("FullSStage1", true, "Stage 1", "FullStory");
                    settings.Add("Story01_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "FullSStage1");
                    settings.Add("Story02_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "FullSStage1");
                    settings.Add("Story04_Temple_Scene_Gameplay", true, "Temple", "FullSStage1");
                    settings.Add("Story05_Boss_Scene_Gameplay", true, "Kozaru", "FullSStage1");
                    settings.Add("Story06_CaveTemple_Scene_Gameplay", true, "Cave Temple", "FullSStage1");
                settings.Add("FullSStage2", true, "Stage 2", "FullStory");
                    settings.Add("Story01_MOUNTAIN_Scene_Gameplay", true, "The Mountainside", "FullSStage2");
                    settings.Add("Story02_FACTORY_Scene_Gameplay", true, "Secret Factory", "FullSStage2");
                    settings.Add("Story03_EXCAVATION_Scene_Gameplay", true, "The Canyon", "FullSStage2");
                    settings.Add("Story04_SIDEPATH_Scene_Gameplay", true, "Sidepath", "FullSStage2");
                settings.Add("FullSStage3", true, "Stage 3", "FullStory");
                    settings.Add("Story01_Lake_Scene_Gameplay", true, "Lake", "FullSStage3");
                    settings.Add("Story01b_LakeCavern_Scene_Gameplay", true, "Lake Cavern", "FullSStage3");
                    settings.Add("Story02_Village_Scene_Gameplay", true, "The Village", "FullSStage3");
                    settings.Add("Story03_Festival_Scene_Gameplay", true, "Festival", "FullSStage3");
                settings.Add("FullSStage4", true, "Stage 4", "FullStory");
                    settings.Add("StoryLevel-01_Market_Gameplay", true, "The Market", "FullSStage4");
                    settings.Add("StoryLevel-02_Containers_Gameplay", true, "The Docks", "FullSStage4");
                    settings.Add("StoryLevel-03_Boss_Gameplay", true, "The Beach", "FullSStage4");
                    settings.Add("StoryLevel-04_Sidepath_Gameplay", true, "Sidepath", "FullSStage4");
                settings.Add("FullSStage5", true, "Stage 5", "FullStory");
                    settings.Add("Story01_CITY_District_Left_Scene_Gameplay", true, "West City District", "FullSStage5");
                    settings.Add("Story03_CITY_District_Right_Scene_Gameplay", true, "East City District", "FullSStage5");
                settings.Add("FullStage6", true, "Submarine Base", "FullStory");
                    settings.Add("StoryFloor_1_Scene_Gameplay", true, "Floor 0", "FullStage6");
                    settings.Add("StoryFloor_2_Scene_Gameplay", true, "Floor B2", "FullStage6");
                    settings.Add("StoryFloor_3_Scene_Gameplay", true, "Floor B3", "FullStage6");
                settings.Add("FullSStage8", true, "Stage 8", "FullStory");
                    settings.Add("Story01_MERCHANDISE_Scene_Gameplay", true, "Freight Cars", "FullSStage8");
                    settings.Add("Story02_PASSENGERS_Scene_Gameplay", true, "Passenger Cars", "FullSStage8");
                    settings.Add("Story03_LOCO_Scene_Gameplay", true, "Armored Cars", "FullSStage8");
                settings.Add("FullSStage9", true, "Stage 9", "FullStory");
                    settings.Add("Story01_DESERT_Scene_Gameplay", true, "Desert", "FullSStage9");
                    settings.Add("Story02_RUINS_Scene_Gameplay", true, "Ruins", "FullSStage9");
                    settings.Add("Story03_MOUNTAIN_Scene_Gameplay", true, "Mountain", "FullSStage9");
                    settings.Add("Story04_SIDEPATH_ASTRAL_Scene_Gameplay", true, "Astral Sidepath", "FullSStage9");
                settings.Add("FullSStage10", true, "Stage 10", "FullStory");
                    settings.Add("Story01_LAB-HUB_Scene_Gameplay", true, "Laboratory", "FullSStage10");
                    settings.Add("Story02_LAB-WEST_AISLE_Scene_Gameplay", true, "West Laboratory Aisle", "FullSStage10");
                    settings.Add("Story03_LAB-EAST_AISLE_Scene_Gameplay", true, "East Laboratory Aisle", "FullSStage10");
                settings.Add("FullSStage11", true, "Stage 11", "FullStory");
                    settings.Add("Story01_LUNGS_Scene_Gameplay", true, "Kaiju Lungs", "FullSStage11");
                    settings.Add("Story02_STOMACHS_Scene_Gameplay", true, "Kaiju Stomachs", "FullSStage11");
                    settings.Add("Story03_CHEST_Scene_Gameplay", true, "Kaiju Chest", "FullSStage11");
                settings.Add("FullSStage12", true, "Stage 12", "FullStory");
                    settings.Add("StoryLevel_01_Battlefield_Gameplay", true, "Battlefield", "FullSStage12");
                    settings.Add("StoryLevel_01b_Gallery_Gameplay", true, "Battlefield Gallery", "FullSStage12");
                    settings.Add("StoryLevel_02_Burning_Tower_Gameplay", true, "Burning Tower", "FullSStage12");
                    settings.Add("StoryLevel03_Boss_Gameplay", true, "Boss", "FullSStage12");
                settings.Add("FullSStage13", true, "Stage 13", "FullStory");
                    settings.Add("Story01_LastFight_Scene_Gameplay.", true, "Spirit World", "FullSStage13");
            settings.Add("FullArcade", true, "Arcade Mode Splits", "FullGame");
                settings.Add("FullAStage1", true, "Stage 1", "FullArcade");
                    settings.Add("Arcade01_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "FullAStage1");
                    settings.Add("Arcade02_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "FullAStage1");
                    settings.Add("Arcade04_Temple_Scene_Gameplay", true, "Temple", "FullAStage1");
                    settings.Add("Arcade05_Boss_Scene_Gameplay", true, "Kozaru", "FullAStage1");
            settings.Add("FullRifts", true, "Rift Splits", "FullGame");
                settings.Add("RIFT-01_TEMPLE_Gameplay", true, "Completed the Stage 1 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-01_TEMPLE_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 1 Ankou Rift", "RIFT-01_TEMPLE_Gameplay");
                settings.Add("RIFT-02_FACTORY_Gameplay", true, "Completed the Stage 2 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-02_FACTORY_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 2 Ankou Rift", "RIFT-02_FACTORY_Gameplay");
                settings.Add("RIFT-03_VILLAGE_Gameplay", true, "Completed the Stage 3 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-03_VILLAGE_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 3 Ankou Rift", "RIFT-03_VILLAGE_Gameplay");
                settings.Add("RIFT-04_HARBOR_Gameplay", true, "Completed the Stage 4 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-04_HARBOR_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 4 Ankou Rift", "RIFT-04_HARBOR_Gameplay");
                settings.Add("RIFT-05_CITY_Gameplay", true, "Completed the Stage 5 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-05_CITY_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 5 Ankou Rift", "RIFT-05_CITY_Gameplay");
                settings.Add("RIFT-07_MILITARY_Gameplay", true, "Completed the Stage 7 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-07_MILITARY_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 7 Ankou Rift", "RIFT-07_MILITARY_Gameplay");
                settings.Add("RIFT-08_TRAIN_Gameplay", true, "Completed the Stage 8 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-08_TRAIN_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 8 Ankou Rift", "RIFT-08_TRAIN_Gameplay");
                settings.Add("RIFT-09_DESERT_Gameplay", true, "Completed the Stage 9 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-09_DESERT_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 9 Ankou Rift", "RIFT-09_DESERT_Gameplay");
                settings.Add("RIFT-10_LABO_Gameplay", true, "Completed the Stage 10 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-10_LABO_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 10 Ankou Rift", "RIFT-10_LABO_Gameplay");
                settings.Add("RIFT-11_KAIJU_Gameplay", true, "Completed the Stage 11 Ankou Rift", "FullRifts");
                    settings.Add("DKRIFT-11_KAIJU_Gameplay", true, "Obtain the Dark Katana Fragment in Stage 11 Ankou Rift", "RIFT-11_KAIJU_Gameplay");
            settings.Add("Bonus", true, "Bonus Stage Splits", "FullGame");
                settings.Add("StoryBonusStage_01_Gameplay", true, "Completed the first Bonus Stage", "Bonus");
                settings.Add("StoryBonusStage_Surf_Scene_Gameplay", true, "Completed the second Bonus Stage", "Bonus");
            settings.Add("EliteSquad", true, "Elite Squad Splits", "FullGame");
                settings.Add("StoryEliteSquad04_Temple_Scene_Gameplay", true, "Defeat the Elite Squad in the Temple", "EliteSquad");
                settings.Add("StoryEliteSquad01_MOUNTAIN_Scene_Gameplay", true, "Defeat the Elite Squad in The Mountainside", "EliteSquad");
                settings.Add("StoryEliteSquad03_EXCAVATION_Scene_Gameplay", true, "Defeat the Elite Squad in The Canyon", "EliteSquad");
                settings.Add("StoryEliteSquad03_CITY_District_Right_Scene_Gameplay", true, "Defeat the Elite Squad in East City District", "EliteSquad");
                settings.Add("StoryEliteSquadLevel-02_Containers_Gameplay", true, "Defeat the Elite Squad in The Docks", "EliteSquad");
                settings.Add("StoryEliteSquadFloor_1_Scene_Gameplay", true, "Defeat the Elite Squad in Floor 0", "EliteSquad");
                settings.Add("StoryEliteSquad01_MERCHANDISE_Scene_Gameplay", true, "Defeat the Elite Squad in Freight Cars", "EliteSquad");
                settings.Add("StoryEliteSquad02_PASSENGERS_Scene_Gameplay", true, "Defeat the Elite Squad in Passenger Cars", "EliteSquad");
                settings.Add("StoryEliteSquad03_LOCO_Scene_Gameplay", true, "Defeat the Elite Squad in Armored Cars", "EliteSquad");
            settings.Add("BossRush", true, "Boss Rush Splits", "FullGame");
                settings.Add("BR1_Monkey_Gameplay", true, "Defeat Kozaru", "BossRush");
                settings.Add("BR2_Mandara_Gameplay", true, "Defeat Mandara", "BossRush");
                settings.Add("BR3_Octostar_Gameplay", true, "Defeat Octostar", "BossRush");
                settings.Add("BR4_Vampire_Gameplay", true, "Defeat Vampire", "BossRush");
                settings.Add("BR5_Chiyo_Gameplay", true, "Defeat Chiyo", "BossRush");
                settings.Add("BR6_MechaTank_Gameplay", true, "Defeat Arachno-Tank", "BossRush");
                settings.Add("BR7_Beastmaster_Gameplay", true, "Defeat Beastmaster", "BossRush");
                settings.Add("BR8_YokaiTwins_Gameplay", true, "Defeat the Yokai Twins", "BossRush");
                settings.Add("BR9_Kijima2_Gameplay", true, "Defeat Kijima", "BossRush");
                settings.Add("BR10_Ruse_Gameplay", true, "Defeat Ruse", "BossRush");
                settings.Add("BR11_FusedRuse_Gameplay", true, "Defeat Fused Ruse", "BossRush");
        settings.Add("Demo", false, "Demo Splits", "AOV");
            settings.Add("DemoStory", true, "Story Mode Splits", "Demo");
                settings.Add("StoryDEMO_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "DemoStory");
                settings.Add("StoryDEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "DemoStory");
                settings.Add("StoryDEMO_Temple_Scene_Gameplay", true, "Temple", "DemoStory");
                settings.Add("StoryDEMO_Boss_Scene_Gameplay", true, "Kozaru", "DemoStory");
            settings.Add("DemoArcade", true, "Arcade Mode Splits", "Demo");
                settings.Add("ArcadeDEMO_Oboro_Village_Scene_Gameplay", true, "Oboro Village", "DemoArcade");
                settings.Add("ArcadeDEMO_Bamboo_Forest_Scene_Gameplay", true, "Bamboo Forest", "DemoArcade");
                settings.Add("ArcadeDEMO_Temple_Scene_Gameplay", true, "Temple", "DemoArcade");
                settings.Add("ArcadeDEMO_Boss_Scene_Gameplay", true, "Kozaru", "DemoArcade");
            settings.Add("DemoRifts", true, "Rift Splits", "Demo");
                settings.Add("RiftDEMO_RIFT-01_TEMPLE_Gameplay", true, "Completed the Stage 1 Ankou Rift", "DemoRifts");
            settings.Add("DemoEliteSquad", true, "Elite Squad Splits", "Demo");
                settings.Add("StoryEliteSquadDEMO_Temple_Scene_Gameplay", true, "Defeat the Elite Squad in the Temple", "DemoEliteSquad");
                settings.Add("StoryEliteSquadDEMO_CaveTemple_Scene_Gameplay", true, "Defeat the Elite Squad in the Temple Cave", "DemoEliteSquad");
            
    vars.Splits = new HashSet<string>();
    vars.EliteSquad = 0;
    vars.EndGameCutscene = 0;

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
    vars.Checkpoint = vars.Helper.Make<int>("StageManager", 0, "Instance", "_SmallCheckpointID");
    vars.Menu = vars.Helper.Make<int>("MenuManager", 0, "Instance", "MenuWithFocus");

    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
        {
            case "A6127A8917ABD0AA7ECB9D87250C8FC3":
                version = "Demo";
                break;

            default:
                version = "Full Game";
                break;
        }
}

update
{
    current.SceneName = vars.Helper.SceneManager.Current.Name;

    //print("Game Mode: " + vars.GameMode.Current.ToString());
    // print("Loading Enum: " + vars.Loading.Current.ToString());

    if(current.SceneName != old.SceneName)
    {
        print(current.SceneName);
    }

    if(vars.Menu.Current != vars.Menu.Old)
    {
        print("Menu: " + vars.Menu.Current.ToString());
    }

    if(vars.Menu.Old == 0 && vars.Menu.Current == 9)
    {
        vars.EliteSquad++;
    }

    if(vars.Menu.Old == 0 && vars.Menu.Current == 11 && current.SceneName == "Story01_LastFight_Scene_Gameplay.")
    {
        vars.EndGameCutscene++;
    }

    if(old.SceneName != current.SceneName)
    {
        vars.EliteSquad = 0;
    }
}

start
{
    return old.SceneName == "WorldMap" && current.SceneName == "Global" || old.SceneName == "MainMenu" && current.SceneName == "Global";
}

split
{
    if(current.SceneName != old.SceneName && !current.SceneName.Contains("RIFT-") && vars.GameMode.Current == 1 && vars.Menu.Old != 20 && !vars.Splits.Contains("Story" + old.SceneName))
    {
        return settings["Story" + old.SceneName] && vars.Splits.Add("Story" + old.SceneName);
    }

    if(current.SceneName != old.SceneName && !current.SceneName.Contains("RIFT-") && vars.GameMode.Current == 3 && vars.Menu.Old != 20 && !vars.Splits.Contains("Arcade" + old.SceneName))
    {
        return settings["Arcade" + old.SceneName] && vars.Splits.Add("Arcade" + old.SceneName);
    }

    if(old.SceneName == "BonusStage_01_Gameplay" && vars.GameMode.Current == 1 && current.SceneName == "Global" && !vars.Splits.Contains("Story" + old.SceneName) ||
    old.SceneName == "BonusStage_Surf_Scene_Gameplay" && vars.GameMode.Current == 1 && current.SceneName == "Global" && !vars.Splits.Contains("Story" + old.SceneName))
    {
        return settings["Story" + old.SceneName] && vars.Splits.Add("Story" + old.SceneName);
    }

    if(current.SceneName.Contains("Gameplay") && vars.GameMode.Current == 1 && vars.Menu.Current == 23 && vars.Menu.Old != 20 && !vars.Splits.Contains("Story" + old.SceneName))
    {
        return settings["Story" + old.SceneName] && vars.Splits.Add("Story" + old.SceneName);
    }

    if(current.SceneName.Contains("Gameplay") && vars.GameMode.Current == 3 && vars.Menu.Current == 22 && vars.Menu.Old != 20 && !vars.Splits.Contains("Arcade" + old.SceneName))
    {
        return settings["Arcade" + old.SceneName] && vars.Splits.Add("Arcade" + old.SceneName);
    }

    if(old.SceneName.Contains("RIFT-") && current.SceneName.Contains("RIFT-") && !vars.Splits.Contains("Rift" + old.SceneName))
    {
        return settings["Rift" + old.SceneName] && vars.Splits.Add("Rift" + old.SceneName);
    }

    if(current.SceneName.Contains("RIFT-") && vars.DarkKatana.Current == vars.DarkKatana.Old + 1 && !vars.Splits.Contains("DK" + current.SceneName))
    {
        return settings["DK" + current.SceneName] && vars.Splits.Add("DK" + current.SceneName);
    }

    if(current.SceneName.Contains("Gameplay") && vars.GameMode.Current == 1 && vars.Menu.Current == 9 && vars.Menu.Old == 0 && vars.EliteSquad == 2 && !vars.Splits.Contains("Story" + "EliteSquad" + current.SceneName))
    {
        return settings["Story" + "EliteSquad" + current.SceneName] && vars.Splits.Add("Story" + "EliteSquad" + current.SceneName);
    }

    if(current.SceneName == "01_LastFight_Scene_Gameplay." && vars.GameMode.Current == 1 && vars.Menu.Current == 11 && vars.Menu.Old == 0 && vars.EndGameCutscene == 3 && !vars.Splits.Contains("Story01_LastFight_Scene_Gameplay."))
    {
        return settings["Story01_LastFight_Scene_Gameplay."] && vars.Splits.Add("Story01_LastFight_Scene_Gameplay.");
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
    vars.EliteSquad = 0;
    vars.EndGameCutscene = 0;
}

reset
{
    return current.SceneName == "MainMenu";
}

exit
{
    timer.IsGameTimePaused = true;
}
