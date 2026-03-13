state("retroarch")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("SMS");
    vars.Log = (Action<object>)(output => print("[Asterix And The Secret Mission] " + output));

    vars.Start = vars.Helper.Make<byte>(0xC0d1);
    vars.Level = vars.Helper.Make<byte>(0xC0db);

    settings.Add("AATSM", true, "Asterix and the Secret Mission (Sega Master System) Splits");
        settings.Add("L1", true, "Plains Complete", "AATSM");
        settings.Add("L3", true, "Waterfall Complete", "AATSM");
        settings.Add("L5", true, "Caves Complete", "AATSM");
        settings.Add("L7", true, "Pirate Ship Complete", "AATSM");
        settings.Add("L10", true, "Below Deck Complete", "AATSM");
        settings.Add("L11", true, "Pirate Boss Defeated", "AATSM");
        settings.Add("L13", true, "Snow Land Complete", "AATSM");
        settings.Add("L16", true, "Ice Caves Complete", "AATSM");
        settings.Add("L19", true, "Temple Complete", "AATSM");
        settings.Add("L20", true, "Final Boss Defeated", "AATSM");

    vars.Splits = new HashSet<string>();
}

update
{
    vars.Log(vars.Level.Old + " -> " + vars.Level.Current);
}

split
{
    // Level Complete Splits
    if(vars.Level.Current != vars.Level.Old && !vars.Splits.Contains("L"+vars.Level.Old.ToString()))
    {
        return settings["L"+vars.Level.Old.ToString()] && vars.Splits.Add("L"+vars.Level.Old.ToString());
    }
}

start
{
    return vars.Start.Old == 0 && vars.Start.Current == 13 && vars.Level.Current == 0;
}

onStart
{
    vars.Splits.Clear();
}
