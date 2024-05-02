state("BadWay")
{
    int Gameplay: 0x45901B4;
    int Autostart: 0x458F420, 0x20, 0x3D4;
}

init
{
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
