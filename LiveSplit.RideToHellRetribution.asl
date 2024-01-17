state("RTH")
{
    bool LoadScreen: 0x2E98770;
    byte MainMenu: 0x2ED9DB9;
}

start
{
    return !current.LoadScreen && old.LoadScreen && current.MainMenu == 40;
}

isLoading
{
    return current.LoadScreen;
}

exit
{
    timer.IsGameTimePaused = true;
}