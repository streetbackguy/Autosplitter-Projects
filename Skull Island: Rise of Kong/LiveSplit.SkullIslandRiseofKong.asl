//Original ASL by Streetbackguy. Unreal Engine coding updated by Kuno Demetries.
state("Monke-Win64-Shipping", "Steam 1.0")
{
    int Loads: 0x6E6B478;
    string255 Stages: 0x6ECB750, 0xAF8, 0x30;
}

state("Monke-Win64-Shipping", "Steam 1.1")
{
    int Loads: 0x6EA4468;
    string255 Stages: 0x6F042D8, 0xAF8, 0x30;
}

startup
{
    //settings.Add("KONG", true, "Skull Island: Rise of Kong");
        //settings.Add("SPLITS", true, "GameSplits", "KONG");
            //settings.Add("Tutorial", false, "Split on final hit from Gaw in the Tutorial (WIP)", "SPLITS");
            //settings.Add("Worm", false, "Split on final hit on Gijja (WIP)", "SPLITS");
            settings.Add("Wetlands", false, "Split on exiting to the Wetlands", "SPLITS");
            //settings.Add("Crab", false, "Split on final hit on King Dengiz (WIP)", "SPLITS");
            settings.Add("Jungle", false, "Split on exiting to the Dark jungle", "SPLITS");
            //settings.Add("Raptors", false, "Split on final hit on the Three Deathrunner Raptors (WIP)", "SPLITS");
            settings.Add("Caverns", false, "Split on exiting to the Great Caverns", "SPLITS");
            //settings.Add("Spider", false, "Split on final hit on Queen Oyoq (WIP)", "SPLITS");
            settings.Add("Wasteland", false, "Split on exiting to the Wasteland", "SPLITS");
            //settings.Add("Gaw", false, "Split on final hit to Gaw", "SPLITS");
}

init
{
    vars.Splits = new HashSet<string>();
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
    {
        case "6078F5B401713C903662F9F71B1FD613": version = "Steam 1.0"; break;
        case "65C4BBF8765B9012F40F9386F7E90B49": version = "Steam 1.1"; break;
        default: version = "Unknown"; break;
    }
}

isLoading
{
    return current.Loads == 50;
}

start
{
    return current.Stages == "Stage_0_Intro" && current.Loads == 50;
}

split
{
    if(current.Stages == "Stage2_Intro" && current.Loads == 50 && old.Stages != "Stage2_Intro" && !vars.Splits.Contains("Wetlands"))
    {
        vars.Splits.Add("Wetlands");
        return settings["Wetlands"];
    }

    if(current.Stages == "Stage3_Intro" && old.Stages != "Stage3_Intro" &&!vars.Splits.Contains("Jungle"))
    {
        vars.Splits.Add("Jungle");
        return settings["Jungle"];
    }

    if(current.Stages == "Stage4_Intro" && old.Stages != "Stage4_Intro" &&!vars.Splits.Contains("Caverns"))
    {
        vars.Splits.Add("Caverns");
        return settings["Caverns"];
    }

    if(current.Stages == "stage_5" && old.Stages != "stage_5" &&!vars.Splits.Contains("Wasteland"))
    {
        vars.Splits.Add("Wasteland");
        return settings["Wasteland"];
    }
}

onStart
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}

reset
{
    return current.Stages == "/MainMenu_SkullIsland" && old.Stages != current.Stages;
}

exit
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}
