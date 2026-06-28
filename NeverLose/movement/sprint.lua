-- NeverLose — Sprint

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Sprint = {}

function Sprint.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        local char = Players.LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        if Config.SprintEnabled then
            hum.WalkSpeed = Storage.isSprinting and Config.SprintSpeed or Config.WalkSpeed
        end
    end))
end

return Sprint