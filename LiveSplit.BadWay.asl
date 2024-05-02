state("BadWay")
{
    int Gameplay: 0x45901B4;
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    vars.Helper.GameName = "Bad Way";

    vars.Helper.AlertLoadless();
}

init
{
    if (vars.Helper.Reject(0x75000))
    return;
}

isLoading
{
    return current.Gameplay == 262144;
}

start
{
    
}

exit
{
    timer.IsGameTimePaused = true;

    print("[Bad Way] Shutdown Game");
}
