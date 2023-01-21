local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local player = game:GetService("Players").LocalPlayer
local request = http_request or request or syn and syn.request

local function GetServers()
    local res = request({
        Url = "https://games.roblox.com/v1/games/"
            .. game.PlaceId
            .. "/servers/Public?cursor=&sortOrder=Desc&excludeFullGames=true",
        Method = "GET",
    })

    return httpService:JSONDecode(res.Body).data, game.JobId
end

local function joinRandomServer()
    local servers, currentServer = GetServers()
    local num
    repeat
        num = math.random(1, #servers)
        local sus, d = pcall(function()
            if servers[num].id == currentServer then
                num = nil
            end
        end)
        if not sus then
            num = nil
            warn(d)
            break
        end
        task.wait()
    until num

    if not num then
        return
    end

    local work, no = pcall(function()
        teleportService:TeleportToPlaceInstance(game.PlaceId, servers[num].id, player)
    end)

    if not work then
        warn(no)
    end
end

local function joinServer(jobid)
    local work, no = pcall(function()
        teleportService:TeleportToPlaceInstance(game.PlaceId, jobid, player)
    end)

    if not work then
        warn(no)
    end
end

joinRandomServer()
