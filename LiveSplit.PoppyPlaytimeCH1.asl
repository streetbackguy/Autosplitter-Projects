//Original ASL by Poots N Doots
//Updated for Current Patch by Streetbackguy

state("Poppy_Playtime-Win64-Shipping", "Current Patch")
{
    int isLoaded: 0x3E54898;
}

state("Playtime_Prototype4-Win64-Shipping", "Old Patch (Prototype4)")
{
    int isLoaded: 0x3E54898;
}

state("UE4Game-Win64-Shipping", "Old Patch (UE4)")
{
    int isLoaded: 0x4033228;
}

init
{
    string MD5Hash;
    using (var md5 = System.Security.Cryptography.MD5.Create())
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            MD5Hash = md5.ComputeHash(s).Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
            print("Hash is: " + MD5Hash);

    switch (MD5Hash){
        case "9B2AF956205EE1FB7813D2783AA231CA": version = "Old Patch (Prototype4)"; break;
        case "590B539C8833454F89BBEAA1621B74B5": version = "Current Patch"; break;

        default: version = "Unknown"; break;
    }

    /*
     * While moving around the level the hand flags are flipped at certain places. 
     * I believe this is due to the level streaming and possibly a bug with the PlayerBP prefab.
     * To avoid incorrect splits we keep a persistent flag which is reset with every run start lol
     */
    vars.hasPickedUpLeftHand = false;
    vars.hasPickedUpRightHand = false;

    /*
     * Same thing for the different inventory items. At certain level streaming triggers it seems
     * to recreate the player prefab from a previous checkpoint. This adds and then removes items from inventory the next frame
     */
    vars.hasPickedUpSecurityVhs = false;
    vars.hasInsertedSecurityVhs = false;

    vars.hasPickedUpLobbyVhs = false;
    vars.hasInsertedLobbyVhs = false;

    vars.hasPickedUpStorageVhs = false;
    vars.hasInsertedStorageVhs = false;
    
    vars.hasPickedUpMachineVhs = false;
    vars.hasInsertedMachineVhs = false;
    
    vars.hasPickedUpSiloVhs = false;
    vars.hasInsertedSiloVhs = false;

    vars.hasPickedUpScannerDoll = false;
    vars.hasInsertedScannerDoll = false;

    vars.itemNames = new Dictionary<string, Tuple<string, string>>() {
        // Vhs tapes
        { "vhslobby", Tuple.Create("Lobby VHS", "Insert Lobby VHS") },
        { "vhssecurity", Tuple.Create("Security VHS", "Insert Security VHS") },
        { "vhsstorage", Tuple.Create("Storage VHS", "Insert Storage VHS") },
        { "vhsmachine", Tuple.Create("Machine VHS", "Insert Machine VHS") },
        { "vhssilo", Tuple.Create("Silo VHS", "Insert Silo VHS") },

        // Key to the power room
        { "simonroomkey", Tuple.Create("Simon Room Key", "") },
        
        // Keys which start the right hand crane in the storage area
        { "blue", Tuple.Create("Blue Key", "") },
        { "red", Tuple.Create("Red Key", "") },
        { "green", Tuple.Create("Green Key", "") },
        { "yellow", Tuple.Create("Yellow Key", "") },

        // The doll that is created in the machine room
        { "scannerdoll", Tuple.Create("Scanner Doll", "Insert Scanner Doll") },
    };

    vars.inventorySlotCount = 11;

    vars.GetInventorySlotDisplayName = (Func<int, string>) ( (slotIndex) => {
        if (slotIndex == 0) {
            return current.slot1DisplayName;
        } else if (slotIndex == 1) {
            return current.slot2DisplayName;
        } else if (slotIndex == 2) {
            return current.slot3DisplayName;
        } else if (slotIndex == 3) {
            return current.slot4DisplayName;
        } else if (slotIndex == 4) {
            return current.slot5DisplayName;
        } else if (slotIndex == 5) {
            return current.slot6DisplayName;
        } else if (slotIndex == 6) {
            return current.slot7DisplayName;
        } else if (slotIndex == 7) {
            return current.slot8DisplayName;
        } else if (slotIndex == 8) {
            return current.slot9DisplayName;
        } else if (slotIndex == 9) {
            return current.slot10DisplayName;
        } else {
            return current.slot11DisplayName;
        }
    });

    // The number of keys the player has collected
    vars.storageKeyCount = 0;

    // We need to keep track of the current inventory state due to a level streaming player prefab bug
    vars.currentInventory = new List<string>();

    vars.SplitOnInventoryPickup = (Func<string, bool>) ( (displayName) =>  {
        Tuple<string, string> itemSettingsKeys;
        if (!vars.itemNames.TryGetValue(displayName.ToLower(), out itemSettingsKeys) || !settings[itemSettingsKeys.Item1]) {
            // Don't split if the item doesn't exist in the splittable items, or isn't enabled in the settings 
            return false;
        }

        if (settings["Debug"]) {
            print(itemSettingsKeys.Item1);
        }

        return true;
    });

    vars.ResetRunPersistentVariables = (Action) (() => {
        vars.hasPickedUpLeftHand = false;
        vars.hasPickedUpRightHand = false;

        vars.hasPickedUpSecurityVhs = false;
        vars.hasInsertedSecurityVhs = false;
        vars.hasPickedUpLobbyVhs = false;
        vars.hasInsertedLobbyVhs = false;
        vars.hasPickedUpStorageVhs = false;
        vars.hasInsertedStorageVhs = false;
        vars.hasPickedUpMachineVhs = false;
        vars.hasInsertedMachineVhs = false;
        vars.hasPickedUpSiloVhs = false;
        vars.hasInsertedSiloVhs = false;

        vars.hasPickedUpScannerDoll = false;
        vars.hasInsertedScannerDoll = false;

        vars.storageKeyCount = 0;
        vars.currentInventory = new List<string>();
    });

    vars.GetFNamePool = (Func<IntPtr>) (() => {	
        var scanner = new SignatureScanner(game, modules.First().BaseAddress, (int)modules.First().ModuleMemorySize);
        var pattern = new SigScanTarget("74 09 48 8D 15 ?? ?? ?? ?? EB 16");
        var gameOffset = scanner.Scan(pattern);
        if (gameOffset == IntPtr.Zero) return IntPtr.Zero;
        int offset = game.ReadValue<int>((IntPtr)gameOffset+0x5);
        return (IntPtr)gameOffset+offset+0x9;
	});

    vars.FNamePool = vars.GetFNamePool();

    vars.GetNameFromFName = (Func<int, int, string>) ( (key,partial) => {
        int chunkOffset = key >> 16;
        int nameOffset = (ushort)key;
        IntPtr namePoolChunk = memory.ReadValue<IntPtr>((IntPtr)vars.FNamePool + (chunkOffset+2) * 0x8);
        Int16 nameEntry = game.ReadValue<Int16>((IntPtr)namePoolChunk + 2 * nameOffset);
        int nameLength = nameEntry >> 6;
        if (partial == 0) {
            return game.ReadString((IntPtr)namePoolChunk + 2 * nameOffset + 2, nameLength);
        } else {
            return game.ReadString((IntPtr)namePoolChunk + 2 * nameOffset + 2, nameLength)+"_"+partial.ToString();
        }
	});

    var exe = modules.First();
    var scanner2 = new SignatureScanner(game, exe.BaseAddress, exe.ModuleMemorySize);
        var General = new SigScanTarget(3, "48 8D 0D ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 8B 05 ?? ?? ?? ?? 48 8B 4C 24 ?? 48 89 0C ?? 48 8B 74 24");
        var PlayerBP_C = new SigScanTarget(3, "48 89 1D ?? ?? ?? ?? F2 0F 11 0D");
        var uWorld = new SigScanTarget(3, "48 8D 0D ?? ?? ?? ?? E8 ?? ?? ?? ?? 48 8B 05 ?? ?? ?? ?? 4C 89 34");

    IntPtr ptr = scanner2.Scan(General);
    IntPtr ptr2 = scanner2.Scan(PlayerBP_C);
    IntPtr ptr3 = scanner2.Scan(uWorld);

    vars.isPaused = new MemoryWatcher<int>(new DeepPointer(ptr, 0x20, 0x18, 0x60, 0xBC));
    vars.isEndCaseDoorOpening = new MemoryWatcher<int>(new DeepPointer(ptr, 0x580, 0x018, 0x020, 0x098, 0x780, 0x278, 0x0B1));
    vars.hasLeftHand = new MemoryWatcher<int>(new DeepPointer(ptr2, 0x030, 0x2A0, 0x70A));
    vars.hasRightHand = new MemoryWatcher<int>(new DeepPointer(ptr2, 0x030, 0x2A0, 0x709));
    vars.isGameReady = new MemoryWatcher<int>(new DeepPointer(ptr2, 0x030, 0x2A0, 0x870));
    vars.inventorySize = new MemoryWatcher<int>(new DeepPointer(ptr2, 0x030, 0x2A0, 0x868));
        vars.slot1DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x008, 0x0), 32);
        vars.slot2DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x030, 0x0), 32);
        vars.slot3DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x058, 0x0), 32);
        vars.slot4DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x080, 0x0), 32);
        vars.slot5DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x0A8, 0x0), 32);
        vars.slot6DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x0D0, 0x0), 32);
        vars.slot7DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x0F8, 0x0), 32);
        vars.slot8DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x118, 0x0), 32);
        vars.slot9DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x148, 0x0), 32);
        vars.slot10DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x170, 0x0), 32);
        vars.slot11DisplayName = new StringWatcher(new DeepPointer(ptr2, 0x030, 0x2A0, 0x860, 0x198, 0x0), 32);
    vars.uWorldFNameIndex = new MemoryWatcher<int>(new DeepPointer(ptr3, 0x018, 0x010, 0x068, 0x020, 0x018));
    vars.watchers = new MemoryWatcherList() {vars.isPaused, vars.isEndCaseDoorOpening, vars.hasLeftHand,
                                             vars.hasRightHand, vars.isGameReady,
                                             vars.inventorySize, vars.slot1DisplayName,
                                             vars.slot2DisplayName, vars.slot3DisplayName,
                                             vars.slot4DisplayName, vars.slot5DisplayName,
                                             vars.slot6DisplayName, vars.slot7DisplayName,
                                             vars.slot8DisplayName, vars.slot9DisplayName,
                                             vars.slot10DisplayName, vars.slot11DisplayName,
                                             vars.uWorldFNameIndex};
}

