// Original Load Remover and Autosplitter by Streetbackguy

state("LikeADragon8", "Steam 1.14")
{
    bool LoadingScreen: 0x38C96E0;
    bool Transitions: 0x38DF980, 0x80, 0x90, 0x104;
    uint Starter: 0x38C7FF4;
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
            "LiveSplit | Like a Dragon Gaiden: Infinite Wealth",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

    settings.Add("LADIF", true, "Like a Dragon: Infinite Wealth");

    settings.Add("Chapter", true, "Chapter Card Splits", "LADIF");
        settings.Add("title_01", true, "Chapter 1: Hidden Dragon", "Chapters");
        settings.Add("title_02", true, "Chapter 2: Castle on the Water", "Chapters");
        settings.Add("title_03", true, "Chapter 3: The Man Who Knew Too Much", "Chapters");
        settings.Add("title_04", true, "Chapter 4: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 5: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 6: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 7: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 8: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 9: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 10: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 11: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 12: The Laughing Man", "Chapters");
        settings.Add("title_04", true, "Chapter 13: The Laughing Man", "Chapters");
        settings.Add("title_05", true, "Final Chapter: The Man Who Reclaimed His Name", "Chapters");
}

isLoading
{
    return current.LoadingScreen || current.Transitions;
}

start
{
    return current.Starter == 3232759808 && old.Starter != 3232759808;
}

exit
{
    timer.IsGameTimePaused = true;
}