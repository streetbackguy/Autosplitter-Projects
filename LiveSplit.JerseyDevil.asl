
state("LiveSplit")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");

    settings.Add("JD", true, "Jersey Devil (PS1) Splits");
        settings.Add("MuseumBoss", true, "Split on Museum Madness Boss", "JD");
        settings.Add("DomeBoss", true, "Split on Dome Sweet Dome Boss", "JD");
        settings.Add("CavesBoss", true, "Split on Bat Caves Boss", "JD");
        settings.Add("CanalBoss", true, "Split on Root Canal Boss", "JD");
        settings.Add("CryptBoss", true, "Split on The Crypt Boss", "JD");
        settings.Add("MansionBoss", true, "Split on Haunted Mansion Boss", "JD");
        settings.Add("ToxicBoss", true, "Split on Toxic Factory Boss", "JD");
        settings.Add("SludgeBoss", true, "Split on Sludge Slides Boss", "JD");
        settings.Add("BoxesBoss", true, "Split on Amazing Boxes Boss", "JD");
        settings.Add("MonkeyBoss", true, "Split on Monkey's Trail Boss", "JD");
        settings.Add("TreesBoss", true, "Split on Through the Trees Boss", "JD");
        settings.Add("KnarfBoss", true, "Split on Knarf Lair Final Boss", "JD");
}

init
{
    vars.Helper.Load = (Func<dynamic, bool>)(emu => 
	{
		emu.Make<short>("GameState", 0x8000867C);
        emu.Make<int>("MapID", 0x80010004);
        emu.Make<byte>("BossHealth", 0x8005AE73);
        emu.Make<byte>("Input", 0x800B962F);
        emu.Make<byte>("StartAssist", 0x800D7921);
        emu.Make<bool>("Loading", 0x8004D754);

		return true;
	});
}

start
{
    // Start when entering World Map with correct Game State value
    return current.MapID == 3 && current.Input != old.Input && current.StartAssist == 2;
}

update
{
    if(current.MapID != old.MapID)
    {
        print(current.MapID.ToString());
    }

    if(current.GameState != old.GameState)
    {
        print(current.GameState.ToString());
    }
}

split
{
    // Level Boss Splits
    if(current.MapID == 10 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["MuseumBoss"];
    }

    if(current.MapID == 5 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["DomeBoss"];
    }

    if(current.MapID == 18 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["CavesBoss"];
    }

    if(current.MapID == 15 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["CanalBoss"];
    }

    if(current.MapID == 25 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["CryptBoss"];
    }

    if(current.MapID == 27 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["MansionBoss"];
    }

    if(current.MapID == 39 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["ToxicBoss"];
    }

    if(current.MapID == 38 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["SludgeBoss"];
    }

    if(current.MapID == 47 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["BoxesBoss"];
    }

    if(current.MapID == 44 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["MonkeyBoss"];
    }

    if(current.MapID == 55 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["TreesBoss"];
    }

    if(current.MapID == 56 && current.BossHealth == 0 && old.BossHealth > 0)
    {
        return settings["KnarfBoss"];
    }
}

isLoading
{
    return !current.Loading;
}

reset
{
    // Reset on Title Screen
    return current.GameState == 2408; 
}
