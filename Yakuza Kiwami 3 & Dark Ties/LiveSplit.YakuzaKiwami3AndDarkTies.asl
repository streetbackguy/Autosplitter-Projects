state("yakuzakiwami3", "Steam 1.13")
{
    int GameStart: 0x39B7E60, 0xC0, 0x58, 0x20, 0xAC;
    int Fades: 0x399F418, 0x224;
    bool LoadingScreens: 0x399F418, 0x1C8, 0xD48, 0xC4;
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
            case "6DC3F3059DEF92D20D84066BDCD369AC":
                version = "Steam 1.13";
                break;

            default:
                version = "Unknown";
                break;
        }
}

start
{
    return current.GameStart == 1 && old.GameStart == 0;
}

isLoading
{
    return current.LoadingScreens || current.Fades != 0;
}

exit
{
    timer.IsGameTimePaused = true;
}
