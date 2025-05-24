-- Server Hop Script
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local PlaceId = game.PlaceId
local LocalServerId = game.JobId

local function serverHop()
    local cursor = ""
    local foundServer = false

    while not foundServer do
        local url = "https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Desc&limit=100"..(cursor ~= "" and "&cursor="..cursor or "")
        local response = HttpService:GetAsync(url)
        local data = HttpService:JSONDecode(response)

        for _, server in ipairs(data.data) do
            if server.playing < server.maxPlayers and server.id ~= LocalServerId then
                TeleportService:TeleportToPlaceInstance(PlaceId, server.id, Players.LocalPlayer)
                foundServer = true
                break
            end
        end

        cursor = data.nextPageCursor
        if not cursor then break end
        wait(1)
    end
end

-- Example: Server hop instantly. You could also bind this to a key or button.
serverHop()
