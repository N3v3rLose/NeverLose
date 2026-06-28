-- NeverLose — NoClip

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local NoClip = {}

function NoClip.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        if not Config.NoClip then return end

        local char = Players.LocalPlayer.Character
        if not char then return end

        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end
    end))
end

return NoClip