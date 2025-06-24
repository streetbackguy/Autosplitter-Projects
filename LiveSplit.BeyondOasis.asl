//Made for Retroarch Emulator with Genesis Plus GX Core v1.7.4 d593106
state("LiveSplit")
{
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("Genesis");

    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
	{
		emu.Make<short>("RoomID", 0x0E40);
        emu.Make<short>("EnemyHealth", 0x184A);
        emu.Make<short>("EnemyID", 0x1CD8);
        emu.Make<short>("CurrentScreen", 0x10AE);
        emu.Make<short>("Cutscene", 0x1CFE);
        emu.Make<short>("Enemy1Status", 0x1CDC);

		return true;
	});

    settings.Add("BO", true, "Beyond Oasis");
        settings.Add("VillageAttack", true, "Village Attack", "BO");
        settings.Add("Scorpion", true, "Scorpion Boss Defeated", "BO");
        settings.Add("RedCube", true, "Red Cube Collected", "BO");
        settings.Add("OOB", true, "Out of Bounds Skip", "BO");
        settings.Add("Snake", true, "Snake Boss Defeated", "BO");
        settings.Add("Dragon", true, "Dragon Boss Defeated", "BO");
        settings.Add("GreenCube", true, "Green Cube Collected", "BO");
        settings.Add("NonEntity", true, "Non-Entity Boss Defeated", "BO");
        settings.Add("Final", true, "Final Boss Defeated", "BO");
}

init
{
    vars.Splits = new HashSet<string>();
}

start
{
    return current.Cutscene == 768;
}

onStart
{
    vars.Splits.Clear();
}

split
{
    if(old.RoomID == 256 && current.RoomID == 15 && !vars.Splits.Contains("VillageAttack"))
    {
        return settings["VillageAttack"] && vars.Splits.Add("VillageAttack");
    }

    if(current.RoomID == 1281 && current.EnemyHealth == 0 && old.EnemyHealth > 0 && !vars.Splits.Contains("Scorpion"))
    {
        return settings["Scorpion"] && vars.Splits.Add("Scorpion");
    }

    if(old.RoomID == 1538 && current.RoomID == 13 && !vars.Splits.Contains("RedCube"))
    {
        return settings["RedCube"] && vars.Splits.Add("RedCube");
    }

    if(old.RoomID == 4358 && current.RoomID == 4864 && !vars.Splits.Contains("OOB"))
    {
        return settings["OOB"] && vars.Splits.Add("OOB");
    }

    if(current.RoomID == 1031 && current.EnemyHealth == 0 && old.EnemyHealth > 0 && !vars.Splits.Contains("Snake"))
    {
        return settings["Snake"] && vars.Splits.Add("Snake");
    }

    if(current.RoomID == 1032 && current.EnemyHealth == 0 && old.EnemyHealth > 0 && !vars.Splits.Contains("Dragon"))
    {
        return settings["Dragon"] && vars.Splits.Add("Dragon");
    }

    if(old.RoomID == 4106 && current.RoomID == 13 && !vars.Splits.Contains("GreenCube"))
    {
        return settings["GreenCube"] && vars.Splits.Add("GreenCube");
    }

    if(current.RoomID == 3851 && current.EnemyHealth == 0 && old.EnemyHealth > 0 && !vars.Splits.Contains("NonEntity"))
    {
        return settings["NonEntity"] && vars.Splits.Add("NonEntity");
    }

    if(current.RoomID == 5388 && current.Enemy1Status == 512 && old.Enemy1Status != 512 && !vars.Splits.Contains("Final"))
    {
        return settings["Final"] && vars.Splits.Add("Final");
    }
}