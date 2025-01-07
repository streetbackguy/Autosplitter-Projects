state("Murdered")
{
    string255 Cutscene: 0x21549B8, 0x50, 0x0;
    string255 Credits: 0x217C2E0, 0x88, 0x30, 0x78, 0x100, 0xF88, 0x28, 0x240;
    bool Loads: 0x20328CC;
    bool GameStart: 0x2173FB0;
}

init
{
    vars.Splits = new HashSet<string>();
}

startup
{
    settings.Add("MSS", true, "Murered: Soul Suspect");
        settings.Add("ANY", true, "Any% Splits", "MSS");
            settings.Add("ep02_000_HubInAll_m-sb", true, "Alleyways", "ANY");
            settings.Add("ep02_090_GruntForeshadow_l-sb-2b", true, "Crime Scene", "ANY");
            settings.Add("ep02_235_ExitAptExt_l-2b-sb", true, "Apartments", "ANY");
            settings.Add("ep03_700_ConEndStart_l-3b-Ce", true, "Church", "ANY");
            settings.Add("ep04_175_ConfrontingJoyPart1_l-4b-sb", true, "Police Station", "ANY");
            settings.Add("ep05_898_HubOutStory_l-5b-sb", true, "Cemetery", "ANY");
            settings.Add("ep06_170_GetIrisToChurch_l-6b-Ae", true, "Mental Hospital", "ANY");
            settings.Add("ep07_898_HubOutStory_l-7b-sb", true, "Museum", "ANY");
            settings.Add("ep08_898_HubOutStory_l-8b-sb", true, "Church Investigation", "ANY");
            settings.Add("ep09_899_HubOutGen_l-9b-sb", true, "Judgment House", "ANY");
        settings.Add("NCANY", true, "Any% No Cutscenes Splits", "MSS");
            settings.Add("ep02_000_HubInAll_m-sb_LOC", true, "Alleyways", "NCANY");
            settings.Add("ep02_090_GruntForeshadow_l-sb-2b_LOC", true, "Crime Scene", "NCANY");
            settings.Add("ep02_235_ExitAptExt_l-2b-sb_LOC", true, "Apartments", "NCANY");
            settings.Add("ep03_700_ConEndStart_l-3b-Ce_LOC", true, "Church", "NCANY");
            settings.Add("ep04_175_ConfrontingJoyPart1_l-4b-sb_LOC", true, "Police Station", "NCANY");
            settings.Add("ep05_898_HubOutStory_l-5b-sb_LOC", true, "Cemetery", "NCANY");
            settings.Add("ep06_170_GetIrisToChurch_l-6b-Ae_LOC", true, "Mental Hospital", "NCANY");
            settings.Add("ep07_898_HubOutStory_l-7b-sb_LOC", true, "Museum", "NCANY");
            settings.Add("ep08_898_HubOutStory_l-8b-sb_LOC", true, "Church Investigation", "NCANY");
            settings.Add("ep09_899_HubOutGen_l-9b-sb_LOC", true, "Judgment House", "NCANY");
        settings.Add("Credits", true, "Save Joy", "MSS");
}

isLoading
{
    return current.Loads;
}

split
{
    if(current.Cutscene != old.Cutscene && !vars.Splits.Contains(current.Cutscene))
    {
        return settings[current.Cutscene] && vars.Splits.Add(current.Cutscene);
    }

    if(current.Credits == "Square Enix Co., Ltd." && !vars.Splits.Contains(current.Credits))
    {
        return settings["Credits"] && vars.Splits.Add("Credits");
    }
}

start
{
    return current.Cutscene == "ep01_010_Intro_m-sb" && current.GameStart;
}

onStart
{
    vars.Splits.Clear();
}

exit
{
	timer.IsGameTimePaused = true;
}