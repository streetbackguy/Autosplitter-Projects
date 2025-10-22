// Original Load Removal by big_jim, Updated for Unofficial Patch 11.5 by Streetbackguy
state("Vampire", "Version 1.1")
{
    int isLoading : "client.dll", 0x5F9C28;
}

state("Vampire", "Unofficial Patch 11.5")
{
    int isLoading : "client.dll", 0x5FAD08;
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
            case "9CF3C3DEBCBA81B2FACE6763D536EB15":
                version = "Unofficial Patch 11.5";
                break;
3
            default:
                version = "Version 1.1";
                break;
        }
}

isLoading
{
    return current.isLoading != 0;
}
