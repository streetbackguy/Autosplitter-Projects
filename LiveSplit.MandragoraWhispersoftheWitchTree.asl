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
                settings.Add("Maddick_3", true, "Objective 1","WitchHunt_3");
                settings.Add("SwampObj1_3", true, "Objective 2","WitchHunt_3");
                settings.Add("AfterClayborn_3", true, "Objective 3","WitchHunt_3");
                settings.Add("Capture1_3", true, "Objective 4","WitchHunt_3");
                settings.Add("Capture2_3", true, "Objective 5","WitchHunt_3");
                settings.Add("Capture3_3", true, "Objective 6","WitchHunt_3");
                settings.Add("SwampObj2_3", true, "Objective 7","WitchHunt_3");
                settings.Add("Seal1_3", true, "Objective 8","WitchHunt_3");
                settings.Add("Seal2_3", true, "Objective 9","WitchHunt_3");
                settings.Add("SwampObj3_3", true, "Objective 10","WitchHunt_3");
            settings.Add("WolfAttack_3", true, "Wolf Attack","MQUESTS");
                settings.Add("Wargquest_Obj1_3", true, "Objective 1","WolfAttack_3");
                settings.Add("Wargquest_Obj2_3", true, "Objective 2","WolfAttack_3");
            settings.Add("Clayborne'sRequest_3", true, "Clayborne's Request","MQUESTS");
                settings.Add("Sewers_Ob1_3", true, "Objective 1","Clayborne'sRequest_3");
                settings.Add("Sewers_Ob2_3", true, "Objective 2","Clayborne'sRequest_3");
            settings.Add("ANoble'sDeath_3", true, "A Noble's Death","MQUESTS");
                settings.Add("Braer1_3", true, "Objective 1","ANoble'sDeath_3");
                settings.Add("Braer4_3", true, "Objective 2","ANoble'sDeath_3");
                settings.Add("Braer5_3", true, "Objective 3","ANoble'sDeath_3");
                settings.Add("Feri1_3", true, "Objective 4","ANoble'sDeath_3");
                settings.Add("Feri2_3", true, "Objective 5","ANoble'sDeath_3");
                settings.Add("Feri3_3", true, "Objective 6","ANoble'sDeath_3");
                settings.Add("Feri4_3", true, "Objective 7","ANoble'sDeath_3");
                settings.Add("Braer2_3", true, "Objective 8","ANoble'sDeath_3");
                settings.Add("Braer3_3", true, "Objective 9","ANoble'sDeath_3");
            settings.Add("FindaFriend_3", true, "Find a Friend","MQUESTS");
                settings.Add("Friend1_3", true, "Objective 1","FindaFriend_3");
                settings.Add("Friend2_3", true, "Objective 2","FindaFriend_3");
            settings.Add("TheTomeMistress_3", true, "Tome Mistress","MQUESTS");
                settings.Add("Tome1_3", true, "Objective 1","TheTomeMistress_3");
                settings.Add("Tome2_3", true, "Objective 2","TheTomeMistress_3");
                settings.Add("Tome3_3", true, "Objective 3","TheTomeMistress_3");
            settings.Add("DragonHeart_3", true, "Dragon Heart","MQUESTS");
                settings.Add("Dragon1_3", true, "Objective 1","DragonHeart_3");
                settings.Add("Dragon2_3", true, "Objective 2","DragonHeart_3");
                settings.Add("Dragon3_3", true, "Objective 3","DragonHeart_3");
                settings.Add("Dragon4_3", true, "Objective 4","DragonHeart_3");
                settings.Add("Dragon5_3", true, "Objective 5","DragonHeart_3");
            settings.Add("NoDirections_3", true, "An Unusual Alliance","MQUESTS");
                settings.Add("Direction1_3", true, "Objective 1","NoDirections_3");
                settings.Add("Direction2_3", true, "Objective 2","NoDirections_3");
                settings.Add("Direction3_3", true, "Objective 3","NoDirections_3");
            settings.Add("TheWitchCoven_3", true, "The Witch Coven","MQUESTS");
                settings.Add("Coven1_3", true, "Objective 1","TheWitchCoven_3");
                settings.Add("Coven2_3", true, "Objective 2","TheWitchCoven_3");
                settings.Add("Coven3_3", true, "Objective 3","TheWitchCoven_3");
                settings.Add("Coven4_3", true, "Objective 4","TheWitchCoven_3");
                settings.Add("Coven5_3", true, "Objective 5","TheWitchCoven_3");
            settings.Add("TheCrimsonCity_3", true, "The Crimson City","MQUESTS");
                settings.Add("Crimson_01_3", true, "Objective 1","TheCrimsonCity_3");
                settings.Add("Crimson_02_3", true, "Objective 2","TheCrimsonCity_3");
                settings.Add("Crimson1_3", true, "Objective 3","TheCrimsonCity_3");
                settings.Add("Crimson2_3", true, "Objective 4","TheCrimsonCity_3");
                settings.Add("Crimson3_3", true, "Objective 5","TheCrimsonCity_3");
        settings.Add("BOSSES", true, "Splits for Defeating each Boss","MWOFWT");
            settings.Add("BP_Warg_Boss_C", true, "Warg","BOSSES");
            settings.Add("BP_VoidRat_C", true, "Corrupted Vermin","BOSSES");
            settings.Add("BP_LarcenistMiniboss_C", true, "Bandit Captain","BOSSES");
            settings.Add("BP_Caretaker_C", true, "Caretaker","BOSSES");
            settings.Add("BP_BanditBruteBoss_C", true, "Pepper","BOSSES");
            settings.Add("BP_SwampExplodingCaretaker2_C", true, "Blood Guardian","BOSSES");
            settings.Add("BP_SwampPoisonCaretaker3_C", true, "Plague Guardian","BOSSES");
            settings.Add("BP_Necromancer_C", true, "Necromancer","BOSSES");
            settings.Add("BP_FangExecutioner_C", true, "Fang Executioner","BOSSES");
            settings.Add("BP_JotunForest_C", true, "Forest Giant","BOSSES");
            settings.Add("BP_Mandragora_C", true, "Mandrake Horror","BOSSES");
            settings.Add("BP_Wraith_C", true, "Wraith","BOSSES");
            settings.Add("BP_VampireBeastMinibossCharacter_C", true, "Bloodfiend","BOSSES");
            settings.Add("BP_GiantAlbinoArachnid_C", true, "Paleweaver","BOSSES");
            settings.Add("BP_Ferryman_C", true, "Ferryman","BOSSES");
            settings.Add("BP_LaboratoryCaretaker4_C", true, "Dungeon Keeper","BOSSES");
            settings.Add("BP_CogRoomCaretaker5_C", true, "Slave Master","BOSSES");
            settings.Add("BP_VampireLord_C", true, "Lord Auberon","BOSSES");
            settings.Add("BP_MarionetteFamily_C", true, "Marionettes","BOSSES");
            settings.Add("BP_LibrarianBoss_C", true, "Tome Mistress","BOSSES");
            settings.Add("BP_Jotun_C", true, "Jotun","BOSSES");
            settings.Add("BP_ExpelledCourtMage_C", true, "Expelled Court Mage","BOSSES");
            settings.Add("BP_ChthonicStalker_C", true, "Cthonic Stalker","BOSSES");
            settings.Add("BP_Pyromancer_C", true, "Entropic Wyrm","BOSSES");
            settings.Add("BP_LycanthropeMatron_C", true, "Matron Layla","BOSSES");
            settings.Add("BP_ForestJotunEntropic_C", true, "Entropic Shade","BOSSES");
            settings.Add("BP_VoidWitch_C", true, "Sleepwalker","BOSSES");
            settings.Add("BP_Kezka_C", true, "Inquisitors","BOSSES");
            settings.Add("BP_FireDemon_C", true, "Darkfire Demon","BOSSES");
            settings.Add("BP_KingPriest_C", true, "King Priest","BOSSES");
        settings.Add("SQUESTS", true, "Splits for Side Quest Completion","MWOFWT");
            settings.Add("LettheRightOneIn_3", true, "Let the Right One In","SQUESTS");
            settings.Add("ChartingtheUnknown_3", true, "Charting the Unknown","SQUESTS");
            settings.Add("Pepper'sRequest_3", true, "Pepper's Request","SQUESTS");
            settings.Add("FreshAir_3", true, "Fresh Air","SQUESTS");
            settings.Add("BanditBoss_3", true, "Bandit Boss","SQUESTS");
            settings.Add("TheHauntedHouse_3", true, "The Haunted House","SQUESTS");
            settings.Add("Family Reunion_3", true, "Family Reunion","SQUESTS");
            settings.Add("Brothers Vanbelleghem_3", true, "Dragon Heart","SQUESTS");
            settings.Add("TheWitch' Call_3", true, "The Witch's Call","SQUESTS");
            settings.Add("StepIntotheSunlight_3", true, "Step into the Sunlight","SQUESTS");
            settings.Add("FreedomAtLast_3", true, "Freedom At Last","SQUESTS");
            settings.Add("TheTimelessTraveler_3", true, "The Timeless Traveler","SQUESTS");
            settings.Add("TheEyeofaDragon_3", true, "The Eye of a Dragon","SQUESTS");
            settings.Add("ALifeLeftBehind_3", true, "A Life Left Behind","SQUESTS");
            settings.Add("OldRegrets_3", true, "Old Regrets","SQUESTS");
            settings.Add("TheTalkingSkull_3", true, "The Talking Skull","SQUESTS");
            settings.Add("RelicHunters_3", true, "Relic Hunters","SQUESTS");
            settings.Add("EchoesofaDistantLand_3", true, "Echoes of a Distant Land","SQUESTS");
            settings.Add("OhSweet Memories_3", true, "Oh Sweet Memories","SQUESTS");
            settings.Add("StrangeMaterial_3", true, "Strange Material","SQUESTS");
            settings.Add("StrangeFabric_3", true, "Strange Fabric","SQUESTS");
            settings.Add("MagicBook_3", true, "Magic Book","SQUESTS");
            settings.Add("DangerousStudies_3", true, "Dangerous Studies","SQUESTS");
            settings.Add("Thief_3", true, "Thief","SQUESTS");
            settings.Add("MapofFaelduum_3", true, "Map of Faelduum","SQUESTS");
            settings.Add("AGourmetMeal_3", true, "A Gourmet Meal","SQUESTS");
            settings.Add("LostCompanion_3", true, "Lost Companion","SQUESTS");
            settings.Add("TheBrilliant_3", true, "The Brilliant","SQUESTS");
            settings.Add("TheAbandonedHouse_3", true, "The Abandoned House","SQUESTS");
            settings.Add("Stradivarius_3", true, "Stradivarius","SQUESTS");
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

            case "F6801423407A504E7070C230F3CC6703":
                version = "Steam 1.2.10.2225";
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

    // GEngine.GameInstance.LocalPlayers[0].PlayerController.Pawn.AttributeContainer.Health
    vars.Helper["PlayerHealth"] = vars.Helper.Make<float>(gEngine, 0xD38, 0x38, 0x0, 0x30, 0x258, 0xA20, 0x3388);

    // GEngine.GameInstance.bFirstGameStart
    vars.Helper["FirstGameStart"] = vars.Helper.Make<bool>(gEngine, 0xD38, 0x206);

    // GEngine.GameInstance.EngineEventHandler.LoadCount
    if(version == "Steam 1.2.10.2225")
    {
        vars.Helper["LoadCount"] = vars.Helper.Make<int>(gEngine, 0xD38, 0x378, 0x40);
    } else {
        vars.Helper["LoadCount"] = vars.Helper.Make<int>(gEngine, 0xD38, 0x368, 0x40);
    }

    // GEngine.GameViewportClient.World.AuthorityGameMode.CurrentBossFightClass.Name
    vars.Helper["BossClass"] = vars.Helper.Make<ulong>(gEngine, 0x780, 0x78, 0x118, 0x1318, 0x18);
    
    // GEngine.GameViewportClient.World.AuthorityGameMode.IsBossFightActive
    vars.Helper["BossActive"] = vars.Helper.Make<bool>(gEngine, 0x780, 0x78, 0x118, 0x1539);

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

    vars.Missions = new Dictionary<ulong, int>();
    vars.MissionObjectives = new Dictionary<ulong, int>();
    vars.FNameCache = new Dictionary<ulong, string>();
    vars.gEngine = gEngine;
    current.World = "";
    current.Boss = "";
}

