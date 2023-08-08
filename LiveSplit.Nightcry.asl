state("Nightcry"){}

startup
{
    vars.Splits = new HashSet<string>();

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Nightcry";
    vars.Helper.LoadSceneManager = true;
    vars.Helper.AlertLoadless();

    settings.Add("NC", true, "Nightcry");
        settings.Add("Chapter1_1", true, "Split after Chapter 1-1", "NC");
        settings.Add("Chapter1_2", true, "Split after Chapter 1-2", "NC");
        settings.Add("Chapter1_3", true, "Split after Chapter 1-3", "NC");
        settings.Add("Chapter2_1", true, "Split after Chapter 2-1", "NC");
        settings.Add("Chapter2_2", true, "Split after Chapter 2-2", "NC");
        settings.Add("Chapter2_3", true, "Split after Chapter 2-3", "NC");
        settings.Add("Chapter2_4", true, "Split after Chapter 2-4", "NC");
        settings.Add("Chapter3_1", true, "Split after Chapter 3-1", "NC");
        settings.Add("Chapter3_2", true, "Split after Chapter 3-2", "NC");
        settings.Add("Chapter3_3", true, "Split after Chapter 3-3", "NC");
        settings.Add("Chapter3_4", true, "Split after Chapter 3-4", "NC");
        settings.Add("Chapter3_5", true, "Split after Chapter 3-5", "NC");
        settings.Add("Chapter3_6", true, "Split after Chapter 3-6", "NC");
        settings.Add("Chapter3_7", true, "Split after Chapter 3-7", "NC");
        settings.Add("Chapter3_8", true, "Split after Chapter 3-8", "NC");
}

init
{
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
}

isLoading
{
    return current.LoadTask || current.fadeUIAlpha != 0;
}

split
{
    if(current.sceneChange != old.sceneChange && !vars.Splits.Contains(old.sceneChange))
    {
        return vars.Splits.Add(old.sceneChange);
        return settings[old.sceneChange];
    }
}

start
{
    return current.LoadTask && old.sceneChange == "Title";
}

reset
{
    return current.sceneChange == "Title";
}