state("LiveSplit")
{

}

startup
{
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v3")).CreateInstance("PSP");
    vars.Log = (Action<object>)(output => print("[Sonic Rivals] " + output));

    vars.Timer = vars.Helper.Make<float>(0x08a6db50);
    vars.PlayerWinFlag = vars.Helper.Make<int>(0x08a9c3d4, 0x868);
    vars.PlayerCharacter = vars.Helper.Make<int>(0x08a9c3d4, 0x220);
    vars.PlayerPlacement = vars.Helper.Make<int>(0x08a9c3d4, 0x9ec);
    vars.CurrentAct = vars.Helper.Make<int>(0x08aaf81c);
    vars.CurrentLevel = vars.Helper.Make<byte>(0x08a729b6);
    vars.CurrentCup = vars.Helper.Make<int>(0x08a72994);
    vars.DemoMode = vars.Helper.Make<byte>(0x08ac4a29);
    vars.SonicStory1 = vars.Helper.Make<byte>(0x08a65f94);
    vars.SonicStory2 = vars.Helper.Make<byte>(0x08a65f95);
    vars.SonicStory3 = vars.Helper.Make<byte>(0x08a65f96);
    vars.ShadowStory1 = vars.Helper.Make<byte>(0x08a65f98);
    vars.ShadowStory2 = vars.Helper.Make<byte>(0x08a65f99);
    vars.ShadowStory3 = vars.Helper.Make<byte>(0x08a65f9a);
    vars.KnucklesStory1 = vars.Helper.Make<byte>(0x08a65f9c);
    vars.KnucklesStory2 = vars.Helper.Make<byte>(0x08a65f9d);
    vars.KnucklesStory3 = vars.Helper.Make<byte>(0x08a65f9e);
    vars.SilverStory1 = vars.Helper.Make<byte>(0x08a65fa0);
    vars.SilverStory2 = vars.Helper.Make<byte>(0x08a65fa1);
    vars.SilverStory3 = vars.Helper.Make<byte>(0x08a65fa2);
    vars.LevelSelect = vars.Helper.Make<byte>(0x08a01c35);

    vars.TotalTime = new TimeSpan();
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
    if(vars.PlayerWinFlag.Current != vars.PlayerWinFlag.Old)
    {
        vars.Log("Win?: " + vars.PlayerWinFlag.Current);
    }

    if(vars.CurrentLevel.Current != vars.CurrentLevel.Old)
    {
        vars.Log("Level: " + vars.CurrentLevel.Current);
    }

    if(vars.PlayerCharacter.Current != vars.PlayerCharacter.Old)
    {
        vars.Log("Character: " + vars.PlayerCharacter.Current);
    }
}

start
{
    return vars.LevelSelect.Current == 64 && vars.CurrentLevel.Current == 0 && vars.PlayerCharacter.Current == 0;
}

onStart
{
    vars.TotalTime = TimeSpan.Zero;
    vars.Splits.Clear();
}

isLoading
{
    return true;
}

split
{
    if(vars.PlayerWinFlag.Current == 1 && vars.DemoMode.Current == 0 && !vars.Splits.Contains(vars.PlayerCharacter.Current.ToString() + vars.CurrentLevel.Current.ToString() + "won"))
    {
        return settings[vars.PlayerCharacter.Current.ToString() + vars.CurrentLevel.Current.ToString() + "won"] && vars.Splits.Add(vars.PlayerCharacter.Current.ToString() + vars.CurrentLevel.Current.ToString() + "won");
    }
}

gameTime
{
    if(vars.Timer.Old > vars.Timer.Current)
    {
        vars.TotalTime += TimeSpan.FromSeconds(vars.Timer.Old);
    }
    
    return vars.TotalTime + TimeSpan.FromSeconds(vars.Timer.Current);
}

reset
{
    return vars.CurrentLevel.Current == 0 && vars.LevelSelect.Old == 64 && vars.LevelSelect.Current == 0 && vars.PlayerCharacter.Current == 0;
}
