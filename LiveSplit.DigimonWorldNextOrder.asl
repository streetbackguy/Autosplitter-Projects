state("Digimon World Next Order")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Digimon World Next Order] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var uinls = mono["UINowLoadingScript"];
        vars.Helper["NowLoading"] = uinls.Make<float>("m_instant", 0x28, 0x118);

        var ses = mono["ScreenEffectScript"];
        vars.Helper["ScreenFade"] = ses.Make<bool>("m_instance", 0x18, 0x58);

        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

    if(current.NowLoading != old.NowLoading)
    {
        vars.Log("Now Loading Value: " + old.NowLoading + " -> " + current.NowLoading);
    }

    if(current.ScreenFade != old.ScreenFade)
    {
        vars.Log("ScreenFade: " + old.ScreenFade + " -> " + current.ScreenFade);
    }
}

isLoading
{
    return current.NowLoading > 0 || current.ScreenFade;
}

start
{
    return current.activeScene != "GameStart" && old.activeScene == "GameStart";
}

exit
{
    timer.IsGameTimePaused = true;
}