state("SWTFU")
{
    bool Loading: 0xE40439;
}

isLoading
{
    return current.Loading;
}

start
{
    return current.Start == 1 && old.Start == 0;
}
