state("Hearthstone") 
{
    int LoadingBar: "UnityPlayer.dll", 0x153BEA0, 0x30, 0x1AC, 0x184, 0x30, 0x348, 0x5D0;
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
    return !current.m_sceneLoaded || current.LoadingBar != 38412338;
}
