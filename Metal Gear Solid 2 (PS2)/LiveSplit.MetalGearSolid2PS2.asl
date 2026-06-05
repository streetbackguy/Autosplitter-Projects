state("pcxs2")
{
}

init
{
    vars.Splits = new HashSet<string>();
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PS2");

    vars.MapString = vars.Helper.MakeString(0x1911E8);
    vars.MapID = vars.Helper.Make<short>(0x1931D8, 0x2C);
    vars.IGT = vars.Helper.Make<short>(0x1931D8, 0x138);
    vars.TankerStory = vars.Helper.Make<short>(0x1931E0, 0x6);
    vars.PlantStory = vars.Helper.Make<short>(0x1931E0, 0x68);
    vars.Fatman = vars.Helper.Make<bool>(0x1931D8, 0x5D7);

    settings.Add("MAJOR", true, "Major Splits Only");
        settings.Add("OLGA", true, "Olga", "MAJOR");
        settings.Add("GUARDS", true, "Guard Rush", "MAJOR");
        settings.Add("TANKER", true, "Tanker Complete", "MAJOR");
        settings.Add("STILLMAN", true, "Stillman", "MAJOR");
        settings.Add("FORTUNE", true, "Fortune", "MAJOR");
        settings.Add("FATMAN", true, "Fatman", "MAJOR");
        settings.Add("AMES", true, "Ames", "MAJOR");
        settings.Add("HARRIER", true, "Harrier", "MAJOR");
        settings.Add("PRESIDENT", true, "President", "MAJOR");
        settings.Add("VAMP1", true, "Vamp 1", "MAJOR");
        settings.Add("VAMP2", true, "Vamp 2", "MAJOR");
        settings.Add("TENGUS1", true, "Tengus 1", "MAJOR");
        settings.Add("TENGUS2", true, "Tengus 2", "MAJOR");
        settings.Add("RAYS", true, "Rays", "MAJOR");
        settings.Add("SOLIDUS", true, "Solidus", "MAJOR");
        settings.Add("PLANT", true, "Plant Complete", "MAJOR");

    vars.TotalTime = new TimeSpan();
}

update
{
    if(vars.MapID.Old != vars.MapID.Current)
    {
        vars.Log(vars.MapID.Old + " -> " + vars.MapID.Current);
    }

    if(vars.MapString.Old != vars.MapString.Current)
    {
        vars.Log(vars.MapString.Old + " -> " + vars.MapString.Current);
    }
}

split
{
    if(vars.TankerStory.Old <= 27 && vars.TankerStory.Current == 28 && !vars.Splits.Contains("OLGA"))
    {
        return settings["OLGA"] && vars.Splits.Add("OLGA");
    }

    if(vars.TankerStory.Old <= 32 && vars.TankerStory.Current == 33 && !vars.Splits.Contains("GUARDS"))
    {
        return settings["GUARDS"] && vars.Splits.Add("GUARDS");
    }

    if(vars.TankerStory.Old >= 32 && vars.TankerStory.Old <= 55 && vars.TankerStory.Current >= 56 && vars.TankerStory.Current <= 64 && !vars.Splits.Contains("TANKER"))
    {
        return settings["TANKER"] && vars.Splits.Add("TANKER");
    }
    
    if(vars.PlantStory.Old <= 91 && vars.PlantStory.Current == 92 && !vars.Splits.Contains("STILLMAN"))
    {
        return settings["STILLMAN"] && vars.Splits.Add("STILLMAN");
    }

    if(vars.PlantStory.Old >= 110 && vars.PlantStory.Old <= 115 && vars.PlantStory.Current == 116 && !vars.Splits.Contains("FORTUNE"))
    {
        return settings["FORTUNE"] && vars.Splits.Add("FORTUNE");
    }

    if(vars.Fatman.Old == 1 && vars.Fatman.Current == 0 && !vars.Splits.Contains("FATMAN"))
    {
        return settings["FATMAN"] && vars.Splits.Add("FATMAN");
    }

    if(vars.PlantStory.Old <= 154 && vars.PlantStory.Current == 155 && !vars.Splits.Contains("AMES"))
    {
        return settings["AMES"] && vars.Splits.Add("AMES");
    }

    if(vars.PlantStory.Old >= 190 && vars.PlantStory.Old <= 192 && vars.PlantStory.Current == 193 && !vars.Splits.Contains("HARRIER"))
    {
        return settings["HARRIER"] && vars.Splits.Add("HARRIER");
    }

    if(vars.PlantStory.Old >= 227 && vars.PlantStory.Old <= 240 && vars.PlantStory.Current == 241 && !vars.Splits.Contains("PRESIDENT"))
    {
        return settings["PRESIDENT"] && vars.Splits.Add("PRESIDENT");
    }

    if(vars.PlantStory.Old >= 254 && vars.PlantStory.Old <= 256 && vars.PlantStory.Current == 257 && !vars.Splits.Contains("VAMP1"))
    {
        return settings["VAMP1"] && vars.Splits.Add("VAMP1");
    }

    if(vars.PlantStory.Old >= 254 && vars.PlantStory.Old <= 256 && vars.PlantStory.Current == 257 && !vars.Splits.Contains("VAMP2"))
    {
        return settings["VAMP2"] && vars.Splits.Add("VAMP2");
    }

    if(vars.PlantStory.Old >= 254 && vars.PlantStory.Old <= 256 && vars.PlantStory.Current == 257 && !vars.Splits.Contains("TENGUS1"))
    {
        return settings["TENGUS1"] && vars.Splits.Add("TENGUS1");
    }

    if(vars.PlantStory.Old >= 404 && vars.PlantStory.Old <= 405 && vars.PlantStory.Current == 406 && !vars.Splits.Contains("TENGUS2"))
    {
        return settings["TENGUS2"] && vars.Splits.Add("TENGUS2");
    }

    if(vars.PlantStory.Old >= 412 && vars.PlantStory.Old <= 417 && vars.PlantStory.Current == 418 && !vars.Splits.Contains("RAYS"))
    {
        return settings["RAYS"] && vars.Splits.Add("RAYS");
    }

    if(vars.PlantStory.Old >= 470 && vars.PlantStory.Old <= 471 && vars.PlantStory.Current == 472 && !vars.Splits.Contains("SOLIDUS"))
    {
        return settings["SOLIDUS"] && vars.Splits.Add("SOLIDUS");
    }

    if(vars.PlantStory.Old == 486 && vars.PlantStory.Current == 487 && !vars.Splits.Contains("PLANT"))
    {
        return settings["PLANT"] && vars.Splits.Add("PLANT");
    }
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
    if(vars.IGT.Old > vars.IGT.Current)
    {
        vars.TotalTime += TimeSpan.FromSeconds(vars.IGT.Old);
    }
    
    return vars.TotalTime + TimeSpan.FromSeconds(vars.IGT.Current);
}
