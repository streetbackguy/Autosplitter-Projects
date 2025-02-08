//Made with EU version of the game and PCSX2 Nightly
state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS2");

    settings.Add("TH", true, "Thunderbirds");
        settings.Add("ANY", true, "Any% ", "TH");
            settings.Add("MISSION0", true, "Complete Training Mission", "ANY");
            settings.Add("MISSION1", true, "Complete Tick-Tock Goes the Clock", "ANY");
            settings.Add("MISSION2", true, "Complete Mayday! Mayday! Plane-X Down!", "ANY");
            settings.Add("MISSION3", true, "Complete Mega Storm!", "ANY");
            settings.Add("MISSION4", true, "Complete End of the line!", "ANY");
            settings.Add("MISSION5", true, "Complete Cosmic Capers!", "ANY");
            settings.Add("MISSION6", true, "Complete Dam of Disaster!", "ANY");
            settings.Add("MISSION7", true, "Complete Temple of Doom!", "ANY");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
        emu.Make<byte>("GameStart", 0x33B44C);
        emu.Make<byte>("MissionID", 0x2E1C24);
        emu.Make<byte>("ResultsScreen", 0x7DDD0D);

        return true;
    });

    vars.CompletedSplits = new HashSet<string>();
}

start
{
    //Starts when selecting Training Mission
    return current.GameStart == 1 && old.GameStart == 0;
}

split
{
    //Splits on each Missions Results Screen
    if(current.ResultsScreen == 1 && !vars.CompletedSplits.Contains("MISSION" + current.MissionID))
    {
        return settings["MISSION" + current.MissionID] && vars.CompletedSplits.Add("MISSION" + current.MissionID);
    }
}

onStart
{
    vars.CompletedSplits.Clear();
}