startup
{
    // Any% Settings
    settings.Add("Chapter 1", true);
    settings.Add("Any%", true, "General Any% settings.", "Chapter 1");
    settings.CurrentDefaultParent = "Any%";
    settings.Add("Security VHS", true);
    settings.Add("Insert Security VHS", true);
    settings.Add("Left Hand", true);
    settings.Add("Simon Room Key", true, "Power Room Key");
    settings.Add("Blue Key", true, "Storage Key 1");
    settings.Add("Red Key", true, "Storage Key 2");
    settings.Add("Green Key", true, "Storage Key 3");
    settings.Add("Yellow Key", true, "Storage Key 4");
    settings.Add("Right Hand", true);
    settings.Add("Scanner Doll", true);
    settings.Add("Insert Scanner Doll", true);

    // All Tapes Settings
    settings.Add("All Tapes", false, "All Tapes Category Settings.", "Chapter 1");
    settings.CurrentDefaultParent = "All Tapes";
    settings.Add("Lobby VHS", false);
    settings.Add("Insert Lobby VHS", false);
    settings.Add("Storage VHS", false);
    settings.Add("Insert Storage VHS", false);
    settings.Add("Machine VHS", false);
    settings.Add("Insert Machine VHS", false);
    settings.Add("Silo VHS", false);
    settings.Add("Insert Silo VHS", false);

    settings.CurrentDefaultParent = null;
    settings.Add("Debug", false, "Debug Splits");
}

