state("Crow Country")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Crow Country] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        return true;
    });
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name ?? old.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.loadingScene;

    if(current.activeScene != old.activeScene)
    {
        vars.Log("Current Scene: " + current.activeScene + " <- " + old.activeScene);
    }

    if(current.loadingScene != old.loadingScene)
    {
        vars.Log("Loading?: " + current.loadingScene);
    }
}

isLoading
{
    
}

start
{
    
}