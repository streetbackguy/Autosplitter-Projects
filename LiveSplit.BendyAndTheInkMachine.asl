state("Bendy and the Ink Machine")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Bendy and the Ink Machine";
    vars.Helper.AlertLoadless();
    vars.Helper.LoadSceneManager = true;

    vars.Helper.Settings.CreateFromXml("Components/BATIM.Settings.xml");
}

init
{	
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        //TMG.Data.SaveFileData

        vars.Helper["Chapters"] = mono.Make<int>("GameManager", "m_Instance", "CurrentChapter", "m_Chapter");
        vars.Helper["Chapters2"] = mono.Make<bool>("ObjectiveSaveDataVO", "IsComplete");
        vars.Helper["Objectives"] = mono.MakeString("GameManager", "m_Instance", "m_ObjectiveController", "m_DataVO", "Objective");

        vars.Helper["IGT"] = mono.Make<float>("GameManager", "m_Instance", "GameData", "CurrentSaveFile", "PlayTime");
        vars.Helper["isPaused"] = mono.Make<bool>("GameManager", "m_Instance", "isPaused");

        return true;

    });

    vars.CompletedSplits = new Dictionary<string, bool>();
    vars.ResetSplits = (Action)(() => { foreach(var split in new List<string>(vars.CompletedSplits.Keys)) vars.CompletedSplits[split] = false; });
}

update
{
    if(old.Objectives != current.Objectives)
    {
        vars.Log("Objective: " + current.Objectives);
    }

    if(old.Chapters != current.Chapters)
    {
        vars.Log("Chapter: " + current.Chapters);
    }
}

gameTime
{
    return TimeSpan.FromSeconds(current.IGT);
}

start 
{
	return current.IGT >0.0f && old.IGT == 0.0f;
}

reset
{
    // return current.IGT == 0.0f && old.IGT > 0.0f;
}

split 
{
	if (current.Chapters > old.Chapters)
    {
		return settings["ch" + old.Chapters];
        vars.CompletedSplits["ch" + old.Chapters] = true;
	}

    if (current.Objectives != old.Objectives && old.Objectives != null)
    {
		return settings[old.Objectives];
        vars.CompletedSplits[old.Objectives] = true;
	}
}

onStart
{
    vars.ResetSplits();
}

exit
{
    timer.IsGameTimePaused = true;
}