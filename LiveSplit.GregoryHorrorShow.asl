//Made with EU version of the game and PCSX2 Nightly
state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS2");

    settings.Add("GHS", true, "Gregory Horror Show");
        settings.Add("ANY", true, "Any% (Emulator)", "GHS");
            settings.Add("NZ", true, "Neko Zombie Soul obtained", "ANY");
            settings.Add("C", true, "Catherine Soul Obtained", "ANY");
            settings.Add("JB", true, "Judgment Boy Soul Obtained", "ANY");
            settings.Add("LD", true, "Lost Doll Soul Obtained", "ANY");
            settings.Add("CG", true, "Cactus Gunman Soul Obtained", "ANY");
            settings.Add("MP", true, "Mummy Papa Soul Obtained", "ANY");
            settings.Add("MS", true, "My Son Soul Obtained", "ANY");
            settings.Add("TF", true, "TV Fish Soul Obtained", "ANY");
            settings.Add("HC", true, "Hell's Chef Soul Obtained", "ANY");
            settings.Add("RB", true, "Roulette Boy Soul Obtained", "ANY");
            settings.Add("ADD", true, "Angel/Devil Dog Soul Obtained", "ANY");
            settings.Add("JBG", true, "Judgement Boy Gold Soul Obtained", "ANY");
            settings.Add("GM", true, "Escape from Gregory Mama's Room", "ANY");
            settings.Add("EGH", true, "Escape Gregory House", "ANY");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
        emu.Make<byte>("GameState", 0x43DB1C);
        emu.Make<byte>("NekoZombieSoul", 0x64E490);
        emu.Make<byte>("CatherineSoul", 0x64E640);
        emu.Make<byte>("JudgementBoySoul", 0x64E400);
        emu.Make<byte>("LostDollSoul", 0x64E520);
        emu.Make<byte>("CactusGunmanSoul", 0x64E7F0);
        emu.Make<byte>("MummyPapaSoul", 0x64E6D0);
        emu.Make<byte>("MySonSoul", 0x64EA30);
        emu.Make<byte>("TVFishSoul", 0x64E910);
        emu.Make<byte>("HellsChefSoul", 0x64E5B0);
        emu.Make<byte>("RouletteBoySoul", 0x64EAC0);
        emu.Make<byte>("AngelDevilDogSoul", 0x64EB50);
        emu.Make<byte>("JudgementBoyGoldSoul", 0x64EBE0);
        emu.Make<float>("PlayerPositionX", 0x471820);
        emu.Make<float>("PlayerPositionZ", 0x471828);
        emu.Make<byte>("MapID", 0x45E3FC); //0x7F - Gregory Mama's Room, 0x04 - Escaping Gregory House

        return true;
    });

    vars.CompletedSplits = new HashSet<string>();
}

start
{
    //Starts when selecting Character gender
    return current.GameState != 33 && old.GameState == 33;
}

split
{
    //Splits after Obtaining each Characters Soul
    if(current.NekoZombieSoul == 2 && old.NekoZombieSoul == 1 && !vars.CompletedSplits.Contains("NZ"))
    {
        return settings["NZ"] && vars.CompletedSplits.Add("NZ");
    }

    if(current.CatherineSoul == 2 && old.CatherineSoul == 1 && !vars.CompletedSplits.Contains("C"))
    {
        return settings["C"] && vars.CompletedSplits.Add("C");
    }

    if(current.JudgementBoySoul == 2 && old.JudgementBoySoul == 1 && !vars.CompletedSplits.Contains("JB"))
    {
        return settings["JB"] && vars.CompletedSplits.Add("JB");
    }

    if(current.LostDollSoul == 2 && old.LostDollSoul == 1 && !vars.CompletedSplits.Contains("LD"))
    {
        return settings["LD"] && vars.CompletedSplits.Add("LD");
    }

    if(current.CactusGunmanSoul == 2 && old.CactusGunmanSoul == 1 && !vars.CompletedSplits.Contains("CG"))
    {
        return settings["CG"] && vars.CompletedSplits.Add("CG");
    }

    if(current.MummyPapaSoul == 2 && old.MummyPapaSoul == 1 && !vars.CompletedSplits.Contains("MP"))
    {
        return settings["MP"] && vars.CompletedSplits.Add("MP");
    }

    if(current.MySonSoul == 2 && old.MySonSoul == 1 && !vars.CompletedSplits.Contains("MS"))
    {
        return settings["MS"] && vars.CompletedSplits.Add("MS");
    }

    if(current.TVFishSoul == 2 && old.TVFishSoul == 1 && !vars.CompletedSplits.Contains("TF"))
    {
        return settings["TF"] && vars.CompletedSplits.Add("TF");
    }

    if(current.HellsChefSoul == 2 && old.HellsChefSoul == 1 && !vars.CompletedSplits.Contains("HC"))
    {
        return settings["HC"] && vars.CompletedSplits.Add("HC");
    }

    if(current.RouletteBoySoul == 2 && old.RouletteBoySoul == 1 && !vars.CompletedSplits.Contains("RB"))
    {
        return settings["RB"] && vars.CompletedSplits.Add("RB");
    }

    if(current.AngelDevilDogSoul == 2 && old.AngelDevilDogSoul == 1 && !vars.CompletedSplits.Contains("ADD"))
    {
        return settings["ADD"] && vars.CompletedSplits.Add("ADD");
    }

    if(current.JudgementBoyGoldSoul == 2 && old.JudgementBoyGoldSoul == 1 && !vars.CompletedSplits.Contains("JBG"))
    {
        return settings["JBG"] && vars.CompletedSplits.Add("JBG");
    }

    //Splits after Mama Gregory Boss
    if(current.PlayerPositionZ == -128 && current.PlayerPositionX == 0 && current.MapID == 3 && !vars.CompletedSplits.Contains("GM"))
    {
        return settings["GM"] && vars.CompletedSplits.Add("GM");
    }

    //Splits on Losing Control of character
    if(current.PlayerPositionZ > 8250 && current.MapID == 4 && !vars.CompletedSplits.Contains("EGH"))
    {
        return settings["EGH"] && vars.CompletedSplits.Add("EGH");
    }
}

reset
{
    return current.GameState == 21;
}

onStart
{
    vars.CompletedSplits.Clear();
}
