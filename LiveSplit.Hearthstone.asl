state("Hearthstone") 
{
    bool LoadingBar: "UnityPlayer.dll", 0x1557660, 0xA9C, 0x9C0, 0x4, 0x44, 0x840;
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
