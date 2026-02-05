state("VIVIDLOPE", "Version 1.4.3 H2")
{
    byte CharacterSelect: 0x32A6287;
    int StageFinish: 0x306AD90, 0x668, 0x618, 0xb8, 0x708, 0x978;
    int LevelFinish: 0x3292688, 0x90, 0x360, 0x278;
    double PercentageFilled: 0x306AC38, 0x10, 0x20, 0x460, 0x8D0;
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
            case "66625C8FD8FE9AB942B15D666EB41ED1":
                version = "Version 1.4.3 H2";
                break;

            default:
                version = "Unknown";
                break;
        }
}

startup
{
    settings.Add("VL", true, "VIVIDLOPE Splits");
        settings.Add("STAGES", true, "Split on Stage Completion", "VL");
        settings.Add("LEVELS", true, "Split on Level Completion", "VL");
}

start
{
    return old.CharacterSelect == 51 && current.CharacterSelect == 50;
}

split
{
    if(current.StageFinish == 1 && old.StageFinish == 0 && settings["STAGES"] || current.PercentageFilled == 100 && old.PercentageFilled == 99 && settings["STAGES"])
    {
        return true;
    }

    if(current.LevelFinish == 1 && old.LevelFinish == 0 && settings["LEVELS"])
    {
        return true;
    }
}
