//Load Removal by Diggity
//Autosplitter by Streetbackguy
state("Crow Country")
{
}

startup
{
    vars.Log = (Action<object>)(output => print("[Crow Country] " + output));

    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.LoadSceneManager = true;
    vars.Helper.Settings.CreateFromXml("Components/CrowCountry.Settings.xml");
    vars.Helper.AlertLoadless();

    vars.ReadFSMInt = (Func<System.Diagnostics.Process, long, string, int>)((proc, arrayBase, name) =>
    {
        DeepPointer dp;
        int arrayCount;

        dp = new DeepPointer((IntPtr)arrayBase + 0x18);
        arrayCount = dp.Deref<int>(proc);

        for (var i = 0; i < arrayCount; i++)
        {
            String s;
            int value;

            dp = new DeepPointer((IntPtr)arrayBase + 0x20 + (0x8 * i), 0x10, 0x14);
            s = dp.DerefString(proc, 64);
            dp = new DeepPointer((IntPtr)arrayBase + 0x20 + (0x8 * i), 0x30);
            value = dp.Deref<int>(proc);

            if (s == name) {
                return value;
            }
        }

        throw new Exception("Item Not Found: " + name);
    });
}

init
{
    vars.Splits = new HashSet<string>();

    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
    {
        var pm = mono["PlayMaker", "PlayMakerGlobals"];
        vars.Helper["arrayBase"] = pm.Make<long>("instance", 0x18, 0x30);
        vars.Helper["Items"] = pm.Make<int>("instance", 0x18, 0x30, 0x18);


        //print("Base address is" + (pm.Static + pm["instance"]).ToString("X"));

        for (var j = 0; j < 238; j++)
        {
            DeepPointer dp = new DeepPointer(pm.Static + pm["instance"], 0x18, 0x30, 0x20+(0x8*j), 0x10, 0x14);
            string s = dp.DerefString(game, 64);
            dp = new DeepPointer(pm.Static + pm["instance"], 0x18, 0x30, 0x20+(0x8*j), 0x30);
            int i = dp.Deref<int>(game);

            print (s + ": " + i.ToString());
        }

        return true;
    });

    //ID Card = Item 1
    //Bronze Key = Item 2
    //Silver Key = Item 3
    //Gold Key = Item 4
    //Trident = Item 9
    //Glass Vials
    //Crank = Item 5
    //Gemstone = Item 6
    //Chain = Item 7
    //Woeful Mask = Item 8
    //Data Disk = Item 10
    //Acid bottle = Item 11
    //Large Battery = Item 12
    current.GotBronzeKey = 0;
    current.GotSilverKey = 0;
    current.GotGoldKey = 0;
    current.GotWoefulMask = 0;
    current.GotTrident = 0;
    current.GotGlassVials = 0;
    current.GotCrank = 0;
    current.GotChain = 0;
    current.GotDataDisk = 0;
    current.GotAcidBottle = 0;
    current.GotLargeBattry = 0;

    //current.CrystalCrowCount = 0;
    //current.Weapons = 0;
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name ?? current.activeScene;
    current.loadingScene = vars.Helper.Scenes.Loaded[0].Name ?? current.loadingScene;

    current.GotBronzeKey = vars.ReadFSMInt(game, current.arrayBase, "item: 2");
    current.GotCrank = vars.ReadFSMInt(game, current.arrayBase, "item: 5");
    current.GotGemstone = vars.ReadFSMInt(game, current.arrayBase, "item: 6");
    current.GotChain = vars.ReadFSMInt(game, current.arrayBase, "item: 7");
    current.GotWoefulMask = vars.ReadFSMInt(game, current.arrayBase, "item: 8");
    current.GotSilverKey = vars.ReadFSMInt(game, current.arrayBase, "item: 3");
    current.GotDataDisk = vars.ReadFSMInt(game, current.arrayBase, "item: 10");
    current.GotGoldKey = vars.ReadFSMInt(game, current.arrayBase, "item: 4");
    current.GotLargeBattery = vars.ReadFSMInt(game, current.arrayBase, "item: 12");
    current.GotTrident = vars.ReadFSMInt(game, current.arrayBase, "item: 9");
    current.GotGlassVials = vars.ReadFSMInt(game, current.arrayBase, "item: 13");
    current.GotAcidBottle = vars.ReadFSMInt(game, current.arrayBase, "item: 11");

    //current.CrystalCrowCount = vars.ReadFSMInt(game, current.arrayBase, "CrystalCrows: 0");
    //current.Weapons = vars.ReadFSMInt(game, current.arrayBase, "total guns: 1");
}

isLoading
{
    return old.loadingScene != current.activeScene;
}

start
{
    //return old.loadingScene != current.activeScene && old.loadingScene == "Roadside";
}

split
{
    //Key Items
    if (old.GotBronzeKey == 0 && current.GotBronzeKey == 1)
    {
        vars.Log("Picked up Bronze Key");
        return settings["itemBronzeKey"];
    }

    if (old.GotCrank == 0 && current.GotCrank == 1)
    {
        vars.Log("Picked up Crank");
        return settings["itemCrank"];
    }

    if (old.GotGemstone == 0 && current.GotGemstone == 1)
    {
        vars.Log("Picked up Gemstone");
        return settings["itemGemstone"];
    }

    if (old.GotChain == 0 && current.GotChain == 1)
    {
        vars.Log("Picked up Chain");
        return settings["itemChain"];
    }

    if (old.GotWoefulMask == 0 && current.GotWoefulMask == 1)
    {
        vars.Log("Picked up Woeful Mask");
        return settings["itemWoefulMask"];
    }

    if (old.GotSilverKey == 0 && current.GotSilverKey == 1)
    {
        vars.Log("Picked up Silver Key");
        return settings["itemSilverKey"];
    }

    if (old.GotDataDisk == 0 && current.GotDataDisk == 1)
    {
        vars.Log("Picked up Data Disk");
        return settings["itemDataDisk"];
    }

    if (old.GotTrident == 0 && current.GotTrident == 1)
    {
        vars.Log("Picked up Trident");
        return settings["itemTrident"];
    }
    
    if (old.GotGoldKey == 0 && current.GotGoldKey == 1)
    {
        vars.Log("Picked up Gold Key");
        return settings["itemGoldKey"];
    }

    if (old.GotLargeBattery == 0 && current.GotLargeBattery == 1)
    {
        vars.Log("Picked up Large Battery");
        return settings["itemLargeBattery"];
    }

    if (old.GotGlassVials == 0 && current.GotGlassVials == 1)
    {
        vars.Log("Picked up Glass Vials");
        return settings["itemGlassVials"];
    }

    if (old.GotAcidBottle == 0 && current.GotAcidBottle == 1)
    {
        vars.Log("Picked up Acid Bottle");
        return settings["itemAcidBottle"];
    }

    //Area
    if(old.loadingScene != current.loadingScene && old.loadingScene != "Title" && old.loadingScene != "Driving Intro")
    {
        vars.Log("Area completed | " + old.loadingScene);
        return settings["area" + old.loadingScene];
    }

    //Secrets
    // if(old.CrystalCrowCount == current.CrystalCrowCount + 1 && current.loadingScene != "Title")
    // {
    //     vars.Log("Crystal Crows | " + current.CrystalCrowCount);
    //     return settings["secretCrows"];
    // }

    // if (old.Weapons != current.Weapons && current.Weapons == old.Weapons + 1)
    // {
    //     return settings["secretWeapons"];
    // }
}

reset
{
    return current.activeScene == "Title" && old.activeScene != "Title";
}
