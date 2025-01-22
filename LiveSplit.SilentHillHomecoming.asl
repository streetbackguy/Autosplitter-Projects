state("SilentHill")
{
    bool Loading: "g_SilentHill.sgl", 0x1596FCC;
    int InGameCutscene: "g_SilentHill.sgl", 0x158C5E0, 0x248, 0x90;
    int PrerenderedCutscene: "binkw32.dll", 0x00230E0;
    string255 CinematicAudio: "g_SilentHill.sgl", 0x15589C1; // Covers fringe cases of Cinematics not being detected under the InGameCutscene pointer address
    string255 CinematicAudio2: "g_SilentHill.sgl", 0x15589B3; // Covers fringe cases of Cinematics not being detected under the InGameCutscene pointer address (if game not on C drive)
}

isLoading
{
    return current.Loading || current.PrerenderedCutscene == 1 || current.InGameCutscene == 1 || current.CinematicAudio == "cin_m14_025.ogg" || current.CinematicAudio == "cin_m02_020.ogg" ||
    current.CinematicAudio2 == "cin_m14_025.ogg" || current.CinematicAudio2 == "cin_m02_020.ogg";
}

exit
{
    timer.IsGameTimePaused = true;
}