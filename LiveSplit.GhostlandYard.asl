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
        // settings.Add("BOSS", true, "Splits after Each Boss Level", "GLY");

}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["GameTimer"] = mono.Make<float>("SceneParameters", "SpeedrunTimer");
        vars.Helper["LevelEnded"] = mono.Make<bool>("LevelManager", "Instance", "levelEnded");

        // vars.Helper["BossOne"] = mono.Make<bool>("LavaBossManager", "dead");
        // vars.Helper["BossTwo"] = mono.Make<bool>("Boss2Manager", "endTrigger");
        // vars.Helper["BossThree"] = mono.Make<bool>("Boss3Manager", "dead");
        // vars.Helper["BossFour"] = mono.Make<int>("Boss4Manager", "bossState");
        // vars.Helper["BossFive"] = mono.Make<bool>("Boss5Manager", "dead");
        // vars.Helper["BossSix"] = mono.Make<bool>("Boss6Manager", "bossDead");

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

    // if(current.BossOne && current.BossOne != old.BossOne ||
    // current.BossTwo && current.BossTwo != old.BossTwo ||
    // current.BossThree && current.BossThree != old.BossThree ||
    // current.BossFour == 7 && current.BossFour != old.BossFour ||
    // current.BossFive && current.BossFive != old.BossFive ||
    // current.BossSix && current.BossSix != old.BossSix)
    // {
    //     return settings["BOSS"];
    // };
}

gameTime
{
    return TimeSpan.FromSeconds(current.GameTimer);
}
