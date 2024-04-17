state("Hearthstone") 
{
    byte Loads: "UnityPlayer.dll", 0x157FCB4, 0x0, 0x528;
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
        vars.Helper["m_sceneLoaded"] = mono.Make<bool>("SceneMgr", "s_instance", 0x55);
        
        return true;

    });

}

isLoading
{
    return !current.m_sceneLoaded || current.Loads == 88;
}
