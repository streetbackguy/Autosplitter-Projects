state("Wretched Depths"){}

startup
{
    vars.Watch = (Action<string>)(key =>
    { if(vars.Helper[key].Changed) vars.Log(key + ": " + vars.Helper[key].Old + " -> " + vars.Helper[key].Current); });

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Wretched Depths";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["igt"] = mono.Make<float>("GameManager", "Instance", 0x120);
        vars.Helper["isPaused"] = mono.Make<bool>("GameManager", "Instance", 0x11C);
        vars.Helper["levelID"] = mono.Make<int>("GameManager", "Instance", 0xFC);

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