state("OutOfSight-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    vars.Helper.Settings.CreateFromXml("Components/OutofSight.Settings.xml");
	vars.Helper.GameName = "Out of Sight";
	vars.Helper.AlertLoadless();

    vars.CompletedSplits = new HashSet<string>();
}

init
{
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
        {
            case "FA47F96DC8AF172A263CEE6777A5E54A":
                version = "Steam 1.00";
                break;

            case "769611513B0F5C3FE1FE7BEC479B1B60":
                version = "Steam 1.01";
                break;

            default:
                version = "Unknown";
                break;
        }

    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 1D ???????? 48 85 DB 74 ?? 41 B0 01");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ???????? 66 0F 5A C9 E8");
	IntPtr fNames = vars.Helper.ScanRel(7, "8B D9 74 ?? 48 8D 15 ???????? EB");
    IntPtr gSyncLoadCount = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    // GWorld.FName
    vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSyncLoadCount);

    // GEngine.TransitionType
    vars.Helper["TransitionType"] = vars.Helper.Make<int>(gEngine, 0xD0C);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.Pawn.ItemComponent.ItemHeldByPlayer
    vars.Helper["ItemHeld"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x2E8, 0x9C0, 0xA0, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.CollectibleWidget
    vars.Helper["Collectibles"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0x890);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.LocationDisplayWidget.Location
    vars.Helper["Location"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xCB0, 0x2E0, 0x188, 0x28, 0x0);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.LocationDisplayWidget.Room
    vars.Helper["Room"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xCB0, 0x2E8, 0x188, 0x28, 0x0);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.LocationDisplayWidget.Room
    vars.Helper["Segmenttest"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xCB0, 0x2F0, 0x30, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.Lever Interaction.TargetLever.Name
    vars.Helper["TargetLever"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0x1F8, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.Instant Interaction.Name
    vars.Helper["CurrentInteraction"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0x978, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.Single Effort Interaction.Name
    vars.Helper["SingleEffortInteraction"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0x9F8, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.IsChaseSequenceActive
    vars.Helper["ChaseTriggered"] = vars.Helper.Make<bool>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xD00);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.IsMoving
    vars.Helper["IsMoving"] = vars.Helper.Make<bool>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xCD8);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.IsPassedOut
    vars.Helper["IsPassedOut"] = vars.Helper.Make<bool>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xCDA);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.IsDead
    vars.Helper["IsDead"] = vars.Helper.Make<bool>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xD18);

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

    current.World = "";
    current.Segment = "";
    current.Item = "";
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();

    var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;

    var item = vars.FNameToString(current.ItemHeld);
	if (!string.IsNullOrEmpty(item) && item != "None")
		current.Item = item;

    var localAppData = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
    vars.Watcher = new FileSystemWatcher()
    {
        Path = localAppData + @"\OutOfSight\Saved",
        Filter = "*.sav",
        IncludeSubdirectories = true,
        EnableRaisingEvents = true
    };

    vars.Watcher.Created += new FileSystemEventHandler((sender, e) => 
    {
        FileInfo file = new FileInfo(e.FullPath);
        vars.Log(file.Name.Substring(11));
        current.Segment = file.Name.Substring(11);
    });
}

start
{
    return current.World == "LVL_FullGamePersistent" && old.World == "LVL_MainMenu";
}

onStart
{
    vars.CompletedSplits.Clear();
    current.World = "";
    current.Segment = "";
    current.Item = "";
}

split
{
    if(current.Segment != old.Segment && !vars.CompletedSplits.Contains(old.Segment))
    {
        return settings[old.Segment] && vars.CompletedSplits.Add(old.Segment);
    }

    if(current.Item != old.Item && !vars.CompletedSplits.Contains(current.Item))
    {
        return settings[current.Item] && vars.CompletedSplits.Add(current.Item);
    }
}

isLoading
{
    return current.GSync || current.TransitionType == 1;
}