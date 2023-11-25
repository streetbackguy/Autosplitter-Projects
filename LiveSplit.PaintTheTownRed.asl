state("PaintTheTownRed")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Paint the Town Red";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var ll = mono["LoadingScreen"];
        vars.Helper["Loads"] = ll.Make<bool>("Instance");

        var sm = mono["SpectatorMenu"];
        vars.Helper["LevelComplete"] = sm.MakeString("String_LevelComplete");

        return true;
    });
}

start
{
    return !current.Loads && old.Loads;
}

isLoading
{
    return current.Loads;
}

//split
//{
    //return current.LevelComplete == "LEVEL COMPLETE";
//}