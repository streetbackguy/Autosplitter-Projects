state("LiveSplit")
{

}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PSP");
    vars.Log = (Action<object>)(output => print("[Sonic Rivals] " + output));

    //NTSC Codes
    vars.NTSCSerial = vars.Helper.MakeString(9, 0x089557d0);
    vars.NTSCTimer = vars.Helper.Make<float>(0x08a85ad0);
    vars.NTSCPlayerWinFlag = vars.Helper.Make<int>(0x08ab4354, 0x868);
    vars.NTSCPlayerCharacter = vars.Helper.Make<int>(0x08ab4354, 0x220);
    vars.NTSCCurrentLevel = vars.Helper.Make<byte>(0x08a02804);
    vars.NTSCDemoMode = vars.Helper.Make<byte>(0x08ac4a29);
    vars.NTSCLevelSelect = vars.Helper.Make<byte>(0x08a017b5);

    vars.NTSCTotalTime = new TimeSpan();
    vars.Splits = new HashSet<string>();

    settings.Add("SR", true, "Sonic Rivals");
        settings.Add("SON", true, "Sonic Level Splits", "SR");
        settings.Add("SHA", true, "Shadow Level Splits", "SR");
        settings.Add("KNU", true, "Knuckles Level Splits", "SR");
        settings.Add("SIL", true, "Silver Level Splits", "SR");

    vars.SonicLevels = new Dictionary<string, string>
    {
        { "313won", "Forest Falls Zone - Act 1" },
        { "314won", "Forest Falls Zone - Act 2" },
        { "315won", "Forest Falls Zone - Boss" },
        { "316won", "Colosseum Highway Zone - Act 1" },
        { "317won", "Colosseum Highway Zone - Act 2" },
        { "318won", "Colosseum Highway Zone - Boss" },
        { "319won", "Sky Park Zone - Act 1" },
        { "320won", "Sky Park Zone - Act 2" },
        { "321won", "Crystal Mountain Zone - Act 1" },
        { "322won", "Crystal Mountain Zone - Act 2" },
        { "323won", "Crystal Mountain Zone - Boss" },
        { "324won", "Death Yard Zone - Act 1" },
        { "325won", "Death Yard Zone - Act 2" },
        { "326won", "Death Yard Zone - Boss" },
        { "327won", "Meteor Base Zone - Act 1" },
        { "328won", "Meteor Base Zone - Act 2" },
        { "329won", "Meteor Base Zone - Boss" }
    };

    vars.ShadowLevels = new Dictionary<string, string>
    {
        { "413won", "Forest Falls Zone - Act 1" },
        { "414won", "Forest Falls Zone - Act 2" },
        { "415won", "Forest Falls Zone - Boss" },
        { "416won", "Colosseum Highway Zone - Act 1" },
        { "417won", "Colosseum Highway Zone - Act 2" },
        { "418won", "Colosseum Highway Zone - Boss" },
        { "419won", "Sky Park Zone - Act 1" },
        { "420won", "Sky Park Zone - Act 2" },
        { "421won", "Crystal Mountain Zone - Act 1" },
        { "422won", "Crystal Mountain Zone - Act 2" },
        { "423won", "Crystal Mountain Zone - Boss" },
        { "424won", "Death Yard Zone - Act 1" },
        { "425won", "Death Yard Zone - Act 2" },
        { "426won", "Death Yard Zone - Boss" },
        { "427won", "Meteor Base Zone - Act 1" },
        { "428won", "Meteor Base Zone - Act 2" },
        { "429won", "Meteor Base Zone - Boss" }
    };

    vars.KnucklesLevels = new Dictionary<string, string>
    {
        { "513won", "Forest Falls Zone - Act 1" },
        { "514won", "Forest Falls Zone - Act 2" },
        { "515won", "Forest Falls Zone - Boss" },
        { "516won", "Colosseum Highway Zone - Act 1" },
        { "517won", "Colosseum Highway Zone - Act 2" },
        { "518won", "Colosseum Highway Zone - Boss" },
        { "519won", "Sky Park Zone - Act 1" },
        { "520won", "Sky Park Zone - Act 2" },
        { "521won", "Crystal Mountain Zone - Act 1" },
        { "522won", "Crystal Mountain Zone - Act 2" },
        { "523won", "Crystal Mountain Zone - Boss" },
        { "524won", "Death Yard Zone - Act 1" },
        { "525won", "Death Yard Zone - Act 2" },
        { "526won", "Death Yard Zone - Boss" },
        { "527won", "Meteor Base Zone - Act 1" },
        { "528won", "Meteor Base Zone - Act 2" },
        { "529won", "Meteor Base Zone - Boss" }
    };

    vars.SilverLevels = new Dictionary<string, string>
    {
        { "613won", "Forest Falls Zone - Act 1" },
        { "614won", "Forest Falls Zone - Act 2" },
        { "615won", "Forest Falls Zone - Boss" },
        { "616won", "Colosseum Highway Zone - Act 1" },
        { "617won", "Colosseum Highway Zone - Act 2" },
        { "618won", "Colosseum Highway Zone - Boss" },
        { "619won", "Sky Park Zone - Act 1" },
        { "620won", "Sky Park Zone - Act 2" },
        { "621won", "Crystal Mountain Zone - Act 1" },
        { "622won", "Crystal Mountain Zone - Act 2" },
        { "623won", "Crystal Mountain Zone - Boss" },
        { "624won", "Death Yard Zone - Act 1" },
        { "625won", "Death Yard Zone - Act 2" },
        { "626won", "Death Yard Zone - Boss" },
        { "627won", "Meteor Base Zone - Act 1" },
        { "628won", "Meteor Base Zone - Act 2" },
        { "629won", "Meteor Base Zone - Boss" }
    };

    foreach (var Tag in vars.SonicLevels)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "SON");
    	};

    foreach (var Tag in vars.ShadowLevels)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "SHA");
    	};

    foreach (var Tag in vars.KnucklesLevels)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "KNU");
    	};

    foreach (var Tag in vars.SilverLevels)
		{
			settings.Add(Tag.Key.ToString(), true, Tag.Value, "SIL");
    	};
}

