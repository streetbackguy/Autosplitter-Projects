state("OutOfSight-Win64-Shipping") { }

startup
{
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Basic");
	vars.Helper.GameName = "Out of Sight (Demo)";
	vars.Helper.AlertLoadless();

	// dynamic[,] _settings =
	// {
	// 	{ "Splits", true, "Splits", null },
	// 		{ "3", true, "Act Two - Part One / Whirl Pool", "Splits" },
	// 		{ "4", true, "Prologue - Calibration", "Splits"},
	// 		{ "PrologueDone", true, "Prologue - Body Removal", "Splits"},
	// 		{ "13", true, "Chapter 1 - Black Water", "Splits"},
	// 		{ "ChaseAndEscape", true, "Chapter 1 - Chase & Escape", "Splits"},
	// 		{ "15", true, "Chapter 1 - TV Tower", "Splits"},
	// 		{ "16", true, "Chapter 1 - Stamping Letters", "Splits"},
	// 		{ "12", true, "Chapter 1 - The Chase", "Splits"},
	// 		{ "Ending", true, "Chapter 1 - Demo End", "Splits"},
	// };

	// vars.Helper.Settings.Create(_settings);
	vars.CompletedSplits = new HashSet<string>();
}

onStart
{
	vars.CompletedSplits.Clear();
	// This makes sure the timer always starts at 0.00
	timer.IsGameTimePaused = true;
}

init
{
	IntPtr gWorld = vars.Helper.ScanRel(10, "80 7C 24 ?? 00 ?? ?? 48 8B 3D ???????? 48");
	IntPtr fNames = vars.Helper.ScanRel(7, "8B D9 74 ?? 48 8D 15 ?? ?? ?? ?? EB");

	if (gWorld == IntPtr.Zero || fNames == IntPtr.Zero)
	{
		const string Msg = "Not all required addresses could be found by scanning.";
		throw new Exception(Msg);
	}
	// GWorld.FNameIndex
	vars.Helper["GWorldName"] = vars.Helper.Make<ulong>(gWorld, 0x18);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.PlayerState.StartTime
    vars.Helper["StartTime"] = vars.Helper.Make<int>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x298, 0x29C);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.Chase1HasTriggered
    vars.Helper["Chase1HasTriggered"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x858, 0xBB0);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.Character.CharacterMovement.MovementMode (nothing?)
    vars.Helper["MovementMode"] = vars.Helper.Make<int>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x2E0, 0x320, 0x1A4);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.IsChaseSequenceActive
    vars.Helper["IsChaseSequenceActive"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x858, 0xCE8);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.MovementInput.bConsumeInput
    vars.Helper["MI_bConsumeInput"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x768, 0x48);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.MovementInput.bTriggerWhenPaused
    vars.Helper["MI_bTriggeredWhenPaused"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x768, 0x49);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.LookInputController.bConsumeInput
    vars.Helper["LIC_bConsumeInput"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x78, 0x48);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.LookInputController.bTriggerWhenPaused
    vars.Helper["LIC_bTriggeredWhenPaused"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x778, 0x49);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.bInteractionsAllowed
    vars.Helper["bInteractionsAllowed"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x858, 0x81C);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.Movable Object Interaction.CurrentMoveState
    vars.Helper["CurrentMoveState"] = vars.Helper.Make<byte>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x858, 0x958, 0x1C8);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.IsHoldingRMB
    vars.Helper["IsHoldingRMB"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x858, 0xAB0);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.IsMoving
    // only when moving
    vars.Helper["IsMoving"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x858, 0xCC0);
    // GWorld.OwningGameInstance.LocalPlayers[0].PlayerController.BP_OurPlayer.IsPassedOut
    vars.Helper["IsPassedOut"] = vars.Helper.Make<bool>(gWorld, 0x1B8, 0x38, 0x0, 0x30, 0x858, 0xCC2);

	vars.FNameToString = (Func<ulong, string>)(fName =>
	{
		var nameIdx = (fName & 0x000000000000FFFF) >> 0x00;
		var chunkIdx = (fName & 0x00000000FFFF0000) >> 0x10;
		var number = (fName & 0xFFFFFFFF00000000) >> 0x20;

		// IntPtr chunk = vars.Helper.Read<IntPtr>(fNames + 0x10 + (int)chunkIdx * 0x8);
		IntPtr chunk = vars.Helper.Read<IntPtr>(fNames + 0x10 + (int)chunkIdx * 0x8);
		IntPtr entry = chunk + (int)nameIdx * sizeof(short);

		int length = vars.Helper.Read<short>(entry) >> 6;
		string name = vars.Helper.ReadString(length, ReadStringType.UTF8, entry + sizeof(short));

		return number == 0 ? name : name + "_" + number;
	});

	current.World = "";
	// current.inMainMenu = false;
	// current.stopParam = false;
    // current.PlayStartID = "";

}

start
{
    return old.World == "LVL_MainMenu" && current.World == "LVL_FullGame";
}

onStart
{
    timer.IsGameTimePaused = true;
	// vars.IntroNoControl = 0;
    vars.CompletedSplits.Clear();
}


update
{
	vars.Helper.Update();
	vars.Helper.MapPointers();

	var world = vars.FNameToString(current.GWorldName);
	if (!string.IsNullOrEmpty(world) && world != "None")
		current.World = world;
		if (old.World != current.World) vars.Log("World: " + old.World + " -> " + current.World);
	if (old.StartTime != current.StartTime) vars.Log("StartTime:" + current.StartTime);
    if (old.Chase1HasTriggered != current.Chase1HasTriggered) vars.Log("Chase1HasTriggered:" + current.Chase1HasTriggered);
    if (old.IsChaseSequenceActive != current.IsChaseSequenceActive) vars.Log("IsChaseSequenceActive:" + current.IsChaseSequenceActive);
    if (old.MI_bConsumeInput != current.MI_bConsumeInput) vars.Log("MI_bConsumeInput:" + current.MI_bConsumeInput);
    if (old.MI_bTriggeredWhenPaused != current.MI_bTriggeredWhenPaused) vars.Log("MI_bTriggeredWhenPaused:" + current.MI_bTriggeredWhenPaused);
    if (old.LIC_bConsumeInput != current.LIC_bConsumeInput) vars.Log("LIC_bConsumeInput:" + current.LIC_bConsumeInput);
    if (old.LIC_bTriggeredWhenPaused != current.LIC_bTriggeredWhenPaused) vars.Log("LIC_bTriggeredWhenPaused:" + current.LIC_bTriggeredWhenPaused);
    if (old.bInteractionsAllowed != current.bInteractionsAllowed) vars.Log("bInteractionsAllowed:" + current.bInteractionsAllowed);
    if (old.IsMoving != current.IsMoving) vars.Log("IsMoving:" + current.IsMoving);
    if (old.IsPassedOut != current.IsPassedOut) vars.Log("IsPassedOut:" + current.IsPassedOut);
    if (old.MovementMode != current.MovementMode) vars.Log("MovementMode:" + current.MovementMode);
    if (old.CurrentMoveState != current.CurrentMoveState) vars.Log("CurrentMoveState: " + current.CurrentMoveState);
    if (old.IsHoldingRMB != current.IsHoldingRMB) vars.Log("IsHoldingRMB: " + current.IsHoldingRMB);
}

split
{
}

isLoading
{
	// return current.PauseLocked;
}