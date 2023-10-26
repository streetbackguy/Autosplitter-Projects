state("SEARCH PARTY DIRECTORS CUT")
{
    long IGT: "UnityPlayer.dll", 0x10B2500, 0x1C, 0x8, 0x18, 0x2C8, 0x688;
    string255 Ending: "mono.dll", 0x02048E8, 0x4C;
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Search Party";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("SP", true, "Search Party");
        settings.Add("LS", true, "Location Splits", "SP");
            settings.Add("First Floor", true, "Split on Entering the House", "LS");
            settings.Add("Second Floor", true, "Split on reaching the Second Floor", "LS");
            settings.Add("Third Floor", true, "Split on reaching the Third Floor", "LS");
            settings.Add("Attic", true, "Split on reaching the Attic", "LS");
            settings.Add("Basement", true, "Split on reaching the Basement", "LS");
            settings.Add("Outside", true, "Split on Exiting the Basement to the Outside", "LS");
            settings.Add("First Floor2", true, "Split on reaching the First Floor after Boss Fight", "LS");
            settings.Add("???", true, "Split after entering the Blue Door Painting", "LS");
            settings.Add("UFO", true, "Split on reaching the UFO", "LS");
        settings.Add("ES", true, "Ending Splits", "SP");
            settings.Add("endinga", true, "Split on reaching Ending A", "ES");
            settings.Add("endingb", true, "Split on reaching Ending B", "ES");
            settings.Add("endingc", true, "Split on reaching Ending C", "ES");
            settings.Add("endingd", true, "Split on reaching Ending D", "ES");
            settings.Add("endinge", true, "Split on reaching Ending E", "ES");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["nextRoom"] = mono.MakeString("GameController", "instance", 0x14);
        //vars.Helper["Ending"] = mono.MakeString("UIManager", "instance");

        return true;
    });
}

update
{
    if(current.nextRoom != old.nextRoom)
    {
        print("Current: |" + current.nextRoom + "| Old: |" + old.nextRoom + "|");
    }
}

start
{
    return current.IGT < old.IGT || current.IGT >= 0 && old.IGT != current.IGT;
}

gameTime
{
    return TimeSpan.FromSeconds(current.IGT);
}

split
{
    if(current.nextRoom == "First Floor" && old.nextRoom == "Outside" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.nextRoom == "Second Floor" && old.nextRoom == "First Floor" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.nextRoom == "Third Floor" && old.nextRoom == "Second Floor" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.nextRoom == "Attic" && old.nextRoom == "Third Floor" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.nextRoom == "Basement" && old.nextRoom == "First Floor" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.nextRoom == "Outside" && old.nextRoom == "Basement" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.nextRoom == "First Floor" && old.nextRoom == "Basement" && !vars.Splits.Contains(current.nextRoom+"2"))
    {
        vars.Splits.Add(current.nextRoom+"2");
        return settings[current.nextRoom+"2"];
    }

    if(current.nextRoom == "???" && old.nextRoom == "Second Floor" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.nextRoom == "UFO" && old.nextRoom == "Outside" && !vars.Splits.Contains(current.nextRoom))
    {
        vars.Splits.Add(current.nextRoom);
        return settings[current.nextRoom];
    }

    if(current.Ending != old.Ending)
    {
        vars.Splits.Add(current.Ending);
        return settings[current.Ending];
    }
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