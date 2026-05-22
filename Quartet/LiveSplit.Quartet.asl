state("RetroArch")
{
  
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("SMS");
    
    vars.Log = (Action<object>)(output => print("[Quartet] " + output));
    vars.Splits = new HashSet<string>();
    
    vars.StageIndex   = vars.Helper.Make<byte>(0XC00E);
    vars.FinalBossHP  = vars.Helper.Make<byte>(0xC071);
    
    settings.Add("Q", true, "Quartet (Sega Master System) splits:");
        settings.Add("S1", true, "Stage 1->2", "Q");
        settings.Add("S2", true, "Stage 2->3", "Q");
        settings.Add("S3", true, "Stage 3->4", "Q");
        settings.Add("S4", true, "Stage 4->5", "Q");
        settings.Add("S5", true, "Stage 5->6", "Q");
        settings.Add("FB", true, "Final Boss Defeated", "Q");
}

update
{
  
}

split
{
    if(vars.StageIndex.Current != 0 &&
        vars.StageIndex.Old != 0 &&
        vars.StageIndex.Current != vars.StageIndex.Old
    )
        return settings["S"+vars.StageIndex.Old] && vars.Splits.Add("S"+vars.StageIndex.Old);
    
    if(vars.StageIndex.Current == 6 &&
        vars.FinalBossHP.Old != 0 &&
        vars.FinalBossHP.Current == 0
    )
        return settings["FB"] && vars.Splits.Add("FB");
}

start
{
    return vars.StageIndex.Old == 0 && vars.StageIndex.Current == 1;
}

onStart
{
    vars.Splits.Clear();
}

reset
{
    return vars.StageIndex.Current == 0;
}
