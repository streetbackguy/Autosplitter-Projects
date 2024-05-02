state("BadWay")
{
    int Gameplay: 0x45901B4;
    int Autostart: 0x458F420, 0x20, 0x3D4;
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
    return current.Autostart == 0 && old.Autostart != 0;
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}
