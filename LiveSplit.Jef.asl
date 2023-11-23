state("JEF-Win64-Shipping")
{
    int Start: 0x4279FC0;
}

startup
{
    //Checks if the current time method is Real Time, if it is then it spawns a popup asking to switch to Game Time
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | JEF",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }

    settings.Add("JEF", true, "JEF");
        settings.Add("ANY", true, "Any% Splits", "JEF");
            settings.Add("Karzalinx", true, "Split on leaving Karzalinx", "ANY");
            settings.Add("Skolgajar", true, "Split on leaving Skolgajar", "ANY");
            settings.Add("Racetrack", true, "Split on leaving Racetrack", "ANY");
            settings.Add("HOTR", true, "Split on Entering the Astral Plane in HOTR", "ANY");
            settings.Add("Astral", true, "Split on leaving Astral Plane", "ANY");
            settings.Add("HOTR2", true, "Split on getting all Lamp Parts in HOTR", "ANY");
            settings.Add("Jacobo", true, "Split on Getting to the Curtain at the end of the game", "ANY");
}

init
{
    vars.Splits = new HashSet<string>();

    // Scanning the MainModule for static pointers to GSyncLoadCount, UWorld, UEngine and FNamePool
    var scn = new SignatureScanner(game, game.MainModule.BaseAddress, game.MainModule.ModuleMemorySize);
    var syncLoadTrg = new SigScanTarget(5, "89 43 60 8B 05 ?? ?? ?? ??") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var syncLoadCounterPtr = scn.Scan(syncLoadTrg);
    var uWorldTrg = new SigScanTarget(8, "0F 2E ?? 74 ?? 48 8B 1D ?? ?? ?? ?? 48 85 DB 74") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var uWorld = scn.Scan(uWorldTrg);
    var gameEngineTrg = new SigScanTarget(3, "48 39 35 ?? ?? ?? ?? 0F 85 ?? ?? ?? ?? 48 8B 0D") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var gameEngine = scn.Scan(gameEngineTrg);
    var fNamePoolTrg = new SigScanTarget(13, "89 5C 24 ?? 89 44 24 ?? 74 ?? 48 8D 15") { OnFound = (p, s, ptr) => ptr + 0x4 + game.ReadValue<int>(ptr) };
    var fNamePool = scn.Scan(fNamePoolTrg);

    // Throwing in case any base pointers can't be found (yet, hopefully)
    if(syncLoadCounterPtr == IntPtr.Zero || uWorld == IntPtr.Zero || gameEngine == IntPtr.Zero || fNamePool == IntPtr.Zero)
    {
        throw new Exception("One or more base pointers not found - retrying");
    }

	vars.Watchers = new MemoryWatcherList
    {
        // GSyncLoadCount
        new MemoryWatcher<int>(new DeepPointer(syncLoadCounterPtr)) { Name = "syncLoadCount" },
        // UWorld.Name
        new MemoryWatcher<ulong>(new DeepPointer(uWorld, 0x18)) { Name = "worldFName"},
        // GameEngine.GameInstance.LocalPlayers[0].PlayerController.PlayerCameraManager.ViewTarget.Target.Name
        new MemoryWatcher<ulong>(new DeepPointer(gameEngine, 0xD28, 0x38, 0x0, 0x30, 0x2B8, 0xE90, 0x18)) { Name = "camViewTargetFName"},
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

    //sets var loading from the memory watcher
    current.loading = old.loading = vars.Watchers["syncLoadCount"].Current > 0;
    //sets the var world from the memory watcher
    current.world = old.world = vars.FNameToString(vars.Watchers["worldFName"].Current);
    
    //helps with null values throwing errors - i dont exactly know why, but thanks to Nikoheart for this
    current.camTarget = "";
    current.world = "";
}

update
{
    vars.Watchers.UpdateAll(game);

    // The game is considered to be loading if any scenes are loading synchronously
    current.loading = vars.Watchers["syncLoadCount"].Current > 0;

    // Get the current world name as string, only if *UWorld isnt null
    var worldFName = vars.Watchers["worldFName"].Current;
    current.world = worldFName != 0x0 ? vars.FNameToString(worldFName) : old.world;

    // Get the Name of the current target for the CameraManager
    current.camTarget = vars.FNameToString(vars.Watchers["camViewTargetFName"].Current);

//DEBUG CODE
    //print("isLoading? " + current.loading.ToString());
    //if(current.world != old.world)
    //{
        //print("Loaded Map = " + current.world.ToString());
    //}
    //print("Camera Target = " + current.camTarget.ToString());
    //print("Horizontal Position:" + current.horizontalPos.ToString());
    //print(modules.First().ModuleMemorySize.ToString());
}

start
{
    return current.Start == 4 && old.Start == 23;
}

isLoading
{
    return current.loading;
}

split
{
    if(current.world == "ChewAndSpit" && old.world == "00_Intro" && !vars.Splits.Contains("Karzalinx"))
    {
        return vars.Splits.Add("Karzalinx") && settings["Karzalinx"];
    }

    if(current.world == "RaceTrackLoading" && old.world == "02_SkolgajarCity" && !vars.Splits.Contains("Skolgajar"))
    {
        return vars.Splits.Add("Skolgajar") && settings["Skolgajar"];
    }

    if(current.world == "ChewAndSpitScooter" && old.world == "03_BlackHoleSurf" && !vars.Splits.Contains("Racetrack"))
    {
        return vars.Splits.Add("Racetrack") && settings["Racetrack"];
    }

    if(current.world == "AstralLoading" && old.world == "07_HOTRStore" && !vars.Splits.Contains("HOTR"))
    {
        return vars.Splits.Add("HOTR") && settings["HOTR"];
    }

    if(current.world == "Hotr2Loading" && old.world == "AstralProjectionLevel" && !vars.Splits.Contains("Astral"))
    {
        return vars.Splits.Add("Astral") && settings["Astral"];
    }

    if(current.world == "GotAllParts" && old.world == "07_HOTRStore" && !vars.Splits.Contains("HOTR2"))
    {
        return vars.Splits.Add("HOTR2") && settings["HOTR2"];
    }

    if(current.world == "EndVictoryLevel" && old.world == "NameGenerator" && !vars.Splits.Contains("Jacobo"))
    {
        return vars.Splits.Add("Jacobo") && settings["Jacobo"];
    }
}

onStart
{
    vars.Splits.Clear();
}

exit
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}
