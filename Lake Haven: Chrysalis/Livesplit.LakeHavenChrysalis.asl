state("Lake Haven - Chrysalis") {}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Lake Haven - Chrysalis";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("Farmhouse_Interior_1F", false, "Entering the House");
    settings.Add("WayToBasement", false, "Entering the Basement Passage");
    settings.Add("safe", false, "Leaving the Attic");
    settings.Add("Office", false, "Entering the Office");
    settings.Add("Well2", false, "Entering the Well's Depths");
    settings.Add("Basement", false, "Entering the Basement Door");
    settings.Add("end", false, "Ending");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Ttimer"] = mono.Make<float>("TextAnimate", "timer");
        vars.Helper["Wtimer"] = mono.Make<float>("WindowUpgrades", "timer");

        vars.Helper["ETotalTime"] = mono.Make<float>("EndlessResultsScreen", "instance", "totaltime");

        return true;
    });
}

update
{
    current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

    if (old.nextRoom != current.nextRoom)
    {
        vars.Log("NextRoom changed: " + old.nextRoom + " -> " + current.nextRoom);
    }

    if (old.autosplitHook != current.autosplitHook)
    {
        vars.Log("Room int changed: " + old.autosplitHook + " -> " + current.autosplitHook);
    }
}

start
{
    return current.activeScene == "FarmHouse_Exterior" && old.igt == 0f && current.igt > 0f;
}

reset
{
    return current.activeScene == "MainMenu" || current.loadingScene == "WarningScreen";
}

gameTime
{
    return TimeSpan.FromSeconds(current.igt);
}

split
{
    if (current.nextRoom != old.nextRoom && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if (current.nextRoom == "Farmhouse_Interior_2F" && old.nextRoom == "Farmhouse_Attic" && !vars.Splits.Contains("safe"))
    {
        vars.Splits.Add("safe");
        return settings["safe"];
    }

    if (!current.gameTimeStarted && old.gameTimeStarted && !vars.Splits.Contains("end"))
    {
        vars.Splits.Add("end");
        return settings["end"];
    }
}

isLoading
{
    return true;
}

onReset
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
}