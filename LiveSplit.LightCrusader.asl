//Made for Retroarch Emulator with Genesis GX Core
state("LiveSplit")
{
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("Genesis");

    settings.Add("LC", true, "Light Crusader");
        settings.Add("EyeBoss", true, "Eye Boss Defeated", "LC");
        settings.Add("Dragon", true, "Dragon Boss Defeated", "LC");
        settings.Add("Snapdragon", true, "Snapdragon Boss Defeated", "LC");
        settings.Add("Sextant", true, "Sextant Collected", "LC");
        settings.Add("BlueOrb", true, "Blue Orb Collected", "LC");
        settings.Add("YellowOrb", true, "Yellow Orb Collected", "LC");
        settings.Add("GreenOrb", true, "Green Orb Collected", "LC");
        settings.Add("RedOrb", true, "Red Orb Collected", "LC");
        settings.Add("Genie", true, "Genie Boss Defeated", "LC");
        settings.Add("Costume", true, "Costume Collected", "LC");
        settings.Add("Crest", true, "Crest Collected", "LC");
        settings.Add("Scorpion", true, "Scorpion Boss Defeated", "LC");
        settings.Add("LightCrusader", true, "Light Crusader Collected", "LC");
        settings.Add("TripleJump", true, "Floor 6 Triple Jump Succeeded", "LC");
        settings.Add("Fairy", true, "Fairy Boss Defeated", "LC");
        settings.Add("Necromancer", true, "Necromancer Boss Defeated", "LC");
        settings.Add("Ramiah", true, "Ramiah Boss Defeated", "LC");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
	{
		emu.Make<byte>("Boss", 0xF955);
        emu.Make<byte>("EnemyHealth", 0xAA03);
		emu.Make<byte>("RoomID", 0xEFDB);
        emu.Make<byte>("LocationID", 0xEFDA);

		return true;
	});

}

start
{
    return current.Boss == 52 && old.Boss > 52;
}

onStart
{
    vars.Splits.Clear();
}

split
{
    if(old.LocationID == 219 && old.RoomID == 248 && current.RoomID != 248 && !vars.Splits.Contains("EyeBoss"))
    {
        return settings["EyeBoss"] && vars.Splits.Add("EyeBoss");
    }

    if(old.LocationID == 220 && old.RoomID == 32 && current.RoomID != 32 && !vars.Splits.Contains("Dragon"))
    {
        return settings["Dragon"] && vars.Splits.Add("Dragon");
    }

    if(old.LocationID == 231 && old.RoomID == 252 && current.RoomID != 252 && !vars.Splits.Contains("Snapdragon"))
    {
        return settings["Snapdragon"] && vars.Splits.Add("Snapdragon");
    }

    if(old.LocationID == 230 && old.RoomID == 8 && current.RoomID != 8 && !vars.Splits.Contains("Sextant"))
    {
        return settings["Sextant"] && vars.Splits.Add("Sextant");
    }

    if(old.LocationID == 231 && old.RoomID == 196 && current.RoomID != 196 && !vars.Splits.Contains("BlueOrb"))
    {
        return settings["BlueOrb"] && vars.Splits.Add("BlueOrb");
    }

    if(old.LocationID == 231 && old.RoomID == 76 && current.RoomID != 76 && !vars.Splits.Contains("YellowOrb"))
    {
        return settings["YellowOrb"] && vars.Splits.Add("YellowOrb");
    }

    if(old.LocationID == 231 && old.RoomID == 148 && current.RoomID != 148 && !vars.Splits.Contains("GreenOrb"))
    {
        return settings["GreenOrb"] && vars.Splits.Add("GreenOrb");
    }

    if(old.LocationID == 231 && old.RoomID == 28 && current.RoomID != 28 && !vars.Splits.Contains("RedOrb"))
    {
        return settings["RedOrb"] && vars.Splits.Add("RedOrb");
    }

    if(old.LocationID == 246 && old.RoomID == 200 && current.RoomID != 200 && !vars.Splits.Contains("Genie"))
    {
        return settings["Genie"] && vars.Splits.Add("Genie");
    }

    if(old.LocationID == 242 && old.RoomID == 2 && current.RoomID != 2 && !vars.Splits.Contains("Costume"))
    {
        return settings["Costume"] && vars.Splits.Add("Costume");
    }

    if(old.LocationID == 2 && old.RoomID == 214 && current.RoomID != 214 && !vars.Splits.Contains("Crest"))
    {
        return settings["Crest"] && vars.Splits.Add("Crest");
    }

    if(old.LocationID == 2 && old.RoomID == 18 && current.RoomID != 18 && !vars.Splits.Contains("Scorpion"))
    {
        return settings["Scorpion"] && vars.Splits.Add("Scorpion");
    }

    if(old.LocationID == 1 && old.RoomID == 210 && current.RoomID != 210 && !vars.Splits.Contains("LightCrusader"))
    {
        return settings["LightCrusader"] && vars.Splits.Add("LightCrusader");
    }

    if(old.LocationID == 6 && old.RoomID == 154 && current.RoomID != 154 && !vars.Splits.Contains("Necromancer"))
    {
        return settings["Necromancer"] && vars.Splits.Add("Necromancer");
    }

    if(old.LocationID == 27 && old.RoomID == 112 && current.RoomID != 112 && !vars.Splits.Contains("TripleJump"))
    {
        return settings["TripleJump"] && vars.Splits.Add("TripleJump");
    }

    if(old.LocationID == 28 && old.RoomID == 176 && current.RoomID != 176 && !vars.Splits.Contains("Fairy"))
    {
        return settings["Fairy"] && vars.Splits.Add("Fairy");
    }

    if(current.LocationID == 28 && current.RoomID == 224 && current.EnemyHealth == 0 && old.EnemyHealth > 0 && old.Boss == 0 && !vars.Splits.Contains("Ramiah"))
    {
        return settings["Ramiah"] && vars.Splits.Add("Ramiah");
    }
}
