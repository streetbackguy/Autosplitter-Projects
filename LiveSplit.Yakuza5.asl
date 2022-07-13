//Collaborative effort by streetbackguy and hoxi
state("Yakuza5", "Steam") 
{
    int isLoading: 0x28ECC5C;
    int chapter: 0x4614FF0, 0x858, 0x9B8, 0x218, 0x4E8, 0xDB0;
}

state("Yakuza5", "Game Pass") 
{
    int isLoading: 0x2AB2DF4;
}

init 
{
    vars.doneMaps = new List<string>();

    switch(modules.First().ModuleMemorySize) {
        case 78782464:
            version = "Game Pass";
            break; 
        case 77086720:
            version = "Steam";
            break;
    }
}

startup
{
    settings.Add("Y5", true, "Yakuza 5");
        settings.Add("KK", true, "Kiryu Kazuma", "Y5");
        settings.Add("TSA", true, "Taiga Saejima", "Y5");
        settings.Add("HA", true, "Haruka Sawamura & Shun Akiyama", "Y5");
        settings.Add("TSH", true, "Tatsuo Shinada", "Y5");
        settings.Add("FIN", true, "Finale", "Y5");

    var tB = (Func<string, string, string, Tuple<string, string, string>>) ((elmt1, elmt2, elmt3) => { return Tuple.Create(elmt1, elmt2, elmt3); });
        var sB = new List<Tuple<string, string, string>> 
    {
        tB("KK", "Part 1, Chapter 1: The Wanderer", "The Wanderer"),
        tB("KK", "Part 1, Chapter 2: Uninvited Guest", "Uninvited Guest"),
        tB("KK", "Part 1, Chapter 3: The Plot Unfolds", "The Plot Unfolds"),
        tB("KK", "Part 1, Chapter 4: Destinations", "Destinations"),
        tB("TSA", "Part 2, Chapter 1: Ends of the Earth", "Ends of the Earth"),
        tB("TSA", "Part 2, Chapter 2: The Way of Resolve", "The Way of Resolve"),
        tB("TSA", "Part 2, Chapter 3: Frozen Roar", "Frozen Roar"),
        tB("TSA", "Part 2, Chapter 4: Reckless Encounter", "Reckless Encounter"),
        tB("HA", "Part 3, Chapter 1: Backstage Dreams", "Backstage Dreams"),
        tB("HA", "Part 3, Chapter 2: Hope Lives On", "Hope Lives On"),
        tB("HA", "Part 3, Chapter 3: Closing In", "Closing In"),
        tB("HA", "Part 3, Chapter 4: Beyond the Dream", "Beyond the Dream"),
        tB("TSH", "Part 4, Chapter 1: Abandoned Glory", "Abandoned Glory"),
        tB("TSH", "Part 4, Chapter 2: Confronting the Past", "Confronting the Past"),
        tB("TSH", "Part 4, Chapter 3: The Price of Truth", "The Price of Truth"),
        tB("TSH", "Part 4, Chapter 4: Fleeting Triumph", "Fleeting Triumph"),
        tB("FIN", "Finale, Chapter 1: A Legend Returns", "A Legend Returns"),
        tB("FIN", "Finale, Chapter 2: A Hidden Past", "A Hidden Past"),
        tB("FIN", "Finale, Chapter 3: The Survivors", "The Survivors"),
        tB("FIN", "Finale, Chapter 4: Crossroads", "Crossroads"),
        tB("FIN", "Finale, Final Chapter: Dreams Fulfilled", "Dreams Fulfilled"),
    };

    foreach (var s in sB) settings.Add(s.Item2, false, s.Item3, s.Item1);

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Yakuza 5",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
    print(modules.First().ModuleMemorySize.ToString());
}

//Starts when the game is booting up, but can be reset at main menu and then will autostart upon loading a New Game/New Game Plus file
start
{
    return (current.isLoading == 1);
}

//Pauses during Title and Chapter Cards also, but shouldn't be too much of an issue
isLoading 
{
    return (current.isLoading == 2);
}

split
{
    if (current.chapter != 0 | current.chapter != 1 && current.isLoading == 2 && old.isLoading == 1)
    {
        return true;
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
