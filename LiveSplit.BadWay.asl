state("BadWay")
{
    int Gameplay: 0x45901B4;
    int LevelID: 0x4860300;
    int Autostart: 0x458F420, 0x20, 0x3D4;
}

init
{
    vars.Splits = new HashSet<string>();

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
    settings.Add("BW", true, "Bad Way");
        settings.Add("LS", true, "Level Splits", "BW");
            settings.Add("ID2", true, "Unexpected Things", "LS");
            settings.Add("ID3", true, "Treasure of Mansa Musa", "LS");
            settings.Add("ID4", true, "Carlos' Prisoner", "LS");
            settings.Add("ID5", true, "Lost in The Amazon Jungle", "LS");
            settings.Add("ID6", true, "Chasing The Map", "LS");
            settings.Add("ID7", true, "Stowaway", "LS");
            settings.Add("ID8", true, "Nice Day", "LS");
            settings.Add("ID9", true, "Pirates Island", "LS");
            settings.Add("ID10", true, "Weeping Angels", "LS");
            settings.Add("ID11", true, "Lost Treasure", "LS");
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
    vars.Splits.Clear();
    vars.LevelHelper = 0;
}

update
{
    if(current.LevelID == old.LevelID + 1)
    {
        vars.LevelHelper++;
    }
}

split
{
    if(current.LevelID != old.LevelID && !vars.Splits.Contains("ID" + vars.LevelHelper.ToString()))
    {
        return settings["ID" + vars.LevelHelper.ToString()] && vars.Splits.Add("ID" + vars.LevelHelper.ToString());
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
