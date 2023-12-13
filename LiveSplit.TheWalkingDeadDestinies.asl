state("The Walking Dead Destinies")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "The Walking Dead: Destinies";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("TWDD", true, "The Walking Dead: Destinies");
        settings.Add("ACT1", true, "Act 1: Welcome to the Apocalypse", "TWDD");
            settings.Add("HospitalMH_Level_InternalArea", true, "Episode 1: Days Gone Bye", "ACT1");
            settings.Add("RicksNeighborhood_Level_Base", true, "Episode 2: Listen Up", "ACT1");
            settings.Add("AtlantaCity_Level_Base", true, "Episode 3: Guts", "ACT1");
            settings.Add("GenericWoods01_Level", true, "Episode 4: Life Worth Living", "ACT1");
            settings.Add("AtlantaCamp_Level", true, "Episode 5: Overrun", "ACT1");
        settings.Add("ACT2", true, "Act 2: Survival of the Fittest", "TWDD");
            settings.Add("GenericWoods02_Level", true, "Episode 6: What Lies Ahead", "ACT2");
            settings.Add("School_Level_Structures", true, "Episode 7: Bloodletting", "ACT2");
            settings.Add("HospitalMH_Level_InternalArea_TS19", true, "Episode 8: Haunted", "ACT2");
            settings.Add("GreeneFarm_Level_PrettyMuch", true, "Episode 9: Pretty Much Dead Already", "ACT2");
            settings.Add("GreeneFarm_Level_BetterAngels", true, "Episode 10: Better Angels", "ACT2");
        settings.Add("ACT3", true, "Act 3: Kill the Dead", "TWDD");
            settings.Add("WGCFacility_Level_Seed_ExternalArea", true, "Episode 11: Seed", "ACT3");
            settings.Add("WGCFacilityBasement_Level", true, "Episode 12: Sick", "ACT3");
            settings.Add("BossAndrew_Level", true, "Episode 13: Killer Within", "ACT3");
            settings.Add("GenericSupplyRun3_Level_Take_Care_Of_Each_Other", true, "Episode 14: Take Care of Each Other", "ACT3");
        settings.Add("ACT4", true, "Act 4: Woodbury", "TWDD");
            settings.Add("WoodBury_Level_Base_WalkWithMe", true, "Episode 15: Walk With Me", "ACT4");
            settings.Add("WoodBury_Level_Base_MadeToSuffer", true, "Episode 16: Made to Suffer", "ACT4");
            settings.Add("WoodBury_Level_Base_Hounded", true, "Episode 17: Hounded", "ACT4");
            settings.Add("GenericSupplyRun3_Level_WhenTheDead", true, "Episode 18: When the Dead Come Knocking", "ACT4");
            settings.Add("Woodbury_Level_Base_SuicideKing", true, "Episode 19: The Suicide King", "ACT4");
        settings.Add("ACT5", true, "Act 5: Fear the Living", "TWDD");
            settings.Add("WGCFacility_Level_Infected_InternalArea", true, "Episode 20: Infected", "ACT5");
            settings.Add("AtlantaSuburbs_Level", true, "Episode 21: Clear", "ACT5");
            settings.Add("GenericSupplyRun5_Level_ThisSorrowfulLife", true, "Episode 22: This Sorrowful Life", "ACT5");
            settings.Add("WGCFacility_Level_TooFarGone", true, "Episode 23: Too Far Gone", "ACT5");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        //Thanks to Ero for helping with this for Load Removal
        var lsm = mono["FluxSceneManager", "LoadSceneManager"];
        vars.Helper["SceneCollection"] = lsm.Make<IntPtr>("_currentSceneCollection");
        vars.Helper["SceneCollection"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
        
        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name == null ? current.activeScene : vars.Helper.Scenes.Active.Name;

    if (old.activeScene != current.activeScene)
    vars.Log("Scene changed: " + old.activeScene + " -> " + current.activeScene);
}

isLoading
{
    return current.SceneCollection != IntPtr.Zero;
}

split
{
    if(current.activeScene != old.activeScene && !vars.Splits.Contains("old.activeScene"))
    {
        vars.Splits.Add(old.activeScene);
        return settings[old.activeScene];
    }
}

start
{
    return current.activeScene == "LevelSelection" && current.SceneCollection != IntPtr.Zero;
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
