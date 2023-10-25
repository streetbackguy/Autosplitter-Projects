state("Monke-Win64-Shipping")
{
    int Loads: 0x6E6B478;
    int MainMenu: 0x6D796E0;
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
    return old.Loads == 1 && current.Loads == 50;
}

reset
{
    return current.Loads == 1 && current.MainMenu == 2;
}

exit
{
    timer.IsGameTimePaused = true;
}
