//Autosplitting and Updated code by Koutyy
//Load Removal and original Autostart by Streetbackguy
state("bionic_commando")
{
    bool isLoading : 0x809952;
    string32 stage : 0x80CF80, 0x7C, 0x0;
    uint someVar : "binkw32.dll", 0x233E8;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Bionic Commando",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

start
{
    return current.isLoading && current.stage == "cutscene_prison_stage1";
}

split
{
    //print(current.someVar.ToString());

    if (current.stage != old.stage &&
        old.stage != "menu/mainmenu/mainmenu" &&
        current.stage != "menu/mainmenu/mainmenu" &&
        current.stage != "tutorial_a_stage1" &&
        current.stage != "harbor_e_stage1")
    {
        return true;
    }

    //final split
    if (current.stage == "boss_terracotta_stage1" && current.someVar != old.someVar && current.someVar == 0)
    {
        return true;
    }
}

isLoading
{
    return current.isLoading;
}

/*exit
{
    timer.IsGameTimePaused = true;
}*/