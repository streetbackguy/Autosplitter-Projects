state("man-Win64-Shipping")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "Mandragora: Whispers of the Witch Tree";
	vars.Helper.AlertLoadless();

    vars.CompletedSplits = new HashSet<string>();

    settings.Add("MWOFWT", true, "Mandragora: Whispers of the Witch Tree");
        settings.Add("MQUESTS", true, "Splits for Main Quest Completion","MWOFWT");
            settings.Add("WitchHunt_3", true, "Witch Hunt","MQUESTS");
            settings.Add("WolfAttack_3", true, "Wolf Attack","MQUESTS");
            settings.Add("ClaybornesRequest_3", true, "Clayborne's Request","MQUESTS");
            settings.Add("ANoblesDeath_3", true, "A Noble's Death","MQUESTS");
            settings.Add("FindaFriend_3", true, "Find a Friend","MQUESTS");
            settings.Add("TomeMistress_3", true, "Tome Mistress","MQUESTS");
            settings.Add("DragonHeart_3", true, "Dragon Heart","MQUESTS");
            settings.Add("NoDirections_3", true, "An Unusual Alliance","MQUESTS");
            settings.Add("TheWitchCoven_3", true, "The Witch Coven","MQUESTS");
            settings.Add("TheCrimsonCity_3", true, "The Crimson City","MQUESTS");
        settings.Add("SQUESTS", true, "Splits for Side Quest Completion","MWOFWT");
            settings.Add("LettheRightOneIn_3", true, "Let the Right One In","SQUESTS");
            settings.Add("ChartingtheUnknown_3", true, "Charting the Unknown","SQUESTS");
            settings.Add("PeppersRequest_3", true, "Pepper's Request","SQUESTS");
            settings.Add("FreshAir_3", true, "Fresh Air","SQUESTS");
            settings.Add("BanditBoss_3", true, "Bandit Boss","SQUESTS");
            settings.Add("TheHauntedHouse_3", true, "The Haunted House","SQUESTS");
            settings.Add("FamilyReunion_3", true, "Family Reunion","SQUESTS");
            settings.Add("BrothersVanbelleghemBj_3", true, "Dragon Heart","SQUESTS");
            settings.Add("TheWitchsCall_3", true, "The Witch's Call","SQUESTS");
            settings.Add("StepIntotheSunlight_3", true, "Step into the Sunlight","SQUESTS");
            settings.Add("FreedomAtLast_3", true, "Freedom At Last","SQUESTS");
            settings.Add("TheTimelessTraveler_3", true, "The Timeless Traveler","SQUESTS");
            settings.Add("TheEyeofaDragon_3", true, "The Eye of a Dragon","SQUESTS");
            settings.Add("ALifeLeftBehind_3", true, "A Life Left Behind","SQUESTS");
            settings.Add("OldRegrets_3", true, "Old Regrets","SQUESTS");
            settings.Add("TheTalkingSkull_3", true, "The Talking Skull","SQUESTS");
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
            case "32D5CF1D9F2AF351BAC3B64523E670AE":
                version = "Steam 1.2.6.2165";
                break;

            case "31E56F416C87CDF918723E2E6CB20713":
                version = "Steam 1.2.7.2168";
                break;

            case "021B2902C662D2DA8EB5F1861948E5CA":
                version = "Steam 1.2.8.2172";
                break;

            case "AFF4FFA31D81E17AEBAF542776A7E67D":
                version = "Steam 1.2.9.2198";
                break;

            default:
                version = "Unknown";
                break;
        }

    IntPtr gWorld = vars.Helper.ScanRel(3, "48 8B 05 ???????? 48 3B C? 48 0F 44 C? 48 89 05 ???????? E8");
	IntPtr gEngine = vars.Helper.ScanRel(3, "48 89 05 ???????? 48 85 c9 74 ?? e8 ???????? 48 8d 4d");
	IntPtr fNames = vars.Helper.ScanRel(3, "48 8d 05 ???????? eb ?? 48 8d 0d ???????? e8 ???????? c6 05");
    IntPtr gSyncLoadCount = vars.Helper.ScanRel(5, "89 43 60 8B 05 ?? ?? ?? ??");

    if (gWorld == IntPtr.Zero || gEngine == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}

    // GWorld.FName
    vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);

    // Not used currently, the health one works but the name one doesn't for some reason
    // GEngine.GameInstance.BP_HUD_C.WidgetTree.BP_AnimatedProgressBar_BossHP_C
    // vars.Helper["BossName"] = vars.Helper.Make<ulong>(gEngine, 0xD38, 0x4B0, 0x780, 0xE8, 0x668, 0x768, 0x2E8);
    // GEngine.GameInstance.BP_HUD_C.WidgetTree.BP_AnimatedProgressBar_BossHP_C
    // vars.Helper["BossHP"] = vars.Helper.Make<float>(gEngine, 0xD38, 0x4B0, 0x780, 0xE8, 0x668, 0x768, 0x33C);

    // Below is for information in case it's needed

    // // GEngine.GameViewportClient.World.AuthorityGameMode.PersistentHeroData.QuestManager.DiscoveredQuests[0].questName
    // vars.Helper["Slot1QuestName"] = vars.Helper.Make<ulong>(gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, 0x0, 0xC8);
    // // GEngine.GameViewportClient.World.AuthorityGameMode.PersistentHeroData.QuestManager.DiscoveredQuests[0].QuestState
    // vars.Helper["Slot1QuestState"] = vars.Helper.Make<int>(gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, 0x0, 0x168);

    // // GEngine.GameViewportClient.World.AuthorityGameMode.PersistentHeroData.QuestManager.DiscoveredQuests[1].questName
    // vars.Helper["Slot2QuestName"] = vars.Helper.Make<ulong>(gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, 0x8, 0xC8);
    // // GEngine.GameViewportClient.World.AuthorityGameMode.PersistentHeroData.QuestManager.DiscoveredQuests[1].QuestState
    // vars.Helper["Slot2QuestState"] = vars.Helper.Make<int>(gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, 0x8, 0x168);

    vars.Helper["GSync"] = vars.Helper.Make<bool>(gSyncLoadCount);

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
    vars.MainMissions = new Dictionary<ulong, int>();
    vars.gEngine = gEngine;
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
    return current.World == "Tutorial_Persistent" && !current.GSync;
}

onStart
{
    vars.CompletedSplits.Clear();
}

split
{
    string setting = "";
    
    for (int i = 0; i < 32; i++){
        ulong mission = vars.Helper.Read<ulong>(vars.gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, 0x0 + (i * 0x8), 0xC8);
        int complete = vars.Helper.Read<int>(vars.gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, 0x0 + (i * 0x8), 0x168);

        int oldComplete;
        if (vars.MainMissions.TryGetValue(mission, out oldComplete))
        {
            if (complete == 3 && oldComplete != 3)
            {
                setting = vars.FNameToString(mission) + "_" + complete;
            }
        }
        
        vars.MainMissions[mission] = complete;
            
        // Debug. Comment out before release.
        //if (!string.IsNullOrEmpty(setting))
        //vars.Log(setting);
        
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            return true && vars.Log("Split Complete: " + setting);
        }
    }
}

isLoading
{
    return current.GSync;
}

reset
{
    return current.World == "MainMenu";
}

exit
{
    timer.IsGameTimePaused = true;
}
