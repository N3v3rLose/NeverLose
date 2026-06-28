-- NeverLose — Hitbox Expander

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Hitbox = {}

function Hitbox.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local Connections = ENV.Connections
    local player = Players.LocalPlayer

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end

        local T = Theme.GetCurrent()

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if Config.HitboxEnabled then
                        local sz = Config.HitboxSize
                        hrp.Size = Vector3.new(sz, sz, sz)
                        hrp.Transparency = Config.HitboxVisible and Config.HitboxTransparency or 1
                        hrp.CanCollide = false
                        hrp.Material = Enum.Material.ForceField
                        hrp.Color = T.Accent
                    else
                        if hrp.Size ~= Vector3.new(2, 2, 1) then
                            hrp.Size = Vector3.new(2, 2, 1)
                            hrp.Transparency = 1
                        end
                    end
                end
            end
        end
    end))
end

function Hitbox.Reset()
    local player = Players.LocalPlayer
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
            end
        end
    end
end

return Hitbox