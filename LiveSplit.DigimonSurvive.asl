state("DigimonSurvive"){}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Digimon Survive";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    Thread.Sleep(20000);

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Loads"] = mono.Make<bool>("FadeManager", "instance", 0x9C);

        return true;
    });
}

isLoading
{
    return current.Loads;
}

start
{
    return current.Loads;
}