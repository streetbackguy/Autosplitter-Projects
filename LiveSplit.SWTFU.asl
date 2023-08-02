state("SWTFU")
{
    bool Loading: 0xE40439;
    byte NGStart: 0xF91AD9;
    byte NGPlusStart: 0x10B5063;
}

isLoading
{
    return current.Loading;
}

start
{
    return current.NGStart == 1 && old.NGStart == 0 || current.NGPlusStart == 66 && old.NGPlusStart == 0;
}
