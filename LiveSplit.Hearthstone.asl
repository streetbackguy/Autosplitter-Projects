state("Hearthstone") 
{
    bool LoadingBar: "UnityPlayer.dll", 0x158EDE0, 0xB04, 0xA1C, 0x9F4, 0x8E0, 0x0, 0x7F8;
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Hearthstone";

    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Transitions"] = mono.Make<bool>("SceneMgr", "s_instance", "m_transitioning");

        return true;
    });
}

isLoading
{
    return current.Transitions || current.LoadingBar;
}

exit
{
    timer.IsGameTimePaused = true;
}
