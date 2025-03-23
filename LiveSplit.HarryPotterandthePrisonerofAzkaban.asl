state("hppoa")
{
    uint Pauser: "Engine.dll", 0x4432E0;
    float TimeSeconds: "Engine.dll", 0x4C660C, 0x740, 0x6A8;
    string50 MapName: "Engine.dll", 0x4C660C, 0x768, 0x0;
}

startup
{
    vars.FinishedLevels = new List<string>();
    vars.Splits = new HashSet<string>();
    vars.CurrentLevel = "";
    vars.OldLevel = "";
    vars.LastLevel = "";

    settings.Add("HP3", true, "Harry Potter and the Prisoner of Azkaban");
        settings.Add("HP3_ADV1EXPRESS", true, "Finish Hogwarts Express", "HP3");
        settings.Add("HP3_GROUNDSDADA", true, "Finish Hogwarts Grounds Cutscene", "HP3");
        settings.Add("HP3_CH1CARPERETRACTUM", true, "Finish Carpe Retractum Challenge (First Half)", "HP3");
        settings.Add("HP3_CH1CARPERETRACTUMB", true, "Finish Carpe Retractum Challenge (Second Half)", "HP3");
        settings.Add("HP3_CH2DRACONIFORS", true, "Finish Draconifors Challenge (First Half)", "HP3");
        settings.Add("HP3_CH2DRACONIFORSB", true, "Finish Draconifors Challenge (Second Half)", "HP3");
        settings.Add("HP3_QUIDDITCH", true, "Finish Quidditch", "HP3");
        settings.Add("HP3_ADV2EXPPATRONUM", true, "Finish Expecto Patronum Challenge", "HP3");
        settings.Add("HP3_ADV3LIBRARY", true, "Finish Library Challenge", "HP3");
        settings.Add("HP3_CH3GLACIUS", true, "Finish Glacius Challenge (First Half)", "HP3");
        settings.Add("HP3_CH3GLACIUSB", true, "Finish Glacius Challenge (Second Half)", "HP3");
        settings.Add("HP3_BUCKYEXECUTED", true, "Finish Buckbeak's Execution", "HP3");
        settings.Add("HP3_WHOMPINGWILLOW", true, "Finish Whomping Willow", "HP3");
        settings.Add("HP3_ADV5SHACK", true, "Finish Shack", "HP3");
        settings.Add("HP3_DEMENTORBATTLE", true, "Finish Dementor Battle", "HP3");
        settings.Add("HP3_ADV6PADDOCK", true, "Finish Paddock", "HP3");
        settings.Add("HP3_DARKTOWER", true, "Finish Dark Tower", "HP3");
        settings.Add("HP3_FA1RON", true, "Finish Ron's Finale", "HP3");
        settings.Add("HP3_FA2HERMIONE", true, "Finish Hermione's Finale", "HP3");
        settings.Add("HP3_FA3HARRY", true, "Finish Harry's Finale", "HP3");
        settings.Add("HP3_FINAL", true, "Finish Finale", "HP3");
}

update
{
    vars.CurrentLevel = current.MapName.ToUpper().Replace(".UNR", "");
    vars.OldLevel = old.MapName.ToUpper().Replace(".UNR", "");
    vars.LastLevel = old.MapName.ToUpper().Replace(".UNR", "");

    if(vars.LastLevel != "" && vars.CurrentLevel != vars.OldLevel)
    {
        print("CurrentLevel:" + vars.CurrentLevel.ToString());
		print("OldLevel:" + vars.OldLevel.ToString());
        print("LastLevel:" + vars.LastLevel.ToString());
			
		vars.FinishedLevels.Add(vars.LastLevel);
        vars.LastMap = "";
    }
}

isLoading
{
    return current.TimeSeconds == old.TimeSeconds;
}

start
{
    return vars.CurrentLevel == "HP3_ADV1EXPRESS" && current.Pauser == 0;
}

split
{
    if(vars.CurrentLevel != vars.LastLevel && !vars.Splits.Contains(vars.LastLevel))
    {
        return settings[vars.LastLevel] && vars.Splits.Add(vars.LastLevel);
    }
}

onStart
{
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
}

onReset
{
    vars.FinishedLevels = new List<string>();
}