state("LikeADragonPirates", "Steam 1.10")
{
    bool LoadScreens: 0x385D1C0;
    bool NGStarter: 0x387D520, 0x58, 0x60, 0xC4;
    bool NGPlusStarter: 0x48835A0, 0x764;
    int BlackFades: 0x385D258, 0x1D0, 0x138, 0x48, 0x124;
    int ChapterSavePrompt: 0x38930A0, 0xC4;
    int BossHealth: 0x3856140, 0x30, 0x10, 0x0, 0x10, 0xC0, 0x0, 0x190;
}

state("LikeADragonPirates", "Steam 1.11")
{
    bool LoadScreens: 0x385E980;
    bool NGStarter: 0x387ECE0, 0x58, 0x60, 0xC4;
    bool NGPlusStarter: 0x4884D60, 0x764;
    int BlackFades: 0x385EA18, 0x1D0, 0x138, 0x48, 0x124;
    int ChapterSavePrompt: 0x3894860, 0xCC;
    int BossHealth: 0x3857900, 0x30, 0x10, 0x0, 0x10, 0xC0, 0x0, 0x190;
}

state("LikeADragonPirates", "Steam 1.12")
{
    bool LoadScreens: 0x3862980;
    bool NGStarter: 0x387ECE0, 0x58, 0x60, 0xC4;
    bool NGPlusStarter: 0x4888D60, 0x764;
    int BlackFades: 0x3862A18, 0x1D0, 0x138, 0x48, 0x124;
    int ChapterSavePrompt: 0x3898860, 0xCC;
    int BossHealth: 0x385B900, 0x30, 0x10, 0x0, 0x10, 0xC0, 0x0, 0x190;
}

state("LikeADragonPirates", "Steam 1.13")
{
    bool LoadScreens: 0x3862980;
    bool NGStarter: 0x387ECE0, 0x58, 0x60, 0xC4;
    bool NGPlusStarter: 0x4888D60, 0x764;
    int BlackFades: 0x3862A18, 0x1D0, 0x138, 0x48, 0x124;
    int ChapterSavePrompt: 0x3898860, 0xCC;
    int BossHealth: 0x385B900, 0x30, 0x10, 0x0, 0x10, 0xC0, 0x0, 0x190;
}

state("LikeADragonPirates", "Steam 1.14")
{
    bool LoadScreens: 0x3862980;
    bool NGStarter: 0x3882CE0, 0x58, 0x60, 0xC4;
    bool NGPlusStarter: 0x4888D60, 0x764;
    int BlackFades: 0x3862A18, 0x1D0, 0x138, 0x48, 0x124;
    int ChapterSavePrompt: 0x3898860, 0xCC;
    int BossHealth: 0x385B900, 0x30, 0x10, 0x0, 0x10, 0xC0, 0x0, 0x190;
}

init 
{
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
        {
            case "57C71A81A1FDF4FD2B2C0B566712EFB9":
                version = "Steam 1.10";
                break;

            case "AAA8CF6DE893628546FB626C8567DC8E":
                version = "Steam 1.11";
                break;

            case "1A520982E9FA47744C330ADCBAB3F6AB":
                version = "Steam 1.12";
                break;

            case "23DCFE9BA640B9AB1A55A08CC518ED58":
                version = "Steam 1.13";
                break;

            case "D4AA289CF4294F507BF20D3CE2FAEB16":
                version = "Steam 1.14";
                break;

            default:
                version = "Unknown";
                break;
        }

    vars.EndofChapter = 0;
    vars.Splits = new HashSet<string>();
    vars.BossName = new HashSet<string>();
}

startup
{   
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Like a Dragon Gaiden: Pirate Yakuza in Hawaii",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

    settings.Add("LADPY", true, "Like a Dragon: Pirate Yakuza in Hawaii");

    settings.Add("CHAPTERS", true, "End of Chapter Splits", "LADPY");
        settings.Add("Chapter1", true, "Chapter 1: Shipwrecked", "CHAPTERS");
        settings.Add("Chapter2", true, "Chapter 2: Heart of Darkness", "CHAPTERS");
        settings.Add("Chapter3", true, "Chapter 3: The Old Man and the Sea", "CHAPTERS");
        settings.Add("Chapter4", true, "Chapter 4: Treasure Island", "CHAPTERS");
        settings.Add("Chapter5", true, "Final Chapter: White Whale", "CHAPTERS");
}

isLoading 
{
    return current.LoadScreens || current.BlackFades != 0;
}

update
{
    if(current.ChapterSavePrompt == 0 && old.ChapterSavePrompt == 1 && current.BlackFades != 0)
    {
        vars.EndofChapter++;
    }

    if(current.BossHealth == 90000)
    {
        vars.BossName.Add("Raymond");
    }
}

start
{
    return current.NGStarter || current.NGPlusStarter;
}

onStart
{
    vars.Splits.Clear();
    vars.BossName.Clear();
    vars.EndofChapter = 0;
    timer.IsGameTimePaused = true;
}

split
{
    if(current.ChapterSavePrompt == 0 && old.ChapterSavePrompt == 1 && current.BlackFades != 0 && !vars.Splits.Contains("Chapter"+vars.EndofChapter))
    {
        return settings["Chapter" + vars.EndofChapter] && vars.Splits.Add("Chapter" + vars.EndofChapter);
    }

    if(current.BossHealth == 0 && old.BossHealth > 0 && vars.BossName.Contains("Raymond") && current.BlackFades == 0 && !vars.Splits.Contains("Chapter5"))
    {
        return settings["Chapter5"] && vars.Splits.Add("Chapter5");
    }
}

exit
{
    timer.IsGameTimePaused = true;
}