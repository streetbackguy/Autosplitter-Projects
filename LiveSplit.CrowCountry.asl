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
		vars.Helper["arrayBaseFloat"] = pmg.Make<long>("instance", "variables", variables["floatVariables"]);
		vars.Helper["arrayBaseInt"] = pmg.Make<long>("instance", "variables", variables["intVariables"]);
		vars.Helper["arrayBaseBool"] = pmg.Make<long>("instance", "variables", variables["boolVariables"]);
		vars.Helper["arrayBaseString"] = pmg.Make<long>("instance", "variables", variables["stringVariables"]);

		vars.Helper["floatVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", variables["floatVariables"]);
		vars.Helper["intVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", variables["intVariables"]);
		vars.Helper["boolVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", variables["boolVariables"]);
		vars.Helper["stringVariables"] = mono.MakeArray<IntPtr>(pmg, "instance", "variables", variables["stringVariables"]);

        vars.OffsetName = mono["PlayMaker", "NamedVariable"]["name"];
        vars.IntOffsetValue = mono["PlayMaker", "FsmInt"]["value"];
        vars.BoolOffsetValue = mono["PlayMaker", "FsmBool"]["value"];
        vars.FloatOffsetValue = mono["PlayMaker", "FsmFloat"]["value"];
        vars.StringOffsetValue = mono["PlayMaker", "FsmString"]["value"];

		//Int variable Output
		vars.Helper["intVariables"].Update(game);
		IntPtr[] intVariables = vars.Helper["intVariables"].Current;

        if (intVariables.Length == 0)
            return false;

        vars.IntVariableCount = intVariables.Length;
        vars.IntVariableNames = intVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();
		
		for (var i = 0; i < intVariables.Length; i++)
		{
			var name = vars.Helper.ReadString(intVariables[i] + vars.OffsetName);
			var value = vars.Helper.Read<int>(intVariables[i] + vars.IntOffsetValue);
         if (String.IsNullOrWhiteSpace(name)) continue;

			print("[Int " + i.ToString() + "] " + name + ": " + value);
		}

        //Bool variable Output
		vars.Helper["boolVariables"].Update(game);
		IntPtr[] boolVariables = vars.Helper["boolVariables"].Current;

        if (boolVariables.Length == 0)
            return false;

        vars.BoolVariableCount = boolVariables.Length;
        vars.BoolVariableNames = boolVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();
		
		for (var i = 0; i < boolVariables.Length; i++)
		{
			var name = vars.Helper.ReadString(boolVariables[i] + vars.OffsetName);
			var value = vars.Helper.Read<bool>(boolVariables[i] + vars.BoolOffsetValue);
         if (String.IsNullOrWhiteSpace(name)) continue;

			print("[Bool " + i.ToString() + "] " + name + ": " + value);
		}

        //Float variable Output
		vars.Helper["floatVariables"].Update(game);
		IntPtr[] floatVariables = vars.Helper["floatVariables"].Current;

        if (floatVariables.Length == 0)
            return false;

        vars.FloatVariableCount = floatVariables.Length;
        vars.FloatVariableNames = floatVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();
		
		for (var i = 0; i < floatVariables.Length; i++)
		{
			var name = vars.Helper.ReadString(floatVariables[i] + vars.OffsetName);
			var value = vars.Helper.Read<float>(floatVariables[i] + vars.FloatOffsetValue);
            if (String.IsNullOrWhiteSpace(name)) continue;

			print("[Float " + i.ToString() + "] " + name + ": " + value);
		}

        //String variable Output
        vars.Helper["stringVariables"].Update(game);
		IntPtr[] stringVariables = vars.Helper["stringVariables"].Current;

        if (stringVariables.Length == 0)
            return false;

        vars.StringVariableCount = stringVariables.Length;
        vars.StringVariableNames = stringVariables.Select(entry => vars.Helper.ReadString(entry + vars.OffsetName)).ToArray();
        
        for (var i = 0; i < stringVariables.Length; i++)
		{
		    var name = vars.Helper.ReadString(stringVariables[i] + vars.OffsetName);
		    var value = vars.Helper.ReadString(stringVariables[i] + vars.StringOffsetValue);
            if (String.IsNullOrWhiteSpace(name)) continue;
		    if (value == null) value = String.Empty;

		    print("[String " + i.ToString() + "] " + name + ": " + value);
		}

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
        int value = vars.Helper.Read<int>(current.intVariables[i] + vars.IntOffsetValue);

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
        int value = vars.Helper.Read<int>(current.boolVariables[i] + vars.BoolOffsetValue);

        string setting = "w-" + name + "-" + value; // w = weapon
        string setting2 = "s-" + name + " " + value; // s = secret
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }

        if (settings.ContainsKey(setting2) && settings[setting2] && vars.CompletedSplits.Add(setting2))
        {
            vars.Log(setting2);
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
        float value = vars.Helper.Read<float>(current.floatVariables[i] + vars.FloatOffsetValue);

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
        string value = vars.Helper.ReadString(current.stringVariables[i] + vars.StringOffsetValue);

        string setting = "m-" + name + "-" + current.ActiveScene + "-" + value; // m = magnum ammo
        string setting2 = "s-" + name + "-" + value; // s = secret
        if (settings.ContainsKey(setting) && settings[setting] && vars.CompletedSplits.Add(setting))
        {
            vars.Log(setting);
            vars.PendingSplits++;
        }

        if (settings.ContainsKey(setting2) && settings[setting2] && vars.CompletedSplits.Add(setting2))
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