// CMR2 AUTOSPLITTER/INGAMETIMER
// by Mr. Mary and pitp0
// Updated 17/08/2026 by Streetbackguy

state("CMR2")
{
	int stageTime : 0x136E0C;
	string11 videoCountry : 0x263B60;
	string5 className : 0x263B60;
	byte ripSS : 0x1191A0;
	byte currentRally : 0x4173F8;
	byte currentStage : 0x4173FC;
	bool isRaceOver : 0x131BCC;
	byte isMenu : 0x12F0E0;
	byte countrySpecific : 0x12EA54;
	bool isPause : 0x120870;
	int endTime : 0x13D1B8;
}

startup
{
	settings.Add("CMR2", true, "Colin McRae Rally 2.0 Splits");
        settings.Add("CHMP", true, "Championship", "CMR2");
            settings.Add("championship", true, "Split after every track", "CHMP");
        settings.Add("CHAL", true, "Challenge", "CMR2");
            settings.Add("challenge", true, "Split after every track", "CHAL");
        settings.Add("ARC", true, "Arcade", "CMR2");
            settings.Add("arcade", true, "Split after every track", "ARC");
}

init
{
	vars.category = timer.Run.CategoryName.ToLower();
	vars.raceTime = 0;
	vars.arcadeStop = false;
}

update 
{	
    // var disableTimer = current.currentStage == 10 && (current.isRaceOver || current.ripSS == 0);
		
		
	// if (current.stageTime != 0 && (current.stageTime - old.stageTime > 300))
	// {
	// 	vars.arcadeStop = true;
	// }
	// else if (current.stageTime == 0 && current.stageTime == old.stageTime)
	// {
	// 	vars.arcadeStop = false;
	// }
		
		
	// if (vars.category.Contains("championship"))
	// {
	// if (
	// (current.stageTime > 0 || (current.stageTime == 0 && old.stageTime == 0))
	// && 
	// current.stageTime > old.stageTime && !disableTimer
	// )
	// 	{
	// 		vars.raceTime = vars.raceTime + current.stageTime - old.stageTime;
	// 	}
	// }
	// else if (vars.category.Contains("arcade") || vars.category.Contains("challenge"))
	// {
	// 	if (current.stageTime - old.stageTime < 300)
	// 	{
	// 		if (current.stageTime > 0)
	// 		{
	// 			if (!vars.arcadeStop)
	// 			{
	// 				vars.raceTime = vars.raceTime + current.stageTime - old.stageTime;
	// 			}
	// 		}
	// 	}
	// }
    
	if (current.endTime != old.endTime)
	{
		vars.raceTime = vars.raceTime + current.endTime;
	}
}

isLoading 
{
    return true;
}

gameTime
{
    return TimeSpan.FromMilliseconds(vars.raceTime*10);
}

start
{
	vars.raceTime = 0;
	// Are we looking at "welcome | finland" screen
	if (vars.category.Contains("championship") && current.videoCountry == "finland" || vars.category.Contains("championship") && current.videoCountry == "finlandia" ||
    vars.category.Contains("mirrored") && current.videoCountry == "finland" || vars.category.Contains("mirrored") && current.videoCountry == "finlandia" ||
    vars.category.Contains("no major skips") && current.videoCountry == "finland" || vars.category.Contains("no major skips") && current.videoCountry == "finlandia" ||
    vars.category.Contains("cockpit") && current.videoCountry == "finland" || vars.category.Contains("cockpit") && current.videoCountry == "finlandia")
	{
        return true;
	}
	
    if (vars.category.Contains("arcade") && old.className == "Class" && old.className != current.className || old.className == "Klasa" && old.className != current.className)
	{
        return true;
	}
	
    if (vars.category.Contains("challenge") && current.videoCountry == "japan" || vars.category.Contains("challenge") && current.videoCountry == "japonia")
	{
        return true;
	}
}
split
{
		// CHAMPIONSHIP
		// Two variants of mid-game split - per-stage or per-rally
	if (vars.category.Contains("championship") || vars.category.Contains("mirrored") || vars.category.Contains("no major skips") || vars.category.Contains("cockpit"))
	{
        if(current.isRaceOver && !old.isRaceOver)
        {
            return settings["championship"];
        }
    }
	
    if (vars.category.Contains("arcade") && current.isRaceOver && !old.isRaceOver)
	{
		return (settings["arcade"]);
	}

    if (vars.category.Contains("challenge") && current.isRaceOver && !old.isRaceOver)
	{
		return (settings["challenge"]);
	}
}

reset
{
	if (vars.category.Contains("arcade") || vars.category.Contains("championship") || vars.category.Contains("mirrored") || vars.category.Contains("no major skips") || vars.category.Contains("cockpit"))
	{
		return current.videoCountry == "Use the cur" && current.videoCountry != old.videoCountry || current.videoCountry == "Dokonaj wyb" && current.videoCountry != old.videoCountry;
	}
	else return false;
}
