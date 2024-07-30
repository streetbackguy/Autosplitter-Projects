state("Krampus is Home")
{
}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Krampus is Home";
    vars.Helper.AlertLoadless();

    settings.Add("KIH", true, "Krampus is Home");
        settings.Add("ANY", true, "Any%", "KIH");
            settings.Add("OBJ0", true, "Check The Terrace", "ANY");
            settings.Add("OBJ1", true, "Answer The Incoming Call", "ANY");
            settings.Add("OBJ2", true, "Turn Off The Pressure Cooker", "ANY");
            settings.Add("OBJ3", true, "Turn On The Christmas Tree Lights", "ANY");
            settings.Add("OBJ4", true, "Check The Strange Object On the Floor", "ANY");
            settings.Add("OBJ5", true, "Call Parents", "ANY");
            settings.Add("OBJ6", true, "Find A Flashlight", "ANY");
            settings.Add("OBJ7", true, "Check The Fuse Box", "ANY");
            settings.Add("OBJ8", true, "Read The Note On The Ground", "ANY");
            settings.Add("OBJ9", true, "Find The Water Gun", "ANY");
            settings.Add("OBJ10", true, "Head To The Gazebo", "ANY");
            settings.Add("OBJ11", true, "Read The Note On The Table", "ANY");
            settings.Add("OBJ12", true, "Call Parents Again", "ANY");
            settings.Add("OBJ13", true, "Survive Until 2:00AM", "ANY");
            settings.Add("OBJ14", true, "Escape The Cell", "ANY");
            settings.Add("OBJ15", true, "Get To Area 200", "ANY");
            settings.Add("OBJ16", true, "Find An Exit", "ANY");
            settings.Add("OBJ17", true, "Inspect The Elevator", "ANY");
            settings.Add("OBJ18", true, "Activate The Elevator", "ANY");
            settings.Add("OBJ19", true, "Find Area 200", "ANY");
            settings.Add("OBJ20", true, "Approach The Guy", "ANY");
            settings.Add("OBJ21", true, "Deactivate The Machine And Escape Through Area 200", "ANY");
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        mono.Images.Clear();

        var smd = mono["StoryMode_Director"];
        vars.Helper["StoryPart"] = smd.Make<int>("StoryMode_Director_S", "Current_StoryPart");
        vars.Helper["StoryPartFirstLoaded"] = smd.Make<bool>("StoryMode_Director_S", "StoryPart_FirstLoaded");
        vars.Helper["CurrentObjective"] = smd.Make<int>("StoryMode_Director_S", "Current_Objective");
        
        var gs = mono["GeneralSetup"];
        vars.Helper["InsideGameplay"] = gs.Make<bool>("GeneralSetup_S", "InsideGameplay");

        var sld = mono["SaveLoad_Director"];
        vars.Helper["DataLoaded"] = sld.Make<bool>("SaveLoad_Director_S", "GeneralDataLoaded");

        var mmd = mono["MainMenu_Director"];
        vars.Helper["MainMenu"] = mmd.Make<bool>("MainMenu_Director_S", "MainMenu_Active");
    

        return true;
    });
}

update
{
    //Debug Updates

    //if(current.StoryPart != old.StoryPart)
    //{
        //vars.Log("Story Part: " + old.StoryPart + " -> " + current.StoryPart);
    //}

    //if(current.StoryPartFirstLoaded != old.StoryPartFirstLoaded)
    //{
        //vars.Log("First Loaded?: " + old.StoryPartFirstLoaded + " -> " + current.StoryPartFirstLoaded);
    //}

    //if(current.Cutscenes != old.Cutscenes)
    //{
        //vars.Log("Cutscene: " + old.Cutscenes + " -> " + current.Cutscenes);
    //}

    //if(current.DataLoaded != old.DataLoaded)
    //{
        //vars.Log("Data Loaded: " + old.DataLoaded + " -> " + current.DataLoaded);
    //}

    //if(current.CurrentObjective != old.CurrentObjective)
    //{
        //vars.Log("Objective: " + old.CurrentObjective + " -> " + current.CurrentObjective);
    //}
}

isLoading
{
    return !current.DataLoaded;
}

split
{
    if(current.CurrentObjective != old.CurrentObjective)
    {
        return vars.Splits.Add("OBJ" + old.CurrentObjective) && settings["OBJ" + old.CurrentObjective];
    }

    if(current.StoryPart == 49 && !current.InsideGameplay)
    {
        return vars.Splits.Add("OBJ21") && settings["OBJ21"];
    }
}

start
{
    return current.StoryPart == 1 && current.InsideGameplay;
}

onStart
{
    vars.Splits.Clear();
    timer.IsGameTimePaused = true;
}

reset
{
    return current.MainMenu && !old.MainMenu;
}

exit
{
    timer.IsGameTimePaused = true;
}
