state("PEAK")
{}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "PEAK";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("PEAK", true, "PEAK");
        settings.Add("1", true, "Shore", "PEAK");
        settings.Add("2", true, "Tropics", "PEAK");
        settings.Add("3", true, "Alpine", "PEAK");
        settings.Add("4", true, "Caldera", "PEAK");
        settings.Add("5", true, "The Kiln", "PEAK");
        settings.Add("END", true, "Helicopter Rescue", "PEAK");

    vars.StartDelay = new Stopwatch();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Loading"] = mono.Make<bool>("LoadingScreenHandler", "loading");
        vars.Helper["InteractionName"] = mono.MakeString("Interaction", "instance", "bestInteractableName");
        vars.Helper["InteractionTime"] = mono.Make<float>("Interaction", "instance", "_cihf");
        vars.Helper["EndCutscene"] = mono.MakeString("GUIManager", "instance", "endgame", "counter", "m_text");

        return true;
    });

    vars.CompletedSplits = new HashSet<string>();
    vars.CampfiresLit = 0;
}

split
{
    if(current.InteractionTime == 0 && old.InteractionTime > 1.97000f && old.InteractionName == "Campfire" && !vars.CompletedSplits.Contains(vars.CampfiresLit.ToString()))
    {
        return settings[vars.CampfiresLit.ToString()] && vars.CompletedSplits.Add(vars.CampfiresLit.ToString());
    }

    if(current.EndCutscene == "0" && old.EndCutscene == "1")
    {
        return settings["END"] && vars.CompletedSplits.Add("END");
    }
}

update
{
    if(current.InteractionTime != old.InteractionTime)
    {
        vars.Log(current.InteractionName + " " + current.InteractionTime);
    }

    if(current.InteractionTime == 0 && old.InteractionTime > 1.97000f && old.InteractionName == "Campfire")
    {
        vars.CampfiresLit++;
    }

    current.SceneCount = vars.Helper.Scenes.Count;

    current.activeScene = vars.Helper.Scenes.Active.Index ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Index ?? old.loadingScene;
}

isLoading
{
    return current.Loading || current.SceneCount == 2;
}

start
{
    if(current.activeScene == 16 && old.activeScene == 0)
    {
        vars.StartDelay.Start();
    }

    if(vars.StartDelay.ElapsedMilliseconds >= 7000)
    {
        vars.StartDelay.Reset();
        return true;
    }
}

onStart
{
    vars.CompletedSplits.Clear();
    vars.CampfiresLit = 0;
}

reset
{
    return current.activeScene == 1 || current.activeScene == 4;
}

exit
{
    timer.IsGameTimePaused = true;
}