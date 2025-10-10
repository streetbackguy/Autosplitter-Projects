// Load Removal by Diggity
// Autosplitter by Streetbackguy
// Code rewrite by Ero

state("Crow Country")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;

    vars.Helper.Settings.CreateFromXml("Components/CrowCountry.Settings.xml");
    vars.Helper.AlertLoadless();

    vars.IntVariablesCache = new Dictionary<string, int>();
    vars.BoolVariablesCache = new Dictionary<string, int>();
    vars.FloatVariablesCache = new Dictionary<string, int>();
    vars.StringVariablesCache = new Dictionary<string, int>();
    
    vars.ReadIntVariable = (Func<string, int>)(name =>
    {
        int i;

        // Retrieve from cache
        if (vars.IntVariablesCache.TryGetValue(name, out i))
        {
            if  (i < vars.Helper["IntVariables"].Current.Length && 
                vars.Helper.ReadString(vars.Helper["IntVariables"].Current[i] + vars.OffsetName) == name)
            {
                return vars.Helper.Read<int>(vars.Helper["IntVariables"].Current[i] + vars.IntOffsetValue);
            }
        }

        // Time to do it the hard way
        vars.IntVariablesCache.Remove(name);
        for (i = 0; i < vars.Helper["IntVariables"].Current.Length; i++)
        {
            if (name == vars.Helper.ReadString(vars.Helper["IntVariables"].Current[i] + vars.OffsetName))
            {
                vars.IntVariablesCache.Add(name, i);
                return vars.Helper.Read<int>(vars.Helper["IntVariables"].Current[i] + vars.IntOffsetValue);
            }
        }

        throw new Exception("ReadIntVariable: Variable not found!");
    });

    vars.ReadBoolVariable = (Func<string, bool>)(name =>
    {
        int i;

        // Retrieve from cache
        if (vars.BoolVariablesCache.TryGetValue(name, out i))
        {
            if  (i < vars.Helper["BoolVariables"].Current.Length && 
                vars.Helper.ReadString(vars.Helper["BoolVariables"].Current[i] + vars.OffsetName) == name)
            {
                return vars.Helper.Read<bool>(vars.Helper["BoolVariables"].Current[i] + vars.BoolOffsetValue);
            }
        }

        // Time to do it the hard way
        vars.BoolVariablesCache.Remove(name);
        for (i = 0; i < vars.Helper["BoolVariables"].Current.Length; i++)
        {
            if (name == vars.Helper.ReadString(vars.Helper["BoolVariables"].Current[i] + vars.OffsetName))
            {
                vars.BoolVariablesCache.Add(name, i);
                return vars.Helper.Read<bool>(vars.Helper["BoolVariables"].Current[i] + vars.BoolOffsetValue);
            }
        }

        throw new Exception("ReadBoolVariable: Variable not found!");
    });

    vars.ReadFloatVariable = (Func<string, float>)(name =>
    {
        int i;

        // Retrieve from cache
        if (vars.FloatVariablesCache.TryGetValue(name, out i))
        {
            if  (i < vars.Helper["FloatVariables"].Current.Length && 
                vars.Helper.ReadString(vars.Helper["FloatVariables"].Current[i] + vars.OffsetName) == name)
            {
                return vars.Helper.Read<float>(vars.Helper["FloatVariables"].Current[i] + vars.FloatOffsetValue);
            }
        }

        // Time to do it the hard way
        vars.FloatVariablesCache.Remove(name);
        for (i = 0; i < vars.Helper["FloatVariables"].Current.Length; i++)
        {
            if (name == vars.Helper.ReadString(vars.Helper["FloatVariables"].Current[i] + vars.OffsetName))
            {
                vars.FloatVariablesCache.Add(name, i);
                return vars.Helper.Read<float>(vars.Helper["FloatVariables"].Current[i] + vars.FloatOffsetValue);
            }
        }

        throw new Exception("ReadFloatVariable: Variable not found!");
    });

    vars.ReadStringVariable = (Func<string, string>)(name =>
    {
        int i;

        // Retrieve from cache
        if (vars.StringVariablesCache.TryGetValue(name, out i))
        {
            if  (i < vars.Helper["StringVariables"].Current.Length && 
                vars.Helper.ReadString(vars.Helper["StringVariables"].Current[i] + vars.OffsetName) == name)
            {
                return vars.Helper.ReadString(vars.Helper["StringVariables"].Current[i] + vars.StringOffsetValue);
            }
        }

        // Time to do it the hard way
        vars.StringVariablesCache.Remove(name);
        for (i = 0; i < vars.Helper["StringVariables"].Current.Length; i++)
        {
            if (name == vars.Helper.ReadString(vars.Helper["StringVariables"].Current[i] + vars.OffsetName))
            {
                vars.StringVariablesCache.Add(name, i);
                return vars.Helper.ReadString(vars.Helper["StringVariables"].Current[i] + vars.StringOffsetValue);
            }
        }

        throw new Exception("ReadStringVariable: Variable not found!");
    });

    vars.PendingSplits = 0;
    vars.CompletedSplits = new HashSet<string>();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var pmg = mono["PlayMaker", "PlayMakerGlobals"];

        vars.Helper["IntVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "intVariables");
        vars.Helper["IntVariables"].Update(game);

        vars.Helper["BoolVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "boolVariables");
        vars.Helper["BoolVariables"].Update(game);

        vars.Helper["FloatVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "floatVariables");
        vars.Helper["FloatVariables"].Update(game);

        vars.Helper["StringVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "stringVariables");
        vars.Helper["StringVariables"].Update(game);

        IntPtr[] intVariables = vars.Helper["IntVariables"].Current;
        IntPtr[] boolVariables = vars.Helper["BoolVariables"].Current;
        IntPtr[] floatVariables = vars.Helper["FloatVariables"].Current;
        IntPtr[] stringVariables = vars.Helper["StringVariables"].Current;

        vars.OffsetName = mono["PlayMaker", "NamedVariable"]["name"];
        vars.IntOffsetValue = mono["PlayMaker", "FsmInt"]["value"];
        vars.BoolOffsetValue = mono["PlayMaker", "FsmBool"]["value"];
        vars.FloatOffsetValue = mono["PlayMaker", "FsmFloat"]["value"];
        vars.StringOffsetValue = mono["PlayMaker", "FsmString"]["value"];

        return true;
    });

    current.hasBronzeKey = false;
    current.hasSilverKey = false;
    current.hasGoldKey = false;
    current.hasCrank = false;
    current.hasGemstone = false;
    current.hasChain = false;
    current.hasWoefulMask = false;
    current.hasTrident = false;
    current.hasDataDisk = false;
    current.hasAcidBottle = false;
    current.hasLargeBattery = false;
    current.hasGlassVials = false;
    current.hasPaper = false;

    current.hasShotgunCapacity = false;
    current.hasCrystalCrows = false;

    current.hasShotgun = false;
    current.hasFlamethrower = false;
    current.hasMagnum = false;

    current.hasShotECrow = false;
    current.hasRunningBoots = false;
    current.hasHandgunLaser = false;
    current.hasShotgunLaser = false;
    current.hasMagnumLaser = false;
    current.hasMedKitImprovement = false;

    current.hasPocketLight = false;
    current.hasClock1 = false;
    current.hasClock2 = false;
    current.hasClockworkCrow = false;

    current.hasHandgunPower = false;

    current.hasFlamethrowerRange = false;
    current.hasMagnumPower = false;
    current.hasMagnumAmmoToilet = false;
    current.hasMagnumAmmoHaunted = false;
    current.hasMagnumAmmoStoreroom = false;
    current.hasMagnumAmmoWitchwood = false;
    current.hasMagnumAmmoShortcut = false;

    current.SceneTransition = false;

    current.StartRun = false;
}

update
{
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? current.ActiveScene;

    // print("SYS Playtime is " + vars.ReadIntVariable("item: 1").ToString());
    // print("SYS Playtime is " + vars.ReadBoolVariable("item: shotgun").ToString());
    // print("SYS Playtime is " + vars.ReadFloatVariable("handgun strength").ToString());
    // print("SYS Playtime is " + vars.ReadStringVariable("Glb ItemAction Name").ToString());

    current.hasBronzeKey = vars.ReadIntVariable("item: 2") == 1;
    current.hasSilverKey = vars.ReadIntVariable("item: 3") == 1;
    current.hasGoldKey = vars.ReadIntVariable("item: 4") == 1;
    current.hasCrank = vars.ReadIntVariable("item: 5") == 1;
    current.hasGemstone = vars.ReadIntVariable("item: 6") == 1;
    current.hasChain = vars.ReadIntVariable("item: 7") == 1;
    current.hasWoefulMask = vars.ReadIntVariable("item: 8") == 1;
    current.hasTrident = vars.ReadIntVariable("item: 9") == 1;
    current.hasDataDisk = vars.ReadIntVariable("item: 10") == 1;
    current.hasAcidBottle = vars.ReadIntVariable("item: 11") == 1;
    current.hasLargeBattery = vars.ReadIntVariable("item: 12") == 1;
    current.hasGlassVials = vars.ReadIntVariable("item: 13") == 1;
    current.hasPaper = vars.ReadIntVariable("item: 14") == 1;

    current.hasShotgunCapacity = vars.ReadIntVariable("Shotgun in Clip MAX") == 4;
    current.hasCrystalCrows = vars.ReadIntVariable("CrystalCrows") == 42;

    current.hasShotgun = vars.ReadBoolVariable("item: shotgun");
    current.hasFlamethrower = vars.ReadBoolVariable("item: flamethrower");
    current.hasMagnum = vars.ReadBoolVariable("item: magnum");

    current.hasShotECrow = vars.ReadBoolVariable("Game End");
    current.hasRunningBoots = vars.ReadBoolVariable("WearingTrainers");
    current.hasHandgunLaser = vars.ReadBoolVariable("Handgun Laser");
    current.hasShotgunLaser = vars.ReadBoolVariable("Shotgun Laser");
    current.hasMagnumLaser = vars.ReadBoolVariable("Magnum Laser");
    current.hasMedKitImprovement = vars.ReadBoolVariable("First Aid knowledge");

    current.hasPocketLight = vars.ReadBoolVariable("light found");
    current.hasClock1 = vars.ReadBoolVariable("clock1bool");
    current.hasClock2 = vars.ReadBoolVariable("clock2bool");
    current.hasClockworkCrow = vars.ReadBoolVariable("mascotwalk");

    current.hasHandgunPower = vars.ReadFloatVariable("handgun strength") == 0.8f;

    current.hasFlamethrowerRange = vars.ReadStringVariable("Glb ItemAction Name");
    current.hasMagnumPower = vars.ReadStringVariable("Glb ItemAction Name");
    current.hasMagnumAmmo = vars.ReadStringVariable("Glb ItemAction Name");

    current.SceneTransition = vars.ReadBoolVariable("SceneTransition");

    current.StartRun = vars.ReadBoolVariable("IsInRun");
}

split
{
    //Item Splits
    if(!old.hasBronzeKey && current.hasBronzeKey && !vars.CompletedSplits.Contains("i-item: 2-1"))
    {
        return settings["i-item: 2-1"] && vars.CompletedSplits.Add("i-item: 2-1");
        vars.Log("Bronze Key");
    }

    if(!old.hasSilverKey && current.hasSilverKey && !vars.CompletedSplits.Contains("i-item: 3-1"))
    {
        return settings["i-item: 3-1"] && vars.CompletedSplits.Add("i-item: 3-1");
        vars.Log("Silver Key");
    }

    if(!old.hasGoldKey && current.hasGoldKey && !vars.CompletedSplits.Contains("i-item: 4-1"))
    {
        return settings["i-item: 4-1"] && vars.CompletedSplits.Add("i-item: 4-1");
        vars.Log("Gold Key");
    }

    if(!old.hasCrank && current.hasCrank && !vars.CompletedSplits.Contains("i-item: 5-1"))
    {
        return settings["i-item: 5-1"] && vars.CompletedSplits.Add("i-item: 5-1");
        vars.Log("Crank");
    }

    if(!old.hasGemstone && current.hasGemstone && !vars.CompletedSplits.Contains("i-item: 6-1"))
    {
        return settings["i-item: 6-1"] && vars.CompletedSplits.Add("i-item: 6-1");
        vars.Log("Gemstone");
    }

    if(!old.hasChain && current.hasChain && !vars.CompletedSplits.Contains("i-item: 7-1"))
    {
        return settings["i-item: 7-1"] && vars.CompletedSplits.Add("i-item: 7-1");
        vars.Log("Chain");
    }

    if(!old.hasWoefulMask && current.hasWoefulMask && !vars.CompletedSplits.Contains("i-item: 8-1"))
    {
        return settings["i-item: 8-1"] && vars.CompletedSplits.Add("i-item: 8-1");
        vars.Log("Woeful Mask");
    }

    if(!old.hasTrident && current.hasTrident && !vars.CompletedSplits.Contains("i-item: 9-1"))
    {
        return settings["i-item: 9-1"] && vars.CompletedSplits.Add("i-item: 9-1");
        vars.Log("Trident");
    }

    if(!old.hasDataDisk && current.hasDataDisk && !vars.CompletedSplits.Contains("i-item: 10-1"))
    {
        return settings["i-item: 10-1"] && vars.CompletedSplits.Add("i-item: 10-1");
        vars.Log("Data Disk");
    }

    if(!old.hasAcidBottle && current.hasAcidBottle && !vars.CompletedSplits.Contains("i-item: 11-1"))
    {
        return settings["i-item: 11-1"] && vars.CompletedSplits.Add("i-item: 11-1");
        vars.Log("Acid Bottle");
    }

    if(!old.hasLargeBattery && current.hasLargeBattery && !vars.CompletedSplits.Contains("i-item: 12-1"))
    {
        return settings["i-item: 12-1"] && vars.CompletedSplits.Add("i-item: 12-1");
        vars.Log("Large Battery");
    }

    if(!old.hasGlassVials && current.hasGlassVials && !vars.CompletedSplits.Contains("i-item: 13-1"))
    {
        return settings["i-item: 13-1"] && vars.CompletedSplits.Add("i-item: 13-1");
        vars.Log("Glass Vials");
    }

    if(!old.hasPaper && current.hasPaper && !vars.CompletedSplits.Contains("i-item: 14-1"))
    {
        return settings["i-item: 14-1"] && vars.CompletedSplits.Add("i-item: 14-1");
        vars.Log("Paper from Edward Crow");
    }

    //Weapon Splits
    if(!old.hasShotgun && current.hasShotgun && !vars.CompletedSplits.Contains("i-item: shotgun-1"))
    {
        return settings["i-item: shotgun-1"] && vars.CompletedSplits.Add("i-item: shotgun-1");
        vars.Log("Shotgun");
    }

    if(!old.hasFlamethrower && current.hasFlamethrower && !vars.CompletedSplits.Contains("i-item: flamethrower-1"))
    {
        return settings["i-item: flamethrower-1"] && vars.CompletedSplits.Add("i-item: flamethrower-1");
        vars.Log("Flamethrower");
    }

    if(!old.hasMagnum && current.hasMagnum && !vars.CompletedSplits.Contains("i-item: magnum-1"))
    {
        return settings["i-item: magnum-1"] && vars.CompletedSplits.Add("i-item: magnum-1");
        vars.Log("Magnum");
    }

    //Secrets Splits
    if(!old.hasRunningBoots && current.hasRunningBoots && !vars.CompletedSplits.Contains("b-WearingTrainers-1"))
    {
        return settings["b-WearingTrainers-1"] && vars.CompletedSplits.Add("b-WearingTrainers-1");
        vars.Log("Running Boots");
    }

    if(!old.hasHandgunLaser && current.hasHandgunLaser && !vars.CompletedSplits.Contains("b-Handgun Laser-1"))
    {
        return settings["b-Handgun Laser-1"] && vars.CompletedSplits.Add("b-Handgun Laser-1");
        vars.Log("Handgun Laser");
    }

    if(!old.hasHandgunPower && current.hasHandgunPower && !vars.CompletedSplits.Contains("f-handgun strength-0.8"))
    {
        return settings["f-handgun strength-0.8"] && vars.CompletedSplits.Add("f-handgun strength-0.8");
        vars.Log("Handgun Power");
    }

    if(!old.hasShotgunLaser && current.hasShotgunLaser && !vars.CompletedSplits.Contains("b-Shotgun Laser-1"))
    {
        return settings["b-Shotgun Laser-1"] && vars.CompletedSplits.Add("b-Shotgun Laser-1");
        vars.Log("Shotgun Laser");
    }

    if(!old.hasShotgunCapacity && current.hasShotgunCapacity && !vars.CompletedSplits.Contains("i-Shotgun in Clip MAX-4"))
    {
        return settings["i-Shotgun in Clip MAX-4"] && vars.CompletedSplits.Add("i-Shotgun in Clip MAX-4");
        vars.Log("Shotgun Capacity");
    }

    if(old.hasFlamethrowerRange != "Range Increased" && current.hasFlamethrowerRange == "Range Increased" && !vars.CompletedSplits.Contains("s-Glb ItemAction Name-Range Increased"))
    {
        return settings["s-Glb ItemAction Name-Range Increased"] && vars.CompletedSplits.Add("s-Glb ItemAction Name-Range Increased");
        vars.Log("Flamethrower Range");
    }

    if(!old.hasMagnumLaser && current.hasMagnumLaser && !vars.CompletedSplits.Contains("b-Magnum Laser-1"))
    {
        return settings["b-Magnum Laser-1"] && vars.CompletedSplits.Add("b-Magnum Laser-1");
        vars.Log("Magnum Laser");
    }

    if(old.hasMagnumPower != "Gold Plated" && current.hasMagnumPower == "Gold Plated" && !vars.CompletedSplits.Contains("s-Glb ItemAction Name-Gold Plated"))
    {
        return settings["s-Glb ItemAction Name-Gold Plated"] && vars.CompletedSplits.Add("s-Glb ItemAction Name-Gold Plated");
        vars.Log("Magnum Power");
    }

    if(!old.hasMedKitImprovement && current.hasMedKitImprovement && !vars.CompletedSplits.Contains("b-First Aid knowledge-1"))
    {
        return settings["b-First Aid knowledge-1"] && vars.CompletedSplits.Add("b-First Aid knowledge-1");
        vars.Log("Med Kit Improvement");
    }

    if(current.hasMagnumAmmo == "Magnum Ammo" && !vars.CompletedSplits.Contains("s-Glb ItemAction Name-Magnum Ammo-" + current.ActiveScene))
    {
        return settings["s-Glb ItemAction Name-Magnum Ammo-" + current.ActiveScene] && vars.CompletedSplits.Add("s-Glb ItemAction Name-Magnum Ammo-" + current.ActiveScene);
        vars.Log("Magnum Ammo " + current.ActiveScene);
    }

    if(!old.hasCrystalCrows && current.hasCrystalCrows && !vars.CompletedSplits.Contains("i-CrystalCrows-42"))
    {
        return settings["i-CrystalCrows-42"] && vars.CompletedSplits.Add("i-CrystalCrows-42");
        vars.Log("42 Crystal Crows");
    }

    //Misc Splits
    if(!old.hasPocketLight && current.hasPocketLight && !vars.CompletedSplits.Contains("b-light found-1"))
    {
        return settings["b-light found-1"] && vars.CompletedSplits.Add("b-light found-1");
        vars.Log("Pocket Light");
    }

    if(!old.hasClock1 && current.hasClock1 && !vars.CompletedSplits.Contains("b-clock1bool-1"))
    {
        return settings["b-clock1bool-1"] && vars.CompletedSplits.Add("b-clock1bool-1");
        vars.Log("Clock 1");
    }

    if(!old.hasClock2 && current.hasClock2 && !vars.CompletedSplits.Contains("b-clock2bool-1"))
    {
        return settings["b-clock2bool-1"] && vars.CompletedSplits.Add("b-clock2bool-1");
        vars.Log("Clock 2");
    }

    if(!old.hasClockworkCrow && current.hasClockworkCrow && !vars.CompletedSplits.Contains("b-mascotwalk-1"))
    {
        return settings["b-mascotwalk-1"] && vars.CompletedSplits.Add("b-mascotwalk-1");
        vars.Log("Clockwork Crow");
    }

    //Area Splits
    if(current.ActiveScene != old.ActiveScene)
    {
        var setting = "ac-" + old.ActiveScene;

        return settings[setting] && vars.CompletedSplits.Add(setting);
    }

    //Final input
    if(!current.StartRun && old.StartRun)
    {
        var setting = "end-input-0";

        return settings[setting] && vars.CompletedSplits.Add(setting);
    }
}

start
{
    return current.StartRun && !old.StartRun;
}

onStart
{
    vars.CompletedSplits.Clear();
}


reset
{
    return old.ActiveScene != "Title" && current.ActiveScene == "Title";
}

isLoading
{
    return current.SceneTransition;
}
