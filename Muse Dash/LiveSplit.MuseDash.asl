state("MuseDash")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Muse Dash";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("MD", true, "Muse Dash");
        settings.Add("SongNo", true, "Split upon completing number of songs", "SongNo");
            settings.Add("10Songs", true, "10 Songs Completed", "SongNo");
            settings.Add("20Songs", true, "20 Songs Completed", "SongNo");
            settings.Add("30Songs", true, "30 Songs Completed", "SongNo");
            settings.Add("40Songs", true, "40 Songs Completed", "SongNo");
            settings.Add("50Songs", true, "50 Songs Completed", "SongNo");
        settings.Add("Touhou", true, "Split upon completing Touhou number of songs", "MD");
            settings.Add("7Songs", true, "7 Songs Completed", "Touhou");
            settings.Add("8Songs", true, "8 Songs Completed", "Touhou");
            settings.Add("15Songs", true, "30 Songs Completed", "Touhou");
            settings.Add("22Songs", true, "40 Songs Completed", "Touhou");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var gg = mono["GameGlobal"];
        vars.Helper["EndSong"] = gg.Make<bool>("gGameMusic", 0x6D);

        return true;
    });

    vars.SongCounter = 0;
}

update
{
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? old.ActiveScene;
    current.LoadingScene = vars.Helper.Scenes.Loaded[0].Name ?? old.LoadingScene;

    if(current.EndSong && !old.EndSong)
    {
        vars.SongCounter++;
    }
}

onStart
{
    vars.SongCounter = 0;
}

split
{
    if(current.EndSong && !old.EndSong)
    {
        return settings[vars.SongCounter + "Songs"];
    }
}

isLoading
{
    return current.ActiveScene == "Loading";
}