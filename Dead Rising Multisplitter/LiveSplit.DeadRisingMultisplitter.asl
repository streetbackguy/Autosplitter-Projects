// Dead Rising
state("DeadRising")
{
    bool IsLoading : 0x1945F70, 0x70;

    // Used for subcase splitting
    byte CaseMenuState : 0x1946FC0, 0x2F058, 0x182;
    
    // Various split variables
    byte Bombs : 0x1944DD8, 0x20DC0, 0x848D;
    byte WatchCase1 : 0x1D18C80, 0x1F58;
    byte WatchCase2 : 0x1D18C80, 0x1F5F;
    byte WatchCase3 : 0x1D18C80, 0x1F66;
    byte WatchCase4 : 0x1D18C80, 0x1F6D;
    byte PPRewardText1 : 0x1946950, 0x154;
    byte PPRewardText2 : 0x1946950, 0x80;
    int CampaignProgress : 0x1944DD8, 0x20DC0, 0x150;
    int CutsceneId : 0x1944DD8, 0x20DC0, 0x8308;
    int Supplies : 0x1944DD8, 0x20FB0;
    int InGameTime : 0x1946FC0, 0x2F058, 0x198;
    int PlayerKills : 0x1959EA0, 0x3B0;
    int PlayerLevel : 0x1946950, 0x68;
    int RoomId : 0x1945F70, 0x48;
    float BossHealth : 0x1CF2620, 0x118, 0x12EC;
    float Boss2Health : 0x1CF2620, 0x118, 0x10, 0x12EC;
    float Boss3Health : 0x1CF2620, 0x118, 0x10, 0x10, 0x12EC;
    float Convict1Health : 0x1CF2620, 0xA0, 0x1220, 0x1C0, 0x12EC;
    float Convict2Health : 0x1CF2620, 0xA0, 0x1220, 0x1A0, 0x12EC;
    float Convict3Health : 0x1CF2620, 0xA0, 0x1220, 0x180, 0x12EC;
    uint PhotoStatsPtr : 0x1959EA0, 0xA8;
    int Transmissions : 0x1946398, 0xD10, 0xCA8, 0xCA8, 0xCB0;
}

// Dead Rising 2
state("deadrising2")
{
    bool Loads: 0x9DC3F0, 0x38, 0x1C8;
    int RoomId: 0x00E1A8C, 0x0;
    string255 Cutscene: 0x09DC3F0, 0x38, 0xCC;
    int KillCount: 0x09DE9A8, 0x0, 0x444;
    float PlayerHealth: 0x00A1162C, 0x2C8 , 0x2C, 0x64, 0x2C;
    int PlayerLevel: 0x09CB124, 0x4, 0x98, 0x20;
    int PlayerCash: 0x09DE9A8, 0x8, 0x70;
    int CaseMenu: 0x009DE9A8, 0x0, 0xA4;
    float BossHealth: 0x09DC488, 0xE8, 0x12C, 0x28, 0x16C, 0x1AC;
    string255 InfoBox: 0x0A11604, 0x194, 0xFC, 0x58;
    int Timer: 0x009DD170, 0x284, 0xE4, 0x2B94;
    int TIRTimer: 0x0097F2B8, 0x34, 0x1C, 0x3C8, 0x3F;
}

// Dead Rising 3
state("deadrising3")
{
    string9 BackupCC: 0x1713ABB;
    string9 CurrentChapter: 0X01714FA0, 0XE98, 0X0;
    string110 CurrentObjective: 0x01713D38, 0xCD0, 0X2A0, 0X7B0, 0X130, 0X2D0, 0X460;
    uint Loader: 0x0199DE40, 0xE0, 0X8, 0X1308;
    long CurBossPtr: 0x019A78D0, 0x120, 0x50, 0x530, 0x1A8, 0x678;
    string110 LastOBJGiven: 0x01713D28, 0x30, 0x58, 0x468, 0xF0;  //ONLY APPLIES TO SIDE OBJS NOT MAIN OBJS
    int BossHealth: 0x01A0CF38, 0x90, 0x28, 0x8, 0xB0, 0x8, 0x10;
    int FrankStatues: 0x01A0D130, 0x90, 0x810, 0x0, 0x120, 0x18, 0x40, 0x7B0;
    int EnterPlane: 0x016F4128, 0x138, 0x30, 0x18, 0x140;
}

