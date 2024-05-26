state("Troublemaker-Win64-Shipping")
{
    int Start: 0x51BAE90;
    int Chapter: 0x56DF420, 0x180, 0x1F0;
}

start
{
    return current.Start == 49 && old.Start == 50;
}

split
{
    if(current.Chapter == old.Chapter + 1)
    {
        return true;
    }
}

isLoading
{

}