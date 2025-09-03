state("SWTFU")
{
    bool Loading: 0xE40439;
    byte NGStart: 0xF91AD9;
    byte NGPlusStart: 0x10B5063;
    byte Level: 0xEA0ADC;
}

init
{
    vars.LevelSplits = new HashSet<string>();
}

startup
{
    settings.Add("SWTFU", true, "Star Wars: The Force Unleashed");
        settings.Add("LVL", true, "End of Level Splits", "SWTFU");
            settings.Add("Kashyyyk", true, "Kashyyyk", "LVL");
            settings.Add("Training Room", true, "Training Room", "LVL");
            settings.Add("Tie Fighter Factory", true, "Tie Fighter Factory", "LVL");
            settings.Add("Raxus Prime", true, "Raxus Prime", "LVL");
            settings.Add("Felucia", true, "Felucia", "LVL");
            settings.Add("The Empiricial", true, "The Empirical", "LVL");
            settings.Add("Cloud City", true, "Cloud City", "LVL");
            settings.Add("Imperial Kashyyyk", true, "Imperial Kashyyyk", "LVL");
            settings.Add("Imperial Felucia", true, "Imperial Felucia", "LVL");
            settings.Add("Imperial Raxus Prime", true, "Imperial Raxus Prime", "LVL");
            settings.Add("Death Star", true, "Death Star", "LVL");
}

isLoading
{
    return current.Loading;
}

split
{
    if(current.Level != old.Level && old.Level == 2 && !vars.LevelSplits.Contains("Kashyyyk"))
    {
        return settings["Kashyyyk"] && vars.LevelSplits.Add("Kashyyyk");
    }

    if(current.Level != old.Level && old.Level == 4 && !vars.LevelSplits.Contains("Training Room"))
    {
        return settings["Training Room"] && vars.LevelSplits.Add("Training Room");
    }

    if(current.Level != old.Level && old.Level == 6 && !vars.LevelSplits.Contains("Tie Fighter Factory"))
    {
        return settings["Tie Fighter Factory"] && vars.LevelSplits.Add("Tie Fighter Factory");
    }

    if(current.Level != old.Level && old.Level == 8 && !vars.LevelSplits.Contains("Raxus Prime"))
    {
        return settings["Raxus Prime"] && vars.LevelSplits.Add("Raxus Prime");
    }

    if(current.Level != old.Level && old.Level == 12 && !vars.LevelSplits.Contains("Felucia"))
    {
        return settings["Felucia"] && vars.LevelSplits.Add("Felucia");
    }

    if(current.Level != old.Level && old.Level == 15 && !vars.LevelSplits.Contains("The Empirical"))
    {
        return settings["The Empirical"] && vars.LevelSplits.Add("The Empirical");
    }

    if(current.Level != old.Level && old.Level == 17 && !vars.LevelSplits.Contains("Cloud City"))
    {
        return settings["Cloud City"] && vars.LevelSplits.Add("Cloud City");
    }

    if(current.Level != old.Level && old.Level == 19 && !vars.LevelSplits.Contains("Imperial Kashyyyk"))
    {
        return settings["Imperial Kashyyyk"] && vars.LevelSplits.Add("Imperial Kashyyyk");
    }
    
    if(current.Level != old.Level && old.Level == 21 && !vars.LevelSplits.Contains("Imperial Felucia"))
    {
        return settings["Imperial Felucia"] && vars.LevelSplits.Add("Imperial Felucia");
    }
        
    if(current.Level != old.Level && old.Level == 26 && !vars.LevelSplits.Contains("Imperial Raxus Prime"))
    {
        return settings["Imperial Raxus Prime"] && vars.LevelSplits.Add("Imperial Raxus Prime");
    }

    if(current.Level != old.Level && old.Level == 31 && !vars.LevelSplits.Contains("Death Star"))
    {
        return settings["Death Star"] && vars.LevelSplits.Add("Death Star");
    }
}

start
{
    return current.NGStart == 1 && old.NGStart == 0 || current.NGPlusStart == 66 && old.NGPlusStart == 0;
}

onStart
{
    vars.LevelSplits.Clear();
}