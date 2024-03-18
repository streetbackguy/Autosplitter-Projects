//Big thanks to Nikoheart for the help in getting started with the Autostart Addresses
state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("Wii");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
        emu.Make<byte>("StartTrigger1", 0x806FDD80);
        emu.Make<int>("StartTrigger2", 0x806FDD70);
        emu.Make<int>("MissionResult", 0x806D4DF8);
        emu.Make<float>("IGT", 0x806D3E94);
        
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
    return current.MissionResult == 2 && old.MissionResult == 1;
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