state("alan_wakes_american_nightmare")
{
    bool LoadScreens: 0x623188;
    int AutoStart: 0x53DE00;
    string1000 Dialogue: 0x0572338, 0x24, 0x0, 0x18, 0x0;
}

init
{
    vars.Splits = new HashSet<string>();
}

startup
{
    settings.Add("AWAN", true, "Alan Wake's American Nightmare Splits");
        settings.Add("The observatory! Hot on the heels of the herald of darkness, the champion of light forges on... to see the stars.", true, "Complete Chapter 1", "AWAN");
        settings.Add("A printout of a signal. It, too, is a weapon created by the champion of light. In its words stirs a new reality... but it is incomplete. And yet, it provides a road map for the man to follow, a course that will lead him to a place where he may confront his enemy.", true, "Complete Chapter 2", "AWAN");
        settings.Add("Oh, hell, this isn't going right!", true, "Complete Chapter 3", "AWAN");
        settings.Add("It's said that nobody knows what the future might bring, but for this man, it's no longer entirely true. A weaker man might simply give up. But the champion of light is an expert on destiny. Sometimes, the puppet and puppeteer can be one and the same...", true, "Complete Chapter 4", "AWAN");
        settings.Add("Another printout. Another signal fragment. The message is still not complete, but it's another piece of the weapon he has built against his adversary. Mere words on a piece of paper, but in the right hands, they will hold back the darkness.", true, "Complete Chapter 5", "AWAN");
        settings.Add("No! It's not enough!", true, "Complete Chapter 6", "AWAN");
        settings.Add("The fate of countless individuals hangs in the balance, threatened by the machinations of the herald of darkness. And yet, for a moment, the champion of light breathes a little easier. He has saved one life. For this moment, it is enough -- and soon, perhaps, he can put an end to this.", true, "Complete Chapter 7", "AWAN");
        settings.Add("In a strange way, he feels at ease. He is armed with his own words, and when the time comes, they will be enough, or they will not. For now, he's content to let the currents take him toward the final confrontation.", true, "Complete Chapter 8", "AWAN");
        // settings.Add("Oh, come on, buddy, why don't you...", true, "Complete Chapter 9", "AWAN");
}

isLoading
{
    return current.LoadScreens;
}

split
{
    if(current.Dialogue != old.Dialogue && !vars.Splits.Contains(current.Dialogue))
    {
        return settings[current.Dialogue] && vars.Splits.Add(current.Dialogue);
    }
}

start
{
    return current.AutoStart == 1 && current.LoadScreens;
}

onStart
{
    vars.Splits.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}