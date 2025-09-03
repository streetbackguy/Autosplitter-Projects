state("MonsterVerse") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Kong: Survivor Instinct";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("KSI", true, "Kong: Survivor Instinct");
        settings.Add("RA", true, "Residential Area", "KSI");
            settings.Add("Scena_0_biom_1_Enviro", true, "Complete Oakwood Avenue", "RA");
            settings.Add("Scena_1_biom_1_Enviro1", true, "Complete Townhall Square", "RA");
            settings.Add("Scena_2_biom_1_Enviro", true, "Complete Riverside Road", "RA");
            settings.Add("Scena_1_biom_1_Enviro2", true, "Complete Townhall Square Second Visit", "RA");
            settings.Add("Scena_3_biom_1_Enviro", true, "Complete High Street", "RA");
        settings.Add("DO", true, "Downtown", "KSI");
            settings.Add("Scena_1_biom_2_Enviro1", true, "Complete Central Plaza", "DO");
            settings.Add("Scena_2_biom_2_Enviro", true, "Complete High Rise Rooftops", "DO");
            settings.Add("Scena_1_biom_2_Enviro2", true, "Complete Central Plaza Second Visit", "DO");
            settings.Add("Scena_3_biom_2_Enviro", true, "Complete Skyscrapers", "DO");
            settings.Add("Scena_1_biom_2_Enviro3", true, "Complete Central Plaza Third Visit", "DO");
        settings.Add("EB", true, "East Bay District", "KSI");
            settings.Add("Scena_1_biom_3_Enviro1", true, "Complete Lighthouse Point", "EB");
            settings.Add("Scena_2_biom_3_Enviro1", true, "Complete Inner Harbour", "EB");
            settings.Add("Scena_1_biom_3_Enviro2", true, "Complete Lighthouse Point Second Visit", "EB");
            settings.Add("Scena_3_biom_3_Enviro1", true, "Complete The Great Bridge", "EB");
            settings.Add("Scena_2_biom_3_Enviro2", true, "Complete Inner Harbour Second Visit", "EB");
            settings.Add("Scena_3_biom_3_Enviro2", true, "Complete The Great Bridge Second Visit", "EB");
            settings.Add("Scena_4_biom_3_Enviro", true, "Complete Hyena's Underground Facility", "EB");

}

