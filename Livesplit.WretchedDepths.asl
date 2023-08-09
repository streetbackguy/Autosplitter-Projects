state("Wretched Depths")
{
    float EndSplit: "UnityPlayer.dll", 0x1B05188, 0x258, 0x48, 0x1E4;
}

startup
{
    vars.Watch = (Action<string>)(key =>
    { if(vars.Helper[key].Changed) vars.Log(key + ": " + vars.Helper[key].Old + " -> " + vars.Helper[key].Current); });

    vars.Sw = new Stopwatch();

    settings.Add("WD", true, "Wretched Depths");
        settings.Add("END", true, "Split on Ending Cutscene", "WD");

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Wretched Depths";
    vars.Helper.LoadSceneManager = true;
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["igt"] = mono.Make<float>("GameManager", "Instance", 0x120);
        vars.Helper["isPaused"] = mono.Make<bool>("GameManager", "Instance", 0x11C);
        vars.Helper["levelID"] = mono.Make<int>("GameManager", "Instance", 0xFC);
        vars.Helper["isAttractive"] = mono.Make<bool>("LureController", "isAttractive");
        vars.Helper["canReel"] = mono.Make<bool>("FishingController", "canReel");
        vars.Helper["isCaught"] = mono.Make<int>("Feeshlopedia", "isCaught");

        return true;
    });
}

update
{
    vars.Watch("levelID");

    //Original code by diggity
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? old.ActiveScene;
    current.LoadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.LoadingScene;
}

isLoading
{
    return current.LoadingScene != old.LoadingScene && !current.isPaused;
}

start
{
    return current.igt > 0f && current.levelID == 0;
}

split
{
    if((!current.isAttractive && !current.canReel) && (old.EndSplit > 188f && current.levelID == 1))
    {
        vars.Sw.Start();
    }

    if (vars.Sw.ElapsedMilliseconds >= 500)
    {
        vars.Sw.Reset();
        return settings["END"];
    }
}
