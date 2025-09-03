state("Saviorless")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Saviorless";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("SL", true, "Saviorless");
        settings.Add("Grotto", true, "Heron's Sanctuary", "SL");
        settings.Add("Cave", true, "Hunter's Cave", "SL");
        settings.Add("JimFirst", true, "Dino Boss", "SL");
        settings.Add("Chappelle", true, "Stereoma Beach Temple", "SL");
        settings.Add("BlackPond", true, "Black Pond", "SL");
        settings.Add("JimSecond", true, "Axe Boss", "SL");
        settings.Add("Underwater", true, "Underwater", "SL");
        settings.Add("SmilingIslands 1", true, "Temple of the Smiling Islands 1", "SL");
        settings.Add("SmilingIslands 2", true, "Temple of the Smiling Islands 2", "SL");
        settings.Add("SmilingIslands 3", true, "Temple of the Smiling Islands 3", "SL");
        settings.Add("Wasteland", true, "Wasteland", "SL");
        settings.Add("Forest 1", true, "Silent Forest 1", "SL");
        settings.Add("Forest 2", true, "Silent Forest 2", "SL");
        settings.Add("DryBlackPond", true, "Dry Black Pond", "SL");
        settings.Add("RedFortress", true, "Red Fortress", "SL");
        settings.Add("SaviorsPath", true, "Savior's Path", "SL");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["LoadingScene"] = mono.Make<bool>("PauseMenuUI", "LoadingScene");
        
        return true;
    });

    vars.Splits = new HashSet<string>();
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;
}

start
{
    return current.LoadingScene && current.loadingScene != "MainMenu" && old.loadingScene == "MainMenu";
}

onStart
{
    vars.Splits.Clear();
}

isLoading
{
    return current.LoadingScene;
}

split
{
    if(current.loadingScene != old.loadingScene && current.loadingScene != "MainMenu" && !vars.Splits.Contains(old.loadingScene))
    {
        return settings[old.loadingScene] && vars.Splits.Add(old.loadingScene);
    }
}

reset
{
    return current.activeScene == "MainMenu" && old.activeScene != "MainMenu";
}