//Coded and values found mainly by Kuno Demetries, with moral support and puppetry by Streetbackguy
state("deadrising4")
{
    int Loading : 0x32B0D3C;
    long CurObj : 0x028620F0, 0x20, 0x3A8, 0x4E0, 0x78, 0x858, 0x2F0, 0x708;
}

init
{
    vars.doneMaps = new List<string>();
    vars.CurObj = "";
}

startup
{
    settings.Add("DR4", true, "Dead Rising 4");
        settings.Add("C0", true, "Case 0: Minigolf Night");
        settings.Add("C1", true, "Case 1: Door Crasher Special");
        settings.Add("C2", true, "Case 2: Invasion on Main Street");
        settings.Add("C3", true, "Case 3: Shit's Getting Science");
        settings.Add("C4", true, "Case 4: Drop the Base");
        settings.Add("C5", true, "Case 5: Man of the Year");
        settings.Add("C6", true, "Case 6: Eye on the Prize");
        settings.Add("FR", true, "Frank Rising");

    var tB = (Func<string, string, string, Tuple<string, string, string>>) ((elmt1, elmt2, elmt3) => { return Tuple.Create(elmt1, elmt2, elmt3); });
        var sB = new List<Tuple<string, string, string>> 
    {
        tB("C0", "Investigate the base", "Investigate the base"),
        tB("C0", "Find the keycard", "Find the keycard"),
        tB("C0", "Sneak into the base", "Sneak into the base"),
        tB("C0", "Explore the base", "Explore the base"),
        tB("C0", "Kill the zombie", "Kill the zombie"),
        tB("C0", "Keep exploring", "Keep exploring"),
        tB("C0", "Pick up a weapon", "Pick up a weapon"),
        tB("C0", "Kill the released zombies", "Kill the released zombies"),
        tB("C0", "Pick up a second weapon", "Pick up a second weapon"),
        tB("C0", "Kill the zombies", "Kill the zombies"),
        tB("C0", "Solve the investigation", "Solve the investigation"),
        tB("C0", "Look for evidence", "Look for evidence"),
        tB("C0", "Tag the controls", "Tag the controls"),
        tB("C0", "Incinerate the zombie", "Incinerate the zombie"),
        tB("C0", "Investigate the morgue", "Investigate the morgue"),
        tB("C0", "Follow Vick", "Follow Vick"),
        tB("C0", "Find a way out", "Find a way out"),
        tB("C0", "Pick up the Blueprint", "Pick up the Blueprint"),
        tB("C0", "Pick up the ingredients", "Pick up the ingredients"),
        tB("C1", "Defend Brad", "Defend Brad"),
        tB("C1", "Clear out the zombies", "Clear out the zombies"),
        tB("C1", "Talk to Brad", "Talk to Brad"),
        tB("C1", "Meet Brad at the hotel", "Meet Brad at the hotel"),
        tB("C1", "Talk to Connor", "Talk to Connor"),
        tB("C1", "Defeat the soldiers", "Defeat the soldiers"),
        tB("C1", "Follow Brad", "Follow Brad"),
        tB("C1", "Find the mall security center", "Find the mall security center"),
        tB("C1", "Kill the fresh infected", "Kill the fresh infected"),
        tB("C1", "Locate Vick’s hideout", "Locate Vick’s hideout"),
        tB("C1", "Talk to the survivors", "Talk to the survivors"),
        tB("C1", "Purchase a map", "Purchase a map"),
        tB("C1", "Get to Medieval Village", "Get to Medieval Village"),
        tB("C1", "Antagonize hostile survivors", "Antagonize hostile survivors"),
        tB("C1", "Exit Medieval Village", "Exit Medieval Village"),
        tB("C1", "Clear the area", "Clear the area"),
        tB("C1", "Enter the quarantine area", "Enter the quarantine area"),
        tB("C1", "Investigate the area", "Investigate the area"),
        tB("C1", "Talk to Darcy", "Talk to Darcy"),
        tB("C2", "Meet up with Paula", "Meet up with Paula"),
        tB("C2", "Pick up the blueprint", "Pick up the blueprint"),
        tB("C2", "Combo the vehicles", "Combo the vehicles"),
        tB("C2", "Investigate the archives", "Investigate the archives"),
        tB("C2", "Talk to Paula", "Talk to Paula"),
        tB("C2", "Find the drug store", "Find the drug store"),
        tB("C2", "Get into the apartment", "Get into the apartment"),
        tB("C2", "Investigate the apartment", "Investigate the apartment"),
        tB("C2", "Listen to the radio", "Listen to the radio"),
        tB("C2", "Go to the fire hall", "Go to the fire hall"),
        tB("C2", "Discover what happened", "Discover what happened"),
        tB("C2", "Clear the fire hall", "Clear the fire hall"),
        tB("C2", "Investigate the fire hall", "Investigate the fire hall"),
        tB("C2", "Enter the junkyard", "Enter the junkyard"),
        tB("C2", "Infiltrate the junkyard", "Infiltrate the junkyard"),
        tB("C2", "Go to West Ridge", "Go to West Ridge"),
        tB("C2", "Talk to Isaac", "Talk to Isaac"),
        tB("C2", "Find Hammond", "Find Hammond"),
        tB("C2", "Follow Hammond", "Follow Hammond"),
        tB("C2", "Defeat Obscuris", "Defeat Obscuris"),
        tB("C2", "Enter the dam", "Enter the dam"),
        tB("C2", "Clear out Obscuris soldiers", "Clear out Obscuris soldiers"),
        tB("C2", "Turn on the lights", "Turn on the lights"),
        tB("C2", "Investigate the dam", "Investigate the dam"),
        tB("C2", "Find the trap", "Find the trap"),
        tB("C2", "Defeat the lieutenant", "Defeat the lieutenant"),
        tB("C3", "Pursue the convoy", "Pursue the convoy"),
        tB("C3", "Talk to the convoy survivor", "Talk to the convoy survivor"),
        tB("C3", "Go to the emergency shelter", "Go to the emergency shelter"),
        tB("C3", "Search for morphine", "Search for morphine"),
        tB("C3", "Trade morphine for intel", "Trade morphine for intel"),
        tB("C3", "Investigate the wreckage", "Investigate the wreckage"),
        tB("C3", "Exit through the gate", "Exit through the gate"),
        tB("C3", "Follow the wreckage", "Follow the wreckage"),
        tB("C3", "Follow the monster", "Follow the monster"),
        tB("C3", "Defeat the strange zombie", "Defeat the strange zombie"),
        tB("C3", "Kill the remaining zombies", "Kill the remaining zombies"),
        tB("C3", "Listen to the call", "Listen to the call"),
        tB("C3", "Meet with Dr. Blackburne", "Meet with Dr. Blackburne"),
        tB("C3", "Defeat the Obscuris soldiers", "Defeat the Obscuris soldiers"),
        tB("C3", "Enter the house", "Enter the house"),
        tB("C3", "Interview Dr. Blackburne", "Interview Dr. Blackburne"),
        tB("C3", "Photograph the picture", "Photograph the picture"),
        tB("C3", "Grab the Exo Suit", "Grab the Exo Suit"),
        tB("C3", "Upgrade Exo Suit", "Upgrade Exo Suit"),
        tB("C3", "Open the garage door", "Open the garage door"),
        tB("C3", "Escape the gated community", "Escape the gated community"),
        tB("C3", "Go to the winery", "Go to the winery"),
        tB("C3", "Find Barnaby’s lab", "Find Barnaby’s lab"),
        tB("C3", "Investigate the lab", "Investigate the lab"),
        tB("C3", "Inspect the door", "Inspect the door"),
        tB("C3", "Examine the machine", "Examine the machine"),
        tB("C3", "Survive", "Survive"),
        tB("C3", "Escape the room", "Escape the room"),
        tB("C4", "Leave the winery", "Leave the winery"),
        tB("C4", "Find Hammond in West Ridge", "Find Hammond in West Ridge"),
        tB("C4", "Search the house", "Search the house"),
        tB("C4", "Go to the pool hall", "Go to the pool hall"),
        tB("C4", "Go to the army base", "Go to the army base"),
        tB("C4", "Grab the explosives", "Grab the explosives"),
        tB("C4", "Find the weak spot", "Find the weak spot"),
        tB("C4", "Plant explosives", "Plant explosives"),
        tB("C4", "Defend Hammond", "Defend Hammond"),
        tB("C4", "Equip the Exo Suit", "Equip the Exo Suit"),
        tB("C4", "Sabotage the Comm Tower", "Sabotage the Comm Tower"),
        tB("C4", "Defeat Obscuris soldiers", "Defeat Obscuris soldiers"),
        tB("C4", "Open the gate", "Open the gate"),
        tB("C4", "Sabotage the turret control", "Sabotage the turret control"),
        tB("C4", "Open gate", "Open gate"),
        tB("C4", "Sabotage the generator", "Sabotage the generator"),
        tB("C4", "Enter the building", "Enter the building"),
        tB("C4", "Search the building", "Search the building"),
        tB("C4", "Investigate the gym", "Investigate the gym"),
        tB("C4", "Find the intelligence lockup", "Find the intelligence lockup"),
        tB("C4", "Discover Barnaby’s secrets", "Discover Barnaby’s secrets"),
        tB("C4", "Find the recon footage", "Find the recon footage"),
        tB("C4", "Watch the recon footage", "Watch the recon footage"),
        tB("C4", "Escape the base", "Escape the base"),
        tB("C4", "Defeat the Commander", "Defeat the Commander"),
        tB("C5", "Go to the West Ridge shelter", "Go to the West Ridge shelter"),
        tB("C5", "Scout out the shelter", "Scout out the shelter"),
        tB("C5", "Investigate the lockdown", "Investigate the lockdown"),
        tB("C5", "Find the panel", "Find the panel"),
        tB("C5", "Override the lockdown", "Override the lockdown"),
        tB("C5", "Enter the emergency shelter", "Enter the emergency shelter"),
        tB("C5", "Clear out all the enemies", "Clear out all the enemies"),
        tB("C5", "Go to Tom’s farm", "Go to Tom’s farm"),
        tB("C5", "Search for Hammond", "Search for Hammond"),
        tB("C5", "Open the secret door", "Open the secret door"),
        tB("C5", "Investigate the secret room", "Investigate the secret room"),
        tB("C5", "Go to the cement factory", "Go to the cement factory"),
        tB("C5", "Find a way to the top", "Find a way to the top"),
        tB("C5", "Find Tom & Hammond", "Find Tom & Hammond"),
        tB("C5", "Defeat Tom", "Defeat Tom"),
        tB("C5", "Go to the elevator", "Go to the elevator"),
        tB("C5", "Talk to Jordan", "Talk to Jordan"),
        tB("C5", "Get the explosives", "Get the explosives"),
        tB("C5", "Head into the sewers", "Head into the sewers"),
        tB("C5", "Plant the explosive", "Plant the explosive"),
        tB("C5", "Track Calder", "Track Calder"),
        tB("C5", "Retrieve the hard drive", "Retrieve the hard drive"),
        tB("C5", "Escape the area", "Escape the area"),
        tB("C5", "Escape from Calder", "Escape from Calder"),
        tB("C6", "Get the camera back", "Get the camera back"),
        tB("C6", "Cut Vick off at Kiichiro Plaza", "Cut Vick off at Kiichiro Plaza"),
        tB("C6", "Defeat Calder", "Defeat Calder"),
        tB("C6", "Fight Calder", "Fight Calder"),
        tB("C6", "Fight off Calder’s zombies", "Fight off Calder’s zombies"),
        tB("C6", "Survive with Vick and Brad", "Survive with Vick and Brad"),
        tB("FR", "Kill the humans", "Kill the humans"),
        tB("FR", "Satisfy your hunger", "Satisfy your hunger"),
        tB("FR", "Hunt for prey", "Hunt for prey"),
        tB("FR", "Listen to the conversation", "Listen to the conversation"),
        tB("FR", "Find the key", "Find the key"),
        tB("FR", "Open the door", "Open the door"),
        tB("FR", "Follow Blackburne", "Follow Blackburne"),
        tB("FR", "Enter the mall", "Enter the mall"),
        tB("FR", "Follow Blackburne’s directions", "Follow Blackburne’s directions"),
        tB("FR", "Approach Calder’s corpse", "Approach Calder’s corpse"),
        tB("FR", "Collect the swarm", "Collect the swarm"),
        tB("FR", "Follow the green glow", "Follow the green glow"),
        tB("FR", "Investigate the lone wasp", "Investigate the lone wasp"),
        tB("FR", "Leave the shelter", "Leave the shelter"),
        tB("FR", "Search Dodd’s Drugs", "Search Dodd’s Drugs"),
        tB("FR", "Find painkillers", "Find painkillers"),
        tB("FR", "Search Cochrane’s Pub", "Search Cochrane’s Pub"),
        tB("FR", "Find the control key", "Find the control key"),
        tB("FR", "Search Big Buck’s", "Search Big Buck’s"),
        tB("FR", "Find the solenoids", "Find the solenoids"),
        tB("FR", "Wait for Blackburne’s instructions", "Wait for Blackburne’s instructions"),
        tB("FR", "Search Rockpile Liquor", "Search Rockpile Liquor"),
        tB("FR", "Find overproof liquor", "Find overproof liquor"),
        tB("FR", "Search the bus depot", "Search the bus depot"),
        tB("FR", "Travel to West Ridge", "Travel to West Ridge"),
        tB("FR", "Go to the school", "Go to the school"),
        tB("FR", "Defeat the evo zombies", "Defeat the evo zombies"),
        tB("FR", "Collect the wasp queen", "Collect the wasp queen"),
        tB("FR", "Clear out the winery", "Clear out the winery"),
        tB("FR", "Listen to Hammond", "Listen to Hammond"),
        tB("FR", "Find Blackburne", "Find Blackburne"),
        tB("FR", "Talk to Blackburne", "Talk to Blackburne"),
        tB("FR", "Head through the airlock", "Head through the airlock"),
        tB("FR", "Place the queen in containment", "Place the queen in containment"),
        tB("FR", "Synthesize the aerosol", "Synthesize the aerosol"),
        tB("FR", "Administer the aerosol", "Administer the aerosol"),
        tB("FR", "Install the solenoids", "Install the solenoids"),
        tB("FR", "Reroute the power", "Reroute the power"),
        tB("FR", "Vent the gas", "Vent the gas"),
        tB("FR", "Activate the treatment chamber", "Activate the treatment chamber"),
    };
    foreach (var s in sB) settings.Add(s.Item2, false, s.Item3, s.Item1);

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Dead Rising 4",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }

}

start
{
    return (current.Loading == 67);
}

update
{
    vars.CurObj = memory.ReadString(new IntPtr(current.CurObj), 256);
    print(vars.CurObj);
}

isLoading
{
    return (current.Loading != 67);
}

split
{
    if (settings[vars.CurObj] && (!vars.doneMaps.Contains(vars.CurObj)))
    {
        vars.doneMaps.Add(vars.CurObj);
        return true;
    }
}

reset
{
    return (vars.CurObj == null);
}
