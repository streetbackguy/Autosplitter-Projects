state("Crow Country")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Crow Country] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    vars.Helper.Settings.CreateFromXml("Components/CrowCountry.Settings.xml");
    vars.Helper.AlertLoadless();
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        //var pm = mono["PlayMaker", "PlayMakerGlobals"];
        //vars.Helper["Items"] = pm.Make<IntPtr>("instance", 0x18, 0x10, 0x10);

        return true;
    });
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name ?? current.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? current.loadingScene;

    if(current.Items!= old.Items)
    {
        vars.Log(old.Items + " -> " + current.Items);
    }
}

isLoading
{
    return old.loadingScene != current.activeScene;
}

start
{
    return old.activeScene == "Title" && current.activeScene == "Driving Intro";
}

split
{
    //Areas
    if(old.loadingScene != current.loadingScene && old.loadingScene != "Title" && old.loadingScene != "Driving Intro")
    {
        vars.Log("Area completed | " + old.loadingScene);
        return settings["area" + old.loadingScene];
    }
}

reset
{
    return current.activeScene == "Title" && old.activeScene != "Title";
}