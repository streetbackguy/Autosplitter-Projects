//Load Remover by Ero
// Autostart and Autoreset by Streetbackguy

state("AlanWake2")
{
    int LoadFile: 0x38085E0;
}

init
{
    // Code stipet written by just_ero, derived from Micrologist's original codework on UE4 sigscanning, using it as I used a simular sigscan method as micro for the game
    Func<int, string, IntPtr> scan = (offset, pattern) => {
    var scn = new SignatureScanner(game, game.MainModule.BaseAddress, game.MainModule.ModuleMemorySize);
    var pttern = new SigScanTarget(offset, pattern);
    var ptr = scn.Scan(pttern);
    return ptr + 0x4 + game.ReadValue<int>(ptr);
    };

    vars.Loading = scan(0x3, "44 38 1D ?? ?? ?? ?? 48 8B");
    vars.MainMenuTest = scan(0x3, "48 FF 05 ?? ?? ?? ?? C6 05 ?? ?? ?? ?? 01 C5 F8 77");
    // vars.Chapters = scan(0x3, "4C 8B 02 0F B7 4A 08 4C 89 00 66 89 48 08 C3");
    print("Loading: " + vars.Loading.ToString("X"));
    print("Menu: " + vars.MainMenuTest.ToString("X"));
    // print("Chapters: " + vars.Chapters.ToString("X"));
    vars.watchers = new MemoryWatcherList
    {
        new MemoryWatcher<bool>(new DeepPointer(vars.Loading)) { Name = "isLoading"},
        new MemoryWatcher<bool>(new DeepPointer(vars.MainMenuTest)) { Name = "MainMenu"},
        // new MemoryWatcher<IntPtr>(new DeepPointer(vars.Chapters)) { Name = "Chapters"},
    };
}

startup
{
    settings.Add("RESET", true, "Reset on Exit to Main Menu");
}

start
{
    return current.LoadFile == 0 && old.LoadFile == 5 && !current.MainMenu;
}

update
{
    vars.watchers.UpdateAll(game);
    current.Loading = vars.watchers["isLoading"].Current;
    current.MainMenu = vars.watchers["MainMenu"].Current;
    // current.Chapters = vars.watchers["Chapters"].Current;

    if(old.Loading != current.Loading)
    {
        print("Loads: " + old.Loading + " -> " + current.Loading);
    }

    // if(old.Chapters != current.Chapters)
    // {
    //     print("Chapters: " + old.Chapters + " -> " + current.Chapters);
    // }

    if(old.MainMenu != current.MainMenu)
    {
        print("Main Menu: " + old.MainMenu + " -> " + current.MainMenu);
    }
}

reset
{
    if(settings["RESET"] && old.LoadFile == 1 && current.MainMenu)
    {
        return true;
    }
}

onStart
{
    timer.IsGameTimePaused = true;
}

isLoading
{
    return (current.Loading);
}
