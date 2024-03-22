state("My Friend Peppa Pig", "Steam")
{
}

startup
{
    settings.Add("MFPP", true, "My Friend Peppa Pig");
        settings.Add("BEACH", true, "Split after The Beach", "MFPP");
        settings.Add("PLAY", true, "Split after Playgroup", "MFPP");
        settings.Add("MTN", true, "Split after Forest/Snowy Mountain", "MFPP");
        settings.Add("WIND", true, "Split after Windy Castle", "MFPP");
        settings.Add("MAUS", true, "Split after The Museum", "MFPP");

    vars.Log = (Action<object>)(output => print("[My Friend Peppa Pig] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Splits = new HashSet<int>();
    vars.Splits = 0;

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Transitions"] = mono.Make<bool>("LoadingSceneManager", 1, "_instance", 0x2C);
        vars.Helper["PauseMenu"] = mono.Make<bool>("PauseManager", 1, "_instance", 0x81);

        return true;
    });
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

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
    return current.Transitions || current.PauseMenu || current.activeScene == "IntroScene" || current.activeScene == "IntroSavingScreenInfo" || current.activeScene == "CharacterSelection";
}

start
{
    return current.activeScene == "LoadingScreen" && old.activeScene == "CharacterSelection";
}

split
{
    //Splits after each return to the Main Menu after each section (Except Tutorial)
    if (vars.Splits == 3 && old.MainMenu == 11 && current.MainMenu == 10)
    {
        return settings["BEACH"];
    }
    
    if (vars.Splits == 5 && old.MainMenu == 11 && current.MainMenu == 10)
    {
        return settings["PLAY"];
    }

    if (vars.Splits == 7 && old.MainMenu == 11 && current.MainMenu == 10)
    {
        return settings["MTN"];
    }

    if (vars.Splits == 9 && old.MainMenu == 11 && current.MainMenu == 10)
    {
        return settings["WIND"];
    }

    if (vars.Splits == 11 && old.MainMenu == 11 && current.MainMenu == 10)
    {
        return settings["MAUS"];
    }

    //if (vars.Splits == 13 && old.MainMenu == 11 && current.MainMenu == 10)
    //{
        //return settings["END"];
    //}
}

onStart
{
    vars.Splits = 0;
}

exit
{
    vars.Splits = 0;
}
