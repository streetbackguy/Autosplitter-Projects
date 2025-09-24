state("SHf-Win64-Shipping"){}
state("SHf-WinGDK-Shipping"){}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
    Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
    // vars.Helper.Settings.CreateFromXml("Components/SilentHillf.Settings.xml");
    vars.Helper.GameName = "Silent Hill f";
    vars.Helper.AlertLoadless();
    vars.Uhara.EnableDebug();

    settings.Add("CapsuleBox_1", true, "test");
}

init
{
    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 85 C0 75 ?? 48 83 C4 ?? 5B");
    IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ???????? 48 8B BC 24 ???????? 48 8B 9C 24");
    IntPtr fNames = vars.Helper.ScanRel(3, "48 8D 0D ???????? E8 ???????? C6 05 ?????????? 0F 10 07");
    IntPtr gSyncLoad = vars.Helper.ScanRel(21, "33 C0 0F 57 C0 F2 0F 11 05");

    vars.CompletedSplits = new HashSet<string>();
    vars.GEngine = gEngine;
    vars.KeyItem = new Dictionary<ulong, int>();
    vars.Omamori = new Dictionary<ulong, int>();
    vars.FNameCache = new Dictionary<ulong, string>();

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
        throw new Exception("Not all required addresses could be found by scanning.");

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
	
	vars.FNameToShortString2 = (Func<ulong, string>)(fName =>
	{
		string name = vars.FNameToString(fName);

		int under = name.LastIndexOf('_');

		return name.Substring(0, under + 1);
	});

    var Events = vars.Uhara.CreateTool("UnrealEngine", "Events");
    IntPtr WBP_Cutscene_C = Events.InstancePtr("WBP_Cutscene_C", "");
    // print(WBP_Cutscene_C.ToString("X"));
    
    vars.Helper["CutsceneName"] = vars.Helper.Make<uint>(WBP_Cutscene_C, 0x460);
    vars.Helper["CutsceneName"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    
    vars.Helper["ProgressTag"] = vars.Helper.Make<ulong>(gWorld, 0x160, 0x328, 0x250);
    vars.Helper["ViewedCutscenes"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x598);
    // vars.Helper["InventoryComponent"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408);
    vars.Helper["LastAddedType"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0xD0);
    vars.Helper["LastAddedID"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0xD4);
    vars.Helper["ViewedWeapons"] = vars.Helper.Make<bool>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x198);
    vars.Helper["Omamoris"] = vars.Helper.Make<bool>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x1F8);
    vars.Helper["AllOmamoriIDs"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x238);
    vars.Helper["KeyItems"] = vars.Helper.Make<bool>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x330);
    vars.Helper["KeyItemIDs"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x350);
    vars.Helper["Letters"] = vars.Helper.Make<bool>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x380);
    vars.Helper["LetterIDs"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x3A8);
    vars.Helper["NoteBookPuzzleIDs"] = vars.Helper.Make<bool>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x3F8);

    vars.Helper["LocalPlayer"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x18);
    vars.Helper["LocalPlayer"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    vars.Helper["AcknowledgedPawn"] = vars.Helper.Make<ulong>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x338, 0x18);
	vars.Helper["AcknowledgedPawn"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;
    vars.Helper["isLoading"] = vars.Helper.Make<bool>(gSyncLoad);
    vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    vars.Helper["IsGameInitialized"] = vars.Helper.Make<bool>(gWorld, 0x158, 0x37A);
    vars.Helper["bWaitForRevive"] = vars.Helper.Make<bool>(gWorld, 0x158, 0x3B1);
    
    vars.CutsceneIndex = -1;
    current.Cutscene = "";
    current.Test = "";
    current.World = "";
}

start
{
    return old.Cutscene == "LS_SC0101_L1_M" && current.Cutscene != "LS_SC0101_L1_M";
}

onStart
{
    timer.IsGameTimePaused = true;
}

