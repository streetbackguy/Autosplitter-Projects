state("LostJudgment", "Steam") 
{
    byte Loads: 0x4322CE0, 0x310, 0x544;
    byte Autostart: 0x151D3DA2;
    string255 Chapter: 0x03F12E30, 0x1A8, 0x60, 0x4D0, 0xE2C;
}

init 
{
    vars.Splits = new HashSet<string>();

    switch(modules.First().ModuleMemorySize) 
    {
        case 77086720:
            version = "Steam 1.0";
            break;

        case 472219648:
            version = "Steam 1.11";
            break;
    }
}

startup
{   
    settings.Add("LJ", true, "Lost Judgment");
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
        settings.Add("13", false, "Final Chapter: Darkest Before the Dawn", "LJ");
    settings.Add("KF", true, "The Kaito Files");
        settings.Add("dlc\\c02_chapter_sequence_dlc.par", false, "Chapter 01: What Goes Around", "KF");
        settings.Add("dlc\\c03_chapter_sequence_dlc.par", false, "Chapter 02: Like Father, Like Son", "KF");
        settings.Add("dlc\\c04_chapter_sequence_dlc.par", false, "Chapter 03: Out for Blood", "KF");
        settings.Add("4", false, "Chapter 04: Cat & Mouse", "KF");

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
    print(modules.First().ModuleMemorySize.ToString());
}

isLoading 
{
    return current.Loads == 1;
}

//Autostarts after the checkpoint information prompt
start
{
    return current.Autostart != old.Autostart;
}

split
{
    if (current.Chapter != old.Chapter && (!vars.Splits.Contains(current.Chapter)))
    {
        vars.Splits.Add(current.Chapter);
        return settings[current.Chapter];
    }
}

onReset
{
    vars.Splits.Clear();
}

onStart
{
    timer.IsGameTimePaused = true;
}
