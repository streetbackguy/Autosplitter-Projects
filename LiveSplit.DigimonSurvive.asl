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
    if(current.Loads && old.Loads)
    {
        return vars.Loader++;
    }
}

isLoading
{
    return vars.Loader > 1;
}

start
{
    return vars.Loader > 1;
}

exit
{
    vars.Loader = 0;
}
