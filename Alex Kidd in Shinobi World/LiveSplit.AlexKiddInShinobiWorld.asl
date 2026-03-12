state("livesplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("SMS");
    vars.Log = (Action<object>)(output => print("[Alex Kidd in Shinobi World] " + output));

    vars.Transition = vars.Helper.Make<byte>(0x40);
    vars.StageID = vars.Helper.Make<byte>(0x4d);
    vars.StageRoom = vars.Helper.Make<byte>(0x4e);
    vars.BossHealth = vars.Helper.Make<byte>(0x31e);

    settings.Add("AKSMS", true, "Alex Kidd in Shinobi World (Sega Master System) Splits");
        settings.Add("R1", true, "Round 1: Kabuto", "AKSMS");
        settings.Add("R2", true, "Round 2: Raid of the Helicopters", "AKSMS");
        settings.Add("R3", true, "Round 3: The Jungle", "AKSMS");
        settings.Add("R4", true, "Round 4: The Battle with the Dark Ninja", "AKSMS");

    vars.Splits = new HashSet<string>();
}

split
{
    // Round Complete Splits
    if(vars.StageID.Current >= 0 && vars.Transition.Current == 9 && !vars.Splits.Contains("R"+vars.StageID.Current.ToString()))
    {
        return settings["R"+vars.StageID.Current.ToString()] && vars.Splits.Add("R"+vars.StageID.Current.ToString());
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
