state("livesplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS2");

    vars.SerialSUBNU = vars.Helper.MakeString(32, 0x1B91CC);
    vars.SerialSUBP = vars.Helper.MakeString(32, 0x1B974C);
    vars.SerialSUBNK = vars.Helper.MakeString(32, 0x1B91CC);
    vars.SerialSUBNJ = vars.Helper.MakeString(32, 0x1B914C);
    vars.SerialSOLNU = vars.Helper.MakeString(32, 0x1B69CC);
    vars.SerialSOLP = vars.Helper.MakeString(32, 0x1B494C);
    vars.SerialSOLNK = vars.Helper.MakeString(32, 0x1B43CC);
    vars.SerialSOLNJ = vars.Helper.MakeString(32, 0x1B40CC);
    vars.Detected = false;
    vars.LastId = "";

    settings.Add("MAJOR", true, "Major Splits Only");
        settings.Add("OLGA", true, "Olga", "MAJOR");
        settings.Add("GUARDS", true, "Guard Rush", "MAJOR");
        settings.Add("TANKER", true, "Tanker Complete", "MAJOR");
        settings.Add("STILLMAN", true, "End of Stillman", "MAJOR");
        settings.Add("FORTUNE", true, "Fortune", "MAJOR");
        settings.Add("FATMAN", true, "Fatman", "MAJOR");
        settings.Add("AMES", true, "Ames", "MAJOR");
        settings.Add("HARRIER", true, "Harrier", "MAJOR");
        settings.Add("PRESIDENT", true, "End of President", "MAJOR");
        settings.Add("VAMP1", true, "Vamp 1", "MAJOR");
        settings.Add("VAMP2", true, "Vamp 2", "MAJOR");
        settings.Add("TENGUS1", true, "Tengus 1", "MAJOR");
        settings.Add("TENGUS2", true, "Tengus 2", "MAJOR");
        settings.Add("RAYS", true, "Rays", "MAJOR");
        settings.Add("SOLIDUS", true, "Solidus", "MAJOR");
        settings.Add("PLANT", true, "Plant Complete", "MAJOR");
    settings.Add("MINOR", true, "Minor Splits Only");
        settings.Add("MEET_STILLMAN", true, "Meet Stillmann", "MINOR");
        settings.Add("MEET_PREZ", true, "Meet The President", "MINOR");

    vars.TotalTime = new TimeSpan();
    vars.Splits = new HashSet<string>();
}

