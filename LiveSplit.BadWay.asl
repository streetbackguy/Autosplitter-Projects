state("BadWay")
{
    int Gameplay: 0x4527230;
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
    
    switch (modules[0].ModuleMemorySize)
    {
        case 0x4F46000: break;
        default:
        {
        dynamic cmp = timer.Run.AutoSplitter != null
            ? timer.Run.AutoSplitter.Component
            : timer.Layout.Components.First(c => c.GetType().Name == "ASLComponent");

        cmp.Script.GetType().GetField("_game", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(cmp.Script, null);
        return;
        }
    }
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    vars.Helper.GameName = "Bad Way";
    vars.Helper.AlertLoadless();
}

isLoading
{
    return current.Gameplay == 0;
}

start
{
    //To Do
}

exit
{
    timer.IsGameTimePaused = true;

    print("[Bad Way] Shutdown Game");
}
