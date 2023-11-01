//Original ASL by Streetbackguy. Unreal Engine coding updated by Kuno Demetries.
state("Monke-Win64-Shipping", "Steam")
{
    int Cutscenes: 0x6C78040, 0x10, 0x330, 0x8;
}

startup
{
    settings.Add("KONG", true, "Skull Island: Rise of Kong");
        settings.Add("ANY", true, "Any% Splits", "KONG");
            settings.Add("Tutorial", true, "Split on final hit from Gaw in the Tutorial", "ANY");
            settings.Add("Worm", true, "Split on final hit on Gijja", "ANY");
            settings.Add("Wetlands", false, "Split on exiting to the Wetlands", "ANY");
            settings.Add("Wasteland", true, "Split on exiting to the Wasteland", "ANY");
            settings.Add("Gaw", true, "Split on final hit to Gaw", "ANY");

    //creates text components for variable information
	vars.SetTextComponent = (Action<string, string>)((id, text) =>
	{
	        var textSettings = timer.Layout.Components.Where(x => x.GetType().Name == "TextComponent").Select(x => x.GetType().GetProperty("Settings").GetValue(x, null));
	        var textSetting = textSettings.FirstOrDefault(x => (x.GetType().GetProperty("Text1").GetValue(x, null) as string) == id);
	        if (textSetting == null)
	        {
	        var textComponentAssembly = Assembly.LoadFrom("Components\\LiveSplit.Text.dll");
	        var textComponent = Activator.CreateInstance(textComponentAssembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
	        timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));
	
	        textSetting = textComponent.GetType().GetProperty("Settings", BindingFlags.Instance | BindingFlags.Public).GetValue(textComponent, null);
	        textSetting.GetType().GetProperty("Text1").SetValue(textSetting, id);
	        }
	
	        if (textSetting != null)
	        textSetting.GetType().GetProperty("Text2").SetValue(textSetting, text);
    });

    //Parent setting
	//settings.Add("Variable Information", true, "Variable Information");
	//Child settings that will sit beneath Parent setting
	//settings.Add("Camera", true, "Current Camera Target", "Variable Information");
    //settings.Add("Map", true, "Current Map", "Variable Information");
}

init
{
    vars.Splits = new HashSet<string>();
    vars.Cutscene = 0;
    vars.HUBs = 0;

    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
    using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
    MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
    print("Hash is: " + MD5Hash);

    switch (MD5Hash)
    {
        case "6078F5B401713C903662F9F71B1FD613": version = "Steam"; break;

        default: version = "Unknown"; break;
    }

    // Scanning the MainModule for static pointers to GSyncLoadCount, UWorld, UEngine and FNamePool
    var scn = new SignatureScanner(game, game.MainModule.BaseAddress, game.MainModule.ModuleMemorySize);
    var LoadingTrg = new SigScanTarget(2, "89 05 ?? ?? ?? ?? e8 ?? ?? ?? ?? 84 c0 75 ?? e8 ?? ?? ?? ?? 84 c0 48 8b c3 74 ?? 48 8b c5 f3 0f 10 04 06 f3 0f 11 05 ?? ?? ?? ?? e9") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var Loading1 = scn.Scan(LoadingTrg);
    var uWorldTrg = new SigScanTarget(3, "48 8b 1d ?? ?? ?? ?? 48 85 db 74 ?? 41 b0") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var uWorld = scn.Scan(uWorldTrg);
    var gameEngineTrg = new SigScanTarget(3, "48 89 05 ?? ?? ?? ?? 48 85 c9 74 ?? e8 ?? ?? ?? ?? 48 8d 4d") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var gameEngine = scn.Scan(gameEngineTrg);
    print(Loading1.ToString("X"));
    var fNamePoolTrg = new SigScanTarget(3, "48 8d 05 ?? ?? ?? ?? eb ?? 48 8d 0d ?? ?? ?? ?? e8 ?? ?? ?? ?? c6 05 ?? ?? ?? ?? ?? 0f 10 07") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var fNamePool = scn.Scan(fNamePoolTrg);

    // Throwing in case any base pointers can't be found (yet, hopefully)
    if(uWorld == IntPtr.Zero || gameEngine == IntPtr.Zero || fNamePool == IntPtr.Zero)
    {
        throw new Exception("One or more base pointers not found - retrying");
    }

	vars.Watchers = new MemoryWatcherList
    {
        new MemoryWatcher<int>(new DeepPointer(Loading1)) { Name = "Loading"},
        // UWorld.Name
        new MemoryWatcher<ulong>(new DeepPointer(uWorld, 0x18)) { Name = "worldFName"},
        // GameEngine.GameInstance.LocalPlayers[0].PlayerController.PlayerCameraManager.ViewTarget.Target.Name
        new MemoryWatcher<ulong>(new DeepPointer(gameEngine, 0xFC0, 0x38, 0x0, 0x30, 0x348, 0x12C0, 0x18)) { Name = "camViewTargetFName"},
    };

    // Translating FName to String, this *could* be cached
    vars.FNameToString = (Func<ulong, string>)(fName =>
    {
        var number   = (fName & 0xFFFFFFFF00000000) >> 0x20;
        var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
        var nameIdx  = (fName & 0x000000000000FFFF) >> 0x00;
        var chunk = game.ReadPointer(fNamePool + 0x10 + (int)chunkIdx * 0x8);
        var nameEntry = chunk + (int)nameIdx * 0x2;
        var length = game.ReadValue<short>(nameEntry) >> 6;
        var name = game.ReadString(nameEntry + 0x2, length);
        return number == 0 ? name : name;
    });

    vars.Watchers.UpdateAll(game);

    //sets the var world from the memory watcher
    current.world = old.world = vars.FNameToString(vars.Watchers["worldFName"].Current);
    
    //helps with null values throwing errors - i dont exactly know why, but thanks to Nikoheart for this
    current.camTarget = "";
    current.world = "";
}

