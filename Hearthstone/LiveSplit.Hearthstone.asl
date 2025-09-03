state("Hearthstone") 
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Hearthstone";
    vars.Helper.AlertLoadless();
}

init
{
    var basePath = Path.GetDirectoryName(modules.First().FileName).ToString();

    var loadingLogPath = Directory.GetFiles(basePath, "LoadingScreen.log", SearchOption.AllDirectories).LastOrDefault();

	if (File.Exists(loadingLogPath)) {
		try {
			vars.reader = new StreamReader(new FileStream(loadingLogPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
			vars.line = vars.reader.ReadToEnd();
			print("Connected successfully to " + loadingLogPath);
		}
		catch {
			print("Failed to connect to " + loadingLogPath);
			vars.reader = null;
			vars.line = null;
		}
	} 
	else {
		print("Couldn't find log file path");
		vars.reader = null;
		vars.line = null;
	}
}

update
{
    while (vars.reader != null)
    {
		vars.line = vars.reader.ReadToEnd();
		if (vars.line == null || vars.line == "")
        {
			return false;
		}
		break;
	}

    print(vars.line);
}

isLoading
{
    if (vars.line.Contains("LoadingScreen.OnSceneLoaded()") ||
		vars.line.Contains("LoadingScreen.OnScenePreUnload() - prevMode=ADVENTURE nextMode=GAMEPLAY m_phase=INVALID") ||
		vars.line.Contains("LoadingScreen.OnSceneUnLoaded()") ||
        vars.line.Contains("LoadingScreen.SetTransitionAudioListener() - AudioListener (UnityEngine.AudioListener)") ||
        vars.line.Contains("LoadingScreen.SetAssetLoadStartTimestamp()") ||
        vars.line.Contains("LoadingScreen.ClearPreviousSceneAssets()") ||
        vars.line.Contains("Box.Awake()") ||
        vars.line.Contains("Box.OnDestroy()") ||
        vars.line.Contains("LoadingScreen.SetAssetLoadStartTimestamp()") ||
        vars.line.Contains("Gameplay.Awake()") ||
        vars.line.Contains("Gameplay.Start()") ||
        vars.line.Contains("Gameplay.Unload()") ||
        vars.line.Contains("LoadingScreen.DisableTransitionUnfriendlyStuff()") ||
        vars.line.Contains("Gameplay.OnPowerHistory() - powerList=126") && vars.line.Old.Contains("LoadingScreen.OnSceneUnLoaded()") ||
        vars.line.Contains("MulliganManager.HandleGameStart()") ||
        vars.line.Contains("MulliganManager.WaitForHeroesAndStartAnimations()") ||
        vars.line.Contains("Gameplay.OnEntityChoices()") ||
        vars.line.Contains("LoadingScreen.HackWaitThenStartTransitionEffects() - START") ||
        vars.line.Contains("LoadingScreen.FadeOut()") ||
        vars.line.Contains("LoadingScreen.OnFadeOutComplete()") ||
        vars.line.Contains("LoadingScreen.FinishPreviousScene()") ||
        vars.line.Contains("LoadingScreen.ClearPreviousSceneAssets()") ||
        vars.line.Contains("LoadingScreen.FadeIn()"))
        {
		    return true;
        } else {
            return false;
        }
}