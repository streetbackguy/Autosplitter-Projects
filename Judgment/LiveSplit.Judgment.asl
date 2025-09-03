state("Judgment") 
{
    int Loads: 0x0240A528, 0x160, 0x88, 0x218, 0x74;
    int Autostart: 0x23F49F0;
}

startup
{   
    settings.Add("JUDGE", true, "Lost Judgment");
        settings.Add("a01_070.par", false, "Prologue", "JUDGE");
        settings.Add("c02_chapter_sequence.par", false, "Chapter 01: Three Blind mice", "JUDGE");
        settings.Add("c03_chapter_sequence.par", false, "Chapter 02: Beneath the Surface", "JUDGE");
        settings.Add("c04_chapter_sequence.par", false, "Chapter 03: The Stick-Up", "JUDGE");
        settings.Add("c05_chapter_sequence.par", false, "Chapter 04: Skeletons in the Closet", "JUDGE");
        settings.Add("c06_chapter_sequence.par", false, "Chapter 05: Days Gone By", "JUDGE");
        settings.Add("c07_chapter_sequence.par", false, "Chapter 06: Collusion", "JUDGE");
        settings.Add("c08_chapter_sequence.par", false, "Chapter 07: The Limelight", "JUDGE");
        settings.Add("c09_chapter_sequence.par", false, "Chapter 08: A Broken Bond", "JUDGE");
        settings.Add("c10_chapter_sequence.par", false, "Chapter 09: The Miracle Drug", "JUDGE");
        settings.Add("c11_chapter_sequence.par", false, "Chapter 10: Chumming the Water", "JUDGE");
        settings.Add("c12_chapter_sequence.par", false, "Chapter 11: Curtain Call", "JUDGE");
        settings.Add("c13_chapter_sequence.par", false, "Chapter 12: Behind Closed Doors", "JUDGE");
        settings.Add("end", false, "Final Chapter: Down Came the Rain", "JUDGE");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Judgment",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

isLoading
{
    return current.Loads != 0;
}

start
{
    return current.Autostart == 231 && old.Autostart == 243;
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    timer.IsGameTimePaused = true;
}