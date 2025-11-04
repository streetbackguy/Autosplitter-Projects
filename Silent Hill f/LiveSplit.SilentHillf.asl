// Autosplitter and Load Remover made by Nikoheart and Streetbackguy
state("SHf-Win64-Shipping"){}
state("SHf-WinGDK-Shipping"){}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
	vars.Helper.Settings.CreateFromXml("Components/SilentHillf.Settings.xml");
	vars.Helper.GameName = "Silent Hill f";
	vars.Helper.AlertLoadless();
	vars.Uhara.EnableDebug();
	vars.CompletedSplits = new HashSet<string>();
}

init
{
	IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 85 C0 75 ?? 48 83 C4 ?? 5B");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 8B 0D ???????? 48 8B BC 24 ???????? 48 8B 9C 24");
	IntPtr fNames = vars.Helper.ScanRel(3, "48 8D 0D ???????? E8 ???????? C6 05 ?????????? 0F 10 07");
	vars.GEngine = gEngine;

	vars.FNameToShortString = (Func<uint, string>)(fName =>
    {
        string name = vars.Events.FNameToString(fName);
        int under = name.LastIndexOf('_');
        return under >= 0 ? name.Substring(0, under + 1) : name;
    });

	vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");
	IntPtr WBP_Cutscene_C = vars.Events.InstancePtr("WBP_Cutscene_C", "");
	vars.Helper["CutsceneName"] = vars.Helper.Make<uint>(WBP_Cutscene_C, 0x460);
	vars.Helper["CutsceneName"].FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull;

	vars.Helper["GWorldName"] = vars.Helper.Make<uint>(gWorld, 0x18);
	vars.Helper["IsGameInitialized"] = vars.Helper.Make<bool>(gWorld, 0x158, 0x37A);
	vars.Helper["bWaitForRevive"] = vars.Helper.Make<bool>(gWorld, 0x158, 0x3B1);
	vars.Helper["ProgressTag"] = vars.Helper.Make<uint>(gWorld, 0x160, 0x328, 0x250);
	vars.Helper["LastAddedID"] = vars.Helper.Make<uint>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x408, 0xD4);
	vars.Helper["LocalPlayer"] = vars.Helper.Make<uint>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x18);
	vars.Helper["bIsInEvent"] = vars.Helper.Make<bool>(gEngine, 0x10A8, 0x38, 0x0, 0x30, 0x298, 0x708);
	
	current.Cutscene = "";
	current.Progress = "";
	current.World = "";
	current.Item = "";
	current.bIsInEvent = false;
	vars.gameStartCutscene = false;
	vars.cutsceneActive = false;
	vars.cutsceneHold = false;
	vars.NGPItemCollected = false;
	current.LocalPlayer = 0;

	vars.CutscenesToHold = new HashSet<string>() 
	{ 
		"LS_SC0106",
		"LS_SC0203", 
		"LS_SC0303", 
		"LS_SC0404", 
		"LS_SC0504",
		"LS_SC0604",
		"LS_SC0704",
		"LS_SC0806",
		"LS_SC1007",
		"LS_SC1103",
		"LS_SC1202",
		"LS_SC1301",
		"LS_SC1402",
	};
}

start
{
	if (current.Cutscene.Contains("LS_SC0101"))
	{
		vars.gameStartCutscene = true;
	}
	return vars.gameStartCutscene && current.World == "NoceWorld" && !current.bIsInEvent;
}

onStart
{
	vars.gameStartCutscene = false;
	vars.CompletedSplits.Clear();
	timer.IsGameTimePaused = true;
}

update
{
	vars.Helper.Update();
	vars.Helper.MapPointers();

	string cutscene = vars.Events.FNameToString(current.CutsceneName); 
	string newCutscene = (!string.IsNullOrEmpty(cutscene) && cutscene != "None") ? cutscene : "";
	if (newCutscene != current.Cutscene) current.Cutscene = newCutscene;

	string world = vars.Events.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None") current.World = world;

	string progress = vars.Events.FNameToString(current.ProgressTag);
	if (!string.IsNullOrEmpty(progress) && progress != "None" && current.World == "NoceWorld") current.Progress = progress;

	string item = vars.Events.FNameToString(current.LastAddedID);
	if (!string.IsNullOrEmpty(item) && item != "None") current.Item = item;
}

