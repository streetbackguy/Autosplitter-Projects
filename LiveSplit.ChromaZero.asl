state("Chroma_Zero-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "Chroma Zero";
	vars.Helper.AlertLoadless();

    settings.Add("ChromaZero", true, "Chroma Zero Splits");
        settings.Add("lightGateSplit", true, "Split on getting Reminder 0 from the Light Gate", "ChromaZero");
        settings.Add("remindersSplit", true, "Split on Reminders", "ChromaZero");
            settings.Add("Reminder 1", false, "Split on Reminder 1", "remindersSplit");
            settings.Add("Reminder 2", false, "Split on Reminder 2", "remindersSplit");
            settings.Add("Reminder 3", false, "Split on Reminder 3", "remindersSplit");
            settings.Add("Reminder 4", false, "Split on Reminder 4", "remindersSplit");
            settings.Add("Reminder 5", false, "Split on Reminder 5", "remindersSplit");
            settings.Add("Reminder 6", false, "Split on Reminder 6", "remindersSplit");
            settings.Add("Reminder 7", false, "Split on Reminder 7", "remindersSplit");
            settings.Add("Reminder 8", false, "Split on Reminder 8", "remindersSplit");
            settings.Add("Reminder 9", false, "Split on Reminder 9", "remindersSplit");
        settings.Add("towerCluesSplit", true, "Split on obtaining the clues from the Magenta Tower", "ChromaZero");
        settings.Add("creditsSplit", true, "Split on reaching the credits", "ChromaZero");

    vars.Reminders = new Dictionary<int, bool>
    {
        {1, true},
        {2, true},
        {3, true},
        {4, true},
        {5, true},
        {6, true},
        {7, true},
        {8, true},
        {9, true},
    };
}

init
{
    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 1D ???????? 48 85 DB 74 ?? 41 B0 01");
    IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ???????? 66 0F 5A C9 E8");
    IntPtr fNames = vars.Helper.ScanRel(7, "8B D9 74 ?? 48 8D 15 ???????? EB");

    vars.Helper["IGT"] = vars.Helper.Make<double>(gWorld, 0x160, 0x4D0, 0x2E0, 0x2D8);

    vars.Helper["DeleteSaveProgress"] = vars.Helper.Make<double>(gWorld, 0x160, 0x4E0, 0x490);
    vars.Helper["ObtainedReminder"] = vars.Helper.Make<int>(gWorld, 0x160, 0x470, 0x28);
    vars.Helper["AnyPercentGoal"] = vars.Helper.Make<bool>(gWorld, 0x160, 0x5B8);
    vars.Helper["MagentaTowerGoal"] = vars.Helper.Make<int>(gWorld, 0x160, 0x560);
    vars.Helper["LightGateGoal"] = vars.Helper.Make<bool>(gWorld, 0x160, 0x590);

    vars.TotalTime = new TimeSpan();
    vars.Splits = new HashSet<string>();
}

start
{
    return current.IGT > 0.0f && old.IGT == 0.0f;
}

onStart
{
    vars.TotalTime = TimeSpan.Zero;
    vars.Splits.Clear();
    vars.Reminders.Clear();
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();

    if (current.DeleteSaveProgress > 0.0f)
    {
        vars.Log("Return to Title: " + current.DeleteSaveProgress);
    }

    // if (current.ObtainedReminder != old.ObtainedReminder)
    // {
    //     vars.Log("Reminders: " + current.ObtainedReminder);
    // }
}

split
{
    if (current.LightGateGoal && !vars.Splits.Contains("Enter Dark Phase"))
    {
        return settings["lightGateSplit"] && vars.Splits.Add("Enter Dark Phase");
    }

    if (current.AnyPercentGoal && !vars.Splits.Contains("Credits"))
    {
        return settings["creditsSplit"] && vars.Splits.Add("Credits");
    }
}

reset 
{    
    return current.DeleteSaveProgress > 0.98f;
}

isLoading
{
    return (old.IGT == current.IGT);
}

gameTime
{
    if (old.IGT > current.IGT && current.IGT == 0.0f)
    {
        vars.TotalTime += TimeSpan.FromSeconds(old.IGT);
    }

    return vars.TotalTime + TimeSpan.FromSeconds(current.IGT);
}
