state("Hearthstone") 
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Hearthstone";

    vars.Helper.AlertLoadless();
    vars.Helper.LoadSceneManager = true;
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["m_sceneLoaded"] = mono.Make<bool>("SceneMgr", "s_instance", 0x55);
        vars.Helper["Loads"] = mono.Make<bool>("SceneMgr", "s_instance", 0x38, 0x38);
        //vars.Helper["ProgressBar2"] = mono.Make<bool>("TransitionPopup", "m_transitionPopup");

        //"LoadingPopup.prefab:ff9266f7c55faa94b9cd0f1371df7168"

        return true;
    });

}

update
{
    //print("Current: " + current.ProgressBar);
}

isLoading
{
    return !current.m_sceneLoaded || current.Loads;
}
