state("retroarch")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("SMS");
    vars.Log = (Action<object>)(output => print("[Alex Kidd in Shinobi World] " + output));

    vars.Transition = vars.Helper.Make<byte>(0xC040);
    vars.StageID = vars.Helper.Make<byte>(0xC04d);
    vars.StageRoom = vars.Helper.Make<byte>(0xC04e);
    vars.BossHealth = vars.Helper.Make<byte>(0xC31e);

    settings.Add("AKSMS", true, "Alex Kidd in Shinobi World (Sega Master System) Splits");
        settings.Add("S00", true, "Split on Round 1 Stage 1 Completion", "AKSMS");
        settings.Add("S03", true, "Split on Round 1 Stage 2 Completion", "AKSMS");
        settings.Add("R0", true, "Round 1: Kabuto", "AKSMS");
        settings.Add("S12", true, "Split on Round 2 Stage 1 Completion", "AKSMS");
        settings.Add("S16", true, "Split on Round 2 Stage 2 Completion", "AKSMS");
        settings.Add("R1", true, "Round 2: Raid of the Helicopters", "AKSMS");
        settings.Add("S22", true, "Split on Round 3 Stage 1 Completion", "AKSMS");
        settings.Add("S26", true, "Split on Round 3 Stage 2 Completion", "AKSMS");
        settings.Add("R2", true, "Round 3: The Jungle", "AKSMS");
        settings.Add("S33", true, "Split on Round 4 Stage 1 Completion", "AKSMS");
        settings.Add("S39", true, "Split on Round 4 Stage 2 Completion", "AKSMS");
        settings.Add("R3", true, "Round 4: The Battle with the Dark Ninja", "AKSMS");

    vars.Splits = new HashSet<string>();
}

update
{
    if(vars.Transition.Current != vars.Transition.Old)
    {
        vars.Log(vars.Transition.Old + " -> " + vars.Transition.Current);
        vars.Log("Stage ID: " + vars.StageRoom.Current);
    }

    
}

split
{
    // Stage Complete Splits
    if(vars.StageID.Current >= 0 && vars.Transition.Current == 9 && vars.Transition.Old == 3 && !vars.Splits.Contains("R"+vars.StageID.Current.ToString()))
    {
        return settings["S"+vars.StageID.Current.ToString()+vars.StageRoom.Current.ToString()] && vars.Splits.Add("S"+vars.StageID.Current.ToString()+vars.StageRoom.Current.ToString());
    }

    // Round Complete Splits
    if(vars.StageID.Current >= 0 && vars.Transition.Current == 9 && vars.BossHealth.Current == 0 && !vars.Splits.Contains("R"+vars.StageID.Current.ToString()) || vars.StageID.Current >= 0 && vars.Transition.Current == 19 && vars.BossHealth.Current == 0 && !vars.Splits.Contains("R"+vars.StageID.Current.ToString()))
    {
        if(vars.StageID.Current == 0 && vars.StageRoom.Current == 4 || vars.StageID.Current == 1 && vars.StageRoom.Current == 7 || vars.StageID.Current == 2 && vars.StageRoom.Current == 7 || vars.StageID.Current == 3 && vars.StageRoom.Current == 10)
        {
            return settings["R"+vars.StageID.Current.ToString()] && vars.Splits.Add("R"+vars.StageID.Current.ToString());
        }
    }
}

start
{
    return vars.StageID.Current == 0 && vars.Transition.Current == 3;
}

onStart
{
    vars.Splits.Clear();
}
