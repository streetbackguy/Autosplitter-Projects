// Load Removal by Diggity
// Autosplitter by Streetbackguy
// Code rewrite by Ero

state("Crow Country")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;

    vars.Helper.Settings.CreateFromXml("Components/CrowCountry.Settings.xml");
    vars.Helper.AlertLoadless();

    vars.PendingSplits = 0;
    vars.CompletedSplits = new HashSet<string>(); 
}

onStart
{
    vars.CompletedSplits.Clear();
}

init
{
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var pmg = mono["PlayMaker", "PlayMakerGlobals"];
        vars.Helper["IntVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "intVariables");
        vars.Helper["BoolVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "boolVariables");

        vars.OffsetName = mono["PlayMaker", "NamedVariable"]["name"];
        vars.IntOffsetValue = mono["PlayMaker", "FsmInt"]["value"];
        vars.BoolOffsetValue = mono["PlayMaker", "FsmBool"]["value"];

        vars.Helper["IntVariables"].Update(game);
        IntPtr[] intVariables = vars.Helper["IntVariables"].Current;

        if (intVariables.Length == 0)
            return false;

        vars.IntVariableCount = intVariables.Length; // if this array is ever resized, this would no longer work
        vars.IntVariableNames = intVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();

        vars.Helper["BoolVariables"].Update(game);
        IntPtr[] boolVariables = vars.Helper["BoolVariables"].Current;

        if (boolVariables.Length == 0)
            return false;

        vars.BoolVariableCount = boolVariables.Length; // if this array is ever resized, this would no longer work
        vars.BoolVariableNames = boolVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();

        return true;
    });
}

update
{
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? current.ActiveScene;
}

start
{
    // return current.ActiveScene != current.ActiveScene && old.ActiveScene == "Roadside";
}

split
{
    if (vars.PendingSplits > 0)
    {
        vars.PendingSplits--;
        return true;
    }

    // Items
    for (int i = 0; i < vars.IntVariableCount; i++)
    {
        string name = vars.IntVariableNames[i];
        int value = vars.Helper.Read<int>(current.IntVariables[i] + vars.IntOffsetValue);

        string setting = "i-" + name + "-" + value; // i = item
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }
    }

    // Weapons
    for (int i = 0; i < vars.BoolVariableCount; i++)
    {
        string name = vars.BoolVariableNames[i];
        int value = vars.Helper.Read<int>(current.BoolVariables[i] + vars.BoolOffsetValue);

        string setting = "w-" + name + "-" + value; // w = weapon
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }
    }

    // Areas
    if (old.ActiveScene != current.ActiveScene)
    {
        string setting = "ac-" + old.ActiveScene; // ac = area complete
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }
    }

    // Secrets
    for (int i = 0; i < vars.BoolVariableCount; i++)
    {
        string name = vars.BoolVariableNames[i];
        int value = vars.Helper.Read<int>(current.BoolVariables[i] + vars.BoolOffsetValue);

        string setting = "s-" + name + " " + value; // s = secret
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }
    }
}

reset
{
    return old.ActiveScene != "Title" && current.ActiveScene == "Title";
}

isLoading
{
    return vars.Helper.IsLoading;
}
