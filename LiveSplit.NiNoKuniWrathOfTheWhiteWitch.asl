state("NinoKuni_WotWW_Remastered")
{
    int StartEasy: 0x1081708, 0x3C8, 0x0, 0xD70, 0x208;
    int StartNormal: 0x109F558, 0x110, 0x58, 0x1B0, 0x310, 0x7E8;
    float BossHealth: 0x1081628, 0x1A8, 0x58, 0x30, 0x250, 0x118, 0xDF8;
    string255 BossName: 0x1081628, 0x1A8, 0x58, 0x30, 0x780, 0x178, 0xB0, 0x104;
}

init
{
    vars.CompletedSplits = new HashSet<string>();
    vars.ShadarCount = 1;
    vars.VileHeartCount = 1;
    vars.CassiopeiaCount = 1;

    vars.BossSecondForm = 0;
}

startup
{
    settings.Add("NNK", true, "Ni No Kuni: Wrath of the White Witch");
        settings.Add("BOSSES", true, "Split on Boss Defeat", "NNK");
            settings.Add("GOTW", true, "Guardian of the Woods", "BOSSES");
            settings.Add("HD", true, "Hickory Dock", "BOSSES");
            settings.Add("Gl", true, "Gladiataur", "BOSSES");
            settings.Add("RN", true, "Rusty's Nightmare", "BOSSES");
            settings.Add("Ba", true, "Bashura", "BOSSES");
            settings.Add("Mo", true, "Moltaan", "BOSSES");
            settings.Add("AK", true, "Al-Khemi", "BOSSES");
            settings.Add("SN", true, "Swaine's Nightmare", "BOSSES");
            settings.Add("Sh", true, "Shadar", "BOSSES");
            settings.Add("RJ", true, "Royal Jelly", "BOSSES");
            settings.Add("PG", true, "Porco Grosso", "BOSSES");
            settings.Add("Can", true, "Candelabracadabra", "BOSSES");
            settings.Add("RD", true, "Red Dragon", "BOSSES");
            settings.Add("DN", true, "Denny's Nightmare", "BOSSES");
            settings.Add("Aa", true, "Aapep", "BOSSES");
            settings.Add("CC", true, "Cap'n Crossbones", "BOSSES");
            settings.Add("Ce", true, "Cerboreas", "BOSSES");
            settings.Add("KN", true, "Khulan's Nightmare", "BOSSES");
            settings.Add("PN", true, "Philip's Nightmare", "BOSSES");
            settings.Add("Vi", true, "Vileheart", "BOSSES");
            settings.Add("Vi2", true, "Vileheart Rematch", "BOSSES");
            settings.Add("Sh2", true, "Shadar Rematch", "BOSSES");
            settings.Add("EK", true, "Eternal Knight", "BOSSES");
            settings.Add("DD", true, "Dark Djinn", "BOSSES");
            settings.Add("KT", true, "King Tom XIV", "BOSSES");
            settings.Add("PL", true, "Porco Loco", "BOSSES");
            settings.Add("QL", true, "Queen Lowlah", "BOSSES");
            settings.Add("Ga", true, "Gallus", "BOSSES");
            settings.Add("Cas", true, "Cassiopeia", "BOSSES");
            settings.Add("Cas2", true, "Cassiopeia Phase 2", "BOSSES");
            settings.Add("Zo", true, "Zodiarch", "BOSSES");
        settings.Add("pause", true, "Enable for Load Removal", "NNK");
}

start
{
    return current.StartEasy == 1 && old.StartEasy == 0 || current.StartNormal == 1 && old.StartNormal == 0;
}

onStart
{
    vars.CompletedSplits.Clear();
    vars.ShadarCount = 1;
    vars.VileHeartCount = 1;
    vars.CassiopeiaCount = 1;

    vars.BossSecondForm = 0;
}

update
{
    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("King Tom XIV") || 
    old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Queen Lowlah"))
    {
        vars.BossSecondForm++;
    }
}