split
{
	bool didSplit = false;

	if (current.Item != old.Item 
		&& !vars.CompletedSplits.Contains(current.Item)
		&& settings.ContainsKey(current.Item)
		&& settings[current.Item]
		&& !current.Item.Contains("SwordOffering")
		&& !current.Item.Contains("SSword"))
	{
		vars.Log("--- Split Complete: " + current.Item);
		vars.CompletedSplits.Add(current.Item);
		didSplit = true;
	}

	if (old.Cutscene != current.Cutscene && !string.IsNullOrEmpty(current.Cutscene))
    {
        string baseCutscene = current.Cutscene.Substring(0, 9);

        if (settings.ContainsKey(baseCutscene) && settings[baseCutscene] 
            && !vars.CompletedSplits.Contains(baseCutscene))
        {
            vars.Log("--- Cutscene Split Complete: " + baseCutscene);
            vars.CompletedSplits.Add(baseCutscene);
            didSplit = true;
        }
    }

	if (!vars.CompletedSplits.Contains(current.Progress))
	{
		string baseProgress = current.Progress;

		if (baseProgress.EndsWith("Easy"))
			baseProgress = baseProgress.Substring(0, baseProgress.Length - 5);
		else if (baseProgress.EndsWith("Normal"))
			baseProgress = baseProgress.Substring(0, baseProgress.Length - 7);
		else if (baseProgress.EndsWith("Hard"))
			baseProgress = baseProgress.Substring(0, baseProgress.Length - 5);
		else if (baseProgress.StartsWith("Progress.Story.Ch16"))
			baseProgress = baseProgress.Substring(0, baseProgress.Length - 1);

		if (settings.ContainsKey(baseProgress) && settings[baseProgress] && !vars.CompletedSplits.Contains(baseProgress))
		{
			vars.Log("--- Progress Split Complete: " + baseProgress);
			vars.CompletedSplits.Add(baseProgress);
			didSplit = true;
		}
		else if (settings.ContainsKey(current.Progress) && settings[current.Progress] && !vars.CompletedSplits.Contains(current.Progress))
		{
			vars.Log("--- Progress Split Complete: " + current.Progress);
			vars.CompletedSplits.Add(current.Progress);
			didSplit = true;
		}
	}

	if (settings.ContainsKey("NewGamePlus") && settings["NewGamePlus"])
    {
        if (current.Item != old.Item 
            && current.Item.Contains("SwordOffering")
            && !vars.NGPItemCollected)
        {
            vars.Log("--- NG+ SwordOffering Item Collected: " + current.Item);
            vars.NGPItemCollected = true;
        }

        if (vars.NGPItemCollected 
            && current.Item != old.Item 
            && current.Item.Contains("SSword")
            && !vars.CompletedSplits.Contains(current.Item)
            && settings.ContainsKey(current.Item) && settings[current.Item])
        {
            vars.Log("--- NG+ Split Complete: " + current.Item);
            vars.CompletedSplits.Add(current.Item);
            didSplit = true;
            vars.NGPItemCollected = false;
        }
    }

	return didSplit;
}

isLoading
{
	bool loading = current.World == "NoceEntry"
				|| current.bWaitForRevive
				|| !current.IsGameInitialized
				|| vars.FNameToShortString(current.LocalPlayer) != "BP_Pl_Hina_PlayerController_"
				|| !string.IsNullOrEmpty(current.Cutscene);

	bool loading2 = vars.cutsceneHold;

	if (!string.IsNullOrEmpty(current.Cutscene) || vars.cutsceneActive)
	{
		vars.cutsceneActive = true;
		loading = true;

		if (string.IsNullOrEmpty(current.Cutscene) && !current.bIsInEvent)
		{
			vars.cutsceneActive = false;
		}
	}

	if (!vars.cutsceneHold && !string.IsNullOrEmpty(current.Cutscene) 
		&& vars.CutscenesToHold.Contains(current.Cutscene.Substring(0, 9)))
	{
		vars.cutsceneHold = true;
	}

	if (vars.cutsceneHold && !string.IsNullOrEmpty(current.Cutscene) 
		&& !vars.CutscenesToHold.Contains(current.Cutscene.Substring(0, 9)))
	{
		vars.cutsceneHold = false;
	}

	return loading || loading2;
}

reset
{
    if (settings["AutoReset"] && current.Cutscene.Contains("LS_SC0101") && old.Cutscene == "")
    {
        return true;
    }
}

exit
{
	timer.IsGameTimePaused = true;
}
