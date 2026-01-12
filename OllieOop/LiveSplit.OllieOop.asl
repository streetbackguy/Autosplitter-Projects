state("OllieOop")
{

}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "OllieOop";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("OO", true, "OllieOop Splits");
        settings.Add("Demo", true, "Split After leaving Tutorial", "OO");
        settings.Add("Culdesac", true, "Split After leaving The Dog Next Door", "OO");
        settings.Add("Doggerton", true, "Split After leaving The Good, The Bad & The Pugly", "OO");
        settings.Add("Pupperwave", true, "Split After leaving Pupperwave", "OO");
        settings.Add("Mars", true, "Split After leaving Paws Attacks!", "OO");
        settings.Add("Skatepark", true, "Split After leaving Extreme Skate Bark", "OO");
        settings.Add("Castle", true, "Split After leaving Kingdom of the Muddy Paws", "OO");

    vars.Splits = new HashSet<string>();
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

    if (current.activeScene != old.activeScene)
    {
        vars.Log("Scene changed: " + old.activeScene + " -> " + current.activeScene);
    }
}

start
{
    if(current.activeScene != "Manager" && old.activeScene == "Manager")
    {
        return true;
    }
}

onStart
{
    vars.Splits.Clear();
}

split
{
    // Split when returning to Manager from any level (level completion)
    if (current.activeScene == "Manager" && old.activeScene != "Manager")
    {
        return true;
    }

    return false;
}
