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
		var variables = mono["PlayMaker", "FsmVariables"];

		vars.Helper["FloatVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "floatVariables");
		vars.Helper["IntVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "intVariables");
		vars.Helper["BoolVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "boolVariables");
		vars.Helper["StringVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", "stringVariables");

        vars.OffsetName = mono["PlayMaker", "NamedVariable"]["name"];
        vars.IntOffsetValue = mono["PlayMaker", "FsmInt"]["value"];
        vars.BoolOffsetValue = mono["PlayMaker", "FsmBool"]["value"];
        vars.FloatOffsetValue = mono["PlayMaker", "FsmFloat"]["value"];
        vars.StringOffsetValue = mono["PlayMaker", "FsmString"]["value"];

		//Int variable Output
		vars.Helper["IntVariables"].Update(game);
		IntPtr[] IntVariables = vars.Helper["IntVariables"].Current;

        if (IntVariables.Length == 0)
            return false;

        vars.IntVariableCount = IntVariables.Length;
        vars.IntVariableNames = IntVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();

        //Bool variable Output
		vars.Helper["BoolVariables"].Update(game);
		IntPtr[] BoolVariables = vars.Helper["BoolVariables"].Current;

        if (BoolVariables.Length == 0)
            return false;

        vars.BoolVariableCount = BoolVariables.Length;
        vars.BoolVariableNames = BoolVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();

        //Float variable Output
		vars.Helper["FloatVariables"].Update(game);
		IntPtr[] FloatVariables = vars.Helper["FloatVariables"].Current;

        if (FloatVariables.Length == 0)
            return false;

        vars.FloatVariableCount = FloatVariables.Length;
        vars.FloatVariableNames = FloatVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();

        //String variable Output
        vars.Helper["StringVariables"].Update(game);
		IntPtr[] StringVariables = vars.Helper["StringVariables"].Current;

        if (StringVariables.Length == 0)
            return false;

        vars.StringVariableCount = StringVariables.Length;
        vars.StringVariableNames = StringVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();

        return true;
    });
}

update
{
    current.ActiveScene = vars.Helper.Scenes.Active.Name ?? current.ActiveScene;

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

    // Weapons & Secrets
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

    //Specifically the Handgun Power Upgrade
    for (int i = 0; i < vars.FloatVariableCount; i++)
    {
        string name = vars.FloatVariableNames[i];
        float value = vars.Helper.Read<float>(current.FloatVariables[i] + vars.FloatOffsetValue);

        string setting = "s-" + name + " " + value; // s = secret
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }
    }

    //Specifically the Magnum Ammo Pickups
    for (int i = 0; i < vars.StringVariableCount; i++)
    {
        string name = vars.StringVariableNames[i];
        string value = vars.Helper.ReadString(current.StringVariables[i] + vars.StringOffsetValue);

        string setting = "m-" + name + "-" + current.ActiveScene + "-" + value; // m = magnum ammo
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }
    }
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
}

reset
{
    return old.ActiveScene != "Title" && current.ActiveScene == "Title";
}

isLoading
{
    return vars.Helper.IsLoading;
}
