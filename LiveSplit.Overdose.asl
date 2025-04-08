state("Overdose") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Overdose";
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["GameStarted"] = mono.Make<bool>("GameManager", "instance", "gameStarted");
        vars.Helper["Paused"] = mono.Make<bool>("GameManager", "instance", "gamePaused");
        vars.Helper["GameCompleted"] = mono.Make<bool>("GameManager", "instance", "gameCompleted");

        return true;
    });
}

start
{
    return current.GameStarted && !old.GameStarted;
}

reset
{
    return !current.GameStarted;
}

split
{
    return current.GameCompleted && !old.GameCompleted;
}

isLoading
{
    return current.Paused;
}

exit
{
    timer.IsGameTimePaused = true;
}