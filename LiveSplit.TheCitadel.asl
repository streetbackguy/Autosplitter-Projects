state("the_citadel-Win64-Shipping")
{
}

startup
{
    Thread.Sleep(5000);

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "The Citadel";
	vars.Helper.AlertLoadless();

    settings.Add("TheCitadel", true, "The Citadel Splits");
        settings.Add("Act1", true, "Act 1 Splits", "TheCitadel");
            settings.Add("INTRO", true, "Introduction", "Act1");
            settings.Add("E1M1", true, "The Enterway", "Act1");
            settings.Add("E1M2", true, "Smoke and Powder", "Act1");
            settings.Add("E1M3", true, "The Hallway", "Act1");
            settings.Add("E1M4", true, "Chain of Fire", "Act1");
            settings.Add("E1M5", true, "Vectra, the Angel of Gluttony", "Act1");
            settings.Add("E1EX", false, "Secret Level", "Act1");
        settings.Add("Act2", true, "Act 2 Splits", "TheCitadel");
            settings.Add("E2M1", true, "Reembody", "Act2");
            settings.Add("E2M2", true, "Armored Fury", "Act2");
            settings.Add("E2M3", true, "Devastator Engine", "Act2");
            settings.Add("E2M4", true, "Shadowforge", "Act2");
            settings.Add("E2M5", true, "Cereste, the Angel of Sloth", "Act2");
            settings.Add("E2EX", false, "Secret Level", "Act2");
        settings.Add("Act3", true, "Act 3 Splits", "TheCitadel");
            settings.Add("E3M1", true, "Whirlwind", "Act3");
            settings.Add("E3M2", true, "High Ground", "Act3");
            settings.Add("E3M3", true, "Pitfall", "Act3");
            settings.Add("E3M4", true, "Downfall", "Act3");
            settings.Add("E3M5", true, "Harkonnen, the Angel of Greed", "Act3");
            settings.Add("E3EX", false, "Secret Level", "Act3");
        settings.Add("Act4", true, "Act 4 Splits", "TheCitadel");
            settings.Add("E4M1", true, "The Gauntlet", "Act4");
            settings.Add("E4M2", true, "Painless", "Act4");
            settings.Add("E4M3", true, "Nightmare Fuel", "Act4");
            settings.Add("E4M4", true, "Sinking City", "Act4");
            settings.Add("E4M5", true, "Lysander, the Angel of Envy", "Act4");
            settings.Add("E4EX", false, "Secret Level", "Act4");
        settings.Add("Act5", true, "Act 5 Splits", "TheCitadel");
            settings.Add("E5M1", true, "Ironclad", "Act5");
            settings.Add("E5M2", true, "Infested Catacomb", "Act5");
            settings.Add("E5M3", true, "Brimstone", "Act5");
            settings.Add("E5M4", true, "Fortress", "Act5");
            settings.Add("E5M5", true, "Gaussia, the Angel of Wrath", "Act5");
            settings.Add("E5EX", false, "Secret Level", "Act5");
        settings.Add("Act6", true, "Act 6 Splits", "TheCitadel");
            settings.Add("E6M1", true, "The Hive", "Act6");
            settings.Add("E6M2", true, "Unholy Temple", "Act6");
            settings.Add("E6M3", true, "Grainder", "Act6");
            settings.Add("E6M4", true, "Tainted Sanctuary", "Act6");
            settings.Add("E6M5", true, "Krone, the Angel of Pride", "Act6");
            settings.Add("E6EX", false, "Secret Level", "Act6");
        settings.Add("Act7", true, "Act 7 Splits", "TheCitadel");
            settings.Add("E7M1", true, "Delirium, The Angel of Lust", "Act7");
            settings.Add("E7M2", true, "Let the Sleeping God Die", "Act7");
}

init
{
    IntPtr gWorld = vars.Helper.ScanRel(8, "0F 2E ?? 74 ?? 48 8B 1D ?? ?? ?? ?? 48 85 DB 74");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 89 05 ?? ?? ?? ?? 48 85 c9 74 ?? e8 ?? ?? ?? ?? 48 8d 4d");
	IntPtr fNames = vars.Helper.ScanRel(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    // GWorld.Name
	vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    vars.FNameToString = (Func<ulong, string>)(fName =>
	{
		var nameIdx = (fName & 0x000000000000FFFF) >> 0x00;
		var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
		var number = (fName & 0xFFFFFFFF00000000) >> 0x20;

		IntPtr chunk = vars.Helper.Read<IntPtr>(fNames + 0x10 + (int)chunkIdx * 0x8);
		IntPtr entry = chunk + (int)nameIdx * sizeof(short);

		int length = vars.Helper.Read<short>(entry) >> 6;
		string name = vars.Helper.ReadString(length, ReadStringType.UTF8, entry + sizeof(short));

		return number == 0 ? name : name + "_" + number;
	});

	vars.FNameToShortString = (Func<ulong, string>)(fName =>
	{
		string name = vars.FNameToString(fName);

		int dot = name.LastIndexOf('.');
		int slash = name.LastIndexOf('/');

		return name.Substring(Math.Max(dot, slash) + 1);
	});

	current.World = "";

    vars.Splits = new HashSet<string>();
}

start
{
    return old.World == "main_cit2" && current.World != "main_cit2";
}

onStart
{
    vars.Splits.Clear();
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();

    var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;
	if (old.World != current.World) vars.Log("GWorldName: " + current.World.ToString());
}

split
{
    if(current.World != old.World && !vars.Splits.Contains(old.World))
    {
        return settings[old.World] && vars.Splits.Add(old.World);
    }
}

isLoading
{
    return current.World == "loading";
}

reset 
{    
    return current.World == "main_cit2" && old.World != "main_cit2";
}