start
{
    if (vars.isGameReady.Current == 1 && vars.isLoaded.Current == 1 && vars.GetNameFromFName(vars.uWorldFNameIndex, 0).ToLower() == "pp_finallevel") {
        vars.ResetRunPersistentVariables();
        return true;
    }
}

update
{
    vars.watchers.UpdateAll(game);
}

isLoading
{
    return current.isLoaded == 0 || vars.isPaused.Current == 1;
}

reset
{
    // 803705 is the fname index of the main menu map
    if (vars.uWorldFNameIndex.Current != vars.uWorldFNameIndex.Old && vars.GetNameFromFName(vars.uWorldFNameIndex, 0).ToLower() == "mainmenu") {
        return true;
    }
}

split
{
    if (current.isLoaded == 0 || vars.isPaused.Current != 0) {
        return false;
    }

    if (settings["Left Hand"] && !vars.hasPickedUpLeftHand && (int) vars.hasLeftHand.Current == 1) {
        if (settings["Debug"]) {
            print("Left Hand Split");
        }
        
        vars.hasPickedUpLeftHand = true;
        return true;
    }

    if (settings["Right Hand"] && !vars.hasPickedUpRightHand && (int)vars.hasRightHand.Current == 257) {
        if (settings["Debug"]) {
            print("Right Hand Split");
        }

        vars.hasPickedUpRightHand = true;
        return true;
    }

    // TODO: Only do the final split after door is completely open
    if (vars.isEndCaseDoorOpening.Old == 4 && vars.isEndCaseDoorOpening.Current == 0) {
        if (settings["Debug"]) {
            print("Poppy Case Door Opened");
        }

        return true;
    }

    if (vars.inventorySize.Current > vars.inventorySize.Old) {
        // Add the item to the player inventory
        string newItemName = vars.GetInventorySlotDisplayName(vars.inventorySize - 1);

        if (String.IsNullOrEmpty(newItemName)) {
            if (settings["Debug"]) {
                print("Item Name string was empty! Current Inventory Size: " + vars.inventorySize);
            }
        } else if (!vars.currentInventory.Contains(newItemName)) { // We need to check that we aren't adding duplicates due to the level streaming issues
            switch (newItemName.ToLower()) {
                case "blue":
                case "red":
                case "green":
                case "yellow":
                    // Keep track of the number of keys picked up to avoid right hand splits happening before they possibly can
                    vars.storageKeyCount++;
                    break;
                case "vhssecurity":
                    if (!vars.hasPickedUpSecurityVhs) {
                        vars.hasPickedUpSecurityVhs = true;
                    } else {
                        newItemName = null;
                    }

                    break;
                case "vhslobby":
                    if (!vars.hasPickedUpLobbyVhs) {
                        vars.hasPickedUpLobbyVhs = true;
                    } else {
                        newItemName = null;
                    }

                    break;
                case "vhsstorage":
                    if (!vars.hasPickedUpStorageVhs) {
                        vars.hasPickedUpStorageVhs = true;
                    } else {
                        newItemName = null;
                    }

                    break;
                case "vhsmachine":
                    if (!vars.hasPickedUpMachineVhs) {
                        vars.hasPickedUpMachineVhs = true;
                    } else {
                        newItemName = null;
                    }

                    break;
                case "vhssilo":
                    if (!vars.hasPickedUpSiloVhs) {
                        vars.hasPickedUpSiloVhs = true;
                    } else {
                        newItemName = null;
                    }

                    break;
                case "scannerdoll":
                    if (!vars.hasPickedUpScannerDoll) {
                        vars.hasPickedUpScannerDoll = true;
                    } else {
                        newItemName = null;
                    }

                    break;
            }

            // Check if we picked up a valid item, or this is a level streaming bug
            if (!String.IsNullOrEmpty(newItemName)) {
                vars.currentInventory.Add(newItemName);

                // The player has picked something up, find out what it is and split based on display name
                if (vars.SplitOnInventoryPickup(newItemName)) {
                    return true;
                }
            }            
        }
    } else if (vars.inventorySize.Current < vars.inventorySize.Old) {
        // This is dumb, but I couldn't find valid fields for when the item placements happen so we just need to find what item was removed from inventory by name
        for (int currentInventoryIndex = 0; currentInventoryIndex < vars.currentInventory.Count; currentInventoryIndex++) {
            string currentInventorySlotName = vars.currentInventory[currentInventoryIndex];

            for (int checkSlotIndex = 0; checkSlotIndex < vars.inventorySlotCount; checkSlotIndex++) {
                string checkName = vars.GetInventorySlotDisplayName(checkSlotIndex);
                if (currentInventorySlotName == checkName) {
                    // This item is still in the inventory
                    break;
                }

                if (checkSlotIndex < vars.inventorySlotCount - 1) {
                    // We need to check every inventory slot
                    continue;
                }

                // Clean up the removed item
                vars.currentInventory.RemoveAt(currentInventoryIndex);

                // Make sure the inventory isn't getting messed up values during level streaming
                switch (currentInventorySlotName.ToLower()) {
                    case "vhssecurity":
                        if (vars.hasInsertedSecurityVhs) {
                            return false;
                        } 
                        
                        vars.hasInsertedSecurityVhs = true;
                        break;
                    case "vhslobby":
                        if (vars.hasInsertedLobbyVhs) {
                            return false;
                        } 
                        
                        vars.hasInsertedLobbyVhs = true;
                        break;
                    case "vhsstorage":
                        if (vars.hasInsertedStorageVhs) {
                            return false;
                        } 
                        
                        vars.hasInsertedStorageVhs = true;
                        break;
                    case "vhsmachine":
                        if (vars.hasInsertedMachineVhs) {
                            return false;
                        } 
                        
                        vars.hasInsertedMachineVhs = true;
                        break;
                    case "vhssilo":
                        if (vars.hasInsertedSiloVhs) {
                            return false;
                        } 
                    
                        vars.hasInsertedSiloVhs = true;
                        break;
                    case "scannerdoll":
                        if (vars.hasInsertedScannerDoll) {
                            return false;
                        } 
                        
                        vars.hasInsertedScannerDoll = true;
                        break;
                }

                Tuple<string, string> itemSettingsKeys;
                if (!vars.itemNames.TryGetValue(currentInventorySlotName.ToLower(), out itemSettingsKeys) 
                    || String.IsNullOrEmpty(itemSettingsKeys.Item2) || !settings[itemSettingsKeys.Item2]
                ) {
                    // Don't split if the item doesn't exist in the splittable items, or isn't enabled in the settings 
                    return false;
                }

                if (settings["Debug"]) {
                    print(itemSettingsKeys.Item2);
                }

                return true;
            }
        }
    }
}
