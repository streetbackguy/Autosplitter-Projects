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
    vars.Loader = 0;

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["Loads"] = mono.Make<bool>("FadeManager", "instance", 0x9C);

        return true;
    });
}

update
{
    if(current.Loads)
    {
        vars.Loader++;
    }
}

isLoading
{
    return current.Loads > 1;
}

start
{
    return current.Loads > 1;
}

exit
{
    vars.Loader = 0;
}
