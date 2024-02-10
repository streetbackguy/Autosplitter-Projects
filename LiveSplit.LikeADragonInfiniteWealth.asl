// Original Load Remover by Streetbackguy

state("LikeADragon8", "Steam 1.14")
{
    bool LoadingScreen: 0x38C96E0;
    bool Transitions: 0x38DF980, 0x80, 0x90, 0x104;
    uint LoadHelper: 0x316E134;
    uint Starter: 0xB6465B0;
}

state("LikeADragon8", "Steam 1.15")
{
    uint LoadingScreen: 0x38E09D0, 0x30, 0x0, 0x18, 0x24;
    bool Transitions: 0x38E09C0, 0x50, 0x50, 0x104;
    uint Starter: 0x38E09C0, 0x50, 0x50, 0xF4;
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
                case "04B58254F97E508F43F7BFDD82807981":
                    version = "Steam 1.14";
                    break;

                case "B2B098E1ACF9906278A251159E3160D0":
                    version = "Steam 1.15";
                    break;

                default:
                    version = "Unknown";
                    break;
            }
}

startup
{   
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Like a Dragon: Infinite Wealth",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

    //settings.Add("LADIF", true, "Like a Dragon: Infinite Wealth");

    //settings.Add("Chapters", true, "End of Chapter Splits", "LADIF");
        //settings.Add("title_01", true, "Chapter 1: Doin' the Best I Can", "Chapters");
        //settings.Add("title_02", true, "Chapter 2: Paradise, Hawaiian Style", "Chapters");
        //settings.Add("title_03", true, "Chapter 3: The Fool", "Chapters");
        //settings.Add("title_04", true, "Chapter 4: In the Ghetto", "Chapters");
        //settings.Add("title_05", true, "Chapter 5: Suspicious Minds", "Chapters");
        //settings.Add("title_06", true, "Chapter 6: Puppet on a String", "Chapters");
        //settings.Add("title_07", true, "Chapter 7: Trouble", "Chapters");
        //settings.Add("title_08", true, "Chapter 8: Return to Sender", "Chapters");
        //settings.Add("title_09", true, "Chapter 9: Hard Headed Woman", "Chapters");
        //settings.Add("title_10", true, "Chapter 10: Don't Be Cruel", "Chapters");
        //settings.Add("title_11", true, "Chapter 11: Devil in Disguise", "Chapters");
        //settings.Add("title_12", true, "Chapter 12: For Ol' Times Sake", "Chapters");
        //settings.Add("title_13", true, "Chapter 13: Promised Land", "Chapters");
        //settings.Add("title_14", true, "Final Chapter: If I Can Dream", "Chapters");
}

isLoading
{
    //1.14
    //return current.LoadingScreen && current.LoadHelper == 0 || current.LoadHelper == 0 && current.Transitions

    return current.LoadingScreen == 1065353216 && current.Transitions;
}

start
{
    //1.14
    //return current.Starter == 33024 && old.Starter == 32768 && current.Transitions;

    return current.Starter == 1 && old.Starter == 0;
}

exit
{
    timer.IsGameTimePaused = true;
}
