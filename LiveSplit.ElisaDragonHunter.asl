state("ElisaDragonHunter-Win64-Shipping")
{
    int Starter: 0x4521D60, 0x168, 0xC10, 0x60, 0xB8;
    float DragonHP: 0x4521D60, 0x30, 0xE8, 0x2A0, 0x4D0, 0xA0, 0x4DC;
    float ElisaHP: 0x4521D60, 0x180, 0x38, 0x0, 0x30, 0x2B8, 0xE70, 0x558;    
}

start
{
    return old.Starter == 0 && current.Starter == 1;
}

split
{
    return old.DragonHP >= 0.02000029758f && current.DragonHP < 0.02000029758f && current.ElisaHP > 0.000000000f;
}

reset
{
    return old.ElisaHP <= 1 && current.ElisaHP == 4;
}
