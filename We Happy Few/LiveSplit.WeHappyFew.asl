//Load Remover by Voetiem
//Autostart by Streetbackguy
state("GlimpseGame")
{
    byte loading: 0x37DB2EB;
}

startup
{
	Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();
	vars.Uhara.EnableDebug();
}

init
{
	vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");

	vars.Resolver.Watch<uint>("GWorldName", vars.Utils.GWorld, 0x18);
    vars.Resolver.Watch<byte>("Input", vars.Utils.GEngine, 0xC80, 0x38, 0x0, 0x30, 0xA00);
    vars.Resolver.Watch<uint>("Character", vars.Utils.GEngine, 0xC80, 0x38, 0x0, 0x30, 0x4A0, 0x18);

	current.World = "";
}

update
{
	vars.Uhara.Update();

	var world = vars.Utils.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;

    if (old.Input != current.Input)
		vars.Uhara.Log("Input: " + current.Input.ToString());
}

start
{
    return current.Input == 0 && old.Input != 0 && current.Character != 0;
}

isLoading
{
    return current.loading != 191;
}
