state("Enotria-Win64-Shipping", "Demo 1.0")
{
    int Loads: 0x78F9800;
}

state("Enotria-Win64-Shipping", "Demo 1.1")
{
    int Loads: 0x78FB800;
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
                    version = "Demo 1.0";
                    break;

                case "F1E0E1D8F3A787EB531BABBEB41B1484":
                    version = "Demo 1.1";
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
