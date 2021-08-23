GearMate = LibStub("AceAddon-3.0"):NewAddon("GearMate", "AceConsole-3.0", "AceEvent-3.0")

function GearMate:OnInitialize()
    GearMate:Print("Welcome to GearMate")
end

GearMate:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    for i = 1, 23 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            GearMate:Print(i .. ": " .. itemLink)
        end
    end
end)
