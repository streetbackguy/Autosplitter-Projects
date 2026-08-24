state("livesplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS2");

    string logPath = null;
    string standardLogPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),"PCSX2","logs","emulog.txt");

    if (File.Exists(standardLogPath))
    {
        logPath = standardLogPath;
        print("Using standard PCSX2 log: " + logPath);
    }

    if (logPath == null)
    {
        try
        {
            var pcsx2Processes = Process.GetProcessesByName("pcsx2-qt");

            foreach (var process in pcsx2Processes)
            {
                try
                {
                    string exePath = process.MainModule.FileName;
                    string exeDirectory = Path.GetDirectoryName(exePath);

                    string portableLogPath = Path.Combine(exeDirectory,"logs","emulog.txt");

                    if (File.Exists(portableLogPath))
                    {
                        logPath = portableLogPath;
                        break;
                    }
                }
                catch
                {
                    
                }
            }
        }
        catch
        {
            
        }
    }

    string crc = "";

    if (logPath != null && File.Exists(logPath))
    {
        try
        {
            string[] lines;

            using (var stream = new FileStream(
                logPath,
                FileMode.Open,
                FileAccess.Read,
                FileShare.ReadWrite))
            using (var reader = new StreamReader(stream))
            {
                lines = reader.ReadToEnd().Split(
                    new[] { "\r\n", "\n" },
                    StringSplitOptions.None);
            }

            for (int i = lines.Length - 1; i >= 0; i--)
            {
                if (lines[i].Contains("CRC:"))
                {
                    crc = lines[i].Substring(
                        lines[i].IndexOf("CRC:") + 4
                    ).Trim();

                    print("PCSX2 CRC: " + crc);
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            print("Could not read PCSX2 log: " + ex.Message);
        }
    }
    else
    {
        print("Could not find PCSX2 emulog.txt");
    }

    switch (crc)
    {
        case "C539049D":
            version = "SLUS";
                vars.MapString = vars.Helper.MakeString(30, 0x1911E8);
                vars.MapID = vars.Helper.Make<short>(0x1931D8, 0x2C);
                vars.IGT = vars.Helper.Make<int>(0x1931D8, 0x138);
                vars.TankerStory = vars.Helper.Make<short>(0x1931E0, 0x6);
                vars.PlantStory = vars.Helper.Make<short>(0x1931E0, 0x68);
            break;

        case "093E7D52":
            version = "SLES";
                vars.MapString = vars.Helper.MakeString(30, 0x191720);
                vars.MapID = vars.Helper.Make<short>(0x193718, 0x2C);
                vars.IGT = vars.Helper.Make<int>(0x193718, 0x138);
                vars.TankerStory = vars.Helper.Make<short>(0x193720, 0x6);
                vars.PlantStory = vars.Helper.Make<short>(0x193720, 0x68);
            break;

        // case "0":
        //     version = "SKOS";
        //         vars.MapString = vars.Helper.MakeString(30, 0x193378);
        //         vars.MapID = vars.Helper.Make<short>(0x193718, 0x2C);
        //         vars.IGT = vars.Helper.Make<int>(0x193718, 0x138);
        //         vars.TankerStory = vars.Helper.Make<short>(0x193724, 0x6);
        //         vars.PlantStory = vars.Helper.Make<short>(0x193724, 0x68);
        //     break;

        default:
            version = "Unknown";
            break;
    }

    print("Version: " + version);

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
