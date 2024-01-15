// Original Load Remover and Autosplitter by Streetbackguy
// Improvements on Memory Addresses and Load Refinement by PlayingLikeAss (aposteriorist)


state("likeadragongaiden", "Steam 1.21")
{
    long FileTimer: 0x3826D28, 0x358;
    long KiryuHP:   0x3826D28, 0x3A8;
    long Money:     0x3826D28, 0x420, 0x8;
    short Plot:     0x3826D28, 0x730;
    int HActAdj:    0x383CBC0, 0xC0, 0x8, 0x18, 0x2B4;
    string60 Magic: 0x383CBC0, 0xC0, 0x8, 0x18, 0x7F2;
    bool Loads:     0x383E740, 0xC0, 0x10, 0x35C;
    bool Starter:   0x383E740, 0xC0, 0x10, 0x554;
    bool Pause:     0x383E740, 0xC0, 0x10, 0x574;
    bool Abbott:    0x383E740, 0xC0, 0x10, 0x684;
    bool Costello:  0x383E740, 0xC0, 0x10, 0x6C4;
}

state("likeadragongaiden", "Steam 1.20") 
{
    long FileTimer: 0x3826D18, 0x358;
    long KiryuHP:   0x3826D18, 0x3A8;
    long Money:     0x3826D18, 0x420, 0x8;
    short Plot:     0x3826D18, 0x730;
    int HActAdj:    0x383CBC0, 0xC0, 0x8, 0x18, 0x2B4;
    string60 Magic: 0x383CBC0, 0xC0, 0x8, 0x18, 0x7F2;
    bool Loads:     0x383E740, 0xC0, 0x10, 0x35C;
    bool Starter:   0x383E740, 0xC0, 0x10, 0x554;
    bool Pause:     0x383E740, 0xC0, 0x10, 0x574;
    bool Abbott:    0x383E740, 0xC0, 0x10, 0x684;
    bool Costello:  0x383E740, 0xC0, 0x10, 0x6C4;
}

state("likeadragongaiden", "Steam 1.12") 
{
    long FileTimer: 0x3826D10, 0x358;
    long KiryuHP:   0x3826D10, 0x3A8;
    long Money:     0x3826D10, 0x420, 0x8;
    short Plot:     0x3826D10, 0x730;
    int HActAdj:    0x383CBC0, 0xC0, 0x8, 0x18, 0x2B4;
    string60 Magic: 0x383CBC0, 0xC0, 0x8, 0x18, 0x7F2;
    bool Loads:     0x383E740, 0xC0, 0x10, 0x35C;
    bool Starter:   0x383E740, 0xC0, 0x10, 0x554;
    bool Pause:     0x383E740, 0xC0, 0x10, 0x574;
    bool Abbott:    0x383E740, 0xC0, 0x10, 0x684;
    bool Costello:  0x383E740, 0xC0, 0x10, 0x6C4;
}

state("likeadragongaiden", "Steam 1.10") // To-Do
{
    long FileTimer: 0x3823CA8, 0x358;
    long Money:     0x3823CA8, 0x420, 0x8;
    short Plot:     0x3823CA8, 0x730;
    bool Loads:     0x383B6C0, 0xC0, 0x10, 0x35C;
    bool Starter:   0x383B6C0, 0xC0, 0x10, 0x554;
    bool Pause:     0x383B6C0, 0xC0, 0x10, 0x574;
}

state("likeadragongaiden", "M Store 1.20 - 1.21")
{
    long FileTimer: 0x2DAB0D0, 0x358;
    long KiryuHP:   0x2DAB0D0, 0x3A8;
    long Money:     0x2DAB0D0, 0x420, 0x8;
    short Plot:     0x2DAB0D0, 0x730;
    int HActAdj:    0x2DD8C40, 0xC0, 0x8, 0x18, 0x2B4;
    string60 Magic: 0x2DD8C40, 0xC0, 0x8, 0x18, 0x7F2;
    bool Loads:     0x2DDA7C0, 0xC0, 0x10, 0x35C;
    bool Starter:   0x2DDA7C0, 0xC0, 0x10, 0x554;
    bool Pause:     0x2DDA7C0, 0xC0, 0x10, 0x574;
    bool Abbott:    0x2DDA7C0, 0xC0, 0x10, 0x684;
    bool Costello:  0x2DDA7C0, 0xC0, 0x10, 0x6C4;
}

