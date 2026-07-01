state("livesplit")
{
}

// EU for Progress Base = 0x193374/0x193720
// EU for Map/ID Base = 0x193718
// EU for MapString = 0x193378
// EU for Boss Health = 0x193388

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS2");

    vars.Version = vars.Helper.MakeString(4, 0x155D0);
    print("Version: " + vars.Version.Current);

    // USA
    vars.MapStringUS = vars.Helper.MakeString(30, 0x1911E8);
    vars.IGTUS = vars.Helper.Make<int>(0x1931D8, 0x138);
    vars.TankerStoryUS = vars.Helper.Make<short>(0x1931E0, 0x6);
    vars.PlantStoryUS = vars.Helper.Make<short>(0x1931E0, 0x68);

    // EU
    vars.MapStringEU = vars.Helper.MakeString(30, 0x193378);
    vars.IGTEU = vars.Helper.Make<int>(0x193718, 0x138);
    vars.TankerStoryEU = vars.Helper.Make<short>(0x193720, 0x6);
    vars.PlantStoryEU = vars.Helper.Make<short>(0x193720, 0x68);

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

    vars.Splits = new HashSet<string>();
}

update
{
    string ver = vars.Version.Current.ToString();

    if(vars.MapStringUS.Old != vars.MapStringUS.Current && vars.Version.Current == "SLUS")
    {
        print("Map StringUS: " + vars.MapStringUS.Old + " -> " + vars.MapStringUS.Current);
    }

    if(vars.TankerStoryUS.Old != vars.TankerStoryUS.Current && vars.Version.Current == "SLUS")
    {
        print("TankerStory Progress US: " + vars.TankerStoryUS.Old + " -> " + vars.TankerStoryUS.Current);
    }

    if(vars.PlantStoryUS.Old != vars.PlantStoryUS.Current && vars.Version.Current == "SLUS")
    {
        print("PlantStory Progress US: " + vars.PlantStoryUS.Old + " -> " + vars.PlantStoryUS.Current);
    }

    if(vars.MapStringEU.Old != vars.MapStringEU.Current && vars.Version.Current == "SLES")
    {
        print("Map StringEU: " + vars.MapStringEU.Old + " -> " + vars.MapStringEU.Current);
    }

    if(vars.TankerStoryEU.Old != vars.TankerStoryEU.Current && vars.Version.Current == "SLES")
    {
        print("TankerStory Progress EU: " + vars.TankerStoryEU.Old + " -> " + vars.TankerStoryEU.Current);
    }

    if(vars.PlantStoryUS.Old != vars.PlantStoryEU.Current && vars.Version.Current == "SLES")
    {
        print("PlantStory Progress EU: " + vars.PlantStoryEU.Old + " -> " + vars.PlantStoryEU.Current);
    }

    switch(ver)
    {
        case "SLUS":
            version = "USA";
            break;

        case "SLES":
            version = "PAL";
            break;
    }
}