update
{
    vars.Helper.Update();
    vars.Helper.MapPointers();

    if (current.CutsceneName != old.CutsceneName)
    {
        if (current.CutsceneName != 0)
        {
            print(current.CutsceneName.ToString("X"));
            string cutscene = vars.FNameToString(current.CutsceneName);
            if (!string.IsNullOrEmpty(cutscene) && cutscene != "None")
            {
                current.Cutscene = cutscene;
            }
        }
        else current.Cutscene = "";
    }

    if (old.Cutscene != current.Cutscene) vars.Log("Cutscene: " + current.Cutscene);

    var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None") current.World = world;
    if (old.World != current.World) vars.Log("World: " + current.World);

    // var test = vars.FNameToShortString2(current.KeyItems);
	// if (!string.IsNullOrEmpty(test)) current.Test = test;
    // if (old.Test != current.Test) vars.Log("KeyItems: " + current.Test);
}

split
{
	// Item splits
	if(vars.FNameToShortString2(current.AcknowledgedPawn) == "BP_Pl_Hina_C_"){ 
		for (int i = 0; i < 66; i++)
		{
            string setting = "";

			ulong item = vars.Helper.Read<ulong>(vars.GEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x350, 0x0 + (i * 0x8));
			int collected = vars.Helper.Read<int>(vars.GEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x330, 0x0 + (i * 0x1));
            int oldcollected = vars.KeyItem.ContainsKey(item) ? vars.KeyItem[item] : -1;

            vars.KeyItem[item] = collected;

			if (collected == 1 && oldcollected == 0)
            {
                if (!vars.FNameCache.ContainsKey(item))
                {
                    vars.FNameCache[item] = vars.FNameToString(item);
                }
                setting = vars.FNameCache[item] + "_" + collected;
            }

            if (!string.IsNullOrEmpty(setting) && settings.ContainsKey(setting) && settings[setting] && !vars.CompletedSplits.Contains(setting))
            {
                return true;
                vars.CompletedSplits.Add(setting);
                vars.Log("Split Complete: " + setting);
            }
			
			// Debug. Comment out before release.
			// if (!string.IsNullOrEmpty(setting))
			// vars.Log(setting);
		}
	}

    // Omamori splits
	if(vars.FNameToShortString2(current.AcknowledgedPawn) == "BP_Pl_Hina_C_"){ 
		for (int i = 0; i < 41; i++)
		{
            string setting = "";

			ulong omamori = vars.Helper.Read<ulong>(vars.GEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x238, 0x0 + (i * 0x8));
			int collected = vars.Helper.Read<int>(vars.GEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0x218, 0x0 + (i * 0x1));
            int oldcollected = vars.Omamori.ContainsKey(omamori) ? vars.Omamori[omamori] : -1;

            vars.Omamori[omamori] = collected;

			if (collected == 1 && oldcollected == 0)
            {
                if (!vars.FNameCache.ContainsKey(omamori))
                {
                    vars.FNameCache[omamori] = vars.FNameToString(omamori);
                }
                setting = vars.FNameCache[omamori] + "_" + collected;
            }

            if (!string.IsNullOrEmpty(setting) && settings.ContainsKey(setting) && settings[setting] && !vars.CompletedSplits.Contains(setting))
            {
                return true;
                vars.CompletedSplits.Add(setting);
                vars.Log("Split Complete: " + setting);
            }
			
			// Debug. Comment out before release.
			// if (!string.IsNullOrEmpty(setting))
			// vars.Log(setting);
		}
	}

    // if(!string.IsNullOrEmpty(current.Cutscene) && string.IsNullOrEmpty(old.Cutscene))
    // {
    //     string cutscenesetting = current.Cutscene;
    //     vars.SplitsToComplete.Add(current.Cutscene);
        
    //     if (settings.ContainsKey(cutscenesetting) && settings[cutscenesetting] && vars.CompletedSplits.Add(cutscenesetting) && vars.SplitsToComplete.Contains(cutscenesetting))
    //     {
    //         vars.SplitsToComplete.Clear();
    //         return true;
    //     }
    // }
}

isLoading
{
    return current.World == "NoceEntry" || current.bWaitForRevive || !current.IsGameInitialized || current.isLoading 
    || !string.IsNullOrEmpty(current.Cutscene) || vars.FNameToShortString2(current.LocalPlayer) != "BP_Pl_Hina_PlayerController_C_";
}

exit
{
    timer.IsGameTimePaused = true;
}
