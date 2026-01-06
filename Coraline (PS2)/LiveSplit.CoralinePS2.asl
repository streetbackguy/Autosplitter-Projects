//Made with NTSC version of the game and PCSX2 Nightly
state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS2");
    vars.Log = (Action<object>)(output => print("[Coraline] " + output));

    vars.Level = vars.Helper.Make<long>(0x50800e);
    vars.MinigameSuccess = vars.Helper.Make<int>(0x1980838);

    settings.Add("ANY", true, "Any% (Emulator)");
        settings.Add("2003710308", true, "Finish Day 1 (Real World)", "ANY");
        settings.Add("2003775844", true, "Finish Day 1 (Other World)", "ANY");
        settings.Add("2003055204", true, "Finish Day 1 (Nightmare)", "ANY");
        settings.Add("2003710564", true, "Finish Day 2 (Real World)", "ANY");
        settings.Add("2003776100", true, "Finish Day 2 (Other World)", "ANY");
        settings.Add("2003055460", true, "Finish Day 2 (Nightmare)", "ANY");
        settings.Add("2003710820", true, "Finish Day 3 (Real World)", "ANY");
        settings.Add("2003776356", true, "Finish Day 3 (Other World)", "ANY");
        settings.Add("2003055716", true, "Finish Day 3 (Nightmare)", "ANY");
        settings.Add("2003711076", true, "Finish Day 4 (Real World)", "ANY");
        settings.Add("2003776612", true, "Finish Day 4 (Other World)", "ANY");
        settings.Add("MINIGAME", true, "Split on Each Minigame Finished", "ANY");
}

init
{
    vars.CompletedSplits = new HashSet<string>();
}

start
{
    //Starts when selecting New Game
    return vars.Level.Current == 2003710308 && vars.Level.Old == 1819568500;
}

split
{
    //Splits after finishing each level
    if(vars.Level.Old != vars.Level.Current && vars.Level.Current != 1819568500)
    {
        return settings[vars.Level.Old.ToString()] && vars.CompletedSplits.Add(vars.Level.Old.ToString());
    }

    //Splits on each Minigame Success
    if(vars.MinigameSuccess.Old != vars.MinigameSuccess.Current && vars.MinigameSuccess.Current == 1667462515)
    {
        return settings["MINIGAME"];
    }
}

update
{
    // vars.Log(vars.Level.Current.ToString());
}

reset
{
    return vars.Level.Current == 1819568500 && vars.Level.Old != 1819568500;
}

onStart
{
    vars.CompletedSplits.Clear();
}
