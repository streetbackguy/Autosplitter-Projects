//Original ASL by Streetbackguy. Unreal Engine coding updated by Kuno Demetries.
state("Monke-Win64-Shipping", "Steam")
{
    int Loads: 0x6E6B478;
    float KongHealth: 0x6EB2130, 0x30, 0x878, 0x318, 0x104;
    float GijjaHealth: 0x6CA5C60, 0x68, 0x28, 0x458, 0x240;
    float GawHealth: 0x6C5FF48, 0xA8, 0x140, 0x750, 0xA4;
    string255 Stages: 0x6ECB750, 0xAF8, 0x30;
}

startup
{
    settings.Add("KONG", true, "Skull Island: Rise of Kong");
        settings.Add("ANY", true, "Any% Splits", "KONG");
            settings.Add("Tutorial", true, "Split on final hit from Gaw in the Tutorial", "ANY");
            settings.Add("Worm", true, "Split on final hit on Gijja", "ANY");
            settings.Add("Wetlands", false, "Split on exiting to the Wetlands", "ANY");
            settings.Add("Wasteland", true, "Split on exiting to the Wasteland", "ANY");
            settings.Add("Gaw", true, "Split on final hit to Gaw", "ANY");
}

init
{
    vars.Splits = new HashSet<string>();
    vars.Cutscene = 0;
    vars.HUBs = 0;

    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
    {
        case "6078F5B401713C903662F9F71B1FD613": version = "Steam"; break;

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
    if(current.KongHealth < 10 && old.KongHealth >= 10 && current.Stages == "Stage_0" && !vars.Splits.Contains("Tutorial"))
    {
        vars.Splits.Add("Tutorial");
        return settings["Tutorial"];
    }

    if(current.GijjaHealth < 0.003f && old.GijjaHealth >= 0.003f && current.Stages == "Stage_1" && !vars.Splits.Contains("Worm"))
    {
        vars.Splits.Add("Worm");
        return settings["Worm"];
    }
    
    if(current.Stages == "Stage2_Intro" && current.Loads == 50 && old.Stages == "Stage_1" && !vars.Splits.Contains("Wetlands"))
    {
        vars.Splits.Add("Wetlands");
        return settings["Wetlands"];
    }
    
    if(current.Stages == "stage_5" && old.Stages == "Stage_2" &&!vars.Splits.Contains("Wasteland"))
    {
        vars.Splits.Add("Wasteland");
        return settings["Wasteland"];
    }

    if(current.GawHealth == 0f && old.GawHealth > 0.00f && current.Stages == "stage_5" && !vars.Splits.Contains("Gaw"))
    {
        vars.Splits.Add("Gaw");
        return settings["Gaw"];
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
