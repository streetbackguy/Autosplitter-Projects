//Original ASL by Streetbackguy. Unreal Engine coding updated by Kuno Demetries.
state("Monke-Win64-Shipping", "Steam 1.0")
{
    int Loads: 0x6E6B478;
    float KongHealth: 0x6EB2130, 0x30, 0x878, 0x318, 0x104;
    float GijjaHealth: 0x6CA5C60, 0x68, 0x28, 0x458, 0x240;
    float DengizHealth: 0x6D6F2A0, 0x28, 0x28, 0xC80, 0x240;
    float DeathrunnerHealth: 0x6A4D060, 0x8, 0x298, 0x50, 0xA48, 0x210;
    float OyoqHealth: 0x6EB2130, 0x30, 0x878, 0x110, 0x490, 0x2B8, 0x100, 0x200;
    float GawHealth: 0x6C5FF48, 0xA8, 0x140, 0x750, 0xA4;

    int Cinematics: 0xEC6AC0, 0xE0, 0x2A8;
    string255 Stages: 0x6ECB750, 0xAF8, 0x30;
}

state("Monke-Win64-Shipping", "Steam 1.1")
{
    int Loads: 0x6EA4468;
    float KongHealth: 0x6EEAB40, 0x30, 0x878, 0x110, 0x4B0, 0x2E0;
    float GijjaHealth: 0x6CA5C60, 0x68, 0x28, 0x458, 0x240;
    float DengizHealth: 0x6D6F2A0, 0x28, 0x28, 0xC80, 0x240;
    float DeathrunnerHealth: 0x6A4D060, 0x8, 0x298, 0x50, 0xA48, 0x210;
    float OyoqHealth: 0x6EB2130, 0x30, 0x878, 0x110, 0x490, 0x2B8, 0x100, 0x200;
    float GawHealth: 0x6C5FF48, 0xA8, 0x140, 0x750, 0xA4;

    int Cinematics: 0x6EA8CC8, 0xB8, 0x178, 0x378, 0x268, 0x0, 0x44;
    string255 Stages: 0x6F042D8, 0xAF8, 0x30;
}

startup
{
    settings.Add("KONG", true, "Skull Island: Rise of Kong");
        settings.Add("SPLITS", true, "GameSplits", "KONG");
            settings.Add("Tutorial", false, "Split on final hit from Gaw in the Tutorial", "SPLITS");
            settings.Add("Worm", false, "Split on final hit on Gijja", "SPLITS");
            settings.Add("Wetlands", false, "Split on exiting to the Wetlands", "SPLITS");
            settings.Add("Crab", false, "Split on final hit on King Dengiz", "SPLITS");
            settings.Add("Jungle", false, "Split on exiting to the Dark jungle", "SPLITS");
            settings.Add("Raptors", false, "Split on final hit on the Three Deathrunner Raptors", "SPLITS");
            settings.Add("Caverns", false, "Split on exiting to the Great Caverns", "SPLITS");
            settings.Add("Spider", false, "Split on final hit on Queen Oyoq", "SPLITS");
            settings.Add("Wasteland", false, "Split on exiting to the Wasteland", "SPLITS");
            settings.Add("Gaw", false, "Split on final hit to Gaw", "SPLITS");

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
    if(current.KongHealth < 75 && current.KongHealth != old.KongHealth && current.Cinematics == 2 && current.Stages == "Stage_0" && !vars.Splits.Contains("Tutorial"))
    {
        vars.Splits.Add("Tutorial");
        return settings["Tutorial"];
    }

    if(current.GijjaHealth < 0.025f && current.GijjaHealth != old.GijjaHealth && current.Cinematics == 2 && current.Stages == "Stage_1" && !vars.Splits.Contains("Worm"))
    {
        vars.Splits.Add("Worm");
        return settings["Worm"];
    }
    
    if(current.Stages == "Stage2_Intro" && current.Loads == 50 && old.Stages != "Stage2_Intro" && !vars.Splits.Contains("Wetlands"))
    {
        vars.Splits.Add("Wetlands");
        return settings["Wetlands"];
    }

    if(current.DengizHealth < 0.025f && current.DengizHealth != old.DengizHealth && current.Cinematics == 2 && current.Stages == "Stage_2" && !vars.Splits.Contains("Crab"))
    {
        vars.Splits.Add("Crab");
        return settings["Crab"];
    }
    
    if(current.Stages == "Stage3_Intro" && old.Stages != "Stage3_Intro" &&!vars.Splits.Contains("Jungle"))
    {
        vars.Splits.Add("Jungle");
        return settings["Jungle"];
    }

    if(current.DeathrunnerHealth < 0.025f && current.DeathrunnerHealth != old.DeathrunnerHealth && current.Cinematics == 2 && current.Stages == "Stage_3" && !vars.Splits.Contains("Raptors"))
    {
        vars.Splits.Add("Raptors");
        return settings["Raptors"];
    }
    
    if(current.Stages == "Stage4_Intro" && old.Stages != "Stage4_Intro" &&!vars.Splits.Contains("Caverns"))
    {
        vars.Splits.Add("Caverns");
        return settings["Caverns"];
    }

    if(current.OyoqHealth < 0.025f && current.OyoqHealth != old.OyoqHealth && current.Cinematics == 2 && current.Stages == "Stage_4" && !vars.Splits.Contains("Spider"))
    {
        vars.Splits.Add("Spider");
        return settings["Spider"];
    }

    if(current.Stages == "stage_5" && old.Stages != "stage_5" &&!vars.Splits.Contains("Wasteland"))
    {
        vars.Splits.Add("Wasteland");
        return settings["Wasteland"];
    }

    if(current.GawHealth < 0.025f && current.GawHealth != old.GawHealth  && current.Cinematics == 2 && current.Stages == "stage_5" && !vars.Splits.Contains("Gaw"))
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
