state("LikeADragonPirates", "Steam 1.10")
{
    bool LoadScreens: 0x385D1C0;
    bool NGStarter: 0x387D520, 0x58, 0x60, 0xC4;
    bool NGPlusStarter: 0x48835A0, 0x764;
    int BlackFades: 0x385D258, 0x1D0, 0x138, 0x48, 0x124;
    int ChapterSavePrompt: 0x3880378, 0x7D0;
}

init 
{
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    vars.Splits = new HashSet<string>();

    switch (MD5Hash)
        {
            case "57C71A81A1FDF4FD2B2C0B566712EFB9":
                version = "Steam 1.10";
                break;

            default:
                version = "Unknown";
                break;
        }

    vars.EndofChapter = 0;
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

    settings.Add("CHAPTERS", true, "Chapter Card Splits", "LADPY");
        settings.Add("Chapter1", true, "Chapter 1: Shipwrecked", "CHAPTERS");
        settings.Add("Chapter2", true, "Chapter 2: Heart of Darkness", "CHAPTERS");
        settings.Add("Chapter3", true, "Chapter 3: The Old Man and the Sea", "CHAPTERS");
        settings.Add("Chapter4", true, "Chapter 4: Treasure Island", "CHAPTERS");
        settings.Add("Chapter5", true, "Final Chapter: Ya Gotta Keep Livin", "CHAPTERS");
}

isLoading 
{
    return current.LoadScreens || current.BlackFades != 0;
}

update
{
    if(current.ChapterSavePrompt == 0 && old.ChapterSavePrompt == 1)
    {
        vars.EndofChapter++;
    }
}

start
{
    return current.NGStarter || current.NGPlusStarter;
}

onStart
{
    vars.Splits.Clear();
    vars.EndofChapter = 0;
}

split
{
    if(current.ChapterSavePrompt == 0 && old.ChapterSavePrompt == 1 && !vars.Splits.Contains("Chapter"+vars.EndofChapter))
    {
        return settings["Chapter" + vars.EndofChapter] && vars.Splits.Add("Chapter" + vars.EndofChapter);
    }
}

reset
{

}

exit
{
    timer.IsGameTimePaused = true;
}