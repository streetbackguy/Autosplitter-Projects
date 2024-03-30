state("SnowDay-Win64-Shipping", "Steam 1.00")
{
    byte Loads: 0x536AD00, 0x354;
    byte ChapterSelect: 0x5343740, 0x1B0, 0xA0, 0xB88, 0x870, 0x230;
    byte StartRun: 0x539F6C8, 0x198, 0x50, 0x68, 0x48, 0x48, 0x48, 0xA4;
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
                case "3FBCBD44408A03DCB0032A0C665F30E5":
                    version = "Steam 1.00";
                    break;

                default:
                    version = "Unknown";
                    break;
            }
}

startup
{
    settings.Add("CHSTART", false, "Select if running All Chapters");
    settings.Add("RUNSTART", false, "Select if running a Single Chapter");
}

isLoading
{
	return current.Loads != 0;
}

start
{
    if(settings["CHSTART"])
    {
        return current.ChapterSelect == 1 && old.ChapterSelect == 0 || current.StartRun == 5 && old.StartRun == 7;
    } 
    else if (settings["RUNSTART"])
    {
        return current.StartRun == 5 && old.StartRun == 7;
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
