state("Nightcry"){}

startup
{
    vars.Splits = new HashSet<string>();

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Nightcry";
    vars.Helper.LoadSceneManager = true;

    settings.Add("NC", true, "Nightcry");
        settings.Add("Chapter1_3", true, "Split after Chapter 1", "NC");
        settings.Add("Chapter2_4", true, "Split after Chapter 2", "NC");
        settings.Add("Chapter3_8", true, "Split after Chapter 3", "NC");
}

init
{
    vars.StarterHelper = 0;

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        vars.Helper["fadeUIAlpha"] = mono.Make<float>("SceneManager", "instance", 0x214);
        vars.Helper["sceneChange"] = mono.MakeString("SceneManager", "instance", 0x14);
        vars.Helper["LoadTask"] = mono.Make<bool>("SceneManager", "instance", 0x12C);

        return true;
    });
}

update
{
    if(current.sceneChange != old.sceneChange)
    {
        vars.Log("Old Level: " + old.sceneChange + " New level: " + current.sceneChange);
    }

    if(old.sceneChange == "Title" && current.sceneChange != "Title")
    {
        vars.StarterHelper++;
    }
}

isLoading
{
    return current.LoadTask || current.fadeUIAlpha != 0;
}

split
{
    if(current.sceneChange != "Chapter1_3" && old.sceneChange == "Chapter1_3" && !vars.Splits.Contains("Chapter1_3"))
    {
        return vars.Splits.Add("Chapter1_3");
        return settings["Chapter1_3"];
    }

    if(current.sceneChange != "Chapter2_4" && old.sceneChange == "Chapter2_4" && !vars.Splits.Contains("Chapter2_4"))
    {
        return vars.Splits.Add("Chapter2_4");
        return settings["Chapter2_4"];
    }

    if(current.sceneChange != "Chapter3_8" && old.sceneChange == "Chapter3_8" && !vars.Splits.Contains("Chapter3_8"))
    {
        return vars.Splits.Add("Chapter3_8");
        return settings["Chapter3_8"];
    }
}

start
{
    return current.LoadTask && old.sceneChange == "Title" && current.sceneChange != "Title" && vars.StarterHelper >= 1;
}

reset
{
    return current.sceneChange == "Title" && old.sceneChange != "Title";
}

onStart
{
    vars.Splits.Clear();
}

exit
{
    vars.StarterHelper = 0;
}
