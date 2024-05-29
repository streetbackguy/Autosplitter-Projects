state("Enotria-Win64-Shipping", "Demo")
{
    int Loads: 0x78F9800;
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
                case "CE256EFC2F488901879B1F097968C01A":
                    version = "Demo";
                    break;

                default:
                    version = "Unknown";
                    break;
            }

}

isLoading
{
    return current.Loads == 50;
}