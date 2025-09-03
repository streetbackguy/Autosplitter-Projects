state("LikeaDragonIshin-Win64-Shipping", "Steam 1.02") 
{
    int Loads: 0x0625E968, 0x780, 0x6C; 
    int Autostart: 0x6239E78; //Version 1.02
}

state("LikeaDragonIshin-Win64-Shipping", "Steam 1.03") 
{
    int Loads: 0x0625B398, 0x780, 0x6C; 
    int Autostart: 0x625ECD0; //Version 1.03
}

state("LikeaDragonIshin-Win64-Shipping", "Steam 1.04") 
{
    int Loads: 0x0625C0E8, 0x780, 0x6C; 
    int Autostart: 0x625FA20; //Version 1.04
}

state("LikeaDragonIshin-Win64-Shipping", "Steam 1.05") 
{
    int Loads: 0x0625C0E8, 0x780, 0x6C; 
    int Autostart: 0x625FA20; //Version 1.05
}

state("LikeaDragonIshin-Win64-Shipping", "Steam 1.06") 
{
    int Loads: 0x06281028, 0x780, 0x6C;
    int Autostart: 0x6284960; //Version 1.06
}

state("LikeaDragonIshin-Win64-Shipping", "Steam 1.06a") 
{
    int Loads: 0x06282028, 0x780, 0x6C;
    int Autostart: 0x6285960; //Version 1.06a
}


startup
{
    vars.Splits = new HashSet<string>();

    settings.Add("ishin", true, "Like a Dragon: Ishin!");
        settings.Add("2", false, "Chapter 1: New Beginnings", "ishin");
        settings.Add("3", false, "Chapter 2: The Ryudo Encounter", "ishin");
        settings.Add("4", false, "Chapter 3: Power Struggle", "ishin");
        settings.Add("5", false, "Chapter 4: The Man in the Sketch", "ishin");
        settings.Add("6", false, "Chapter 5: The Curtain Rises", "ishin");
        settings.Add("7", false, "Chapter 6: Gameplan", "ishin");
        settings.Add("8", false, "Chapter 7: The Mad Dog", "ishin");
        settings.Add("9", false, "Chapter 8: Conspirators", "ishin");
        settings.Add("10", false, "Chapter 9: The Plot", "ishin");
        settings.Add("11", false, "Chapter 10: Unfinished Business", "ishin");
        settings.Add("12", false, "Chapter 11: Crisis", "ishin");
        settings.Add("RUN OVER", false, "Chapter 12: The End of Ambition", "ishin");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Like a Dragon: Ishin!",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

init
{
    switch(modules.First().ModuleMemorySize) 
    {
        case 341323776:
            version = "Steam 1.02";
            break;

        case 348905472:
            version = "Steam 1.03";
            break;

        case 349364224:
            version = "Steam 1.04";
            break;

        case 331259904:
            version = "Steam 1.06";
            break;

        case 339443712:
            version = "Steam 1.06a";
            break;
    }

    print(modules.First().ModuleMemorySize.ToString());
}

isLoading
{
    return current.Loads == 4;
}

start
{
    return current.Autostart == 1 && old.Autostart == 0;
}

split
{

}

onStart
{
    timer.IsGameTimePaused = true;
}

onReset
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
    vars.Splits.Clear();
}
