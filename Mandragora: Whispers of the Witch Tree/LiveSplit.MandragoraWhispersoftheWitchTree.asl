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
                settings.Add("Maddick_3", true, "Talk to inquisitor Maddick","WitchHunt_3");
                //settings.Add("SwampObj1_3", true, "Find a way to Gravseep Swamp","WitchHunt_3");
                settings.Add("AfterClayborn_3", true, "Pass through Old Wickham Monastery to reach the swamp","WitchHunt_3");
                settings.Add("Capture1_3", true, "Search the dungeons beneath the swamp","WitchHunt_3");
                settings.Add("Capture2_3", true, "Find a way to break through the shaky ground","WitchHunt_3");
                settings.Add("Capture3_3", true, "Descend deeper into the Dilapidated Mausoleum","WitchHunt_3");
                settings.Add("SwampObj2_3", true, "Find the witch's hideout","WitchHunt_3");
                settings.Add("Seal1_3", true, "Find the seals","WitchHunt_3");
                settings.Add("Seal2_3", true, "Place the seals on their pedestals","WitchHunt_3");
                settings.Add("SwampObj3_3", true, "Face the witch","WitchHunt_3");
            settings.Add("WolfAttack_3", true, "Wolf Attack","MQUESTS");
                settings.Add("Wargquest_Obj1_3", true, "Chase the wolves","WolfAttack_3");
                settings.Add("Wargquest_Obj2_3", true, "Talk to Ulfar","WolfAttack_3");
            settings.Add("Clayborne'sRequest_3", true, "Clayborne's Request","MQUESTS");
                settings.Add("Sewers_Ob1_3", true, "Cleanse the ruins below Wickham","Clayborne'sRequest_3");
                //settings.Add("Sewers_Ob2_3", false, "Talk to commander Clayborne","Clayborne'sRequest_3");
            settings.Add("ANoble'sDeath_3", true, "A Noble's Death","MQUESTS");
                settings.Add("Braer1_3", true, "Meet Branween at the Witch Tree","ANoble'sDeath_3");
                settings.Add("Braer4_3", true, "Enter the corrupted portal","ANoble'sDeath_3");
                settings.Add("Braer5_3", true, "Find a way out","ANoble'sDeath_3");
                //settings.Add("Feri1_3", true, "Find a way to reach Braer Island","ANoble'sDeath_3");
                //settings.Add("Feri2_3", false, "Meet the Ferryman","ANoble'sDeath_3");
                //settings.Add("Feri3_3", false, "Find the coin for the Ferryman","ANoble'sDeath_3");
                settings.Add("Feri4_3", true, "Bring the coin to the Ferryman","ANoble'sDeath_3");
                settings.Add("Braer2_3", true, "Travel to Braer Island","ANoble'sDeath_3");
                settings.Add("Braer3_3", true, "Find Lord Auberon","ANoble'sDeath_3");
            settings.Add("FindaFriend_3", true, "Find a Friend","MQUESTS");
                settings.Add("Friend1_3", true, "Find Rikter in Lochmuir Village","FindaFriend_3");
                //settings.Add("Friend2_3", false, "Talk to Killashandra","FindaFriend_3");
            settings.Add("TheTomeMistress_3", true, "The Tome Mistress","MQUESTS");
                settings.Add("Tome1_3", true, "Get to the right wing of Braer Castle","TheTomeMistress_3");
                settings.Add("Tome2_3", true, "Meet the Tome Mistress","TheTomeMistress_3");
                settings.Add("Tome3_3", true, "Find the room of the Tome Mistress","TheTomeMistress_3");
            settings.Add("DragonHeart_3", true, "Dragon Heart","MQUESTS");
                settings.Add("Dragon1_3", true, "Travel to Drakkeden Citadel","DragonHeart_3");
                settings.Add("Dragon2_3", true, "Find a way to the dragon's lair","DragonHeart_3");
                settings.Add("Dragon3_3", true, "Fidn the missing mechanical parts","DragonHeart_3");
                settings.Add("Dragon4_3", true, "Activate the mechanism","DragonHeart_3");
                settings.Add("Dragon5_3", true, "Get to the dragon","DragonHeart_3");
            settings.Add("NoDirections_3", true, "An Unusual Alliance","MQUESTS");
                settings.Add("Direction1_3", true, "Find Branween","NoDirections_3");
                settings.Add("Direction2_3", true, "Get to the bottom of Gloomroot Woods","NoDirections_3");
                settings.Add("Direction3_3", true, "Meet Matron Layla","NoDirections_3");
            settings.Add("TheWitchCoven_3", true, "The Witch Coven","MQUESTS");
                settings.Add("Coven1_3", true, "Find the hidden portal","TheWitchCoven_3");
                settings.Add("Coven2_3", true, "Travel to the Witch Coven","TheWitchCoven_3");
                settings.Add("Coven3_3", true, "Talk to the witches","TheWitchCoven_3");
                settings.Add("Coven4_3", true, "Wake the Sleepwalker","TheWitchCoven_3");
                settings.Add("Coven5_3", true, "Resurrect Mandragora","TheWitchCoven_3");
            settings.Add("TheCrimsonCity_3", true, "The Crimson City","MQUESTS");
                settings.Add("Crimson_01_3", true, "Find a way to reach Crimson City","TheCrimsonCity_3");
                settings.Add("Crimson_02_3", true, "Find the exit from the Umbral City","TheCrimsonCity_3");
                settings.Add("Crimson1_3", true, "Get to Crimson City","TheCrimsonCity_3");
                settings.Add("Crimson2_3", true, "Reach the Throne Room","TheCrimsonCity_3");
                settings.Add("Crimson3_3", true, "Confront the King Priest","TheCrimsonCity_3");
        settings.Add("BOSSES", true, "Splits for Defeating each Boss","MWOFWT");
            settings.Add("BP_Warg_Boss_C", false, "Warg","BOSSES");
            settings.Add("BP_VoidRat_C", false, "Corrupted Vermin","BOSSES");
            settings.Add("BP_LarcenistMiniboss_C", false, "Bandit Captain","BOSSES");
            settings.Add("BP_Caretaker_C", false, "Caretaker","BOSSES");
            settings.Add("BP_BanditBruteBoss_C", false, "Pepper","BOSSES");
            settings.Add("BP_SwampExplodingCaretaker2_C", false, "Blood Guardian","BOSSES");
            settings.Add("BP_SwampPoisonCaretaker3_C", false, "Plague Guardian","BOSSES");
            settings.Add("BP_Necromancer_C", false, "Necromancer","BOSSES");
            settings.Add("BP_FangExecutioner_C", false, "Fang Executioner","BOSSES");
            settings.Add("BP_JotunForest_C", false, "Forest Giant","BOSSES");
            settings.Add("BP_Mandragora_C", false, "Mandrake Horror","BOSSES");
            settings.Add("BP_Wraith_C", false, "Wraith","BOSSES");
            settings.Add("BP_VampireBeastMinibossCharacter_C", false, "Bloodfiend","BOSSES");
            settings.Add("BP_GiantAlbinoArachnid_C", false, "Paleweaver","BOSSES");
            settings.Add("BP_Ferryman_C", false, "Ferryman","BOSSES");
            settings.Add("BP_LaboratoryCaretaker4_C", false, "Dungeon Keeper","BOSSES");
            settings.Add("BP_CogRoomCaretaker5_C", false, "Slave Master","BOSSES");
            settings.Add("BP_VampireLord_C", false, "Lord Auberon","BOSSES");
            settings.Add("BP_MarionetteFamily_C", false, "Marionettes","BOSSES");
            settings.Add("BP_LibrarianBoss_C", false, "Tome Mistress","BOSSES");
            settings.Add("BP_Jotun_C", false, "Jotun","BOSSES");
            settings.Add("BP_ExpelledCourtMage_C", false, "Expelled Court Mage","BOSSES");
            settings.Add("BP_ChthonicStalker_C", false, "Cthonic Stalker","BOSSES");
            settings.Add("BP_Pyromancer_C", false, "Entropic Wyrm","BOSSES");
            settings.Add("BP_LycanthropeMatron_C", false, "Matron Layla","BOSSES");
            settings.Add("BP_ForestJotunEntropic_C", false, "Entropic Shade","BOSSES");
            settings.Add("BP_VoidWitch_C", false, "Sleepwalker","BOSSES");
            settings.Add("BP_Kezka_C", false, "Inquisitors","BOSSES");
            settings.Add("BP_FireDemon_C", false, "Darkfire Demon","BOSSES");
            settings.Add("BP_KingPriest_C", false, "King Priest","BOSSES");
        settings.Add("SQUESTS", false, "Splits for Side Quest Completion","MWOFWT");
            settings.Add("LettheRightOneIn_3", false, "Let the Right One In","SQUESTS");
            settings.Add("ChartingtheUnknown_3", false, "Charting the Unknown","SQUESTS");
            settings.Add("Pepper'sRequest_3", false, "Pepper's Request","SQUESTS");
            settings.Add("FreshAir_3", false, "Fresh Air","SQUESTS");
            settings.Add("BanditBoss_3", false, "Bandit Boss","SQUESTS");
            settings.Add("TheHauntedHouse_3", false, "The Haunted House","SQUESTS");
            settings.Add("Family Reunion_3", false, "Family Reunion","SQUESTS");
            settings.Add("Brothers Vanbelleghem_3", false, "Dragon Heart","SQUESTS");
            settings.Add("TheWitch' Call_3", false, "The Witch's Call","SQUESTS");
            settings.Add("StepIntotheSunlight_3", false, "Step into the Sunlight","SQUESTS");
            settings.Add("FreedomAtLast_3", false, "Freedom At Last","SQUESTS");
            settings.Add("TheTimelessTraveler_3", false, "The Timeless Traveler","SQUESTS");
            settings.Add("TheEyeofaDragon_3", false, "The Eye of a Dragon","SQUESTS");
            settings.Add("ALifeLeftBehind_3", false, "A Life Left Behind","SQUESTS");
            settings.Add("OldRegrets_3", false, "Old Regrets","SQUESTS");
            settings.Add("TheTalkingSkull_3", false, "The Talking Skull","SQUESTS");
            settings.Add("RelicHunters_3", false, "Relic Hunters","SQUESTS");
            settings.Add("EchoesofaDistantLand_3", false, "Echoes of a Distant Land","SQUESTS");
            settings.Add("OhSweet Memories_3", false, "Oh Sweet Memories","SQUESTS");
            settings.Add("StrangeMaterial_3", false, "Strange Material","SQUESTS");
            settings.Add("StrangeFabric_3", false, "Strange Fabric","SQUESTS");
            settings.Add("MagicBook_3", false, "Magic Book","SQUESTS");
            settings.Add("DangerousStudies_3", false, "Dangerous Studies","SQUESTS");
            settings.Add("Thief_3", false, "Thief","SQUESTS");
            settings.Add("MapofFaelduum_3", false, "Map of Faelduum","SQUESTS");
            settings.Add("AGourmetMeal_3", false, "A Gourmet Meal","SQUESTS");
            settings.Add("LostCompanion_3", false, "Lost Companion","SQUESTS");
            settings.Add("TheBrilliant_3", false, "The Brilliant","SQUESTS");
            settings.Add("TheAbandonedHouse_3", false, "The Abandoned House","SQUESTS");
            settings.Add("Stradivarius_3", false, "Stradivarius","SQUESTS");
}