init
{
    vars.Splits = new HashSet<string>();
    vars.TownhallSquareCounter = 0;
    vars.CentralPlazaCounter = 0;
    vars.LighthousePointCounter = 0;
    vars.InnerHarbourCounter = 0;
    vars.GreatBridgeCounter = 0;

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {

        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

    if(current.activeScene != old.activeScene || current.loadingScene != old.loadingScene)
    {
        vars.Log("Old to Current Active: " + old.activeScene + " -> " + current.activeScene);
        vars.Log("Old to Current Loading: " + old.loadingScene + " -> " + current.loadingScene);
    }

    if(old.activeScene == "Scena_1_biom_1_Enviro" && current.activeScene == "Loading")
    {
        vars.TownhallSquareCounter++;
    }

    if(old.activeScene == "Scena_1_biom_2_Enviro" && current.activeScene == "Loading")
    {
        vars.CentralPlazaCounter++;
    }

    if(old.activeScene == "Scena_1_biom_3_Enviro" && current.activeScene == "Loading")
    {
        vars.LighthousePointCounter++;
    }
    
    if(old.activeScene == "Scena_2_biom_3_Enviro" && current.activeScene == "Loading")
    {
        vars.InnerHarbourCounter++;
    }

    if(old.activeScene == "Scena_3_biom_3_Enviro" && current.activeScene == "Loading")
    {
        vars.GreatBridgeCounter++;
    }
}

start
{
    return current.activeScene == "Scena_0_biom_1_Enviro" && old.activeScene == "Loading";
}

reset
{
    return current.activeScene == "Scena_Menu";
}

split
{
    if(old.activeScene == "Scena_1_biom_1_Enviro" && current.activeScene == "Loading" && vars.TownhallSquareCounter == 1 && !vars.Splits.Contains("Scena_1_biom_1_Enviro1"))
    {
        return settings["Scena_1_biom_1_Enviro1"] && vars.Splits.Add("Scena_1_biom_1_Enviro1");
    }

    if(old.activeScene == "Scena_1_biom_1_Enviro" && current.activeScene == "Loading" && vars.TownhallSquareCounter == 2 && !vars.Splits.Contains("Scena_1_biom_1_Enviro2"))
    {
        return settings["Scena_1_biom_1_Enviro2"] && vars.Splits.Add("Scena_1_biom_1_Enviro2");
    }

    if(old.activeScene == "Scena_1_biom_2_Enviro" && current.activeScene == "Loading" && vars.CentralPlazaCounter == 1 && !vars.Splits.Contains("Scena_1_biom_2_Enviro1"))
    {
        return settings["Scena_1_biom_2_Enviro1"] && vars.Splits.Add("Scena_1_biom_2_Enviro1");
    }

    if(old.activeScene == "Scena_1_biom_2_Enviro" && current.activeScene == "Loading" && vars.CentralPlazaCounter == 2 && !vars.Splits.Contains("Scena_1_biom_2_Enviro2"))
    {
        return settings["Scena_1_biom_2_Enviro2"] && vars.Splits.Add("Scena_1_biom_2_Enviro2");
    }

    if(old.activeScene == "Scena_1_biom_2_Enviro" && current.activeScene == "Loading" && vars.CentralPlazaCounter == 2 && !vars.Splits.Contains("Scena_1_biom_2_Enviro3"))
    {
        return settings["Scena_1_biom_2_Enviro3"] && vars.Splits.Add("Scena_1_biom_2_Enviro3");
    }

    if(old.activeScene == "Scena_1_biom_3_Enviro" && current.activeScene == "Loading" && vars.LighthousePointCounter == 1 && !vars.Splits.Contains("Scena_1_biom_3_Enviro1"))
    {
        return settings["Scena_1_biom_3_Enviro1"] && vars.Splits.Add("Scena_1_biom_3_Enviro1");
    }

    if(old.activeScene == "Scena_1_biom_3_Enviro" && current.activeScene == "Loading" && vars.LighthousePointCounter == 2 && !vars.Splits.Contains("Scena_1_biom_3_Enviro2"))
    {
        return settings["Scena_1_biom_3_Enviro2"] && vars.Splits.Add("Scena_1_biom_3_Enviro2");
    }
    
    if(old.activeScene == "Scena_2_biom_3_Enviro" && current.activeScene == "Loading" && vars.InnerHarbourCounter == 1 && !vars.Splits.Contains("Scena_2_biom_3_Enviro1"))
    {
        return settings["Scena_2_biom_3_Enviro1"] && vars.Splits.Add("Scena_2_biom_3_Enviro1");
    }

    if(old.activeScene == "Scena_2_biom_3_Enviro" && current.activeScene == "Loading" && vars.InnerHarbourCounter == 2 && !vars.Splits.Contains("Scena_2_biom_3_Enviro2"))
    {
        return settings["Scena_2_biom_3_Enviro2"] && vars.Splits.Add("Scena_2_biom_3_Enviro2");
    }
    
    if(old.activeScene == "Scena_3_biom_3_Enviro" && current.activeScene == "Loading" && vars.GreatBridgeCounter == 1 && !vars.Splits.Contains("Scena_3_biom_3_Enviro1"))
    {
        return settings["Scena_3_biom_3_Enviro1"] && vars.Splits.Add("Scena_3_biom_3_Enviro1");
    }

    if(old.activeScene == "Scena_3_biom_3_Enviro" && current.activeScene == "Loading" && vars.GreatBridgeCounter == 2 && !vars.Splits.Contains("Scena_3_biom_3_Enviro2"))
    {
        return settings["Scena_3_biom_3_Enviro2"] && vars.Splits.Add("Scena_3_biom_3_Enviro2");
    }
    
    if(old.activeScene != current.activeScene && current.activeScene == "Loading" && !vars.Splits.Contains(old.activeScene))
    {
        return settings[old.activeScene] && vars.Splits.Add(old.activeScene);
    }
}

isLoading
{
    return current.activeScene == "Loading";
}

onStart
{
    vars.Splits.Clear();
    vars.TownhallSquareCounter = 0;
    vars.CentralPlazaCounter = 0;
    vars.LighthousePointCounter = 0;
    vars.InnerHarbourCounter = 0;
    vars.GreatBridgeCounter = 0;
}

exit
{
    timer.IsGameTimePaused = true;
}