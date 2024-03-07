state("My Friend Peppa Pig")
{
    byte Start: "UnityPlayer.dll", 0x19A7630, 0xA8, 0xC8, 0x28, 0x30;
    byte MainMenu: "UnityPlayer.dll", 0x199ACE0, 0x1E0, 0x48, 0x118, 0x50, 0x20, 0x10, 0x28;
    byte MainMenu2: "mono-2.0-bdwgc.dll", 0x0495A90, 0xD88, 0x130, 0x18, 0x18, 0x210, 0xE0, 0xA6C;
}
startup
{
    settings.Add("MFPP", true, "My Friend Peppa Pig");
        settings.Add("BEACH", true, "Split after The Beach", "MFPP");
        settings.Add("PLAY", true, "Split after Playgroup", "MFPP");
        settings.Add("MTN", true, "Split after Forest/Snowy Mountain", "MFPP");
        settings.Add("WIND", true, "Split after Windy Castle", "MFPP");
        settings.Add("MAUS", true, "Split after The Museum", "MFPP");
        //settings.Add("END", true, "Split when interacting with the Carousel", "MFPP");

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
        vars.Helper["Carousel"] = mono.Make<bool>("PotatoActivitiesQuest", "FinishCutscene");
        return true;
    });
}
update
{
    if (current.MainMenu != old.MainMenu || current.MainMenu2 != old.MainMenu2)
    {
        vars.Splits++;
        vars.Log("Times returned to Main Menu: " + vars.Splits);
    }
}
isLoading
{
    return current.Transitions || current.PauseMenu || current.MainMenu == 1 || current.MainMenu2 == 1;
}
start
{
    return current.Start == 1 && old.Start == 0;
}
split
{
    //Splits after each return to the Main Menu after each section (Except Tutorial)
    if (vars.Splits == 3 && old.MainMenu == 0 && current.MainMenu != 0 || vars.Splits == 3 && old.MainMenu2 == 0 && current.MainMenu2 != 0)
    {
        return settings["BEACH"];
    }
    
    if (vars.Splits == 5 && old.MainMenu == 0 && current.MainMenu != 0 || vars.Splits == 5 && old.MainMenu2 == 0 && current.MainMenu2 != 0)
    {
        return settings["PLAY"];
    }
    if (vars.Splits == 7 && old.MainMenu == 0 && current.MainMenu != 0 || vars.Splits == 7 && old.MainMenu2 == 0 && current.MainMenu2 != 0)
    {
        return settings["MTN"];
    }
    if (vars.Splits == 9 && old.MainMenu == 0 && current.MainMenu != 0 || vars.Splits == 9 && old.MainMenu2 == 0 && current.MainMenu2 != 0)
    {
        return settings["WIND"];
    }
    if (vars.Splits == 11 && old.MainMenu == 0 && current.MainMenu != 0 || vars.Splits == 11 && old.MainMenu2 == 0 && current.MainMenu2 != 0)
    {
        return settings["MAUS"];
    }
    if (vars.Splits == 13 && old.MainMenu == 0 && current.MainMenu != 0 || vars.Splits == 13 && old.MainMenu2 == 0 && current.MainMenu2 != 0)
    {
        return settings["END"];
    }
}
onReset
{
    vars.Splits = 0;
}
exit
{
    vars.Splits = 0;
}
