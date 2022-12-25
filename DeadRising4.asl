//Coded and values found mainly by Kuno Demetries, with moral support and puppetry by Streetbackguy
state("deadrising4")
{
    int Loading : 0x3352C54;
    int Loading2 : 0x32B0C90;
    int MGSummary : 0x337A3F0;
    int Paradigm : 0x3352CD8;
    byte MainMenu : 0x21444B4;
    byte PauseMenu : 0x3498D01;
    byte CaseSummary : 0x21497E4;
    byte CaseStart : 0x3352C19;    
    long CurObj : 0x028620F0, 0x20, 0x3A8, 0x4E0, 0x78, 0x858, 0x2F0, 0x708;
}

init
{
    vars.doneMaps = new List<string>();
    vars.CurObj = "";
}

startup
{
    settings.Add("DR4", true, "Dead Rising 4");
        settings.Add("test", false, "Split after each Story Case", "DR4");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Dead Rising 4",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

}

//Starts as soon as you hit New Game from Main Menu
start
{
    return (old.Loading == 1 && current.MainMenu == 33 || current.MainMenu == 33 && current.Loading == 0);
}

isLoading
{
    return (current.Loading == 1 && current.Loading2 != 84 || current.Loading2 == 0 && current.Loading == 0 || current.Loading == 0 && current.Loading2 == 84 && current.PauseMenu != 1);
}

//Currently not finished, use at own discretion
split
{
    if (current.CaseSummary == 1 && old.CaseSummary == 2 && current.Loading2 == 84 && current.Paradigm != 0)
    {
        return settings["test"];
    }
}

onReset
{
    vars.doneMaps.Clear();
}
