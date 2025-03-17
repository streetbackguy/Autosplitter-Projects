state("hppoa")
{
    byte LoadingScreens: "Engine.dll", 0x04C660C, 0x740, 0x574;
    byte LoadingScreens2: "Engine.dll", 0x0166B7C, 0x1E0;
    string50 MapName: "Engine.dll", 0x0653BB8, 0x2C, 0x168, 0x0;
}

isLoading
{
    return current.LoadingScreens != 0 || current.LoadingScreens2 == 255;
}

start
{
    return current.LoadingScreens != 0;
}

onStart
{
    timer.IsGameTimePaused = true;
}