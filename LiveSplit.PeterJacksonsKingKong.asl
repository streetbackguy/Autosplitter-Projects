state("KingKong8", "DirectX 8.1")
{
    string255 LevelName: 0x6A6531;
    byte Loads: 0x1695178;
}

state("KingKong9", "DirectX 9")
{
    byte Loads: 0x1702158;
    string255 LevelName: 0x70E4B1;
}

init
{
    vars.Splits = new HashSet<string>();

    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
    {
        case "CBAEB5A2770A21E22F612BAB1FC04964": version = "DirectX 9"; break;
        case "95F233C848E175718FEEF5FCFEC1B7B9": version = "DirectX 8.1"; break;

        default: version = "Unknown"; break;

    }
}

startup
{
    settings.Add("PJKK", true, "Peter Jackson's King Kong");
        settings.Add("LS", true, "Level Splits", "PJKK");
            settings.Add("1A_Venture", true, "The Venture", "LS");
            settings.Add("1B_Skull_Island", true, "Skull Island", "LS");
            settings.Add("2A_Tombs", true, "Necropolis", "LS");
            settings.Add("2C_Ann_s_capture_Part_1", true, "Scorpions", "LS");
            settings.Add("2C_Ann_s_capture_Part_2", true, "The Wall", "LS");
            settings.Add("3A_Escape_from_natives", true, "Sacrifice", "LS");
            settings.Add("3B_On_Kongs_Tracks", true, "On Kong's Tracks", "LS");
            settings.Add("3C_Hayes_is_back", true, "Hayes", "LS");
            settings.Add("3E_Chased_by_The_Trex", true, "The Venture", "LS");
            settings.Add("3F_Ann_first_escape", true, "Ann", "LS");
            settings.Add("3D_Kong_On_His_Killing_Ground", true, "Kong", "LS");
            settings.Add("4A_Brontosaurs", true, "The Canyon", "LS");
            settings.Add("4A_Brontosaurs_part1", true, "Millipedes", "LS");
            settings.Add("4A_Brontosaurs_part2", true, "Brontosaurus", "LS");
            settings.Add("4B_To_the_raft", true, "Jimmy", "LS");
            settings.Add("5A_On_the_raft_Part_1", true, "On the Raft", "LS");
            settings.Add("5A_On_the_Raft_Part_2", true, "Rapids", "LS");
            settings.Add("5C_Kong_vs_first_Trex", true, "Fight", "LS");
            settings.Add("7B_Protection_Swamps", true, "Swamps", "LS");
            settings.Add("7D_Kong_Saves_Ann", true, "Chased by V-Rex", "LS");
            settings.Add("B_Pit", true, "The Log", "LS");
            settings.Add("0B_3_T-rex", true, "The Skull Islanders", "LS");
            settings.Add("1A_Ann_alone", true, "To Save Ann", "LS");
            settings.Add("2A_In_the_Temple", true, "The Cave", "LS");
            settings.Add("2B_Blocked", true, "Venatosaurus", "LS");
            settings.Add("7B_Protection_Swamps_Part_2", true, "In the Mud", "LS");
            settings.Add("4A_Call_Kong", true, "Call Kong", "LS");
            settings.Add("4B", true, "Kong to the Rescue", "LS");
            settings.Add("5A_Follow_The_Plane", true, "To the Plane", "LS");
            settings.Add("7A_Jack_Gets_To_The_Lair", true, "To the Lair", "LS");
            settings.Add("7A_Jack_Gets_To_The_Lair_Bis", true, "Kong's Lair", "LS");
            settings.Add("7C_Fight_in_the_lair", true, "Fight in the Lair", "LS");
            settings.Add("8A_Down_from_the_lair", true, "Free!", "LS");
            settings.Add("3C_Hayes_is_back_retour", true, "Chased by Kong", "LS");
            settings.Add("3B_On_Kongs_Tracks_retour", true, "Heading Back", "LS");
            settings.Add("3A_Escape_from_natives_retour", true, "Back to the Village", "LS");
            settings.Add("9A_Kong_in_the_village", true, "Kongs Capture", "LS");
            settings.Add("9B_Kong_is_inconscious", true, "Kong Struck Down", "LS");
            settings.Add("0A_NY_theater", true, "In the Streets of New York", "LS");
            settings.Add("0C_Plane_In_New-York", true, "The Empire State Building", "LS");
            settings.Add("0A_New_York_Kongs_death", true, "Kong's Death", "LS");
}

start
{
    return old.LevelName == "main_menu" && current.LevelName != "main_menu";
}

update
{
    if(current.LevelName != old.LevelName)
    {
        print("Old Level: " + old.LevelName + " Current Level: " + current.LevelName);
    }
}

split
{
    if(current.LevelName != old.LevelName && !vars.Splits.Contains(old.LevelName))
    {
        vars.Splits.Add(old.LevelName);
        return settings[old.LevelName];
    }
}

isLoading
{
    return current.Loads == 1;
}