update
{
    if (!vars.Detected)
    {
        string gameId = "";
        foreach (string raw in new string[] { (string)(vars.SerialSUBNJ.Current ?? ""), (string)(vars.SerialSUBP.Current ?? ""), (string)(vars.SerialSUBNK.Current ?? ""), (string)(vars.SerialSOLNU.Current ?? ""), (string)(vars.SerialSOLP.Current ?? ""), (string)(vars.SerialSOLNK.Current ?? ""), (string)(vars.SerialSOLNJ.Current ?? "") })
        {
            string clean = new string(raw.Where(char.IsLetterOrDigit).ToArray()).ToUpper();
            var m = System.Text.RegularExpressions.Regex.Match(clean, @"SL[A-Z]{2}\d{5}");

            if (m.Success)
            {
                gameId = m.Value;
                break;
            }
        }

        if (gameId == "")
        {
            return false;
        }

        bool changed = (gameId != vars.LastId);
        vars.LastId = gameId;
        if (changed) { print("Game ID: " + gameId); }

        switch (gameId)
        {
            //MGS2:SUBSTANCE Regions
            case "SLUS20554":
                version = "Substance (NTSC-U)";
                    vars.MapString = vars.Helper.MakeString(30, 0x18FA98);
                    vars.IGT = vars.Helper.Make<int>(0x1931D8, 0x138);
                    vars.TankerStory = vars.Helper.Make<short>(0x1931E0, 0x6);
                    vars.PlantStory = vars.Helper.Make<short>(0x1931E0, 0x68);
                break;

            case "SLES82008":
                version = "Substance (PAL)";
                    vars.MapString = vars.Helper.MakeString(30, 0x191720);
                    vars.IGT = vars.Helper.Make<int>(0x193718, 0x138);
                    vars.TankerStory = vars.Helper.Make<short>(0x193720, 0x6);
                    vars.PlantStory = vars.Helper.Make<short>(0x193720, 0x68);
                break;

            case "SLPM35001":
                version = "Substance (NTSC-K)";
                    vars.MapString = vars.Helper.MakeString(30, 0x18FA98);
                    vars.IGT = vars.Helper.Make<int>(0x1931D8, 0x138);
                    vars.TankerStory = vars.Helper.Make<short>(0x1931E0, 0x6);
                    vars.PlantStory = vars.Helper.Make<short>(0x1931E0, 0x68);
                break;

            case "SLPM67002":
                version = "Substance (NTSC-J)";
                    vars.MapString = vars.Helper.MakeString(30, 0x18FA98);
                    vars.IGT = vars.Helper.Make<int>(0x193158, 0x138);
                    vars.TankerStory = vars.Helper.Make<short>(0x193160, 0x6);
                    vars.PlantStory = vars.Helper.Make<short>(0x193160, 0x68);
                break;

            //MGS2:SOL Regions
            case "SLUS20144":
                version = "Sons of Liberty (NTSC-U)";
                    vars.MapString = vars.Helper.MakeString(30, 0x18FA98);
                    vars.IGT = vars.Helper.Make<int>(0x191910, 0x130);
                    vars.TankerStory = vars.Helper.Make<short>(0x191918, 0xE);
                    vars.PlantStory = vars.Helper.Make<short>(0x19191C, 0x2);
                break;

            case "SLES50383":
                version = "Sons of Liberty (PAL)";
                    vars.MapString = vars.Helper.MakeString(30, 0x18D860);
                    vars.IGT = vars.Helper.Make<int>(0x18F6D4, 0x130);
                    vars.TankerStory = vars.Helper.Make<short>(0x18F6DC, 0x12);
                    vars.PlantStory = vars.Helper.Make<short>(0x18F6DC, 0x6);
                break;

            case "SLPM67515":
                version = "Sons of Liberty (NTSC-K)";
                    vars.MapString = vars.Helper.MakeString(30, 0x18D2A8);
                    vars.IGT = vars.Helper.Make<int>(0x18F114, 0x130);
                    vars.TankerStory = vars.Helper.Make<short>(0x18F120, 0x12);
                    vars.PlantStory = vars.Helper.Make<short>(0x18F120, 0x6);
                break;

            case "SLPM65078":
                version = "Sons of Liberty (NTSC-J)";
                    vars.MapString = vars.Helper.MakeString(30, 0x18D028);
                    vars.IGT = vars.Helper.Make<int>(0x18EE94, 0x130);
                    vars.TankerStory = vars.Helper.Make<short>(0x18EE9C, 0xE);
                    vars.PlantStory = vars.Helper.Make<short>(0x18EE9C, 0x2);
                break;

            default:
                version = "Unknown";
                break;
        }

        if (changed) { print("Version: " + version); }

        vars.Detected = (version != "Unknown");
        if (!vars.Detected)
        {
            return false;
        }
    }

        if(vars.MapString.Old != vars.MapString.Current)
        {
            print("Map String: " + vars.MapString.Old + " -> " + vars.MapString.Current);
        }

        if(vars.TankerStory.Old != vars.TankerStory.Current)
        {
            print("TankerStory Progress: " + vars.TankerStory.Old + " -> " + vars.TankerStory.Current);
        }

        if(vars.PlantStory.Old != vars.PlantStory.Current)
        {
            print("PlantStory Progress: " + vars.PlantStory.Old + " -> " + vars.PlantStory.Current);
        }

        //print("IGT: " + vars.IGT.Current * 1000 / 60);
}

