state("DQIIIHD2DRemake")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/uhara9")).CreateInstance("Main");
    vars.Uhara.EnableDebug();
	
	vars.NowLoading = false;
}

init
{
    vars.Events = vars.Uhara.CreateTool("UnrealEngine", "Events");
	vars.Resolver.Watch<ulong>("StartLoading", vars.Events.FunctionFlag("WB_LoadingIcon_WindowItem00_C", "Loading", "PreConstruct"));
	vars.Resolver.Watch<ulong>("EndLoading", vars.Events.FunctionFlag("WB_LoadingIcon_WindowItem00_C", "Loading*", "Destruct"));
}

onStart
{
	vars.NowLoading = false;
}

update
{
    vars.Uhara.Update();
	
	if (vars.Resolver.CheckFlag("StartLoading")) vars.NowLoading = true;
	if (vars.Resolver.CheckFlag("EndLoading")) vars.NowLoading = false;
}

isLoading
{
	return vars.NowLoading;
}
