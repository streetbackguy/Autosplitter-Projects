//Original Autosplitter by Klawsin (Unfortunately not functional anymore)
//Updated with Autostart, Game Time and Reset by Streetbackguy
state("Freakpocalypse")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Cyanide & Happiness: Freakpocalypse";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
		//vars.Helper["Chores"] = mono.Make<int>("QuestManager", "m_Instance", 0x30);
		vars.Helper["IGT"] = mono.Make<float>("SpeedRunning", "Instance", "currentTime");
		
        return true;
    });
}

start
{
	return current.activeScene == "LoadGame" && old.activeScene == "MainMenu";
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

}

reset
{
	return current.activeScene == "MainMenu";
}