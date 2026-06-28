-- NeverLose — Rejoin

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

local Rejoin = {}

function Rejoin.Do()
    TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
end

return Rejoin