TentativeGearMate = LibStub("AceAddon-3.0"):NewAddon("<Tentative> GearMate", "AceConsole-3.0", "AceEvent-3.0")

lastUpdateTime = nil

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

function TentativeGearMate:ShouldUpdateGear()
    return lastUpdateTime == nil or time() - lastUpdateTime > 1000
end

TentativeGearMate:RegisterEvent("GUILD_ROSTER_UPDATE", function()
    local guildName = GetGuildInfo("player")

    if (guildName == "Tentative" and TentativeGearMate:ShouldUpdateGear()) then
        TentativeGearMate:SaveGear()
    end
end)