split
{
    if(vars.TankerStory.Old <= 25 && vars.TankerStory.Current == 26 && !vars.Splits.Contains("OLGA"))
    {
        return settings["OLGA"] && vars.Splits.Add("OLGA");
    }

    if(vars.TankerStory.Old <= 32 && vars.TankerStory.Current == 33 && !vars.Splits.Contains("GUARDS"))
    {
        return settings["GUARDS"] && vars.Splits.Add("GUARDS");
    }

    if(vars.TankerStory.Old <= 55 && vars.TankerStory.Current >= 56 && vars.TankerStory.Current <= 64 && !vars.Splits.Contains("TANKER"))
    {
        return settings["TANKER"] && vars.Splits.Add("TANKER");
    }
    
    if(vars.PlantStory.Old <= 62 && vars.PlantStory.Current == 63 && !vars.Splits.Contains("MEET_STILLMAN"))
    {
        return settings["MEET_STILLMAN"] && vars.Splits.Add("MEET_STILLMAN");
    }

    if(vars.PlantStory.Old <= 91 && vars.PlantStory.Current == 92 && !vars.Splits.Contains("STILLMAN"))
    {
        return settings["STILLMAN"] && vars.Splits.Add("STILLMAN");
    }

    if(vars.PlantStory.Old <= 114 && vars.PlantStory.Current == 115 && !vars.Splits.Contains("FORTUNE"))
    {
        return settings["FORTUNE"] && vars.Splits.Add("FORTUNE");
    }

    if(vars.PlantStory.Old <= 118 && vars.PlantStory.Current == 119 && !vars.Splits.Contains("FATMAN"))
    {
        return settings["FATMAN"] && vars.Splits.Add("FATMAN");
    }

    if(vars.PlantStory.Old <= 154 && vars.PlantStory.Current == 155 && !vars.Splits.Contains("AMES"))
    {
        return settings["AMES"] && vars.Splits.Add("AMES");
    }

    if(vars.PlantStory.Old <= 189 && vars.PlantStory.Current == 190 && !vars.Splits.Contains("HARRIER"))
    {
        return settings["HARRIER"] && vars.Splits.Add("HARRIER");
    }

    if(vars.PlantStory.Old <= 205 && vars.PlantStory.Current == 206 && !vars.Splits.Contains("MEET_PREZ"))
    {
        return settings["MEET_PREZ"] && vars.Splits.Add("MEET_PREZ");
    }

    if(vars.PlantStory.Old <= 240 && vars.PlantStory.Current == 241 && !vars.Splits.Contains("PRESIDENT"))
    {
        return settings["PRESIDENT"] && vars.Splits.Add("PRESIDENT");
    }

    if(vars.PlantStory.Old <= 253 && vars.PlantStory.Current == 254 && !vars.Splits.Contains("VAMP1"))
    {
        return settings["VAMP1"] && vars.Splits.Add("VAMP1");
    }

    if(vars.PlantStory.Old <= 317 && vars.PlantStory.Current == 318 && !vars.Splits.Contains("VAMP2"))
    {
        return settings["VAMP2"] && vars.Splits.Add("VAMP2");
    }

    // did split too early one time?
    if(vars.PlantStory.Old <= 396 && vars.PlantStory.Current == 397 && !vars.Splits.Contains("TENGUS1"))
    {
        return settings["TENGUS1"] && vars.Splits.Add("TENGUS1");
    }

    if(vars.PlantStory.Old <= 403 && vars.PlantStory.Current == 404 && !vars.Splits.Contains("TENGUS2"))
    {
        return settings["TENGUS2"] && vars.Splits.Add("TENGUS2");
    }

    if(vars.PlantStory.Old <= 411 && vars.PlantStory.Current == 412 && !vars.Splits.Contains("RAYS"))
    {
        return settings["RAYS"] && vars.Splits.Add("RAYS");
    }

    if(vars.PlantStory.Old <= 469 && vars.PlantStory.Current == 470 && !vars.Splits.Contains("SOLIDUS"))
    {
        return settings["SOLIDUS"] && vars.Splits.Add("SOLIDUS");
    }

    if(vars.PlantStory.Old == 486 && vars.PlantStory.Current == 487 && !vars.Splits.Contains("PLANT"))
    {
        return settings["PLANT"] && vars.Splits.Add("PLANT");
    }

    if(vars.TankerStory.Old <= 25 && vars.TankerStory.Current == 26 && !vars.Splits.Contains("OLGA"))
    {
        return settings["OLGA"] && vars.Splits.Add("OLGA");
    }

    if(vars.TankerStory.Old <= 32 && vars.TankerStory.Current == 33 && !vars.Splits.Contains("GUARDS"))
    {
        return settings["GUARDS"] && vars.Splits.Add("GUARDS");
    }

    if(vars.TankerStory.Old <= 55 && vars.TankerStory.Current >= 56 && vars.TankerStory.Current <= 64 && !vars.Splits.Contains("TANKER"))
    {
        return settings["TANKER"] && vars.Splits.Add("TANKER");
    }
    
    if(vars.PlantStory.Old <= 62 && vars.PlantStory.Current == 63 && !vars.Splits.Contains("MEET_STILLMAN"))
    {
        return settings["MEET_STILLMAN"] && vars.Splits.Add("MEET_STILLMAN");
    }

    if(vars.PlantStory.Old <= 91 && vars.PlantStory.Current == 92 && !vars.Splits.Contains("STILLMAN"))
    {
        return settings["STILLMAN"] && vars.Splits.Add("STILLMAN");
    }

    if(vars.PlantStory.Old <= 114 && vars.PlantStory.Current == 115 && !vars.Splits.Contains("FORTUNE"))
    {
        return settings["FORTUNE"] && vars.Splits.Add("FORTUNE");
    }

    if(vars.PlantStory.Old <= 118 && vars.PlantStory.Current == 119 && !vars.Splits.Contains("FATMAN"))
    {
        return settings["FATMAN"] && vars.Splits.Add("FATMAN");
    }

    if(vars.PlantStory.Old <= 154 && vars.PlantStory.Current == 155 && !vars.Splits.Contains("AMES"))
    {
        return settings["AMES"] && vars.Splits.Add("AMES");
    }

    if(vars.PlantStory.Old <= 189 && vars.PlantStory.Current == 190 && !vars.Splits.Contains("HARRIER"))
    {
        return settings["HARRIER"] && vars.Splits.Add("HARRIER");
    }

    if(vars.PlantStory.Old <= 205 && vars.PlantStory.Current == 206 && !vars.Splits.Contains("MEET_PREZ"))
    {
        return settings["MEET_PREZ"] && vars.Splits.Add("MEET_PREZ");
    }

    if(vars.PlantStory.Old <= 240 && vars.PlantStory.Current == 241 && !vars.Splits.Contains("PRESIDENT"))
    {
        return settings["PRESIDENT"] && vars.Splits.Add("PRESIDENT");
    }

    if(vars.PlantStory.Old <= 253 && vars.PlantStory.Current == 254 && !vars.Splits.Contains("VAMP1"))
    {
        return settings["VAMP1"] && vars.Splits.Add("VAMP1");
    }

    if(vars.PlantStory.Old <= 317 && vars.PlantStory.Current == 318 && !vars.Splits.Contains("VAMP2"))
    {
        return settings["VAMP2"] && vars.Splits.Add("VAMP2");
    }

    // did split too early one time?
    if(vars.PlantStory.Old <= 396 && vars.PlantStory.Current == 397 && !vars.Splits.Contains("TENGUS1"))
    {
        return settings["TENGUS1"] && vars.Splits.Add("TENGUS1");
    }

    if(vars.PlantStory.Old <= 403 && vars.PlantStory.Current == 404 && !vars.Splits.Contains("TENGUS2"))
    {
        return settings["TENGUS2"] && vars.Splits.Add("TENGUS2");
    }

    if(vars.PlantStory.Old <= 411 && vars.PlantStory.Current == 412 && !vars.Splits.Contains("RAYS"))
    {
        return settings["RAYS"] && vars.Splits.Add("RAYS");
    }

    if(vars.PlantStory.Old <= 469 && vars.PlantStory.Current == 470 && !vars.Splits.Contains("SOLIDUS"))
    {
        return settings["SOLIDUS"] && vars.Splits.Add("SOLIDUS");
    }

    if(vars.PlantStory.Old == 486 && vars.PlantStory.Current == 487 && !vars.Splits.Contains("PLANT"))
    {
        return settings["PLANT"] && vars.Splits.Add("PLANT");
    }
}

start
{
    return (vars.IGT.Current == 0 && vars.IGT.Current != vars.IGT.Old);
}

onStart
{
    vars.Splits.Clear();
    vars.TotalTime = TimeSpan.Zero;
}

isLoading
{
    return true;
}

gameTime
{
    return TimeSpan.FromMilliseconds(vars.IGT.Current * 1000 / 60);
}

reset
{
    if(vars.MapString.Current == "n_title")
    {
        return true;
    }
}
