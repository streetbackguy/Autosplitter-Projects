//Version 7 by Streetbackguy
state("Prey", "v1.00 Steam")
{
	int Loading: 0x242D800, 0x118, 0xB0;
    float XAxis: 0x28C42DC;
    float YAxis: 0x28C42D8;
    float ZAxis: 0x242DD8C;
    int MainMenu: 0x21FF280;
}

state("Prey", "v1.06 Steam")
{
	int Loading: "PreyDll.dll", 0x2C367A0, 0x118, 0xB0;
    float XAxis: "PreyDll.dll", 0x28BE48C;
    float YAxis: "PreyDll.dll", 0x28BE488;
    float ZAxis: "PreyDll.dll", 0x24247F4;
    int MainMenu: "PreyDll.dll", 0x2261F20;
}

init
{
	int moduleSize = modules.First().ModuleMemorySize;
	print("Main Module Size: "+moduleSize.ToString());

    switch(modules.First().ModuleMemorySize) 
    {
        case 171769856:
            version = "v1.00 Steam";
            break;

        case 581632:
            version = "v1.06 Steam";
            break;

        default:
            version = "Unknown";
            break;

    }
	
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Prey (2017)",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

startup
{

}

start
{
    return current.MainMenu == 0 && old.Loading == 0 && current.Loading == 1;
}

update
{
	
}

split
{
	
}

isLoading
{
	return current.Loading == 0 && current.XAxis == old.XAxis && current.YAxis == old.YAxis;
}

exit
{
    timer.IsGameTimePaused = true;
}
