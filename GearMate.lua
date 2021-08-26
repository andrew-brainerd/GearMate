GearMate = LibStub("AceAddon-3.0"):NewAddon("GearMate", "AceConsole-3.0", "AceEvent-3.0")

function GearMate:SaveGear()
    name = GetUnitName("player", true)
    GearMate:Print("Saving gear for " .. name .. "...")

    local TempGear = {}
    TempGear[name] = {}

    for i = 1, 23 do
        local link = GetInventoryItemLink("player", i)
        local itemId = GetInventoryItemID("player", i)

        if itemId then
            local itemName, itemLink, itemRarity = GetItemInfo(link)
            GearMate:Print(itemId .. ": " .. itemLink)
            TempGear[name][i] = {
                itemSlot = i,
                itemId = itemId,
                itemName = itemName,
                itemRarity = itemRarity
            }
        end
    end

    GearLocker = TempGear
end

GearMate:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    name = GetUnitName("player", true)
    GearLocker = {}
    GearMate:Print("Welcome to GearMate " .. name .. "!")
    GearMate:SaveGear()
end)
