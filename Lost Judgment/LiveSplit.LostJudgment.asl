state("LostJudgment", "Steam 1.11") 
{
    bool Loads: 0x4322CE0, 0x310, 0x544;
    bool CutsceneLoads: 0x5313844;
    bool Crafting: 0x5340E84;
    int Autostart: 0x041F0D88, 0x8, 0x6F8, 0x170, 0x58, 0x0, 0xA2C;
    int QTE: 0x041F0D88, 0x8, 0xF68, 0xA8, 0x8;
    int QTE2: 0x03EFD538, 0x148, 0x460, 0x2B8, 0x58, 0x94;
    int BossHealth: 0x03B6ABB8, 0x110, 0x48, 0x0, 0x8, 0x10, 0x180;
    string255 Chapter: 0x03F12E30, 0x1A8, 0x60, 0x4D0, 0xDD0;
}

state("LostJudgment", "Steam 1.12") 
{
    bool Loads: 0x4322CE0, 0x310, 0x544;
    bool CutsceneLoads: 0x5313844;
    bool Crafting: 0x5340E84;
    int Autostart: 0x041F0D88, 0x8, 0x6F8, 0x170, 0x58, 0x0, 0xA2C;
    int QTE: 0x041F0D88, 0x8, 0xF68, 0xA8, 0x8;
    int QTE2: 0x03EFD538, 0x148, 0x460, 0x2B8, 0x58, 0x94;
    int BossHealth: 0x03B6ABB8, 0x110, 0x48, 0x0, 0x8, 0x10, 0x180;
    int HActAdj: 0x4322F20, 0x218, 0x50, 0xD0, 0x18, 0x170, 0x190, 0x2B4;
    string60 Magic: 0x4322F20, 0x218, 0x50, 0xD0, 0x18, 0x170, 0x190, 0x7E2;
    string255 Chapter: 0x03F12E30, 0x1A8, 0x60, 0x4D0, 0xDD0;
}

init 
{
    print(modules.First().ModuleMemorySize.ToString());

    vars.Splits = new HashSet<string>();
    vars.QTEs = 0;

    vars.Edco = 0;
    vars.QTE = null;
    vars.QTECount = 0;
    vars.QTESuccess = false;
    vars.FinalQTE = false;

    switch(modules.First().ModuleMemorySize) 
    {
        case 77086720:
            version = "Steam 1.0";
            break;

        case 472219648:
            version = "Steam 1.11";
            break;

        case 451444736: 
            version = "Steam 1.12";
            vars.Edco = 0x43206E0;
            break;
    }
}

startup
{   
    settings.Add("LJ", true, "Lost Judgment");
        settings.Add("ia\\data\\auth\\a01_070.par", false, "Prologue", "LJ");
        settings.Add("c02_chapter_sequence.par", false, "Chapter 01: Black Sheep", "LJ");
        settings.Add("c03_chapter_sequence.par", false, "Chapter 02: Vicious Cycle", "LJ");
        settings.Add("c04_chapter_sequence.par", false, "Chapter 03: Two Sides of the Same Coin", "LJ");
        settings.Add("c05_chapter_sequence.par", false, "Chapter 04: Red Knife", "LJ");
        settings.Add("c06_chapter_sequence.par", false, "Chapter 05: Double Jeopardy", "LJ");
        settings.Add("c07_chapter_sequence.par", false, "Chapter 06: Converging Heat", "LJ");
        settings.Add("c08_chapter_sequence.par", false, "Chapter 07: Blindsided", "LJ");
        settings.Add("c09_chapter_sequence.par", false, "Chapter 08: Phantom of Ijincho", "LJ");
        settings.Add("c10_chapter_sequence.par", false, "Chapter 09: The Weight of Guilt", "LJ");
        settings.Add("c11_chapter_sequence.par", false, "Chapter 10: Catch a Tiger", "LJ");
        settings.Add("c12_chapter_sequence.par", false, "Chapter 11: Undercover", "LJ");
        settings.Add("c13_chapter_sequence.par", false, "Chapter 12: To Nourish a Viper", "LJ");
        settings.Add("end", false, "Final Chapter: Darkest Before the Dawn", "LJ");
    settings.Add("KF", true, "The Kaito Files");
        settings.Add("th_dlc\\dlc_p02_00100.par", false, "Chapter 01: What Goes Around", "KF");
        settings.Add("th_dlc\\dlc_p03_00100.par", false, "Chapter 02: Like Father, Like Son", "KF");
        settings.Add("th_dlc\\dlc_p04_00100.par", false, "Chapter 03: Out for Blood", "KF");
        settings.Add("dlcend", false, "Chapter 04: Cat & Mouse", "KF");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Lost Judgment",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
    if (current.Magic == "jh80710_dlc_shi_hit" && current.Magic != old.Magic)
    {
        vars.QTE = null;
        vars.QTECount = 0;
        vars.QTESuccess = false;
        vars.FinalQTE = true;
    }
}

isLoading 
{
    return current.Loads && !current.Crafting || current.CutsceneLoads;
}

//Autostarts after the autosave information prompt
start
{
    return current.Autostart == 1 && old.Autostart != 1;
}

split
{
    //Splits after each end of chapter save screen, on the story summary
    if (current.Chapter != old.Chapter && (!vars.Splits.Contains(current.Chapter)))
    {
        vars.Splits.Add(current.Chapter);
        return settings[current.Chapter.Substring(current.Chapter.Length - 24)];
    }

    //Splits on the final Kuwana QTE
    if (current.Chapter.EndsWith("\\jh80670_c13_kwn_last.par") && current.QTE2 == 0 && old.QTE2 > 0 && !vars.Splits.Contains("end"))
    {
        vars.Splits.Add("end");
        return settings["end"];
    }

    //Splits on the final Shirakaba QTE
    //if (current.Chapter.EndsWith("\\jh80710_dlc_shi_hit.par") && vars.QTEs > 3 && !vars.Splits.Contains("dlcend"))
    //{
        //vars.Splits.Add("dlcend");
        //return settings["dlcend"];
    //}

    if (vars.FinalQTE && !vars.Splits.Contains("dlcend"))
    {
        if (vars.QTE == null)
        {
            if (current.HActAdj > 0)
            {
                // 0x70 for success, 0x74 for failure. We'll use a long to check both ints.
                vars.QTE = new DeepPointer(vars.Edco + ((current.HActAdj & 0xFFFFF) << 5), 0x70);
            }
            else return false;
        }

        long result = vars.QTE.Deref<long>(game);

        if (result == 1 && !vars.QTESuccess)
        {
            vars.QTECount++;
            vars.QTESuccess = true;

            if (vars.QTECount == 4)
            {
                vars.QTE = null;
                vars.FinalQTE = false;
                vars.Splits.Add("dlcend");
                return settings["dlcend"];
            }
        }

        else if (result == 0x100000000)
        {
            vars.QTE = null;
            vars.QTECount = 0;
            vars.QTESuccess = false;
            vars.FinalQTE = false;
            return false;
        }

        else if (result != 1 && vars.QTESuccess)
        {
            vars.QTESuccess = false;
        }
    }
}

onStart
{
    vars.Splits.Clear();
    vars.QTEs = 0;
    vars.QTE = null;
    vars.QTECount = 0;
    vars.QTESuccess = false;
    vars.FinalQTE = false;
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
    vars.QTEs = 0;
    vars.QTE = null;
    vars.QTECount = 0;
    vars.QTESuccess = false;
    vars.FinalQTE = false;
}