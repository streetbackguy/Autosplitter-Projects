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
        settings.Add("BOSSES", true, "Splits for Defeating each Boss","MWOFWT");
            settings.Add("BP_WargBoss_C", true, "Warg","BOSSES");
            settings.Add("Corrupted Vermin", true, "Corrupted Vermin","BOSSES");
            settings.Add("Bandit Captain", true, "Bandit Captain","BOSSES");
            settings.Add("Caretaker", true, "Caretaker","BOSSES");
            settings.Add("Pepper", true, "Pepper","BOSSES");
            settings.Add("Blood Guardian", true, "Blood Guardian","BOSSES");
            settings.Add("Necromancer", true, "Necromancer","BOSSES");
            settings.Add("Fang Executioner", true, "Fang Executioner","BOSSES");
            settings.Add("Forest Giant", true, "Forest Giant","BOSSES");
            settings.Add("Mandrake Horror", true, "Mandrake Horror","BOSSES");
            settings.Add("Wraith", true, "Wraith","BOSSES");
            settings.Add("Bloodfiend", true, "Bloodfiend","BOSSES");
            settings.Add("Paleweaver", true, "Paleweaver","BOSSES");
            settings.Add("Ferryman", true, "Ferryman","BOSSES");
            settings.Add("Dungeon Keeper", true, "Dungeon Keeper","BOSSES");
            settings.Add("Slave Master", true, "Slave Master","BOSSES");
            settings.Add("Lord Auberon", true, "Lord Auberon","BOSSES");
            settings.Add("Marionettes", true, "Marionettes","BOSSES");
            settings.Add("Tome Mistress", true, "Tome Mistress","BOSSES");
            settings.Add("Jotun", true, "Jotun","BOSSES");
            settings.Add("Expelled Court Mage", true, "Expelled Court Mage","BOSSES");
            settings.Add("Cthonic Stalker", true, "Cthonic Stalker","BOSSES");
            settings.Add("Entropic Wyrm", true, "Entropic Wyrm","BOSSES");
            settings.Add("Darkfire Demon", true, "Darkfire Demon","BOSSES");
            settings.Add("Matron Layla", true, "Matron Layla","BOSSES");
            settings.Add("Entropic Shade", true, "Entropic Shade","BOSSES");
            settings.Add("Sleepwalker", true, "Sleepwalker","BOSSES");
            settings.Add("Kezka+Olen", true, "Inquisitors","BOSSES");
            settings.Add("Darkfire Demon2", true, "Darkfire Demon (Crimson City)","BOSSES");
            settings.Add("King Priest", true, "King Priest","BOSSES");
            settings.Add("King Priest2", true, "King Priest Second Phase","BOSSES");
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

    // GEngine.GameInstance.LocalPlayers[0].PlayerController.Pawn.AttributeContainer.Health
    vars.Helper["PlayerHealth"] = vars.Helper.Make<float>(gEngine, 0xD38, 0x38, 0x0, 0x30, 0x258, 0xA20, 0x3388);

    // GEngine.GameInstance.NewCharacterStartData.CharacterName
    vars.Helper["NewGame"] = vars.Helper.Make<ulong>(gEngine, 0xD38, 0x1E8, 0x18);

    // GEngine.GameInstance.EngineEventHandler.LoadCount
    vars.Helper["LoadCount"] = vars.Helper.Make<int>(gEngine, 0xD38, 0x368, 0x40);

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

    current.World = "";
    vars.MainMissions = new Dictionary<ulong, int>();
    vars.gEngine = gEngine;
    current.Boss = "";
    current.Start = "";
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

    var ng = vars.FNameToString(current.NewGame);
	if (!string.IsNullOrEmpty(ng) && ng != "None")
		current.Start = ng;
}

start
{
    return current.Start.StartsWith("NewCharacterStartData");
}

onStart
{
    vars.CompletedSplits.Clear();
}

split
{
    string setting = "";
    
    for (int i = 0; i < 32; i++)
    {
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
        //vars.Log(setting);1
        
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            return true && vars.Log("Split Complete: " + setting);
        }
    }

    if(current.Boss != "" && !current.BossActive && current.PlayerHealth > 0)
    {
        return settings[current.Boss] && vars.CompletedSplits.Add(current.Boss) && vars.Log("Split Complete: " + current.Boss);
    }
}

isLoading
{
    return current.GSync || current.LoadCount != 0;
}

reset
{
    return current.World == "MainMenu" && old.LoadCount == 1 && !current.Start.StartsWith("NewCharacterStartData");
}

exit
{
    timer.IsGameTimePaused = true;
}
