//Load Removal Address found by, and coding by Plyd
//Objective Activation, Completion and Autostart Addresses found by Streetbackguy
state("MadMax")
{
    float FirstInput: 0x17F5228, 0x20, 0x198;
    int GameStarted: 0x17F5FE0, 0x178, 0x170, 0x310, 0x720;
    int  LoadValue          : 0x193D4D0, 0x58, 0x70, 0x8, 0x1D0, 0x60, 0x28, 0x8;
    bool ObjectiveCompleted : 0x1944730, 0x30, 0x1A0, 0x98, 0x330, 0x0, 0xA8, 0x70, 0x1E8;
    int ObjectiveActivated : 0x17FCF78, 0x470;
}

startup
{
    settings.Add("IL Timing", false);
    settings.SetToolTip("IL Timing", "Will start and end timer on completing objective");

    var _settings = new Dictionary<string, string[]>
    {
        {
            "Feral Man",
            new[]
            {
                "Find water",
                "Drink from the canteen",
                "Find the dog",
                "Speak with Chumbucket",
                "Find wire for Chum's buggy",
                "Find wire for Chum's buggy (second time)",
                "Return the wire to Chum",
                "Follow Chum to his buggy",
                "Put the dog in the back of the buggy",
                "Drive to the lookout point",
                "Follow Chum to the lookout point"
            }
        },
        {
            "Magnum Opus",
            new[]
            {
                "Drive to the Graveyard",
                "Find fuel for the Magnum Opus",
                "Refuel the Magnum Opus",
                "Store a fuel can in the Magnum Opus",
                "Drive to the Graveyard (second time)",
                "Destroy the gate",
                "Find a car body",
                "Reach the car body platform",
                "Collect the flashlight",
                "Reach the car body platform (second time)",
                "Select a car body",
                "Defeat the Buzzards",
                "Escape the Graveyard"
            }
        },
        {
            "Righteous Work",
            new[]
            {
                "Collect the scrap",
                "Collect the jag tip",
                "Return the jag tip to Chum",
                "Exit Chum's hideout",
                "Destroy the scarecrows",
                "Scout the camp from the lookout point",
                "Eliminate the sniper",
                "Disable the flame pipe at the gate",
                "Eliminate the War Crier",
                "Defeat the War Boys",
                "Find the remains of Max's Car",
                "Destroy the oil pump",
                "Return to the Magnum Opus",
                "Meet up with the mysterious wastelander",
                "Return to the Magnum Opus (second time)",
                "Signal Chum with the flare gun",
                "Use the garage to install the dual nitro boost",
                "Test out the nitro boost",
                "Defeat the Spotters"
            }
        },
        {
            "Into Madness",
            new[]
            {
                "Follow Stank Gum's Legion",
                "Drive to Jeet's stronghold",
                "Make a deal with Jeet",
                "Speak with Chum about the sniper rifle",
                "Collect the trigger mechanism",
                "Install the sniper rifle",
                "Exit Jeet's stronghold",
                "Test the sniper rifle",
                "Drive to Dead Barrens Pass",
                "Reach the lookout point and scout the Jaw",
                "Return to Chum"
            }
        },
        {
            "A Wasteland Classic",
            new[]
            {
                "Speak with Jeet",
                "Exit Jeet's stronghold (second time)",
                "Find the required car body",
                "Use the garage to install upgrades for the Jack",
                "Drive to Gutgash's stronghold",
                "Collect the welding wire"
            }
        },
        {
            "A Piece Tougher",
            new[]
            {
                "Exit Gutgash's stronghold",
                "Find Dim Rim's convoy",
                "Destroy Dim Rim's convoy truck",
                "Collect the hood ornament"
            }
        },
        {
            "Black Magic",
            new[]
            {
                "Install the Thunderpoon",
                "Exit Jeet's stronghold (third time)",
                "Test out the Thunderpoon",
                "Drive into Dead Barrens Pass",
                "Destroy the thunderstick launchers",
                "Destroy the hinges on the Jaw",
                "Pull down the Jaw with the harpoon"
            }
        },
        {
            "Smoke Rises",
            new[]
            {
                "Eliminate Stank Gum's Legion",
                "Destroy the catapults",
                "Reach the stronghold",
                "Defeat Stank Gum's fighters"
            }
        },
        {
            "Dance With Death",
            new[]
            {
                "Drive to the Underdune",
                "Enter the Underdune",
                "Find the light bulbs",
                "Lower the bridge",
                "Find the light bulbs (second time)",
                "Collect the light bulbs",
                "Return to the Magnum Opus (third time)",
                "Survive the ambush",
                "Escape the Underdune",
                "Return to the Outcrier"
            }
        },
        {
            "Fumehead's Debt",
            new[]
            {
                "Speak with Tenderloin",
                "Return to Crow Dazzle",
                "Win the Speed Demon death run",
                "Recruit Tenderloin"
            }
        },
        {
            "Immortal Enemy",
            new[]
            {
                "Defeat Stank Gum before the bomb explodes",
                "Defeat Tenderloin",
                "Defeat Scrotus",
                "Find a way back to the Big Chief",
                "Defeat Scrotus (second time)"
            }
        },
        {
            "The Big Chief",
            new[]
            {
                "Reach Stank Gum's garage",
                "Find the Big Chief engine",
                "Defeat Stank Gum's fighters",
                "Lower Stank Gum's car",
                "Drive to Deep Friah's temple"
            }
        },
        {
            "In It For Glory",
            new[]
            {
                "Follow the tire tracks",
                "Ram through the gate",
                "Reach the dig sites",
                "Descend the elevator shaft",
                "Reach the dig sites (second time)",
                "Defeat the buzzards",
                "Investigate the dig site",
                "Find Glory",
                "Investigate the noise",
                "Find Glory (second time)",
                "Bring Glory back out",
                "Defeat the Buzzards (second time)",
                "Put Glory into the Buzzard car",
                "Drive Glory to her mother"
            }
        },
        {
            "All Is Lost Forever",
            new[]
            {
                "Defeat Stank Gum",
                "Drive to Deep Friah's temple (second time)"
            }
        },
        {
            "Paint My Name In Blood",
            new[]
            {
                "Eliminate Scrotus' escort",
                "Destroy the Land Mover",
                "Ram the Land Mover",
                "Defeat Scrotus (final time)"
            }
        }
    };

    settings.Add("miss-a", false, "Split when activating a mission:");
    settings.Add("miss-c", false, "Split when completing a mission:");
    
    var i = 0;
    foreach (var setting in _settings)
    {
        var final = i + setting.Value.Length - 1; // final objective
    
        settings.Add("miss-a-" + final, false, setting.Key, "miss-a");
        settings.Add("miss-c-" + final, false, setting.Key, "miss-c");
    
        foreach (var split in setting.Value)
        {
            settings.Add("obj-a-" + i, false, split, "miss-a-" + final);
            settings.Add("obj-c-" + i, false, split, "miss-c-" + final);
    
            i++;
        }
    }
}

onStart
{
    vars.CurrentObjectiveCompleted = 0;
    vars.CurrentObjectiveActivated = 0;
}

start
{
    if(!old.ObjectiveCompleted && current.ObjectiveCompleted && settings["IL Timing"])
    {
        return true;
    }
    if(current.GameStarted == 1 && old.GameStarted == 0)
    {
        Thread.Sleep(1000);
    }
    return current.FirstInput > 0.5f && current.LoadValue == 0 && current.GameStarted == 1 && !settings["IL Timing"];
}

split
{
    if (!old.ObjectiveCompleted && current.ObjectiveCompleted && timer.CurrentTime.RealTime > TimeSpan.FromSeconds(1))
    {
        int objc = vars.CurrentObjectiveCompleted++;

        return settings["obj-c-" + objc] || settings["miss-c-" + objc];
    }
    if(current.ObjectiveActivated > old.ObjectiveActivated)
    {
        int obja = vars.CurrentObjectiveActivated++;

        return settings["obj-a-" + obja] || settings["miss-a-" + obja];
    }
}

reset
{
    
}

isLoading
{
    return current.LoadValue == 1;
}