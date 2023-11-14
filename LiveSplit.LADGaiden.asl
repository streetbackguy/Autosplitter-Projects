state("LikeADragonGaiden", "Steam 1.10") 
{
    bool Loads: 0x383B6C0, 0xC0, 0x10, 0x35C;
    int Chapter: 0x31E5434;
    int FinalBoss: 0x3824B50, 0x60;
}

state("LikeADragonGaiden", "Windows Store 1.10") 
{
    bool Loads: 0x383B6C0, 0xC0, 0x10, 0x35C;
    int Chapter: 0x31E5430;
    int FinalBoss: 0x3824B50, 0x60;
}

init 
{
    vars.Splits = new HashSet<string>();
    vars.ChapterCard = 0;
    vars.QTE = 0;

    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
    {
        case "859CDDBEC2B6F5B890CD4A96BBCFCFCC": version = "Steam 1.10"; break;
        case "0": version = "Windows Store 1.10"; break;

        default: version = "Unknown"; break;
    }
}

startup
{   
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Like a Dragon: Gaiden",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

    settings.Add("LADG", true, "Like a Dragon: Gaiden");
        settings.Add("CH1", false, "First Tutorial Fight", "LADG");
        settings.Add("CH2", true, "Chapter 01: Hidden Dragon", "LADG");
        settings.Add("CH3", true, "Chapter 02: Castle on the Water", "LADG");
        settings.Add("CH4", true, "Chapter 03: The Man Who Knew Too Much", "LADG");
        settings.Add("CH5", true, "Chapter 04: The Laughing Man", "LADG");
        settings.Add("END", true, "Final Chapter: The Man Who Erased His Name", "LADG");
}

isLoading 
{
    return current.Loads;
}

update
{
    if(current.Chapter != 0 && old.Chapter == 0)
    {
        vars.ChapterCard++;
    }

    if(current.FinalBoss == 2 && old.FinalBoss == 1)
    {
        vars.QTE++;
    }
}

split
{
    //Splits after each end of chapter save screen, on the Chapter Card
    if (current.Chapter != 0 && old.Chapter == 0 && (!vars.Splits.Contains("CH" + vars.ChapterCard)))
    {
        vars.Splits.Add("CH" + vars.ChapterCard);
        return settings["CH" + vars.ChapterCard];
    }

    //Splits after the QTE in the Shishido fight in the Final Chapter
    if (vars.QTE == 2 && (!vars.Splits.Contains("END")))
    {
        vars.Splits.Add("END");
        return settings["END"];
    }
}

onReset
{
    vars.Splits.Clear();
}

onStart
{
    vars.ChapterCard = 0;
    vars.QTE = 0;
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
}
