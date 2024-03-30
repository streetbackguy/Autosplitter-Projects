state("SnowDay-Win64-Shipping", "Steam 1.00")
{
    byte Loads: 0x536AD00, 0x354;
    //uint StartRun: 0x514F210, 0x78, 0x218, 0x228, 0xF6C;
    uint ChapterVictory: 0x52D38B8, 0x10, 0x8, 0x588;
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
    settings.Add("SNOWDAY", true, "South Park: Snow Day!");
        settings.Add("CHVICTORY", true, "Split on each Chapter Victory screen", "SNOWDAY");

    vars.Sw = new Stopwatch();
}

isLoading
{
	return current.Loads != 0;
}

start
{
    //return current.StartRun != old.StartRun && old.Loads != 0;
}

split
{
    if(current.ChapterVictory == 192 && old.ChapterVictory == 1920)
    {
        vars.Sw.Start();
    }

    if (vars.Sw.ElapsedMilliseconds >= 60000)
    {
        vars.Sw.Reset();
        return settings["CHVICTORY"];
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
