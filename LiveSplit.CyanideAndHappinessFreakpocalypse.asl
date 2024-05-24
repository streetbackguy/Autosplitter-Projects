//Original Autosplitter by Klawsin (Unfortunately not functional anymore)
//Updated with Autostart, Game Time, Reset and new Autosplitting by Streetbackguy
state("Freakpocalypse")
{
    int choreNumber: "UnityPlayer.dll", 0x18243D0, 0x3D8, 0x80, 0xE8, 0x60, 0x38, 0x48;
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Cyanide & Happiness: Freakpocalypse";
    vars.Helper.LoadSceneManager = true;

    settings.Add("CAH", true, "Freakpocalypse - Episode 1");
        settings.Add("CHORE", true, "Split upon completing each Chore", "CAH");
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
		vars.Helper["IGT"] = mono.Make<float>("SpeedRunning", "Instance", "currentTime");

        return true;
    });
}

start
{
	return current.activeScene == "LoadGame" && old.activeScene == "MainMenu";
}

onStart
{
    vars.choreStorage = 0;
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;
}

gameTime
{
    return TimeSpan.FromSeconds(current.IGT);
}

split
{
    if (current.choreNumber > old.choreNumber)
	{
		if (current.choreNumber == vars.choreStorage+1)
		{
			vars.choreStorage = current.choreNumber;
			return settings["CHORE"];
		}
	}
}

reset
{
	return current.activeScene == "MainMenu";
}
