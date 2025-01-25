state("SilentHill")
{
    bool Loading: "g_SilentHill.sgl", 0x1596FCC;
    int InGameCutscene: "g_SilentHill.sgl", 0x158C5E0, 0x248, 0x90;
    int PrerenderedCutscene: "binkw32.dll", 0x00230E0;
    string255 CinematicAudio: "g_SilentHill.sgl", 0x1558958; // Covers fringe cases of Cinematics not being detected under the InGameCutscene pointer address
}

isLoading
{
    return current.Loading || current.PrerenderedCutscene == 1 || current.InGameCutscene == 1 || current.CinematicAudio.Substring(current.CinematicAudio.Length - 15, 3) == "cin"; 
}

exit
{
    timer.IsGameTimePaused = true;
}