split
{
    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Guardian of the Woods") && !vars.CompletedSplits.Contains("GOTW"))
    {
        return settings["GOTW"] && vars.CompletedSplits.Add("GOTW");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Hickory Dock") && !vars.CompletedSplits.Contains("HD"))
    {
        return settings["HD"] && vars.CompletedSplits.Add("HD");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Gladiataur") && !vars.CompletedSplits.Contains("Gl"))
    {
        return settings["Gl"] && vars.CompletedSplits.Add("Gl");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Rusty's Nightmare") && !vars.CompletedSplits.Contains("RN"))
    {
        return settings["RN"] && vars.CompletedSplits.Add("RN");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Bashura") && !vars.CompletedSplits.Contains("Ba"))
    {
        return settings["Ba"] && vars.CompletedSplits.Add("Ba");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Moltaan") && !vars.CompletedSplits.Contains("Mo"))
    {
        return settings["Mo"] && vars.CompletedSplits.Add("Mo");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Al-Khemi") && !vars.CompletedSplits.Contains("AK"))
    {
        return settings["AK"] && vars.CompletedSplits.Add("AK");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Swaine's Nightmare") && !vars.CompletedSplits.Contains("SN"))
    {
        return settings["SN"] && vars.CompletedSplits.Add("SN");
    }

    if(old.BossHealth > current.BossHealth && current.BossHealth < old.BossHealth && old.BossName.Contains("Shadar") && current.BossName != old.BossName && !vars.CompletedSplits.Contains("Sh"))
    {
        return settings["Sh"] && vars.CompletedSplits.Add("Sh") && vars.ShadarCount++;
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Royal Jelly") && !vars.CompletedSplits.Contains("RJ"))
    {
        return settings["RJ"] && vars.CompletedSplits.Add("RJ");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Porco Grosso") && !vars.CompletedSplits.Contains("PG"))
    {
        return settings["PG"] && vars.CompletedSplits.Add("PG");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Candelabracadabra") && !vars.CompletedSplits.Contains("Can"))
    {
        return settings["Can"] && vars.CompletedSplits.Add("Can");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Red Dragon") && !vars.CompletedSplits.Contains("RD"))
    {
        return settings["RD"] && vars.CompletedSplits.Add("RD");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Denny's Nightmare") && !vars.CompletedSplits.Contains("DN"))
    {
        return settings["DN"] && vars.CompletedSplits.Add("DN");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Aapep") && !vars.CompletedSplits.Contains("Aa"))
    {
        return settings["Aa"] && vars.CompletedSplits.Add("Aa");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Cap'n Crossbones") && !vars.CompletedSplits.Contains("CC"))
    {
        return settings["CC"] && vars.CompletedSplits.Add("CC");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Cerboreas") && !vars.CompletedSplits.Contains("Ce"))
    {
        return settings["Ce"] && vars.CompletedSplits.Add("Ce");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Khulan's Nightmare") && !vars.CompletedSplits.Contains("KN"))
    {
        return settings["KN"] && vars.CompletedSplits.Add("KN");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Philip's Nightmare") && !vars.CompletedSplits.Contains("PN"))
    {
        return settings["PN"] && vars.CompletedSplits.Add("PN");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Vileheart") && !vars.CompletedSplits.Contains("Vi"))
    {
        return settings["Vi"] && vars.CompletedSplits.Add("Vi") && vars.VileHeartCount++;
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Vileheart") && vars.VileHeartCount == 2 && !vars.CompletedSplits.Contains("Vi2"))
    {
        return settings["Vi2"] && vars.CompletedSplits.Add("Vi2");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Shadar") && vars.ShadarCount == 2 && !vars.CompletedSplits.Contains("Sh2"))
    {
        return settings["Sh2"] && vars.CompletedSplits.Add("Sh2");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Eternal Knight") && !vars.CompletedSplits.Contains("EK"))
    {
        return settings["EK"] && vars.CompletedSplits.Add("EK");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Dark Djinn") && !vars.CompletedSplits.Contains("DD"))
    {
        return settings["DD"] && vars.CompletedSplits.Add("DD");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && vars.BossSecondForm == 2 && current.BossName.Contains("King Tom XIV") && !vars.CompletedSplits.Contains("KT"))
    {
        return settings["KT"] && vars.CompletedSplits.Add("KT");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Porco Loco") && !vars.CompletedSplits.Contains("PL"))
    {
        return settings["PL"] && vars.CompletedSplits.Add("PL");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Queen Lowlah") && vars.BossSecondForm == 4 && !vars.CompletedSplits.Contains("QL"))
    {
        return settings["QL"] && vars.CompletedSplits.Add("QL");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Gallus") && !vars.CompletedSplits.Contains("Ga"))
    {
        return settings["Ga"] && vars.CompletedSplits.Add("Ga");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Cassiopeia") && !vars.CompletedSplits.Contains("Cas"))
    {
        return settings["Cas"] && vars.CompletedSplits.Add("Cas") && vars.CassiopeiaCount++;
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Cassiopeia") && vars.CassiopeiaCount == 2 && !vars.CompletedSplits.Contains("Cas2"))
    {
        return settings["Cas2"] && vars.CompletedSplits.Add("Cas2");
    }

    if(old.BossHealth > 0 && current.BossHealth == 0 && current.BossName.Contains("Zodiarch") && !vars.CompletedSplits.Contains("Zo"))
    {
        return settings["Zo"] && vars.CompletedSplits.Add("Zo");
    }
}

reset
{
    //return current.TitleScreen == 1 && old.TitleScreen == 0;
}