// Dead Rising 4
state("deadrising4")
{
    int Loading : 0x3352C54;
    int Loading2 : 0x32B0C90;
    int MGSummary : 0x337A3F0;
    int Paradigm : 0x3352CD8;
    byte MainMenu : 0x21444B4;
    byte PauseMenu : 0x3498D01;
    byte CaseSummary : 0x21497E4;
    byte CaseStart : 0x3352C19;    
    long CurObj : 0x028620F0, 0x20, 0x3A8, 0x4E0, 0x78, 0x858, 0x2F0, 0x708;
}

startup
{
    // Settings tree
    settings.Add("splits", true, "All Splits");
        settings.Add("DR", false, "Dead Rising Splits", "splits");
            settings.Add("DR72Hour", false, "72 Hour Splits", "DR");
                settings.Add("DRcase1", false, "Case 1 Splits", "DR72Hour");
                    settings.Add("DRcase1EntrancePlaza", false, "Entrance Plaza", "DRcase1");
                    settings.Add("DRcase1Barnaby", false, "Met Barnaby", "DRcase1");
                    settings.Add("DRcase1Prologue", false, "Prologue", "DRcase1");
                    settings.Add("DRcase1.1", false, "Case 1-1", "DRcase1");
                    settings.Add("DRcase1.2", false, "Case 1-2", "DRcase1");
                    settings.Add("DRcase1.3", false, "Case 1-3", "DRcase1");
                    settings.Add("DRcase1.4", false, "Case 1-4", "DRcase1");
                    settings.Add("DRconvicts", false, "Convicts", "DRcase1");
                settings.Add("DRcase2", false, "Case 2 Splits", "DR72Hour");
                    settings.Add("DRcase2.1", false, "Case 2-1", "DRcase2");
                    settings.Add("DRcase2Steven", false, "Steven", "DRcase2");
                    settings.Add("DRcase2FirstAid", false, "First Aid", "DRcase2");
                    settings.Add("DRcase2.2", false, "Case 2-2", "DRcase2");
                    settings.Add("DRcase2.3", false, "Case 2-3", "DRcase2");
                settings.Add("DRcase3", false, "Case 3 Splits", "DR72Hour");
                    settings.Add("DRcase3.1", false, "Case 3-1", "DRcase3");
                settings.Add("DRcase4", false, "Case 4 Splits", "DR72Hour");
                    settings.Add("DRcase4.1", false, "Case 4-1", "DRcase4");
                    settings.Add("DRcase4IsabelaStart", false, "Start Isabela Fight", "DRcase4");
                    settings.Add("DRcase4.2", false, "Case 4-2", "DRcase4");
                settings.Add("DRcase5", false, "Case 5 Splits", "DR72Hour");
                    settings.Add("DRcase5Zombie", false, "Killed First Zombie", "DRcase5");
                    settings.Add("DRcase5.1", false, "Case 5-1", "DRcase5");
                    settings.Add("DRcase5.2", false, "Case 5-2", "DRcase5");
                settings.Add("DRcase6", false, "Case 6 Splits", "DR72Hour");
                    settings.Add("DRcase6.1", false, "Case 6-1", "DRcase6");
                settings.Add("DRcase7", false, "Case 7 Splits", "DR72Hour");
                    settings.Add("DRcase7.1", false, "Case 7-1", "DRcase7");
                    for (int i = 1; i <= 5; ++i)
                    {
                        settings.Add("DRcase7Bomb" + i.ToString(), false, "Bomb #" + i.ToString(), "DRcase7");
                    }
                    settings.Add("DRcase7.2", false, "Case 7-2", "DRcase7");
                settings.Add("DRcase8", false, "Case 8 Splits", "DR72Hour");
                    settings.Add("DRcase8.1", false, "Case 8-1", "DRcase8");
                    settings.Add("DRcase8.2", false, "Case 8-2", "DRcase8");
                    settings.Add("DRcase8.3", false, "Case 8-3", "DRcase8");
                    settings.Add("DRcase8.4", false, "Case 8-4", "DRcase8");
                settings.Add("DRcase9.1", false, "The Facts", "DR72Hour");
                settings.Add("DRendings", false, "Endings", "DR72Hour");
                    settings.Add("DRendingA", false, "Ending A", "DRendings");
            settings.Add("DRovertime", false, "Overtime", "DR");
                settings.Add("DRotDrone", false, "Frank sees a sick RC Drone", "DRovertime");
                settings.Add("DRotSupplies", false, "Supplies", "DRovertime");
                    settings.Add("DRotSupplyTaken", false, "Splits when you grab the supplies", "DRotSupplies");
                    settings.Add("DRotSupplyHideout", false, "Back to hideout", "DRotSupplies");
                settings.Add("DRotClockTower", false, "Clock Tower", "DRovertime");
                settings.Add("DRotQueens", false, "Queens", "DRovertime");
                settings.Add("DRotTunnel", false, "Tunnel", "DRovertime");
                settings.Add("DRotTank", false, "Tank", "DRovertime");
                settings.Add("DRotBrock", false, "Brock", "DRovertime");
        settings.Add("DR2splits", true, "Dead Rising 2", "splits");
            settings.Add("DR272H", true, "72 Hour Splits", "DR2splits");
                settings.Add("DR2prologue", true, "Prologue", "DR272H");
                    settings.Add("prologuedeath", false, "Death in Prologue", "DR2prologue");
                    settings.Add("013_exit_the_stadium", false, "Exit the Stadium", "DR2prologue");
                settings.Add("DR2kateyzombrex", true, "Katey's Zombrex", "DR272H");
                    settings.Add("023_give_katey_zombrex_01", false, "Zombrex 1", "DR2kateyzombrex");
                    settings.Add("034_give_katey_zombrex_02", false, "Zombrex 2", "DR2kateyzombrex");
                    settings.Add("042_give_katey_zombrex_03", false, "Zombrex 3", "DR2kateyzombrex");
                    settings.Add("049_give_katey_zombrex_04", false, "Zombrex 4", "DR2kateyzombrex");
                settings.Add("DR2case01", true, "Case 1", "DR272H");
                    settings.Add("024_framed", true, "Case 1-1", "DR2case01");
                        settings.Add("020_find_zombrex", false, "Looters", "024_framed");
                    settings.Add("025_rebecca_chang", false, "Case 1-2", "DR2case01");
                    settings.Add("026_central_security", false, "Case 1-3", "DR2case01");
                    settings.Add("027_alliance", false, "Case 1-4", "DR2case01");
                settings.Add("DR2case02", true, "Case 2", "DR272H");
                    settings.Add("029_stacey_sees_something", false, "Case 2-1", "DR2case02");
                    settings.Add("033a_katey_needs_zombrex_2", false, "Case 2-2", "DR2case02");
                settings.Add("DR2case03", true, "Case 3", "DR272H");
                    settings.Add("036_explosion", false, "Case 3-1", "DR2case03");
                    settings.Add("037_thwarted", false, "Case 3-2", "DR2case03");
                settings.Add("DR2case04", true, "Case 4", "DR272H");
                    settings.Add("041_twins_boss_defeated", true, "Case 4-1", "DR2case04");
                    settings.Add("041_twins_boss_defeated_s", false, "Alternate Twins Death", "041_twins_boss_defeated");
                    settings.Add("041a_twins_boss_defeated_2", false, "Alternate Twins Death 2", "041_twins_boss_defeated");
                    settings.Add("041a_twins_boss_defeated_2s", false, "Alternate Twins Death 3", "041_twins_boss_defeated");
                settings.Add("DR2case05", true, "Case 5", "DR272H");
                    settings.Add("043_the_getaway", false, "Case 5-1", "DR2case05");
                    settings.Add("048a_tk_in_the_house", false, "Case 5-2", "DR2case05");
                settings.Add("DR2case06", true, "Case 6", "DR272H");
                    settings.Add("051_all_hell_broken_loose", false, "Case 6-1", "DR2case06");
                    settings.Add("053_military_boss_death", false, "Case 6-2", "DR2case06");
                    settings.Add("054a_safehouse_is_overrun_a", false, "Case 6-3", "DR2case06");
                    settings.Add("055a_what_the_hell_happened_a", false, "Case 6-4", "DR2case06");
                settings.Add("DR2case07", true, "Case 7", "DR272H");
                    settings.Add("057_this_is_bigger_than_tk", true, "Case 7-1", "DR2case07");
                        settings.Add("056_give_tk_zombrex", false, "Give TK Zombrex", "057_this_is_bigger_than_tk");
                    settings.Add("059_queens_exit", false, "Case 7-2", "DR2case07");
                    settings.Add("060_the_facts", false, "Case 7-3", "DR2case07");
                settings.Add("DR2facts", true, "The Facts", "DR272H");
                    settings.Add("sullivan", false, "Sullivan", "DR2facts");
                settings.Add("DR2overtime", true, "Overtime", "DR272H");
                    settings.Add("DR2OTItems", true, "Overtime Items", "DR2overtime");
                        settings.Add("@[00CC00FF,Compromising Photo] acquired!", false, "Compromising Photo", "DR2OTItems");
                        settings.Add("@[00CC00FF,Lab Suit] acquired!", false, "Lab Suit", "DR2OTItems");
                        settings.Add("@[00CC00FF,USB Drive] acquired!", false, "USB Drive", "DR2OTItems");
                        settings.Add("@[00CC00FF,Mobile Headset] acquired!", false, "Mobile Headset", "DR2OTItems");
                        settings.Add("@[00CC00FF,Expensive Champagne] acquired!", false, "Expensive Champagne", "DR2OTItems");
                        settings.Add("@[00CC00FF,Case of Queens] acquired!", false, "Case of Queens", "DR2OTItems");
                        settings.Add("@[00CC00FF,Gift Basket] acquired!", false, "Gift Basket", "DR2OTItems");
                    settings.Add("065a_chuck_is_knocked_out_a", false, "Delivered Items to TK", "DR2overtime");
                    settings.Add("tkDead", false, "TK Defeated", "DR2overtime");
        settings.Add("DR3", true, "Dead Rising 3", "splits");
            settings.Add("Chapter00", true, "Chapter 0", "DR3");
            settings.Add("Chapter01", true, "Chapter 1", "DR3");
            settings.Add("Chapter02", true, "Chapter 2", "DR3");
            settings.Add("Chapter03", true, "Chapter 3", "DR3");
            settings.Add("Chapter04", true, "Chapter 4", "DR3");
            settings.Add("Chapter05", true, "Chapter 5", "DR3");
            settings.Add("Chapter06", true, "Chapter 6", "DR3");
            settings.Add("Chapter07", true, "Chapter 7", "DR3");
            settings.Add("Chapter08", true, "Chapter 8", "DR3");

        var tB = (Func<string, string, string, Tuple<string, string, string>>) ((elmt1, elmt2, elmt3) => { return Tuple.Create(elmt1, elmt2, elmt3); });
        var sB = new List<Tuple<string, string, string>> 
    {
        tB("Chapter00","Eat Food To Restore Health","Eat Food To Restore Health"),
        tB("Chapter00","Find Supplies","Find Supplies"),
        tB("Chapter00","Explore the Tunnel","Explore the Tunnel"),
        //tB("Chapter00","Find a Way Out","Find a Way Out"),
        tB("Chapter00","Get to the Diner","Get to the Diner"),
        tB("Chapter00","Combine Two Weapons","Combine Two Weapons"),
        tB("Chapter00","Get Everyone to Rhonda's Garage","Get Everyone to Rhonda's Garage"),
        tB("Chapter00","Lower the Barricade","Lower the Barricade"),
        tB("Chapter00","Explore while Rhonda's Busy","Explore while Rhonda's Busy"),
        tB("Chapter00","Talk to Rhonda","Talk to Rhonda"),
        tB("Chapter01","Combine Two Vehicles","Combine Two Vehicles"),
        tB("Chapter01","Get to the Quarantine Station","Get to the Quarantine Station"),
        tB("Chapter01","Defeat 10 Bikers","Defeat 10 Bikers"),
        tB("Chapter01","Defeat the Gang Leader","Defeat the Gang Leader"),
        tB("Chapter02","Get to the Sewers","Get to the Sewers"),
        tB("Chapter02","Get Zombrex at the Morgue","Get Zombrex at the Morgue"),
        tB("Chapter02","Break in through Skylight","Break in through Skylight"),
        tB("Chapter02","Let Gary in","Let Gary in"),
        tB("Chapter02","Get to Cold Storage","Get to Cold Storage"),
        tB("Chapter02","Find Nicole White's Corpse","Find Nicole White's Corpse"),
        tB("Chapter02","Find Keys to Morgue Drawers","Find Keys to Morgue Drawers"),
        tB("Chapter02","Help Gary","Help Gary"),
        tB("Chapter02","Get the Corpse to the Club","Get the Corpse to the Club"),
        tB("Chapter03","Get to the Plane","Get to the Plane"),
        tB("Chapter03","Find the Illegally Infected","Find the Illegally Infected"),
        tB("Chapter03","Talk to Lauren","Talk to Lauren"),
        tB("Chapter03","Find Tattoo Kit","Find Tattoo Kit"),
        tB("Chapter03","Find Lauren's Ring Box","Find Lauren's Ring Box"),
        tB("Chapter03","Return to Lauren","Return to Lauren"),
        tB("Chapter03","Find Annie","Find Annie"),
        tB("Chapter03","Destroy 3 camera","Destroy 3 camera"),
        tB("Chapter03","Destroy 2 Relays","Destroy 2 Relays"),
        tB("Chapter03","Burn 2 Sets of Supplies","Burn 2 Sets of Supplies"),
        tB("Chapter03","Defeat the Real Albert","Defeat the Real Albert"),
        tB("Chapter03","Return to the Comm Tower","Return to the Comm Tower"),
        tB("Chapter03","Get to the Police Station","Get to the Police Station"),
        tB("Chapter03","Follow Hilde","Follow Hilde"),
        tB("Chapter03","Defeat Hilde, the Sergeant","Defeat Hilde, the Sergeant"),
        tB("Chapter03","Meet Red and Annie at the Hotel","Meet Red and Annie at the Hotel"),
        tB("Chapter03","Explore While Red Gets Fuel","Explore While Red Gets Fuel"),
        tB("Chapter03","Meet Red at the Comm Tower","Meet Red at the Comm Tower"),
        tB("Chapter04","Get to Car Lot Rooftop","Get to Car Lot Rooftop"),
        tB("Chapter04","Infiltrate the Compound","Infiltrate the Compound"),
        tB("Chapter04","Enter the HQ","Enter the HQ"),
        tB("Chapter04","Destroy the Generators","Destroy the Generators"),
        tB("Chapter04","Free the Captives","Free the Captives"),
        tB("Chapter04","Defeat all Spec Ops","Defeat all Spec Ops"),
        tB("Chapter04","Defeat the Commander","Defeat the Commander"),
        tB("Chapter04","Get to Central Storage","Get to Central Storage"),
        tB("Chapter04","Find the Fuel","Find the Fuel"),
        tB("Chapter04","Get into the Fuel Car","Get into the Fuel Car"),
        tB("Chapter05","Find Diego at Museum","Find Diego at Museum"),
        tB("Chapter05","Defeat Diego","Defeat Diego"),
        tB("Chapter05","Find the Gang Members","Find the Gang Members"),
        tB("Chapter05","Bring Diego to the Plane","Bring Diego to the Plane"),
        tB("Chapter05","Explore While Rhonda Researches","Explore While Rhonda Researches"),
        tB("Chapter06","Get to the Collector's House","Get to the Collector's House"),
        tB("Chapter06","Clear the Room","Clear the Room"),
        tB("Chapter06","Disable the Alarm","Disable the Alarm"),
        tB("Chapter06","Find the Rudder Arm","Find the Rudder Arm"),
        tB("Chapter06","Get to the Courier","Get to the Courier"),
        tB("Chapter06","Find the Flywheel","Find the Flywheel"),
        //tB("Chapter06","Get to the Plane","Get to the Plane"),
        tB("Chapter06","Find a Way Out","Find a Way Out"),
        tB("Chapter06","Destroy the Loaders to Escape","Destroy the Loaders to Escape"),
        tB("Chapter07","Get to the Karaoke Bar","Get to the Karaoke Bar"),
        tB("Chapter07","Unlock the Doors","Unlock the Doors"),
        tB("Chapter07","Turn on the Power","Turn on the Power"),
        tB("Chapter07","Find Some Wire","Find Some Wire"),
        //tB("Chapter07","Turn on the Power","Turn on the Power"),
        //tB("Chapter07","Unlock the Doors","Unlock the Doors"),
        tB("Chapter07","Escape the Metro","Escape the Metro"),
        tB("Chapter07","PLANE","Enter the Plane"),
        tB("Chapter07","Find Rhonda","Find Rhonda"),
        tB("Chapter07","Find First Aid Kit","Find First Aid Kit"),
        tB("Chapter07","Find an Acetylene Tank","Find an Acetylene Tank"),
        tB("Chapter07","Bring Rhonda to Gary","Bring Rhonda to Gary"),
        tB("Chapter07","Clear Zombies Around Annie","Clear Zombies Around Annie"),
        tB("Chapter07","Help Annie","Help Annie"),
        tB("Chapter07","Take Annie to the Plane","Take Annie to the Plane"),
        tB("Chapter07","Destroy the Crane","Destroy the Crane"),
        tB("Chapter07","Free Annie and Isabella","Free Annie and Isabella"),
        tB("Chapter08","Track Down Hemlock","Track Down Hemlock"),
        tB("Chapter08","Destroy 60 Harvest Drones","Destroy 60 Harvest Drones"),
        tB("Chapter08","Hemlock","Defeat Hemlock"),
    };
    foreach (var s in sB) settings.Add(s.Item2, false, s.Item3, s.Item1);

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var mbox = MessageBox.Show(
            "Removing loads from these games requires comparing against Game Time.\nWould you like to switch to it?",
            "LiveSplit | Dead Rising Multisplitter",
            MessageBoxButtons.YesNo);

        if (mbox == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

}

init
{
            // Keep track of hit splits
            vars.Splits = new HashSet<string>();

            // For splitting when hitting a cutscene
            vars.Cutscenes = new Dictionary<int, string>
            {
                {2,   "DRcase1EntrancePlaza"},
                {3,   "DRcase1Barnaby"},
                {4,   "DRcase1Prologue"},
                {22,  "DRcase2Steven"},
                {26,  "DRcase4IsabelaStart"},
                {31,  "DRcase5Zombie"},
                {53,  "DRendingA"},
                {70,  "psychoKent3"},
                {71,  "psychoCliff"},
                {72,  "psychoCletus"},
                {73,  "psychoSean"},
                {74,  "psychoAdam"},
                {75,  "psychoJo"},
                {76,  "psychoPaul"},
                {112, "psychoKent1"},
                {117, "psychoKent2"},
                {125, "DRotClockTower"},
                {126, "DRotQueens"},
                {131, "DRotSupplyHideout"},
                {136, "DRotTunnel"},
                {140, "DRotDrone"},
                {143, "DRendingB"},
                {144, "DRotTank"},
            };

            // Used for room transition splits
            vars.CaseProgress = new Dictionary<string, HashSet<int>>
            {
                {"1",   new HashSet<int>(Enumerable.Range(10, 150))},
                {"2",   new HashSet<int>(Enumerable.Range(160, 20))},
                {"2.1", new HashSet<int>(Enumerable.Range(180, 25))},  // Case 2 after saving Barnaby
                {"2.2", new HashSet<int>(Enumerable.Range(215, 1))},   // Case 2 after picking up first-aid
                {"4",   new HashSet<int>(Enumerable.Range(230, 21))},
                {"5",   new HashSet<int>(Enumerable.Range(270, 21))},
                {"7",   new HashSet<int>(Enumerable.Range(320, 21))},
                {"8",   new HashSet<int>(Enumerable.Range(350, 20))},
                {"8.1", new HashSet<int>(Enumerable.Range(370, 20))},
                {"9",   new HashSet<int>(Enumerable.Range(500, 150))}, // Overtime
                {"9.1", new HashSet<int>(Enumerable.Range(650, 999))}, // Overtime after supplies
            };

            // Represents the progress level at the starts of cases for splits.
            vars.CaseStarts = new Dictionary<int, string>
            {
                {80,  "1.1"},
                {110, "1.2"},
                {130, "1.3"},
                {140, "1.4"},
                {160, "2.1"},
                {180, "2.2"},
                {215, "2.3"},
                {220, "3.1"},
                {230, "4.1"},
                {250, "4.2"},
                {280, "5.1"},
                {290, "5.2"},
                {300, "6.1"},
                {320, "7.1"},
                {340, "7.2"},
                {350, "8.1"},
                {360, "8.2"},
                {370, "8.3"},
                {390, "8.4"},
                {400, "9.1"}
            };

            // For starting on player control
            vars.PrimeStart = false;
            vars.WillStart = false;

            vars.doneMaps = new List<string>();
            vars.BossName = ".";
            vars.lastBoss = ".";

            vars.CurObj = "";
}

start
{
    switch (game.ProcessName)
    {
        case "DeadRising":
        {
            // Starts when player gains control
            if (vars.WillStart)
            {
                vars.PrimeStart = false;
                vars.WillStart = false;
            }
        }
        break;

        case "deadrising3":
        {
            return current.BackupCC == "Chapter00" && current.Loader == 3452816641;
        }
        break;

        case "deadrising4":
        {
            return old.Loading == 1 && current.MainMenu == 33;
        }
        break;
    }
}

onStart
{
    switch (game.ProcessName)
    {
        case "DeadRising":
        {
            vars.doneMaps.Clear();
            vars.Splits.Clear();
        }
        break;
        case "deadrising3":
        {
            vars.doneMaps.Add(current.CurrentChapter);
            vars.doneMaps.Add(current.CurrentObjective);
            vars.lastBoss = vars.BossName;
        }
        break;
    }
}

update 
{
    switch (game.ProcessName)
    {
        case "DeadRising":
        {
            // Clear any hit splits if timer stops
            if (timer.CurrentPhase == TimerPhase.NotRunning)
            {
                vars.Splits.Clear();
            }

            // For starting on player control
            if (current.InGameTime != 0 && old.InGameTime == 0)
            {
                vars.PrimeStart = true;
            }

            if (vars.PrimeStart && !current.IsLoading && current.CampaignProgress > 0)
            {
                vars.WillStart = true;
            }
        }
        break;

        case "deadrising3":
        {
            vars.BossName = memory.ReadString(new IntPtr(current.CurBossPtr), 256);
        }
        break;
    }
}

split
{
    switch (game.ProcessName)
    {
        case "DeadRising":
        {
            // Generic Case Split
            if (old.CaseMenuState == 2 && (current.CaseMenuState == 0 || current.CaseMenuState == 19))
            {
                if (vars.CaseStarts.ContainsKey(current.CampaignProgress) && !vars.Splits.Contains("DRcase" + vars.CaseStarts[current.CampaignProgress]))
                {
                    vars.Splits.Add("DRcase" + vars.CaseStarts[current.CampaignProgress]);
                    return settings["DRcase" + vars.CaseStarts[current.CampaignProgress]];
                }
            }

            // Splitting when hitting cutscenes
            if (current.CutsceneId != old.CutsceneId)
            {
                if (vars.Cutscenes.ContainsKey(current.CutsceneId) && !vars.Splits.Contains(vars.Cutscenes[current.CutsceneId]))
                {
                    vars.Splits.Add(vars.Cutscenes[current.CutsceneId]);
                    return settings[vars.Cutscenes[current.CutsceneId]];
                }
            }

            // First Aid
            if (current.CampaignProgress == 215 && old.CampaignProgress != 215)
            {
                if (!vars.Splits.Contains("DRcase2FirstAid"))
                {
                    vars.Splits.Add("DRcase2FirstAid");
                    return settings["DRcase2FirstAid"];
                }
            }

            // Bombs
            if (current.CampaignProgress <= 340 && current.CampaignProgress < 350 && current.Bombs > old.Bombs)
            {
                return settings["DRcase7Bomb" + current.Bombs.ToString()];
            }

            // Overtime splits
            if (settings["DRovertime"])
            {
                // Supplies
                if(current.CutsceneId == 140 && current.Supplies > old.Supplies)
                {
                    return settings["DRotSupplyTaken"];
                }

                // Brock
                if (current.CutsceneId == 144 && current.BossHealth == 0 && old.BossHealth != 0)
                {
                    return settings["DRotBrock"];
                }
            }
        }
        break;

        case "deadrising2":
        {
            // Use start condition as split condition for multi-game runs.
            // Cutscene splits
            if (current.Cutscene != old.Cutscene && !vars.Splits.Contains(current.Cutscene))
            {
                vars.Splits.Add(current.Cutscene);
                return settings[current.Cutscene];
            }

            // Prologue split
            if (current.PlayerHealth < 1 && old.PlayerHealth != 0 && !vars.Splits.Contains("prologuedeath"))
            {
                vars.Splits.Add("prologuedeath");
                return settings["prologuedeath"];
            }
            //Split on last hit on Sullivan
            if (current.RoomId == 38  && current.BossHealth < 0 && !vars.Splits.Contains("sullivan"))
            {
                vars.Splits.Add("sullivan");
                return settings["sullivan"];
            }

            //Overtime Items and Improper Behaviour Splits
            if (current.InfoBox != old.InfoBox && !vars.Splits.Contains(current.InfoBox))
            {
                vars.Splits.Add(current.InfoBox);
                return settings[current.InfoBox];
            }
        }
        break;

        case "deadrising3":
        {
            if (current.CurrentChapter != old.CurrentChapter && !vars.doneMaps.Contains(old.CurrentChapter))
            {
                vars.doneMaps.Add(old.CurrentChapter);
                return settings[old.CurrentChapter];
            }

            if (current.CurrentObjective != old.CurrentObjective && !vars.doneMaps.Contains(old.CurrentObjective))
            {
                vars.doneMaps.Add(old.CurrentObjective);
                return settings[old.CurrentObjective];
            }

            if (settings[vars.BossName] && !vars.doneMaps.Contains(vars.BossName) && vars.lastBoss != vars.BossName && current.BossHealth == 0)
            {
                vars.doneMaps.Add(vars.BossName);
                return true;
            }

            //Splits on interacting with the Plane during Chapter 7 for Ending D
            if (old.EnterPlane == 0 && current.EnterPlane == 3 && current.CurrentChapter == "Chapter07")
            {
                vars.doneMaps.Add("PLANE");
                return settings["PLANE"];
            }
        }
        break;
    }
}

reset
{
    switch (game.ProcessName)
    {
        case "DeadRising":
        {
            return current.InGameTime == 0 && old.InGameTime != 0;
        }
        break;
    }
}

isLoading
{
    switch (game.ProcessName)
    {
        case "DeadRising":
        {
            return current.IsLoading;
        }
        break;

        case "deadrising2":
        {
            return current.Loads;
        }
        break;

        case "deadrising3":
        {
            return current.Loader == 3452816641;
        }
        break;

        case "deadrising4":
        {
            return current.Loading == 1 && current.Loading2 != 84 || current.Loading2 == 0 && current.Loading == 0 || current.Loading == 0 && current.Loading2 == 84 && current.PauseMenu != 1;
        }
        break;
    }
}

exit
{
    timer.IsGameTimePaused = true;
}