init
{

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
    
    // GEngine.GameViewportClient.World.AuthorityGameMode.PersistentHeroData.QuestManager.DiscoveredQuests[0].QuestState
    vars.Helper["NewGameQuestsDiscovered"] = vars.Helper.Make<int>(gEngine, 0x780, 0x78, 0x118, 0x14F0, 0x328, 0x128, 0x0, 0x148); //Used to start the run when the Witch Hunt Quest becomes active

    // GEngine.GameInstance.LocalPlayers[0].PlayerController.Pawn.AttributeContainer.Health
    vars.Helper["PlayerHealth"] = vars.Helper.Make<float>(gEngine, 0xD38, 0x38, 0x0, 0x30, 0x258, 0xA10, 0x3360);

    // GEngine.GameInstance.EngineEventHandler.LoadCount
    vars.Helper["LoadCount"] = vars.Helper.Make<int>(gEngine, 0xD38, 0x380, 0x40);

    // GEngine.GameViewportClient.World.AuthorityGameMode.CurrentBossFightClass.Name
    vars.Helper["BossClass"] = vars.Helper.Make<ulong>(gEngine, 0x780, 0x78, 0x118, 0x13A0, 0x18);
    
    // GEngine.GameViewportClient.World.AuthorityGameMode.IsBossFightActive
    vars.Helper["BossActive"] = vars.Helper.Make<bool>(gEngine, 0x780, 0x78, 0x118, 0x15D9);

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
    return current.NewGameQuestsDiscovered == 1  && current.World != "MainMenu";
}

