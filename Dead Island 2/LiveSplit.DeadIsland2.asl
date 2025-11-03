state("DeadIsland-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "Dead Island 2";
	vars.Helper.AlertLoadless();
}

init
{
    IntPtr gWorld = vars.Helper.ScanRel(8, "0F 2E ?? 74 ?? 48 8B 1D ?? ?? ?? ?? 48 85 DB 74");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 89 05 ?? ?? ?? ?? 48 85 c9 74 ?? e8 ?? ?? ?? ?? 48 8d 4d");
	IntPtr fNames = vars.Helper.ScanRel(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15");
    IntPtr gSync = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    // GWorld.Name
	vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSync);

    vars.Helper["ActiveMission"] = vars.Helper.MakeString(gEngine, 0xEA8, 0x6F8, 0xE8, 0x0, 0x78, 0x28, 0x28, 0x0);

    // GWorld.PersistentLevel.WorldSettings.LoadingSceneManager.IsEnding
    vars.Helper["LoadingScreen"] = vars.Helper.Make<byte>(gWorld, 0x30, 0x248, 0x740, 0x538);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.AcknowledgedPawn.PlayerMovementComponent.MovementMode
    vars.Helper["InCutscene"] = vars.Helper.Make<byte>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2D8, 0x1280, 0x1A4);

    // GEngine.GameInstance.MasterHUDFader
    vars.Helper["HUDFades"] = vars.Helper.Make<int>(gEngine, 0xEA8, 0x3F8, 0x58);

    // GEngine.GameInstance.ActiveMissions[0].MissionData.Count
    vars.Helper["ActiveMissionCount"] = vars.Helper.Make<int>(gEngine, 0xEA8, 0x6F8, 0xF4);

    // GEngine.GameInstance.LocalPlayer[0].PlayerController.MyHUD.StateMgr.EnabledHUDStates[0].bActiveState
    vars.Helper["HUDStateCount"] = vars.Helper.Make<int>(gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x11C);

    // GEngine.GameInstance.MenuManager.ActiveMenus[0].Name
    vars.Helper["MenuName"] = vars.Helper.Make<ulong>(gEngine, 0xEA8, 0x3E0, 0x58, 0x0, 0x18);

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
    current.MQMission = "";
    current.SQMission = "";
    current.Menu = "";
    vars.Splits = new HashSet<string>();
    vars.gEngine = gEngine;
    vars.Loading = false;
}

start
{
    return current.ActiveMission == "MQ01 (WIP) DEATH FLIGHT 71" && old.InCutscene == 5 && current.InCutscene == 1;
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
	// if (old.World != current.World) vars.Log("GWorldName: " + current.World.ToString());

    var menu = vars.FNameToString(current.MenuName);
	if (!string.IsNullOrEmpty(menu) && menu != "None")
		current.Menu = menu;
	if (old.Menu != current.Menu) vars.Log("Menu: " + current.Menu.ToString());

    current.ActiveMQMissions = new List<string>();
    current.ActiveSQMissions = new List<string>();
    int count = current.ActiveMissionCount;

    for (int i = 0; i < count; i++)
    {
        string mqmission = vars.Helper.ReadString(128, ReadStringType.UTF16, vars.gEngine, 0xEA8, 0x6F8, 0xE8, (i * 0x8), 0x78, 0x28, 0x28, 0x0);

        if (!string.IsNullOrEmpty(mqmission))
            current.ActiveMQMissions.Add(mqmission);
    }

    if (old.ActiveMQMissions != null)
    {
        for (int i = 0; i < current.ActiveMQMissions.Count; i++)
        {
            if (current.ActiveMQMissions[i].StartsWith("MQ"))
            {
                if (i >= old.ActiveMQMissions.Count || current.ActiveMQMissions[i] != old.ActiveMQMissions[i])
                {
                    current.MQMission = current.ActiveMQMissions[i];
                    vars.Log("Current MQ Mission: " + current.MQMission);
                }
            }
        }
    }

    for (int i = 0; i < current.ActiveMissionCount; i++)
    {
        string sqmission = vars.Helper.ReadString(128, ReadStringType.UTF16, vars.gEngine, 0xEA8, 0x6F8, 0xE8, (i * 0x8), 0x78, 0x28, 0x28, 0x0);

        if (!string.IsNullOrEmpty(sqmission) && sqmission.StartsWith("SQ"))
        {
            current.ActiveSQMissions.Add(sqmission);
        }
    }

    current.CompletedSideQuest = "";

    foreach (string oldQuest in old.ActiveSQMissions)
    {
        if (!current.ActiveSQMissions.Contains(oldQuest))
        {
            current.CompletedSideQuest = oldQuest;
            vars.Log("SQ Complete: " + oldQuest);
        }
    }

    // vars.Log(current.LoadingScreen);
    // vars.Log(current.InCutscene);

    for (int i = 0; i < current.HUDStateCount; i++)
    {
        int hudstateenabled = vars.Helper.Read<int>(vars.gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x110, (i * 0x8), 0xA0);
        ulong hudstatename = vars.Helper.Read<ulong>(vars.gEngine, 0xEA8, 0x38, 0x0, 0x30, 0x2E8, 0x358, 0x110, (i * 0x8), 0x18);

        var statename = vars.FNameToString(hudstatename);

        if (statename == "BP_HUDState_Cutscene_C" && hudstateenabled == 1)
        {
            vars.Loading = true;
        } else 
        {
            vars.Loading = false;
        }
    }
}

split
{
    for (int i = 0; i < current.ActiveMissionCount; i++)
    { 
        if (old.MQMission.StartsWith("MQ") && current.MQMission.StartsWith("MQ") && current.MQMission != old.MQMission && !current.Menu.StartsWith("BP_MenuInstance_InGamePauseMenu_C") && !vars.Splits.Contains(old.MQMission)) 
        { 
            vars.Log("MQ Split Complete: " + old.MQMission);
            return true && vars.Splits.Add(old.MQMission); 
        }
    }

    if (!string.IsNullOrEmpty(current.CompletedSideQuest) && !current.Menu.StartsWith("BP_MenuInstance_InGamePauseMenu_C") && !vars.Splits.Contains(current.CompletedSideQuest))
    {
        vars.Log("SQ Split Complete: " + current.CompletedSideQuest);
        return true && vars.Splits.Add(current.CompletedSideQuest);
    }
}

isLoading
{
    return current.GSync || current.HUDFades >= 1065000000 || vars.Loading || current.Menu.StartsWith("BP_MenuInstance_FrontEnd_C") || current.LoadingScreen == 0 || vars.Loading && current.InCutscene == 5;
}

exit
{
    timer.IsGameTimePaused = true;
}