init 
{
    // Needs to be explicitly set for things to function appropriately
    refreshRate = 60;

    // Pointer table offset for the QTE (to be set below in the switch)
    vars.Cucco = 0;

    // QTE variables to be used for the final boss split
    vars.QTE = null;
    vars.FinalQTE = false;

    // Start / load variables
    vars.StartPrompt = false;
    vars.IsLoading = false;
    vars.LoadCount = 0;
    vars.Leash = false;

    // Split tracker (using numbers this time around)
    vars.Splits = new List<int>();

    // Event list indices (fights adjusted to catch the event AFTER the fight)
    // Corresponding filenames have "aston_" removed from the beginning
    vars.PlotPoints = new Dictionary<short, string>() {
        {75, "btl01_0100"}, {78, "title_01"}, {84, "btl01_0200"}, {86, "btl01_0300"}, {91, "btl01_0400"},
        {93, "btl01_0500"}, {98, "btl01_0600"}, {103, "btl01_0800"}, {108, "btl01_1000"}, {113, "c01_1900"},
        {115, "btl01_1100"}, {119, "btl01_1300"}, {122, "title_02"}, {130, "btl02_0100"}, {138, "btl02_0200"},
        {142, "btl02_0300"}, {1146, "FEET OF KSON"}, {145, "c02_1500"}, {149, "t02_0200"}, {152, "btl02_0400"},
        {154, "btl02_0500"}, {156, "btl02_0600"}, {165, "c02_2400"}, {166, "btl02_0700"}, {168, "btl02_0800"},
        {176, "btl02_0900"}, {178, "title_03"}, {186, "c03_0500"}, {193, "btl03_0100"}, {195, "btl03_0150"},
        {197, "btl03_0200"}, {199, "title_04"}, {212, "c04_0800"}, {217, "btl04_0200"}, {222, "btl04_0300"},
        {709, "DAN BRODY"}, {234, "btl04_0400"}, {238, "WAREHOUSE"}, {239, "btl04_0500"}, {241, "btl04_0600"},
        {244, "title_05"}, {254, "t05_0200"}, {259, "btl05_0100"}, {267, "btl05_0200"}, {270, "btl05_0300"}, {272, "END"}
    };

    // Note to maintainers: I'm keeping memory module sizes in comments in case they're needed down the line.
    // Microsoft Store games don't like File.Open, hence the try-catch.
    print(modules.First().ModuleMemorySize.ToString());
    if (modules.First().ModuleMemorySize > 350000000)
    {
        string MD5Hash;
        using (var md5 = System.Security.Cryptography.MD5.Create())
        try {
            using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
            print("Hash is: " + MD5Hash);

            switch (MD5Hash)
            {
                case "50EF74E7E7F287CE08ACF5B89D51DBF1": // Memory size: 426950656 
                    version = "Steam 1.21";
                    vars.Cucco = 0x382A740;
                    break;

                case "E6031417A5A3B7819DDCD26359860AB0": // Memory size: 439140352
                    version = "Steam 1.20";
                    vars.Cucco = 0x382A740;
                    break;

                case "27B67CD71627BF7096823BDF038B7AD1":
                    version = "Steam 1.12";
                    vars.Cucco = 0x382A740;
                    break;

                case "859CDDBEC2B6F5B890CD4A96BBCFCFCC":
                    version = "Steam 1.10";
                    vars.Cucco = 0x382A740; // TO-DO
                    break;

                default:
                    MessageBox.Show("ASL won't work for the moment. Send PLA this: " + MD5Hash);
                    version = "Unknown";
                    vars.Cucco = 0;
                    break;
            }
        }
        catch (UnauthorizedAccessException) // This shouldn't ever hit.
        {
            MessageBox.Show(String.Format("Unexpected exception!\nSend PLA a screenshot or this number: {0}", modules.First().ModuleMemorySize));
            version = "M Store 1.20 - 1.21";
            vars.Cucco = 0x2DC6760;
        }
    }

    else
    {
        version = "M Store 1.20 - 1.21"; // Memory sizes: 337735680, 337424384
        vars.Cucco = 0x2DC6760;
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
            "LiveSplit | Like a Dragon Gaiden: The Man Who Erased His Name",
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

    settings.Add("FIGHTS", false, "Fight Splits", "LADG");
        settings.Add("btl01_0100", false, "Ch.1: Osamu-kun and Friends", "FIGHTS");
        settings.Add("btl01_0200", false, "Ch.1: Agent Jo-an", "FIGHTS");
        settings.Add("btl01_0300", false, "Ch.1: Agent Jo-an and Friends", "FIGHTS");
        settings.Add("btl01_0400", false, "Ch.1: Mysterious Men", "FIGHTS");
        settings.Add("btl01_0500", false, "Ch.1: More Mysterious Men", "FIGHTS");
        settings.Add("btl01_0600", false, "Ch.1: Rooftop Rumble", "FIGHTS");
        settings.Add("btl01_0800", false, "Ch.1: Man in a Suit", "FIGHTS");
        settings.Add("btl01_1000", false, "Ch.1: Man in a Hannya Mask", "FIGHTS");
        settings.Add("btl01_1100", false, "Ch.1: Four Agents, One Room", "FIGHTS");
        settings.Add("btl01_1300", false, "Ch.1: Yoshimura and Friends", "FIGHTS");
        settings.Add("btl02_0100", false, "Ch.2: Parking Loiterers", "FIGHTS");
        settings.Add("btl02_0200", false, "Ch.2: Riverside Rumpus", "FIGHTS");
        settings.Add("btl02_0300", false, "Ch.2: Welfare Thieves", "FIGHTS");
        settings.Add("btl02_0400", false, "Ch.2: Masaru Watase-ish Man", "FIGHTS");
        settings.Add("btl02_0500", false, "Ch.2: Kazuma Kiryu-esque Man", "FIGHTS");
        settings.Add("btl02_0600", false, "Ch.2: Ryuji Goda?", "FIGHTS");
        settings.Add("c02_2400", false, "Ch.2: Namiki No. 3 Lobby", "FIGHTS");
        settings.Add("btl02_0800", false, "Ch.2: Yuki Tsuruno and Friends", "FIGHTS");
        settings.Add("btl02_0900", false, "Ch.2: Daidoji Hideout", "FIGHTS");
        settings.Add("btl03_0100", false, "Ch.3: Pool Party", "FIGHTS");
        settings.Add("btl03_0200", false, "Ch.3: Nishitani", "FIGHTS");
        settings.Add("btl04_0200", false, "Ch.4: Cabaret Grand", "FIGHTS");
        settings.Add("btl04_0300", false, "Ch.4: Castle Crashers", "FIGHTS");
        settings.Add("DAN BRODY", false, "Ch.4: The Four Kings of the Coliseum", "FIGHTS");
        settings.Add("btl04_0400", false, "Ch.4: Golf Center Gang", "FIGHTS");
        settings.Add("WAREHOUSE", false, "Ch.4: Outside the Warehouse", "FIGHTS");
        settings.Add("btl04_0600", false, "Ch.4: Nishitani", "FIGHTS");
        settings.Add("btl05_0100", false, "Ch.5: Shishitani and Friends", "FIGHTS");
        settings.Add("btl05_0200", false, "Ch.5: Breakup Brouhaha", "FIGHTS");
        settings.Add("btl05_0300", false, "Ch.5: Shirts v. Skins", "FIGHTS");
        settings.Add("END", false, "Ch.5: Final Boss", "FIGHTS");

    settings.Add("SETPIECES", false, "Setpiece Splits (before boss)", "LADG");
        settings.Add("btl01_1200", false, "Ch.1: Daidoji Temple", "SETPIECES");
        settings.Add("btl02_0700", false, "Ch.2: Namiki No. 3", "SETPIECES");
        settings.Add("btl03_0150", false, "Ch.3: The Castle", "SETPIECES");
        settings.Add("btl04_0500", false, "Ch.4: The Warehouse", "SETPIECES");

    settings.Add("EVENTS", false, "Event Splits", "LADG");
        settings.Add("c01_1900", false, "Ch.1: Leaving Ijincho", "EVENTS");
        settings.Add("FEET OF KSON", false, "Ch.2: Emergency Request!", "EVENTS");
        settings.Add("c02_1500", false, "Ch.2: Go to the Castle", "EVENTS");
        settings.Add("t02_0200", false, "Ch.2: Tuxedo Mask", "EVENTS");
        settings.Add("c03_0500", false, "Ch.3: Akame's Drink Link", "EVENTS");
        settings.Add("c04_0800", false, "Ch.4: A Night of Debauchery", "EVENTS");
        settings.Add("t05_0200", false, "Ch.4: Begin the Finale", "EVENTS");
}

isLoading 
{
    return vars.IsLoading;
}

update
{
    // If we're at the final boss fight, reset the QTE variables every time there's a new HAct.
    if (current.Plot == 271 && current.HActAdj != old.HActAdj)
    {
        vars.QTE = null;
        vars.FinalQTE = current.Magic == "ab2290_ssd_last"; // Filename of final QTE
    }

    // We have to stop complex loads from falsely triggering in certain corner cases.
    if (vars.Leash || current.Magic == "tougi_main_menu"
    || current.FileTimer != old.FileTimer && vars.IsLoading && (current.Magic == "at4060_win" || current.Magic == "at4070_fellow_win"))
    {
        vars.Leash = true;
        vars.IsLoading = vars.LoadCount > 0;
        vars.LoadCount = 0;
    }
    else vars.Leash = false;

    // Check if the game is loading. It's either a simple load or a complex load.
    if (current.Loads || current.FileTimer == old.FileTimer && !current.Pause && current.KiryuHP != 0
    && !vars.Leash && (current.Starter || !current.Abbott && current.Costello))
    {
        vars.LoadCount++;
        vars.IsLoading = true;
    }

    else if (vars.LoadCount > 0)
    {
        vars.LoadCount = 0;
        vars.IsLoading = true;
    }

    else vars.IsLoading = false;
}

start
{
    vars.StartPrompt |= current.Plot == 0 && current.Money == 103968 && old.Money == 0;
    return vars.StartPrompt && current.Starter;
}

onStart
{
    vars.QTE = null;
    vars.FinalQTE = false;
    vars.StartPrompt = false;
    vars.IsLoading = false;
    vars.LoadCount = 0;
    vars.Leash = false;
    vars.Splits.Clear();
}

split
{
    // Split for event indices.
    if (old.Plot != current.Plot && vars.PlotPoints.ContainsKey(current.Plot) && !vars.Splits.Contains(current.Plot))
    {
        vars.Splits.Add(current.Plot);
        return settings[vars.PlotPoints[current.Plot]];
    }

    // Split on the final QTE against the final boss.
    else if (vars.FinalQTE && !vars.Splits.Contains(271))
    {
        // As of 1.21, the QTE code we're mimicking is located (using .exe offsets) at:
        //  Steam:      Success +0x25E1CED, Failure +0x25E1D82
        //  M Store:    Success +0x1E69F8C, Failure +0x1E69FAC
        // Look upwards from there to see the related logic and offsets.
        
        if (vars.QTE == null)
        {
            if (current.HActAdj > 0)
            {
                // 0x70 for success, 0x74 for failure. We'll use a long to check both ints.
                vars.QTE = new DeepPointer(vars.Cucco + ((current.HActAdj & 0xFFFFF) << 5), 0x70);
            }
            else return false;
        }

        long result = vars.QTE.Deref<long>(game);

        if (result == 1)
        {
            vars.QTE = null;
            vars.FinalQTE = false;
            vars.Splits.Add(271);
            return settings["END"];
        }

        else if (result == 0x100000000)
        {
            vars.QTE = null;
            vars.FinalQTE = false;
            return false;
        }
    }
}

reset
{
    // Reset when returning to the title screen.
    return current.Plot == 0 && old.Plot > 0;
}

onReset
{
    vars.QTE = null;
    vars.FinalQTE = false;
    vars.StartPrompt = false;
    vars.IsLoading = false;
    vars.LoadCount = 0;
    vars.Leash = false;
    vars.Splits.Clear();
}

exit
{
    vars.QTE = null;
    vars.FinalQTE = false;
    vars.StartPrompt = false;
    vars.IsLoading = false;
    vars.LoadCount = 0;
    vars.Leash = false;
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
}
