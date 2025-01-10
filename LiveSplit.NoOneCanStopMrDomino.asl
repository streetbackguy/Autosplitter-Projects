state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");
    vars.Log = (Action<object>)(output => print("[No One Can Stop Mr. Domino!] " + output));

    settings.Add("NOCSMD", true, "No One Can Stop Mr. Domino!");
        settings.Add("Stage1", true, "Phat Tony's Casino");
        settings.Add("Stage2", true, "Shop 'til You Drop");
        settings.Add("Stage3", true, "Grandpa's in the House");
        settings.Add("Stage4", true, "Tripping in the Park");
        settings.Add("Stage5", true, "Fun Park Massive");
        settings.Add("Stage6", true, "No One Can Stop Mr. Domino");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
        emu.Make<short>("StageID", 0x800b2d98);
        
        return true;
    });

    vars.CompletedSplits = new HashSet<string>();
}

split
{
    if(current.StageID == old.StageID + 1)
    {
        return settings["Stage" + old.StageID] && vars.CompletedSplits.Add("Stage" + old.StageID);
    }
}

start
{
    return current.StageID == 1 && old.StageID != 1;
}

onStart
{
    vars.CompletedSplits.Clear();
}

reset
{
    return current.StageID == 0 || current.StageID == 1 && old.StageID != 1;
}