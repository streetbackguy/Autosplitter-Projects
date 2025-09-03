state("LiveSplit")
{
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");

    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
	{
		emu.Make<short>("Level", 0x8008EE9C);
        emu.Make<short>("Screen", 0x8008EF30);
        emu.Make<short>("NewGame", 0x8008F19C);
        emu.Make<short>("Loading", 0x80089C13);
        emu.Make<byte>("LoadingFades", 0x801FFB97);

		return true;
	});

    settings.Add("FULL", false, "Nightmare Creatures Any%/Glitchless");
        settings.Add("FG0", false, "Complete Chelsea", "FULL");
        settings.Add("FG1", false, "Complete Spitalfield", "FULL");
        settings.Add("FG2", false, "Sewer Snake Defeated", "FULL");
        settings.Add("FG3", false, "Complete Thames Tunnel", "FULL");
        settings.Add("FG4", false, "Complete India Docks", "FULL");
        settings.Add("FG5", false, "Complete Highgate Cemetery", "FULL");
        settings.Add("FG6", false, "Complete Hampstead Heath", "FULL");
        settings.Add("FG7", false, "Complete Queenhithe Docks", "FULL");
        settings.Add("FG8", false, "Complete City", "FULL");
        settings.Add("FG9", false, "Complete Smithfield", "FULL");
        settings.Add("FG10", false, "Snowman Defeated", "FULL");
        settings.Add("FG11", false, "Complete Regents Canal", "FULL");
        settings.Add("FG12", false, "Complete London Zoo", "FULL");
        settings.Add("FG13", false, "Complete St. Marylebone", "FULL");
        settings.Add("FG14", false, "Complete Bloomsbury", "FULL");
        settings.Add("FG15", false, "Complete Pimlico", "FULL");
        settings.Add("FG16", false, "Jose Manuel Defeated", "FULL");
        settings.Add("FG17", false, "Complete Westminster", "FULL");
        settings.Add("FG18", false, "Complete Westminster 2", "FULL");
        settings.Add("FG19", false, "Adam Crowley Defeated", "FULL");
    settings.Add("IL", false, "Nightmare Creatures ILs");
        settings.Add("IL0", false, "Complete Chelsea", "IL");
        settings.Add("IL1", false, "Complete Spitalfield", "IL");
        settings.Add("IL2", false, "Sewer Snake Defeated", "IL");
        settings.Add("IL3", false, "Complete Thames Tunnel", "IL");
        settings.Add("IL4", false, "Complete India Docks", "IL");
        settings.Add("IL5", false, "Complete Highgate Cemetery", "IL");
        settings.Add("IL6", false, "Complete Hampstead Heath", "IL");
        settings.Add("IL7", false, "Complete Queenhithe Docks", "IL");
        settings.Add("IL8", false, "Complete City", "IL");
        settings.Add("IL9", false, "Complete Smithfield", "IL");
        settings.Add("IL10", false, "Snowman Defeated", "IL");
        settings.Add("IL11", false, "Complete Regents Canal", "IL");
        settings.Add("IL12", false, "Complete London Zoo", "IL");
        settings.Add("IL13", false, "Complete St. Marylebone", "IL");
        settings.Add("IL14", false, "Complete Bloomsbury", "IL");
        settings.Add("IL15", false, "Complete Pimlico", "IL");
        settings.Add("IL16", false, "Jose Manuel Defeated", "IL");
        settings.Add("IL17", false, "Complete Westminster", "IL");
        settings.Add("IL18", false, "Complete Westminster 2", "IL");
        settings.Add("IL19", false, "Adam Crowley Defeated", "IL");

    vars.ILTimer = new Stopwatch();
    vars.PauseOffset = new Stopwatch();
    vars.InGame = false;
}

init
{
    vars.Splits = new HashSet<string>();
}

start
{
    if(settings["FULL"])
    {
        return current.NewGame == 1 && current.Screen == 12;
    }

    if(settings["IL"] && old.Loading == 2 && current.Loading != 2 && vars.InGame == true)
    {
        vars.ILTimer.Start();
    }

    if(settings["IL"] && vars.ILTimer.ElapsedMilliseconds >= 1000)
    {
        vars.ILTimer.Reset();
        return true;
    }
}

onStart
{
    vars.Splits.Clear();
}

onReset
{
    vars.InGame = false;
}

update
{
    if(old.Screen == 12 && current.Screen == 0)
    {
        vars.InGame = true;
    }
}

isLoading
{
    if(current.Screen == 1 || current.Screen == 2 || current.Screen == 3 || current.Screen == 6 || current.Screen == 10 || current.Screen == 13 || current.Loading == 2 || current.LoadingFades == 128)
    {
        return true;
    }

    if(old.Screen == 10 && current.Screen != 10 || old.Screen == 13 && current.Screen != 13 || old.Screen == 1 && current.Screen != 1 || old.Screen == 2 && current.Screen != 2 || old.Screen == 3 && current.Screen != 3)
    {
        vars.PauseOffset.Start();
    }

    if(vars.PauseOffset.ElapsedMilliseconds >= 100)
    {
        vars.PauseOffset.Reset();
        return false;
    }
}

split
{
    if(current.Screen == 6 && !vars.Splits.Contains("FG"+current.Level.ToString()))
    {
        return settings["FG"+current.Level.ToString()] && vars.Splits.Add("FG"+current.Level.ToString());
    }

    if(current.Level == 19 && current.Screen == 36 && !vars.Splits.Contains("FG"+current.Level.ToString()))
    {
        return settings["FG"+current.Level.ToString()] && vars.Splits.Add("FG"+current.Level.ToString());
    }

    if(current.Screen == 6 && !vars.Splits.Contains("IL"+current.Level.ToString()))
    {
        return settings["IL"+current.Level.ToString()] && vars.Splits.Add("IL"+current.Level.ToString());
    }

    if(current.Level == 19 && current.Screen == 36 && !vars.Splits.Contains("IL"+current.Level.ToString()))
    {
        return settings["IL"+current.Level.ToString()] && vars.Splits.Add("IL"+current.Level.ToString());
    }
}