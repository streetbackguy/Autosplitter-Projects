//Made with RINE08 version of the game and Dolphin 5.0-21088
//Big thanks to Nikoheart for the help in getting started with the Autostart Addresses
state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("Wii");

    settings.Add("CTYD", true, "Dead Rising: Chop Til You Drop");
        settings.Add("ANY", false, "Any%", "CTYD");
            settings.Add("MRS", false, "Split after each Mission Results Screen", "ANY");
            settings.Add("CC", false, "Split after each Case Summary Screen", "ANY");
        settings.Add("OJ", false, "Odd Jobs", "CTYD");
            settings.Add("OJC", false, "Split after each Odd Job is completed", "OJ");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
        emu.Make<int>("StartTrigger", 0x806FDD70);
        emu.Make<int>("MissionResult", 0x9347631C);
        emu.Make<int>("CaseComplete", 0x806EA96C);
        emu.Make<int>("OddJobActive", 0x806D1470);
        emu.Make<int>("OddJobComplete", 0x806F9FA4);
        emu.Make<float>("IGT", 0x806D3E94);
        emu.Make<float>("MissionTimer", 0x806D3E98);

        return true;
    });
}

start
{
    //Starts when selecting Difficulty from the New Game menu
    if(settings["ANY"])
    {
        return old.StartTrigger == 10 && current.StartTrigger == 11;
    }

    if(settings["OJ"])
    {
        return current.OddJobActive == 1 && old.OddJobActive == 0;
    }
}

split
{
    //Splits after each Mission Result Screen
    if(current.MissionResult == 1 && old.MissionResult == 0 && current.MissionTimer == old.MissionTimer)
    {
        return settings["MRS"];
    }

    //Splits after each Case Summary Screen
    if(current.CaseComplete == 0 && old.CaseComplete != 0)
    {
        return settings["CC"];
    }

    //Splits after each Odd Job is completed
    if(current.OddJobComplete != old.OddJobComplete && current.OddJobComplete != 0)
    {
        return settings["OJC"];
    }
}

gameTime
{
    if(settings["ANY"])
    {
        return TimeSpan.FromSeconds(current.IGT);
    }

    if(settings["OJ"])
    {
        return TimeSpan.FromSeconds(current.MissionTimer);
    }
}

reset
{
    return current.StartTrigger == 0 && old.StartTrigger != 0;
}
