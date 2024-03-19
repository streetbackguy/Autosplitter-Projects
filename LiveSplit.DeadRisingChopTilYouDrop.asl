//Made with RINE08 version of the game and Dolphin 5.0-21088
//Big thanks to Nikoheart for the help in getting started with the Autostart Addresses
state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("Wii");

    settings.Add("CTYD", true, "Dead Rising: Chop Til You Drop");
        settings.Add("ANY", true, "Any%", "CTYD");
            settings.Add("MRS", true, "Split after each Mission Results Screen", "ANY");
            settings.Add("CC", true, "Split after each Case Summary Screen", "ANY");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
        emu.Make<byte>("StartTrigger1", 0x806FDD80);
        emu.Make<int>("StartTrigger2", 0x806FDD70);
        emu.Make<int>("MissionResult", 0x9347631C);
        emu.Make<int>("CaseComplete", 0x806EA96C);
        emu.Make<float>("IGT", 0x806D3E94);
        emu.Make<float>("MissionTimer", 0x806D3E98);
        
        return true;
    });
}

start
{
    //Starts when selecting Difficulty from the New Game menu
    return old.StartTrigger1 == 129 && (current.StartTrigger2 == 11 || current.StartTrigger2 == 12 || current.StartTrigger2 == 13);
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
}

update
{
    if (old.StartTrigger1 != current.StartTrigger1) print("Start Trigger 1: " + current.StartTrigger1.ToString());
    if (old.StartTrigger2 != current.StartTrigger2) print("Start Trigger 2: " + current.StartTrigger2.ToString());
}

gameTime
{
    return TimeSpan.FromSeconds(current.IGT);
}