update
{
    vars.Watchers.UpdateAll(game);

    // Get the current world name as string, only if *UWorld isnt null
    var worldFName = vars.Watchers["worldFName"].Current;
    current.world = worldFName != 0x0 ? vars.FNameToString(worldFName) : old.world;

    // Get the Name of the current target for the CameraManager
    current.camTarget = vars.FNameToString(vars.Watchers["camViewTargetFName"].Current);
    current.loading = vars.Watchers["Loading"].Current;
    //Prints the camera target to the Livesplit layout if the setting is enabled
        //if(settings["Camera"]) 
    //{
        //vars.SetTextComponent("Camera Target:",current.camTarget.ToString());
        //if (old.camTarget != current.camTarget) print("Camera Target:" + current.camTarget.ToString());
    //}

    //Prints the current map to the Livesplit layout if the setting is enabled
        //if(settings["Map"]) 
    //{
        //vars.SetTextComponent("Map:",current.world.ToString());
        //if (old.world != current.world) print("Map:" + current.world.ToString());
    //}

    //DEBUG CODE
        //print("isLoading? " + current.loading.ToString());
        //print("Loaded Map = " + current.world.ToString());
        //print("Camera Target = " + current.camTarget.ToString());
        //print("Horizontal Position:" + current.horizontalPos.ToString());
        //print(modules.First().ModuleMemorySize.ToString());

    if(current.Cutscenes == 2 && old.Cutscenes == 1)
    {
        vars.Cutscene++;
        print("Cutscene Total: " + vars.Cutscene);
    }

    if(current.world == "Stage" && vars.Watchers["Loading"].Current == 50 && vars.Watchers["Loading"].Old == 1)
    {
        vars.HUBs++;
        print("Stage Total: " + vars.HUBs);
    }
}

isLoading
{
    return vars.Watchers["Loading"].Current == 50;
}

start
{
    return vars.Watchers["Loading"].Old == 1 && vars.Watchers["Loading"].Current == 50 && old.world == "MainMenu_SkullIsland";
}

split
{
    if(vars.Cutscene == 4 && !vars.Splits.Contains("Tutorial"))
    {
        vars.Splits.Add("Tutorial");
        return settings["Tutorial"];
    }

    if(vars.Cutscene == 9 && !vars.Splits.Contains("Worm"))
    {
        vars.Splits.Add("Worm");
        return settings["Worm"];
    }
    
    if(current.world == "Stage2_Intro" && vars.Watchers["Loading"].Current == 50 && vars.Watchers["Loading"].Old == 1 && !vars.Splits.Contains("Wetlands"))
    {
        vars.Splits.Add("Wetlands");
        return settings["Wetlands"];
    }
    
    if(vars.HUBs == 3 && !vars.Splits.Contains("Wasteland"))
    {
        vars.Splits.Add("Wasteland");
        return settings["Wasteland"];
    }

    if(vars.Cutscene == 15 && !vars.Splits.Contains("Gaw"))
    {
        vars.Splits.Add("Gaw");
        return settings["Gaw"];
    }
}

reset
{
    return vars.Watchers["Loading"].Current == 1 && current.world == "MainMenu_SkullIsland";
}

onStart
{
    vars.Cutscene = 0;
    vars.HUBs = 0;
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}

onReset
{
    vars.Cutscene = 0;
    vars.HUBs = 0;
    vars.Splits.Clear();
}

exit
{
    vars.Cutscene = 0;
    vars.HUBs = 0;
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}
