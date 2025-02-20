state("MM-Win64-Shipping")
{
    bool ScreenFades: 0x565B988;
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
}

onStart
{

}

init
{
    IntPtr gEngine = vars.Helper.ScanRel(3, "48 39 35 ?? ?? ?? ?? 0F 85 ?? ?? ?? ?? 48 8B 0D");
    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 3B C? 48 0F 44 C? 48 89 05 ???????? E8");
    IntPtr namePoolData = vars.Helper.ScanRel(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15");
    IntPtr gSyncLoadCount = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gEngine == IntPtr.Zero || gEngine == IntPtr.Zero || namePoolData == IntPtr.Zero || gSyncLoadCount == IntPtr.Zero)
    {
        throw new InvalidOperationException(
            "Not all required addresses found. Retrying.");
    }

    vars.Helper["IsLoading"] = vars.Helper.Make<bool>(gSyncLoadCount);

    vars.Helper["Level"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    vars.FNameToString = (Func<ulong, string>)(fName =>
	{
		var nameIdx = (fName & 0x000000000000FFFF) >> 0x00;
		var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
		var number = (fName & 0xFFFFFFFF00000000) >> 0x20;

		IntPtr chunk = vars.Helper.Read<IntPtr>(namePoolData + 0x10 + (int)chunkIdx * 0x8);
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

    var world = vars.FNameToString(current.Level);
	if (!string.IsNullOrEmpty(world) && world != "None") current.World = world;

    // vars.Log("Localplayer?: " + vars.FNameToString(current.LocalPlayer));
}

start
{
    return current.World == "PreIntro" && old.World == "MainMenu";
}

reset
{
    return current.World == "MainMenu" && old.World != "MainMenu";
}

isLoading
{
    return current.IsLoading || current.ScreenFades;
}