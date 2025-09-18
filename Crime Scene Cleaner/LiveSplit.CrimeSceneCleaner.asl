state("CrimeCleaner")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Crime Scene Cleaner] " + output));

    Assembly.Load(File.ReadAllBytes("Components/unity-help")).CreateInstance("Unity");

    settings.Add("CSS", true, "Crime Scene Cleaner");
        settings.Add("Levels", true, "Level Splits", "CSS");
            settings.Add("Dealer's Apartment", true, "Bad Call", "Levels");
            settings.Add("SPA&Wellness", true, "Trial by Blood", "Levels");
            settings.Add("ToxicDuoScene", true, "Toxic Love", "Levels");
            settings.Add("SmartHouse", true, "Short Circuit", "Levels");
            settings.Add("PizzaRestaurant", true, "Italian Job", "Levels");
            settings.Add("New_Villa", true, "Affair With Death", "Levels");
            settings.Add("Tyler's_Apartment_LastMission", true, "Friendly Fire", "Levels");
            settings.Add("Party's_Over", true, "Party's Over", "Levels");
            settings.Add("Modern_Art", true, "Modern Art", "Levels");
            settings.Add("Warehouse", true, "Call in Dead", "Levels");
            
    vars.Splits = new HashSet<string>();
    vars.TotalTime = new TimeSpan();
}

init
{
    vars.MissionComplete = vars.Helper.Make<bool>("MainGame", "MissionReportDataController", 1, "instance", "summary", "isMissionSucceeded");
    vars.IGT = vars.Helper.Make<float>("MainGame", "MissionTimer", 1, "instance", "missionTime");
}

update
{
    current.SceneName = vars.Helper.SceneManager.Current.Name;

    if(current.SceneName != old.SceneName)
    {
        print(current.SceneName);
    }

    if(vars.MissionComplete.Current.ToString() != vars.MissionComplete.Old.ToString())
    {
        print(vars.MissionComplete.Current.ToString());
    }
}

start
{
    return vars.IGT.Current > 0.0f && !current.SceneName.Contains("MenuScreen");
}

split
{
    if(vars.MissionComplete.Current && !vars.Splits.Contains(current.SceneName))
    {
        return settings[current.SceneName] && vars.Splits.Add(current.SceneName);
    }
}

isLoading
{
    return vars.IGT.Old == vars.IGT.Current;
    return vars.MissionComplete.Current;
}

gameTime
{
    if (vars.IGT.Old > vars.IGT.Current)
    {
        vars.TotalTime += TimeSpan.FromSeconds(vars.IGT.Old);
    }
    
    return vars.TotalTime + TimeSpan.FromSeconds(vars.IGT.Current);
}

onStart
{
    vars.Splits.Clear();
    vars.TotalTime = TimeSpan.Zero;
}

reset
{
    return current.SceneName.Contains("MenuScreen") && !old.SceneName.Contains("MenuScreen");
}

exit
{
    timer.IsGameTimePaused = true;
}


