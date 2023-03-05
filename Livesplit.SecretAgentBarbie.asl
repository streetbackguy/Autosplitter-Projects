state("SecretAgent")
{
    string8 Level : 0x5ABFE8, 0xAC, 0x0;
    int IsLevelLoaded : 0x5ABFE8, 0x74;  // Zero only on title screen
    byte IsLoading: 0x0000B11C, 0x0;  // Zero only on loading screen, but not through the whole thing? idk man...
                               // Also not zero during the variable blackout that occurs before the prerendered
                               // level intro video starts playing.
    byte EndSplit: 0x5ACD46;
    int Gameplay: 0x0000C038, 0x0;
}

startup 
{
    settings.Add("SAB", false, "Secret Agent Barbie splits");
        settings.Add("VRAct", true, "VR Action Training", "SAB");
        settings.Add("VRSte", true, "VR Stealth Training", "SAB");
        settings.Add("VRAdv", true, "VR Adventure Training", "SAB");
        settings.Add("NewYork1", true, "New York 1", "SAB");
        settings.Add("VRGRAP", true, "VR Camera/Wrist Glider Training", "SAB");
        settings.Add("Paris", true, "Paris 1", "SAB");
        settings.Add("Tokyo1", true, "Tokyo 1","SAB");
        settings.Add("Egypt", true, "Egypt 1", "SAB");
        settings.Add("NewYork2", true, "New York 2", "SAB");
        settings.Add("Paris2", true, "Paris 2", "SAB");
        settings.Add("Tokyo5", true, "Tokyo 2", "SAB");
        settings.Add("Rio1", true, "Rio 1", "SAB");
        settings.Add("Tokyo3", true, "Enter Tokyo Warehouse", "SAB");
        settings.Add("TokyoWH", true, "Tokyo 3", "SAB");
        settings.Add("Rio2", true, "Rio 2","SAB");
        settings.Add("NewYork3", true, "New York 3", "SAB");
        settings.Add("Egypt2", true, "Egypt 2", "SAB");
        settings.Add("end", true, "Himalayas", "SAB");
    settings.Add("limitedStart", true, "Only start on Intro or NY1");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Secret Agent Barbie",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

init
{
    vars.Splits = new HashSet<string>();
}

start 
{
    return (!settings["limitedStart"] || current.Level == "HQ01" || current.Level == "NewYork1") && (current.IsLevelLoaded != 0 && old.IsLevelLoaded == 0 && current.IsLoading == 0);
}

isLoading 
{
    return current.IsLoading == 0;
}

split
{
    if (current.Level != old.Level) 
    {
        vars.Splits.Add(old.Level);
        return settings[old.Level];
    }

    if (current.Level == "SIsland" && current.EndSplit == 0 && old.EndSplit == 34)
    {
        vars.Splits.Add("end");
        return settings["end"];
    }

}

reset
{
    return (current.IsLevelLoaded == 0 && old.IsLevelLoaded != 0);
}

onReset
{
    vars.Splits.Clear();
}

onStart
{
    timer.IsGameTimePaused = true;
}

exit
{
    vars.Splits.Clear();
}
