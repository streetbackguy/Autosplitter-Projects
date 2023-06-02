state("Hearthstone") 
{
    bool LoadingBar: "mono-2.0-bdwgc.dll", 0x5FBF04, 0x3C, 0x8, 0x88, 0xD0, 0x18, 0xC8, 0x294;
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
        vars.Helper["Transitioning"] = mono.Make<bool>("SceneMgr", "s_instance", "m_transitioning");

        return true;
    });
}

isLoading
{
    return current.Transitioning || current.LoadingBar;
}

exit
{
    timer.IsGameTimePaused = true;
}
