state("MySims")
{
    bool Loads: 0xC86D94;
}

isLoading
{
    return current.Loads;
}