update
{
    if(vars.NTSCPlayerWinFlag.Current != vars.NTSCPlayerWinFlag.Old)
    {
        vars.Log("Win?: " + vars.NTSCPlayerWinFlag.Current);
    }

    if(vars.NTSCCurrentLevel.Current != vars.NTSCCurrentLevel.Old)
    {
        vars.Log("Level: " + vars.NTSCCurrentLevel.Current);
    }

    if(vars.NTSCPlayerCharacter.Current != vars.NTSCPlayerCharacter.Old)
    {
        vars.Log("Character: " + vars.NTSCPlayerCharacter.Current);
    }
}

start
{
        return vars.NTSCLevelSelect.Current == 64 && vars.NTSCCurrentLevel.Current != 0 && vars.NTSCPlayerCharacter.Current == 0;
}

onStart
{
    vars.NTSCTotalTime = TimeSpan.Zero;
    vars.Splits.Clear();
}

isLoading
{
    return true;
}

split
{
    if(vars.NTSCPlayerWinFlag.Current == 1 && !vars.Splits.Contains(vars.NTSCPlayerCharacter.Current.ToString() + vars.NTSCCurrentLevel.Current.ToString() + "won"))
    {
        return settings[vars.NTSCPlayerCharacter.Current.ToString() + vars.NTSCCurrentLevel.Current.ToString() + "won"] && vars.Splits.Add(vars.NTSCPlayerCharacter.Current.ToString() + vars.NTSCCurrentLevel.Current.ToString() + "won");
    }
}

gameTime
{
    if(vars.NTSCTimer.Old > vars.NTSCTimer.Current && vars.NTSCPlayerWinFlag.Current == 0)
    {
        vars.NTSCTotalTime += TimeSpan.FromSeconds(vars.NTSCTimer.Old);
    }

    return vars.NTSCTotalTime + TimeSpan.FromSeconds(vars.NTSCTimer.Current);
}

reset
{
    return vars.NTSCCurrentLevel.Current == 116 && vars.NTSCLevelSelect.Old == 64 && vars.NTSCLevelSelect.Current == 0 && vars.NTSCPlayerCharacter.Current == 0;
}
