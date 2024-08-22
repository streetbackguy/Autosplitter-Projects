state("Ghost Land Yard")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Ghostland Yard";
    vars.Helper.AlertLoadless();

    settings.Add("GLY", true, "Ghostland Yard");
        settings.Add("ANY", true, "Splits after Each Completed Level", "GLY");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["GameTimer"] = mono.Make<float>("SceneParameters", "SpeedrunTimer");
        vars.Helper["LevelEnded"] = mono.Make<bool>("LevelManager", "Instance", "levelEnded");

        vars.Helper["LevelNumber"] = mono.Make<int>("LevelManager", "Instance", "lvl");
        vars.Helper["WorldNumber"] = mono.Make<int>("LevelManager", "Instance", "World");
        
        return true;
    });
}

update
{
    if(current.LevelEnded && current.LevelEnded != old.LevelEnded)
    {
        vars.Log("World " + old.WorldNumber + " Level " + old.LevelNumber + " beaten!");
    };
}

start
{
    return current.GameTimer > 0.0f && old.GameTimer == 0.0f;
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
    return TimeSpan.FromSeconds(current.GameTimer);
}