onStart
{
    vars.CompletedSplits.Clear();
    vars.Missions.Clear();
    vars.MissionObjectives.Clear();
    current.World = "";
    current.Boss = "";
}

split
{    
    bool shouldSplit = false;
        
    for (int i = 0; i < 50; i++)
    {
        string setting = "";

        // Missions
        ulong mission = vars.Helper.Read<ulong>(vars.gEngine, 0x780, 0x78, 0x118, 0x14F0, 0x328, 0x128, (i * 0x8), 0xA0);
        if (mission == 0)
            continue;

        int complete = vars.Helper.Read<int>(vars.gEngine, 0x780, 0x78, 0x118, 0x14F0, 0x328, 0x128, (i * 0x8), 0x140);
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

            ulong missionobj = vars.Helper.Read<ulong>(vars.gEngine, 0x780, 0x78, 0x118, 0x14F0, 0x328, 0x128, (i * 0x8), 0x130, (j * 0x8), 0x50);
            if (missionobj == 0)
                continue;

            int objcomplete = vars.Helper.Read<int>(vars.gEngine, 0x780, 0x78, 0x118, 0x14F0, 0x328, 0x128, (i * 0x8), 0x130, (j * 0x8), 0xA0);
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

// reset
// {
//     return current.World == "MainMenu" && current.NewGameQuestsDiscovered == 0;
// }

exit
{
    timer.IsGameTimePaused = true;
}