update
{
    vars.Helper.Update();
	vars.Helper.MapPointers();

    var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;

    var boss = vars.FNameToString(current.BossClass);
	if (!string.IsNullOrEmpty(boss) && boss != "None")
        current.Boss = boss;
}

start
{
    int complete = vars.Helper.Read<int>(vars.gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, 0x8, 0x168);

    if(complete == 3 && !current.FirstGameStart && current.World != "MainMenu" && current.LoadCount != 1)
    {
        return false;
    } else if (complete != 3 && !current.FirstGameStart && current.World != "MainMenu" && current.LoadCount != 1)
    {
        return true;
    }
}

onStart
{
    vars.CompletedSplits.Clear();
    vars.Missions.Clear();
    vars.MissionObjectives.Clear();
}

split
{    
    bool shouldSplit = false;

    for (int i = 0; i < 50; i++)
    {
        string setting = "";

        // Missions
        ulong mission = vars.Helper.Read<ulong>(vars.gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, (i * 0x8), 0xC8);
        if (mission == 0)
            continue;

        int complete = vars.Helper.Read<int>(vars.gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, (i * 0x8), 0x168);
        int oldComplete = vars.Missions.ContainsKey(mission) ? vars.Missions[mission] : -1;

        // Early skip if already fully complete and no change
        if (complete == oldComplete)
            goto Objectives;

        vars.Missions[mission] = complete;

        if (complete == 3 && oldComplete != 3)
        {
            if (!vars.FNameCache.ContainsKey(mission))
            {
                vars.FNameCache[mission] = vars.FNameToString(mission);
            }
            setting = vars.FNameCache[mission] + "_" + complete;
        }

        if (!string.IsNullOrEmpty(setting) && settings.ContainsKey(setting) && settings[setting] && !vars.CompletedSplits.Contains(setting))
        {
            vars.CompletedSplits.Add(setting);
            shouldSplit = true;
            vars.Log("Split Complete: " + setting);
        }

    Objectives:
        // Mission Objectives
        for (int j = 0; j < 10; j++)
        {
            string objSetting = "";

            ulong missionobj = vars.Helper.Read<ulong>(vars.gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, (i * 0x8), 0x158, (j * 0x8), 0x78);
            if (missionobj == 0)
                continue;

            int objcomplete = vars.Helper.Read<int>(vars.gEngine, 0x780, 0x78, 0x118, 0x14C0, 0x338, 0x150, (i * 0x8), 0x158, (j * 0x8), 0xC8);
            int oldObjComplete = vars.MissionObjectives.ContainsKey(missionobj) ? vars.MissionObjectives[missionobj] : -1;

            if (objcomplete == oldObjComplete)
                continue;

            vars.MissionObjectives[missionobj] = objcomplete;

            if (objcomplete == 3 && oldObjComplete != 3)
            {
                if (!vars.FNameCache.ContainsKey(missionobj))
                {
                    vars.FNameCache[missionobj] = vars.FNameToString(missionobj);
                }
                objSetting = vars.FNameCache[missionobj] + "_" + objcomplete;
            }

            if (!string.IsNullOrEmpty(objSetting) && settings.ContainsKey(objSetting) && settings[objSetting] && !vars.CompletedSplits.Contains(objSetting))
            {
                vars.CompletedSplits.Add(objSetting);
                shouldSplit = true;
                vars.Log("Split Complete: " + objSetting);
            }
        }
    }

    if(shouldSplit)
    {
        return true;
    }

    if (!string.IsNullOrEmpty(old.Boss) && current.PlayerHealth > 0.0f && !current.BossActive && !vars.CompletedSplits.Contains(old.Boss))
    {
        return settings[old.Boss] && vars.CompletedSplits.Add(old.Boss);
    }
}

isLoading
{
    return current.GSync || current.LoadCount != 0;
}

reset
{
    return current.World == "MainMenu";
}

exit
{
    timer.IsGameTimePaused = true;
}
