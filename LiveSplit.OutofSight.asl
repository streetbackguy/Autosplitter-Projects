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

            case "422088019C0D0A95673B89169272FC44":
                version = "Steam 1.02";
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

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.ItemComponent.ItemHeldByPlayer
    vars.Helper["ItemHeld"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0x9C0, 0xA0, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.BP_OurPlayer.WBP_FadeIn.FadeToBlack.DisplayLabel.Data
    vars.Helper["EndFade"] = vars.Helper.MakeString(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x860, 0xAF8, 0x2D8, 0x88, 0x0);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.Pawn.InteractionComponents[0].InteractionTarget.Name
    vars.Helper["CurrentInteract"] = vars.Helper.Make<ulong>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x2E8, 0x938, 0x0, 0x1F8, 0x18);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.Pawn.InteractionComponents[0].InteractionTarget.ActivatedActors[0].CanFlush
    vars.Helper["CurrentInteractTriggered"] = vars.Helper.Make<bool>(gEngine, 0x11F8, 0x38, 0x0, 0x30, 0x2E8, 0x938, 0x0, 0x1F8, 0x348, 0x0, 0x2C0);

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
    current.InteractTarget = "";
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

    var interact = vars.FNameToString(current.CurrentInteract);
	if (!string.IsNullOrEmpty(interact) && interact != "None")
		current.InteractTarget = interact;

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
    current.InteractTarget = "";
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

    if(current.InteractTarget == "BP_PowerSwitch_Toilet_C_2" && !current.CurrentInteractTriggered && old.CurrentInteractTriggered && !vars.CompletedSplits.Contains("Flush"))
    {
        return settings["Flush"] && vars.CompletedSplits.Add("Flush");
    }
}

isLoading
{
    return current.GSync || current.TransitionType == 1;
}
