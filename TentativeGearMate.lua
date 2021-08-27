TentativeGearMate = LibStub("AceAddon-3.0"):NewAddon("<Tentative> GearMate", "AceConsole-3.0", "AceEvent-3.0")

function TentativeGearMate:SaveGear()
    TentativeGearMate:Print("Saving Gear Data")

    local playerName = GetUnitName("player", true)
    local characterClass = UnitClass("player")
    local TempGear = {}

    TempGear[playerName] = {
        characterClass = characterClass
    }

    TempGear[playerName]["gear"] = {}

    for i = 1, 23 do
        local link = GetInventoryItemLink("player", i)
        local itemId = GetInventoryItemID("player", i)

        if itemId then
            local itemName, itemLink, itemRarity = GetItemInfo(link)

            TempGear[playerName]["gear"][i] = {
                itemSlot = i,
                itemId = itemId,
                itemName = itemName,
                itemRarity = itemRarity
            }
        end
    end

    GearLocker = TempGear
end

TentativeGearMate:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    GearLocker = {}
    TentativeGearMate:SaveGear()
end)
