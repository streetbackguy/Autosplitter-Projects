state("StateOfDecay2-Win64-Shipping")
{
    int Loading: 0x4584364;
    int MainMenu: 0x4758E78;
}

isLoading
{
    return current.Loading != 0 || current.Loading == 0 && current.MainMenu == 0;
}