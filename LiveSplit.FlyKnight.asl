state("FlyKnightPrelude-Win64-Shipping")
{
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "FlyKnight";

    settings.Add("FK", true, "FlyKnight");
        settings.Add("Level00_Town", true, "Split on completing the Town level", "FK");
        settings.Add("Level01_Caves", true, "Split on completing the Caves level", "FK");
        settings.Add("Level02_Swamp", true, "Split on completing the Swamp level", "FK");
        settings.Add("Level03_Ruins", true, "Split on completing the Ruins level", "FK");

    vars.Splits = new HashSet<String>();
}

init
{
	IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 3B C? 48 0F 44 C? 48 89 05 ???????? E8");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 39 35 ?? ?? ?? ?? 0F 85 ?? ?? ?? ?? 48 8B 0D");
	IntPtr fNames = vars.Helper.ScanRel(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15");

	if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

	// GWorld.Name
	vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    //GEngine.GameInstance.[0]LocalPlayers.PlayerController.AcknowledgedPawn.CharacterMovement.Velocity.X/Velocity.Y
    vars.Helper["CurrentState"] = vars.Helper.Make<byte>(gEngine, 0xD28, 0x38, 0x0, 0x30, 0x2A0, 0x6C8);

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
}

update
{
	vars.Helper.Update();
	vars.Helper.MapPointers();

	var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;
}

start
{
    if(current.CurrentState == 0 && old.CurrentState == 8 && current.World == "Level00_Town")
    {
        return true;
    }
}

split
{
    if(current.World != old.World && current.World != "Level00_Town_MainMenu" && !vars.Splits.Contains(old.World))
    {
        return settings[old.World] && vars.Splits.Add(old.World);
    }
}
