state("ReadyOrNotSteam-Win64-Shipping")
{}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/uhara10")).CreateInstance("Main");
	vars.Uhara.AlertLoadless();
	vars.Uhara.EnableDebug();

    vars.CompletedSplits = new HashSet<string>();

    settings.Add("RON", true, "Ready or Not");
        settings.Add("MLSPLITS", true, "Main Level Splits", "RON");
            settings.Add("RoN_Gas_BarricadedSuspects_Core", true, "Thank You, Come Again", "MLSPLITS");
            settings.Add("RoN_Streamer_BarricadedSuspects_Core", true, "23 Megabytes A Second", "MLSPLITS");
            settings.Add("RoN_Meth_BarricadedSuspects_Core", true, "Twisted Nerve", "MLSPLITS");
            settings.Add("RoN_Agency_BarricadedSuspects_Core", true, "The Spider", "MLSPLITS");
            settings.Add("RoN_RidgeLine_BarricadedSuspects_Core", true, "A Lethal Obsession", "MLSPLITS");
            settings.Add("RoN_Penthouse_BarricadedSuspects_Core", true, "Ides Of March", "MLSPLITS");
            settings.Add("RoN_Datacenter_BarricadedSuspects_Core", true, "Sinuous Trail", "MLSPLITS");
            settings.Add("RoN_Beachfront_BarricadedSuspects_Core", true, "Ends Of The Earth", "MLSPLITS");
            settings.Add("RoN_Importer_BarricadedSuspects_Core", true, "Greased Palms", "MLSPLITS");
            settings.Add("RoN_Valley_BarricadedSuspects_Core", true, "Valley Of The Dolls", "MLSPLITS");
            settings.Add("RoN_Campus_BarricadedSuspects_Core", true, "Elephant", "MLSPLITS");
            settings.Add("RoN_Sins_BarricadedSuspects_Core", true, "Sins Of The Father", "MLSPLITS");
            settings.Add("RoN_Club_BarricadedSuspects_Core", true, "Neon Tomb", "MLSPLITS");
            settings.Add("RoN_Dealer_BarricadedSuspects_Core", true, "Buy Cheap, Buy Twice", "MLSPLITS");
            settings.Add("RoN_Farm_BarricadedSuspects_Core", true, "Carriers Of The Vine", "MLSPLITS");
            settings.Add("RoN_Hospital_BarricadedSuspects_Core", true, "Relapse", "MLSPLITS");
            settings.Add("RoN_Port_BarricadedSuspects_Core", true, "Hide And Seek", "MLSPLITS");
        settings.Add("HILSPLITS", true, "Home Invasion Level Splits", "RON");
            settings.Add("RoN_Dorms_BarricadedSuspects_Core", true, "Dorms", "HILSPLITS");
            settings.Add("RoN_Narcos_BarricadedSuspects_Core", true, "Narcos", "HILSPLITS");
            settings.Add("RoN_Lawmaker_BarricadedSuspects_Core", true, "Lawmaker", "HILSPLITS");
        settings.Add("DWLSPLITS", true, "Dark Waters Level Splits", "RON");
            settings.Add("RoN_Boat_BarricadedSuspects_Core", true, "Mirage At Sea", "DWLSPLITS");
            settings.Add("RoN_Rig_BarricadedSuspects_Core", true, "Leviathan", "DWLSPLITS");
            settings.Add("RoN_Island_BarricadedSuspects_Core", true, "3 Letter Triad", "DWLSPLITS");
        settings.Add("LSSLSPLITS", true, "Los Suenos Stories Level Splits", "RON");
            settings.Add("RoN_FastFood_BarricadedSuspects_Core", true, "Hunger Strike", "LSSLSPLITS");
            settings.Add("RoN_Meth_Apartments_BarricadedSuspects_Core", true, "Stolen Valor", "LSSLSPLITS");
        settings.Add("BPLSPLITS", true, "Main Level Splits", "RON");
            settings.Add("RoN_Pier_BarricadedSuspects_Core", true, "No Good Deed", "BPLSPLITS");
            settings.Add("RoN_Bank_BarricadedSuspects_Core", true, "All Gods Burn", "BPLSPLITS");
            settings.Add("RoN_Tower_BarricadedSuspects_Core", true, "A New America", "BPLSPLITS");
}

init
{
    vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");
    vars.Utils = vars.Uhara.CreateTool("UnrealEngine", "Utils");

    // GWorld.FName
	vars.Resolver.Watch<uint>("GWorldName", vars.Utils.GWorld, 0x18);
    vars.Resolver.Watch<bool>("GSync", vars.Utils.GSync);

    vars.Resolver.Watch<ulong>("MissionEndScreen", vars.Events.FunctionFlag("W_MissionScore_C", "W_MissionScore", "BP_OnActivated"));
    vars.Resolver.Watch<ulong>("PreMissionEnd", vars.Events.FunctionFlag("W_PreMission_C", "W_PreMission_C", "BP_OnDeactivated"));

    current.World = "";
}

update
{
    vars.Uhara.Update();

    var world = vars.Utils.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None") current.World = world;
	if(old.World != current.World) vars.Uhara.Log("World: " + old.World + " -> " + current.World);
}

start
{
    return current.World != "TransitionMap" && !current.World.Contains("RoN_Station") && vars.Resolver.CheckFlag("PreMissionEnd");
}

isLoading
{
    return current.World == "TransitionMap" || current.GSync;
}

split
{
    if(current.World != "TransitionMap" && vars.Resolver.CheckFlag("MissionEndScreen") || current.World != "RoN_Station_DLC04_Core" && vars.Resolver.CheckFlag("MissionEndScreen"))
    {
        return settings[current.World] && vars.CompletedSplits.Add(current.World);
    }
}

onStart
{
    vars.CompletedSplits.Clear();
}

reset
{
    return current.World == "MainMenu_V2";
}

exit
{
    timer.IsGameTimePaused = true;
}
