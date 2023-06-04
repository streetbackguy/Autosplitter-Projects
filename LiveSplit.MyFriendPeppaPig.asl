state("My Friend Peppa Pig", "Steam")
{
    byte Start: "UnityPlayer.dll", 0x19A7630, 0xA8, 0xC8, 0x28, 0x30;
    bool MainMenu: "UnityPlayer.dll", 0x199ACE0, 0x1E0, 0x48, 0x118, 0x50, 0x20, 0x10, 0x28;
    bool MainMenu2: "mono-2.0-bdwgc.dll", 0x0495A90, 0xD88, 0x130, 0x18, 0x18, 0x210, 0xE0, 0xA6C;
}

startup
{   
    vars.Log = (Action<object>)(output => print("[My Friend Peppa Pig] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Transitions"] = mono.Make<bool>("LoadingSceneManager", 1, "_instance", 0x2C);
        vars.Helper["PauseMenu"] = mono.Make<bool>("PauseManager", 1, "_instance", 0x81);

        return true;
    });
}

isLoading
{
    return current.Transitions || current.PauseMenu || current.MainMenu || current.MainMenu2;
}

start
{
    return current.Start == 1 && old.Start == 0;
}
