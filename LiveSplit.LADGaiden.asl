state("LikeADragonGaiden", "Steam 1.12") 
{
    long FileTimer: 0x3826D10, 0x358;
    long Money:     0x3826D10, 0x420, 0x8;
    short Plot:     0x3826D10, 0x730;
    int  FinalBoss: 0x3824B50, 0x60;    // To-Do
    bool Loads:     0x383E740, 0xC0, 0x10, 0x35C;
    bool Starter:   0x383E740, 0xC0, 0x10, 0x554;
}

state("LikeADragonGaiden", "Steam 1.10")
{
    long FileTimer: 0x3823CA8, 0x358;
    long Money:     0x3823CA8, 0x420, 0x8;
    short Plot:     0x3823CA8, 0x730;
    int  FinalBoss: 0x3824B50, 0x60;
    bool Loads:     0x383B6C0, 0xC0, 0x10, 0x35C;
    bool Starter:   0x383B6C0, 0xC0, 0x10, 0x554; // Alternate load value
}

state("LikeADragonGaiden", "M Store") 
{
    long FileTimer: 0x3823CA8, 0x358;
    long Money:     0x3823CA8, 0x420, 0x8;
    short Plot:     0x3823CA8, 0x730;
    int  FinalBoss: 0x3824B50, 0x60;
    bool Loads:     0x383B6C0, 0xC0, 0x10, 0x35C;
    bool Starter:   0x383B6C0, 0xC0, 0x10, 0x554;
}

init 
{
    refreshRate = 60;
    vars.StartPrompt = false;

    vars.Splits = new List<int>();

    // Event list indices (fights adjusted by 1 to catch the event AFTER the fight)
    vars.PlotPoints = new Dictionary<short, string>() {
    {75, "btl01_0100"}, {78, "title_01"}, {84, "btl01_0200"}, {86, "btl01_0300"}, {91, "btl01_0400"},
    {93, "btl01_0500"}, {98, "btl01_0600"}, {103, "btl01_0800"}, {108, "btl01_1000"}, {119, "btl01_1300"},
    {122, "title_02"}, {178, "title_03"}, {199, "title_04"}, {244, "title_05"}, {272, "END"}
    };

    vars.QTE = 0;

    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
    {
        case "27B67CD71627BF7096823BDF038B7AD1": version = "Steam 1.12"; break;
        case "859CDDBEC2B6F5B890CD4A96BBCFCFCC": version = "Steam 1.10"; break;
        // case "0": version = "M Store"; break;

        default: version = "Unknown"; break;
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
            "LiveSplit | Like a Dragon: Gaiden",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

    settings.Add("LADG", true, "Like a Dragon: Gaiden");

    settings.Add("CHAPTERS", true, "Chapter Card Splits", "LADG");
        settings.Add("title_01", false, "Chapter 1: Hidden Dragon", "CHAPTERS");
        settings.Add("title_02", true, "Chapter 2: Castle on the Water", "CHAPTERS");
        settings.Add("title_03", true, "Chapter 3: The Man Who Knew Too Much", "CHAPTERS");
        settings.Add("title_04", true, "Chapter 4: The Laughing Man", "CHAPTERS");
        settings.Add("title_05", true, "Final Chapter: The Man Who Erased His Name", "CHAPTERS");

    settings.Add("FIGHTS", true, "Fight Splits", "LADG");
        settings.Add("btl01_0100", false, "C1: Tutorial Fight 1", "FIGHTS");
        settings.Add("btl01_0200", false, "C1: Tutorial Fight 2", "FIGHTS");
        settings.Add("btl01_0300", false, "C1: Tutorial Fight 3", "FIGHTS");
        settings.Add("btl01_0400", false, "C1: Mysterious Men", "FIGHTS");
        settings.Add("btl01_0500", false, "C1: More Mysterious Men", "FIGHTS");
        settings.Add("btl01_0600", false, "C1: Rooftop Rumble", "FIGHTS");
        settings.Add("btl01_0800", false, "C1: Man in a Suit", "FIGHTS");
        settings.Add("btl01_1000", false, "C1: Man in a Hannya Mask", "FIGHTS");
        settings.Add("btl01_1300", false, "C1: Yoshimura", "FIGHTS");
        settings.Add("END", false, "Final Boss", "FIGHTS");
}

isLoading 
{
    return current.Loads;
}

update
{
    // if (old.Plot != current.Plot) print(String.Format("Plot: {0} -> {1}", old.Plot, current.Plot));

    if (version == "Steam 1.10")
    {
        if(current.FinalBoss == 2 && old.FinalBoss == 1)
        {
            vars.QTE++;
        }
    }
}

start
{
    vars.StartPrompt |= current.Money == 103968 && old.Money == 0 && current.FileTimer < old.FileTimer;
    return vars.StartPrompt && current.Starter;
}

onStart
{
    vars.StartPrompt = false;
    vars.QTE = 0;
    vars.Splits.Clear();
}

split
{
    if (old.Plot != current.Plot && vars.PlotPoints.ContainsKey(current.Plot) && !vars.Splits.Contains(current.Plot))
    {
        vars.Splits.Add(current.Plot);
        return settings[vars.PlotPoints[current.Plot]];
    }

    else if (version == "Steam 1.10")
    {
        // Splits after the QTE in the Shishido fight in the Final Chapter
        if (vars.QTE == 3)
        {
            vars.QTE = -1;
            return settings["END"];
        }
    }
}

reset
{
    // Reset when returning to the title screen.
    return current.Plot == 0 && old.Plot > 0;
}

exit
{
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
}
