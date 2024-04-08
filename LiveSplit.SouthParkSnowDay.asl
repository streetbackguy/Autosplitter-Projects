//Big thanks to CactusDuper for help with Unreal Engine stuff
state("SnowDay-Win64-Shipping", "Steam 1.00")
{
    byte Loads: 0x536E630, 0x180, 0x30, 0x210, 0x37C;
    byte ClosingScreen: 0x536E630, 0x120, 0x2C8, 0x4B0, 0xA0, 0x340;
    string10 StorySummary: 0x536E630, 0x120, 0x2C8, 0x4B0, 0xA0, 0x3C0, 0x0;
    uint ChapterVictory: 0x536E630, 0x120, 0x2B0, 0x2C8, 0xA8, 0x8, 0x588;
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
}

isLoading
{
	return current.Loads != 0;
}

start
{
    ///Engine/Transient.QtnEngine:QtnGameInstanceArchetype_C.MenuMapEntry_Widget_C.WidgetTree.Btn_StartRun
    return current.ClosingScreen == 1 && current.StorySummary != "";
}

split
{
    if(current.ChapterVictory != old.ChapterVictory)
    {
        return settings["CHVICTORY"];
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
