state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PSP");
    vars.Log = (Action<object>)(output => print("[Kurohyou: Ryu Ga Gotoku Shinshou] " + output));

    settings.Add("KRGGS", true, "Kurohyou: Ryu Ga Gotoku Shinshou Splits");
        settings.Add("Chapter1", true, "Chapter 1: Mark of Murder", "KRGGS");
            settings.Add("12001", true, "Delinquents Fight", "Chapter1");
            settings.Add("11404", true, "End and Degawa Fight", "Chapter1");
            settings.Add("12038", true, "Diablo Fight", "Chapter1");
            settings.Add("16019", true, "Locker Room Fight", "Chapter1");
            settings.Add("16020", true, "Kuki Family Fight", "Chapter1");
            settings.Add("10001", true, "Tomoki Fight", "Chapter1");
        settings.Add("Chapter2", true, "Chapter 2: The Strongest Proof", "KRGGS");
            settings.Add("16001", true, "High Schoolers Fight", "Chapter2");
            settings.Add("10002", true, "Hyuga Fight", "Chapter2");
        settings.Add("Chapter3", true, "Chapter 3: The Meaning of Violence", "KRGGS");
            settings.Add("16002", true, "Hirasawa Fight", "Chapter3");
            settings.Add("12004", true, "Club Asia Fight", "Chapter3");
            settings.Add("16003", true, "Kirisawa and Kure Fight", "Chapter3");
            settings.Add("10003", true, "Yuki Fight", "Chapter3");
        settings.Add("Chapter4", true, "Chapter 4: A Fugitive", "KRGGS");
            settings.Add("Boss4", true, "Fujimoto Fight", "Chapter4");
        settings.Add("Chapter5", true, "Chapter 5: The Price of Suspicion", "KRGGS");
            settings.Add("Boss5", true, "Makabe Fight", "Chapter5");
        settings.Add("Chapter6", true, "Chapter 6: A Wall That Stands", "KRGGS");
            settings.Add("Boss6", true, "Hyuga Fight", "Chapter6");
        settings.Add("Chapter7", true, "Chapter 7: Fifteen Years Ago", "KRGGS");
            settings.Add("Boss7", true, "Cho Fight", "Chapter7");
        settings.Add("Chapter8", true, "Chapter 8: The Secret of 10 Consecutive Wins", "KRGGS");
            settings.Add("Boss8", true, "Aramaki Fight", "Chapter8");
        settings.Add("Chapter9", true, "Chapter 9: Identity of the Insider", "KRGGS");
            settings.Add("Boss9", true, "Shima Fight", "Chapter9");
        settings.Add("Chapter10", true, "Chapter 10: The Place of Truth", "KRGGS");
            settings.Add("Boss10", true, "Tenma Fight", "Chapter10");

    vars.Gamestate = vars.Helper.Make<int>(0x0814D111C);
        // Game State [8-bit]

        // 0x00: Just booted up, In-game, save prompt
        // 0x01: SEGA screen
        // 0x02: Disclaimer from TeamK4L
        // 0x03: Title screen (new game or load game)
        // 0x04: Main menu (continue story, multiplayer, ecc)
        // 0x06: Co-op character select
        // 0x09: Co-op mission select
        // 0x10: In combat (random encounter)
        // 0x15: Save select
        // 0x81: Shinjou fight (and cutscene)
        // 0x93 In combat (random encounter 2)
        // 0x99: Kamurocho Strongest Ranking select

    vars.Chapter = vars.Helper.Make<int>(0x08EA22FC);
        // Chapter [8-bits] // Changes chapter the moment it asks to save data (but last chapter)
        // 01=Chapter 1: Mark of Murder
        // 02=Chapter 2: The Strongest Proof
        // 03=Chapter 3: The Meaning of Violence
        // 04=Chapter 4: A Fugitive
        // 05=Chapter 5: The Price of Suspicion
        // 06=Chapter 6: A Wall That Stands
        // 07=Chapter 7: Fifteen Years Ago
        // 08=Chapter 8: The Secret of 10 Consecutive Wins
        // 09=Chapter 9: Identity of the Insider
        // 0a=Chapter 10: The Place of Truth
        // 0b=Premium Adventure

    vars.TatsuyaHealth = vars.Helper.Make<float>(0x08EC2A04, 0x1C78);

    vars.CombatID = vars.Helper.Make<int>(0x08EA2794);
        // 0x2711 = TOMOKI
        // 0x2712 = Hyuga 1
        // 0x2713 = Yuki
        // 0x2714 = Fujimoto
        // 0x2715 = Makabe
        // 0x2716 = Hyuga 2
        // 0x2717 = Cho
        // 0x2718 = Aramaki
        // 0x2719 = Shima
        // 0x271a = Taizan
        // 0x271b = Shinjo
        // 0x2f2e = Gaia
        // 0x3b08 = Tenma

    vars.InCombat = vars.Helper.Make<bool>(0x08F142A5);
    vars.BossHealth = vars.Helper.Make<float>(0x08EC2A78, 0x38);
    vars.CombatHealth = vars.Helper.Make<float>(0x08EC00A0);
        // [24-bits] Pointer
        // [16-bits] +ff0eca=Health
        // [16-bits] +ff0ed2=Injured state
        // [16-bits] +ff354a=Health (enemy)
        // [16-bits] +ff38ca=Health (enemy)
        // [16-bits] +ff374a=Health (enemy)
        // [16-bits] +ff34aa=Health (enemy)
        // [16-bits] +ff343a=Health (enemy)
        // [16-bits] +ff5fca=Health (enemy)

    vars.Difficulty = vars.Helper.Make<int>(0x08E9E9DA);
        // Difficulty (1, true value) [Lower4]
        // 0=Easy
        // 1=Medium
        // 2=Hard
        // 3=Extra-Hard

    vars.Splits = new HashSet<string>();
}

update
{
    if(vars.Chapter.Current != vars.Chapter.Old)
    {
        print("Chapter: " + vars.Chapter.Current.ToString());
    }

    if(vars.BossHealth.Current != vars.BossHealth.Old)
    {
        print("BossHealth: " + vars.BossHealth.Current.ToString());
    }

    if(vars.CombatID.Current != vars.CombatID.Old)
    {
        print("CombatID: " + vars.CombatID.Current.ToString());
    }

    if(vars.InCombat.Current != vars.InCombat.Old)
    {
        print("Combat?: " + vars.InCombat.Current.ToString());
    }
}

split
{
    //Chapter Splits
    if(vars.Chapter.Current != vars.Chapter.Old && !vars.Splits.Contains("Chapter" + vars.Chapter.Old.ToString()))
    {
        return settings["Chapter" + vars.Chapter.Old.ToString()] && vars.Splits.Add("Chapter" + vars.Chapter.Old.ToString());
    }

    //General Fight & Boss Splits
    if(!vars.InCombat.Current && vars.InCombat.Old && vars.TatsuyaHealth.Current > 0.0f && !vars.Splits.Contains(vars.CombatID.Current.ToString()))
    {
        return settings[vars.CombatID.Old.ToString()] && vars.Splits.Add(vars.CombatID.Current.ToString());
    }
}

onStart
{
    vars.Splits.Clear();
}