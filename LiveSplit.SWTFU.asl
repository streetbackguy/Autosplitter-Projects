state("SWTFU")
{
    bool Loading: 0xE40439;
}

isLoading
{
    return current.Loading;
}
