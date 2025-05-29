state("kaneandlynch")
{
    bool Starter: 0x888398;
    //byte GameFlag: 0x68C6AE;
    bool Loads: 0x788020;
    //byte Chapters: 0x025468C, 0xE00, 0x7E8;
    string16 level: 0x6875F0, 0x2C5;
}

startup
{
    vars.levels = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase)
    {
        {"A\\M01A_Main.gms", 1},
        {"A\\M02A_Main.gms", 2},
        {"A\\M03A_Main.gms", 3},
        {"B\\M03B_Main.gms", 4},
        {"A\\M05A_Main.gms", 5},
        {"A\\M06A_Main.gms", 6},
        {"A\\M07A_Main.gms", 7},
        {"M07_A_Funeral.gm", 7}, //cutscene level, double up the counter to ignore it
        {"A\\M08A_Main.gms", 8},
        {"A\\M09A_Main.gms", 9},
        {"B\\M09B_Main.gms", 10},
        {"A\\M11A_Main.gms", 11},
        {"B\\M11B_Main.gms", 12},
        {"A\\M12A_Main.gms", 13},
        {"A\\M13A_Main.gms", 14},
        {"B\\M13B_Main.gms", 15}, //Last Level Any%
        {"A\\M14A_Main.gms", 16}  //Last Level 100%
    };
    vars.end  = "B\\M13B_Main.gms";
}


start
{
    return current.level == "A\\M01A_Main.gms" && old.level == "ms";
}

onStart
{
    timer.IsGameTimePaused = true;
}

split
{
    if (current.level == "ms" && old.level == "B\\M13B_Main.gms") return true; //Special case for Any% ending
    if (current.level == "ms" && old.level == "A\\M14A_Main.gms") return true; //Special case for 100% ending
    
    if (current.level != "ms")
        {
        return
        (vars.levels.ContainsKey(current.level) &&
        vars.levels.ContainsKey(old.level) &&
        vars.levels[current.level] == vars.levels[old.level] + 1);
        }
}

isLoading
{
    //game crashes a lot, pause in menu too
    return current.Loads || current.level == "ms" || current.level == "Lynch.gms";
}

exit
{
    timer.IsGameTimePaused = true;
}
