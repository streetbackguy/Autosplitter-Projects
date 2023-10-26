state("Engine")
{
    int PlayerControl: 0x201A0934;
    int Loads: 0x1C1F6C;
}

start
{
    return current.PlayerControl == 2 && old.PlayerControl == 0;
}

isLoading
{
    return current.Loads == 0;
}