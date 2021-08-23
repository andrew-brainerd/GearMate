GearMate = LibStub("AceAddon-3.0"):NewAddon("GearMate", "AceConsole-3.0", "AceEvent-3.0")

function GearMate:OnInitialize()
    GearLocker = {}
    GearMate:Print("Welcome to GearMate")
    GearMate:SaveGear()
    GearMate:PrintGear()
end

function GearMate:PrintGear()
    name = GetUnitName("player", true)

    GearMate:Print("Gear for " .. name)
    GearMate:Print("--------------------")

    for i = 1, 23 do
        local itemLink = GetInventoryItemLink("player", i)
        local itemId = GetInventoryItemID("player", i)

        if itemLink then 
            GearMate:Print(itemId .. ": " .. itemLink)
        end
    end
end

function GearMate:SaveGear()
    GearMate:Print("Saving gear...")
    name = GetUnitName("player", true)

    GearLocker[name] = {}

    for i = 1, 23 do
        local link = GetInventoryItemLink("player", i)
        local itemId = GetInventoryItemID("player", i)
        local itemName, itemLink, itemRarity = GetItemInfo(link)

        if itemId then
            GearLocker[name][i] = {
                itemSlot = i,
                itemId = itemId,
                itemName = itemName,
                itemRarity = itemRarity
            }
        end
    end
end

GearMate:RegisterEvent("PLAYER_LOGOUT", function()
    GearMate:SaveGear()
end)
