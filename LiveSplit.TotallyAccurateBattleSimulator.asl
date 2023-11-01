state("TotallyAccurateBattleSimulator")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Totally Accurate Battle Simulator";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["LoadingScreen"] = mono.Make<bool>("TABSSceneManager", "m_IsLoading");

        return true;
    });
}

isLoading
{
    return current.LoadingScreen;
}