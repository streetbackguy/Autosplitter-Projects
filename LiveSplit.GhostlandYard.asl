state("Ghost Land Yard")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Ghostland Yard";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("GLY", true, "Ghostland Yard");
        settings.Add("ANY", true, "Splits after Each Completed Level", "GLY");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["SpeedrunTimer"] = mono.Make<float>("SceneParameters", "SpeedrunTimer");
        vars.Helper["LevelEnded"] = mono.Make<bool>("LevelManager", "Instance", "levelEnded");

        // vars.Helper["LevelNumber"] = mono.Make<int>("LevelManager", "Instance", "lvl");
        // vars.Helper["WorldNumber"] = mono.Make<int>("LevelManager", "Instance", "World");
        
        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;
}

start
{
    return current.SpeedrunTimer > 0.0f && old.SpeedrunTimer == 0.0f;
}

split
{
    if(current.LevelEnded && current.LevelEnded != old.LevelEnded)
    {
        return settings["ANY"];
    };
}

gameTime
{
    return TimeSpan.FromSeconds(current.SpeedrunTimer);
}

reset
{
    return current.SpeedrunTimer == 0.0f || current.activeScene == "Menu_RELEASE" && old.activeScene == "Menu_RELEASE";
}