split
{
    // if(vars.TankerStory.Old <= 25 && vars.TankerStory.Current == 26 && !vars.Splits.Contains("OLGA"))
    // {
    //     return settings["OLGA"] && vars.Splits.Add("OLGA");
    // }

    // if(vars.TankerStory.Old <= 32 && vars.TankerStory.Current == 33 && !vars.Splits.Contains("GUARDS"))
    // {
    //     return settings["GUARDS"] && vars.Splits.Add("GUARDS");
    // }

    // if(vars.TankerStory.Old <= 55 && vars.TankerStory.Current >= 56 && vars.TankerStory.Current <= 64 && !vars.Splits.Contains("TANKER"))
    // {
    //     return settings["TANKER"] && vars.Splits.Add("TANKER");
    // }
    
    // if(vars.PlantStory.Old <= 62 && vars.PlantStory.Current == 63 && !vars.Splits.Contains("MEET_STILLMAN"))
    // {
    //     return settings["MEET_STILLMAN"] && vars.Splits.Add("MEET_STILLMAN");
    // }

    // if(vars.PlantStory.Old <= 91 && vars.PlantStory.Current == 92 && !vars.Splits.Contains("STILLMAN"))
    // {
    //     return settings["STILLMAN"] && vars.Splits.Add("STILLMAN");
    // }

    // if(vars.PlantStory.Old <= 114 && vars.PlantStory.Current == 115 && !vars.Splits.Contains("FORTUNE"))
    // {
    //     return settings["FORTUNE"] && vars.Splits.Add("FORTUNE");
    // }

    // if(vars.PlantStory.Old <= 118 && vars.PlantStory.Current == 119 && !vars.Splits.Contains("FATMAN"))
    // {
    //     return settings["FATMAN"] && vars.Splits.Add("FATMAN");
    // }

    // if(vars.PlantStory.Old <= 154 && vars.PlantStory.Current == 155 && !vars.Splits.Contains("AMES"))
    // {
    //     return settings["AMES"] && vars.Splits.Add("AMES");
    // }

    // if(vars.PlantStory.Old <= 189 && vars.PlantStory.Current == 190 && !vars.Splits.Contains("HARRIER"))
    // {
    //     return settings["HARRIER"] && vars.Splits.Add("HARRIER");
    // }

    // if(vars.PlantStory.Old <= 205 && vars.PlantStory.Current == 206 && !vars.Splits.Contains("MEET_PREZ"))
    // {
    //     return settings["MEET_PREZ"] && vars.Splits.Add("MEET_PREZ");
    // }

    // if(vars.PlantStory.Old <= 240 && vars.PlantStory.Current == 241 && !vars.Splits.Contains("PRESIDENT"))
    // {
    //     return settings["PRESIDENT"] && vars.Splits.Add("PRESIDENT");
    // }

    // if(vars.PlantStory.Old <= 253 && vars.PlantStory.Current == 254 && !vars.Splits.Contains("VAMP1"))
    // {
    //     return settings["VAMP1"] && vars.Splits.Add("VAMP1");
    // }

    // if(vars.PlantStory.Old <= 317 && vars.PlantStory.Current == 318 && !vars.Splits.Contains("VAMP2"))
    // {
    //     return settings["VAMP2"] && vars.Splits.Add("VAMP2");
    // }

    // // did split too early one time?
    // if(vars.PlantStory.Old <= 396 && vars.PlantStory.Current == 397 && !vars.Splits.Contains("TENGUS1"))
    // {
    //     return settings["TENGUS1"] && vars.Splits.Add("TENGUS1");
    // }

    // if(vars.PlantStory.Old <= 403 && vars.PlantStory.Current == 404 && !vars.Splits.Contains("TENGUS2"))
    // {
    //     return settings["TENGUS2"] && vars.Splits.Add("TENGUS2");
    // }

    // if(vars.PlantStory.Old <= 411 && vars.PlantStory.Current == 412 && !vars.Splits.Contains("RAYS"))
    // {
    //     return settings["RAYS"] && vars.Splits.Add("RAYS");
    // }

    // if(vars.PlantStory.Old <= 469 && vars.PlantStory.Current == 470 && !vars.Splits.Contains("SOLIDUS"))
    // {
    //     return settings["SOLIDUS"] && vars.Splits.Add("SOLIDUS");
    // }

    // if(vars.PlantStory.Old == 486 && vars.PlantStory.Current == 487 && !vars.Splits.Contains("PLANT"))
    // {
    //     return settings["PLANT"] && vars.Splits.Add("PLANT");
    // }
}

start
{
    return (vars.IGTUS.Current == 0 && vars.IGTUS.Current != vars.IGTUS.Old && vars.Version.Current == "SLUS" || vars.IGTEU.Current == 0 && vars.IGTEU.Current != vars.IGTEU.Old && vars.Version.Current == "SLES");
}

onStart
{
    vars.Splits.Clear();
}

isLoading
{
    return true;
}

gameTime
{
    if(vars.Version.Current == "SLUS")
    {
        return TimeSpan.FromMilliseconds(vars.IGTUS.Current * 1000 / 60);
    }

    if(vars.Version.Current == "SLES")
    {
        return TimeSpan.FromMilliseconds(vars.IGTEU.Current * 1000 / 60);
    }
}

reset
{
    if(vars.MapStringUS.Current == "n_title" && vars.Version.Current == "SLUS" || vars.MapStringEU.Current == "n_title" && vars.Version.Current == "SLES")
    {
        return true;
    }
}
