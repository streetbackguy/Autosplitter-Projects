state("South Park - The Stick of Truth")
{
	bool Loads:  0x0108598, 0x0;
	bool UnpatchedLoads: 0x00108708, 0x0; 
	int ScreenChange: 0x01B70FE4, 0x0, 0x6A8;
	int Quest: 0x0E49C00, 0x690, 0x5AC;
	int Friends: 0x1C7660C;
	int Chinpokomon: 0x1C765C0;
    	int Lightning: 0x1CA80D0;
	int MainMenu: 0x1D2AC70;
}

init
{
    vars.CurCounter = 0;
    vars.Splits = new HashSet<string>();
}

startup
{
    settings.Add("Anyquests", true, "Any% Quests");
        settings.Add("any1", false, "The New Kid in Town", "Anyquests");
        settings.Add("any2", false, "Gate Crasher", "Anyquests");
        settings.Add("any3", false, "Hot Coffee", "Anyquests");
        settings.Add("any4", false, "Detention Sentence", "Anyquests");
        settings.Add("any5", false, "Call the Banners", "Anyquests");
        settings.Add("any6", false, "The Bard", "Anyquests");
        settings.Add("any7", false, "Alien Abduction", "Anyquests");
        settings.Add("any8", false, "PTA Problems", "Anyquests");
        settings.Add("any9", false, "Nonconformist", "Anyquests");
        settings.Add("any10", false, "Recruit the Goth Kids", "Anyquests");
        settings.Add("any11", false, "Gain New Allies", "Anyquests");
        settings.Add("any12", false, "Attack the School", "Anyquests");
        settings.Add("any13", false, "Defeat the Underpants Gnomes", "Anyquests");
        settings.Add("any14", false, "Pose as Bebe’s Boyfriend", "Anyquests");
        settings.Add("any15", false, "Heading North", "Anyquests");
        settings.Add("any16", false, "O Canada", "Anyquests");
        settings.Add("any17", false, "Recruit the Girls", "Anyquests");
        settings.Add("any18", false, "Forging Alliances", "Anyquests");
        settings.Add("any19", false, "Beat Up Clyde!", "Anyquests");
        settings.Add("any20", false, "Betrayal from Within", "Anyquests");
    settings.Add("Friendsquests", true, "120 Friends Quests");
        settings.Add("friend1", false, "Flower for a Princess", "Friendsquests");
        settings.Add("friend2", false, "The New Kid in Town", "Friendsquests");
        settings.Add("friend3", false, "Gate Crasher", "Friendsquests");
        settings.Add("friend4", false, "Mr. Slave’s Package", "Friendsquests");
        settings.Add("friend5", false, "Hot Coffee", "Friendsquests");
        settings.Add("friend6", false, "Detention Sentence", "Friendsquests");
        settings.Add("friend7", false, "Call the Banners", "Friendsquests");
        settings.Add("friend8", false, "The Bard", "Friendsquests");
        settings.Add("friend9", false, "Alien Abduction", "Friendsquests");
        settings.Add("friend10", false, "The Timmy Express", "Friendsquests");
        settings.Add("friend11", false, "PTA Problems", "Friendsquests");
        settings.Add("friend12", false, "Nonconformist", "Friendsquests");
        settings.Add("friend13", false, "Recruit the Goth Kids", "Friendsquests");
        settings.Add("friend14", false, "Gain New Allies", "Friendsquests");
        settings.Add("friend15", false, "Attack the School", "Friendsquests");
        settings.Add("friend16", false, "Defeat the Underpants Gnomes", "Friendsquests");
        settings.Add("friend17", false, "Pose as Bebe’s Boyfriend", "Friendsquests");
        settings.Add("friend18", false, "Heading North", "Friendsquests");
        settings.Add("friend19", false, "O Canada", "Friendsquests");
        settings.Add("friend20", false, "Magical Songs", "Friendsquests");
        settings.Add("friend21", false, "Dropping the Kids Off", "Friendsquests");
        settings.Add("friend22", false, "ManBearPig", "Friendsquests");
        settings.Add("friend23", false, "Hide ‘n’ Seek", "Friendsquests");
        settings.Add("friend24", false, "The She-Ogre", "Friendsquests");
        settings.Add("friend25", false, "Vulcan Around", "Friendsquests");
        settings.Add("friend26", false, "Big Game Huntin’ with Jimbo", "Friendsquests");
        settings.Add("friend27", false, "The Homeless Problem", "Friendsquests");
        settings.Add("friend28", false, "Recruit the Girls", "Friendsquests");
        settings.Add("friend29", false, "Restoring the Balance", "Friendsquests");
        settings.Add("friend30", false, "Forging Alliances", "Friendsquests");
        settings.Add("friend31", false, "Beat Up Clyde!", "Friendsquests");
        settings.Add("friend32", false, "Betrayal from Within", "Friendsquests");
        settings.Add("friend33", false, "Phase 1", "Friendsquests");
        settings.Add("friend34", false, "Wasted Cache", "Friendsquests");
        settings.Add("friend35", false, "Nazi Zombie Bounty", "Friendsquests");
        settings.Add("friend36", false, "Find Jesus", "Friendsquests");
        settings.Add("friend37", false, "Mongolian Beef", "Friendsquests");
        settings.Add("friend38", false, "Rats in the Cellar", "Friendsquests");
    settings.Add("100quests", true, "100% Quests");
        settings.Add("100p1", false, "Flower for a Princess", "100quests");
        settings.Add("100p2", false, "The New Kid in Town", "100quests");
        settings.Add("100p3", false, "Gate Crasher", "100quests");
        settings.Add("100p4", false, "Mr. Slave’s Package", "100quests");
        settings.Add("100p5", false, "Hot Coffee", "100quests");
        settings.Add("100p6", false, "Detention Sentence", "100quests");
        settings.Add("100p7", false, "Call the Banners", "100quests");
        settings.Add("100p8", false, "The Bard", "100quests");
        settings.Add("100p9", false, "Alien Abduction", "100quests");
        settings.Add("100p10", false, "The Timmy Express", "100quests");
        settings.Add("100p11", false, "PTA Problems", "100quests");
        settings.Add("100p12", false, "Nonconformist", "100quests");
        settings.Add("100p13", false, "Recruit the Goth Kids", "100quests");
        settings.Add("100p14", false, "Gain New Allies", "100quests");
        settings.Add("100p15", false, "Attack the School", "100quests");
        settings.Add("100p16", false, "Defeat the Underpants Gnomes", "100quests");
        settings.Add("100p17", false, "Pose as Bebe’s Boyfriend", "100quests");
        settings.Add("100p18", false, "Heading North", "100quests");
        settings.Add("100p19", false, "O Canada", "100quests");
        settings.Add("100p20", false, "Magical Songs", "100quests");
        settings.Add("100p21", false, "Dropping the Kids Off", "100quests");
        settings.Add("100p22", false, "ManBearPig", "100quests");
        settings.Add("100p23", false, "Hide ‘n’ Seek", "100quests");
        settings.Add("100p24", false, "The She-Ogre", "100quests");
        settings.Add("100p25", false, "Vulcan Around", "100quests");
        settings.Add("100p26", false, "Big Game Huntin’ with Jimbo", "100quests");
        settings.Add("100p27", false, "The Homeless Problem", "100quests");
        settings.Add("100p28", false, "Recruit the Girls", "100quests");
        settings.Add("100p29", false, "Unfriend Al Gore", "100quests");
        settings.Add("100p30", false, "Restoring the Balance", "100quests");
        settings.Add("100p31", false, "Forging Alliances", "100quests");
        settings.Add("100p32", false, "Beat Up Clyde!", "100quests");
        settings.Add("100p33", false, "Betrayal from Within", "100quests");
        settings.Add("100p34", false, "Phase 1", "100quests");
        settings.Add("100p35", false, "Wasted Cache", "100quests");
        settings.Add("100p36", false, "Nazi Zombie Bounty", "100quests");
        settings.Add("100p37", false, "Find Jesus", "100quests");
        settings.Add("100p38", false, "Defeat ManBearPig", "100quests");
        settings.Add("100p39", false, "Mongolian Beef", "100quests");
        settings.Add("100p40", false, "Rats in the Cellar", "100quests");

    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | South Park: The Stick of Truth",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

update
{
    if ((current.Quest != old.Quest) && (old.Quest == 0) && (current.Quest != 0))
    {
        vars.CurCounter++;
    }
}

start
{
    return (current.ScreenChange == 0 && old.ScreenChange == 2);
}

isLoading 
{
	return (current.Loads || current.UnpatchedLoads || current.ScreenChange == 16 || current.Lightning == 1);
}

split
{
    if ((current.Quest != 0 && old.Quest == 0) && (!vars.Splits.Contains("any" + vars.CurCounter.ToString())))
    {
        vars.Splits.Add("any" + vars.CurCounter.ToString());
        return settings["any" + vars.CurCounter.ToString()];
    }

    if ((current.Quest != 0 && old.Quest == 0) && (!vars.Splits.Contains("friend" + vars.CurCounter.ToString())))
    {
        vars.Splits.Add("friend" + vars.CurCounter.ToString());
        return settings["friend" + vars.CurCounter.ToString()];
    }

    if ((current.Quest != 0 && old.Quest == 0) && (!vars.Splits.Contains("100p" + vars.CurCounter.ToString())))
    {
        vars.Splits.Add("100p" + vars.CurCounter.ToString());
        return settings["100p" + vars.CurCounter.ToString()];
    }
}

onStart
{
    timer.IsGameTimePaused = true;
}

reset
{
    return (current.MainMenu == 0 && old.MainMenu == 1);
}

onReset
{
    vars.Splits.Clear();
    vars.CurCounter = 0;
}

exit
{
    timer.IsGameTimePaused = true;
}
