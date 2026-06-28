-- NeverLose — Fullbright

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Fullbright = {}

function Fullbright.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Core = ENV.Core
    local Connections = ENV.Connections

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        if Config.Fullbright then
            Lighting.Ambient = Color3.fromRGB(200, 200, 200)
            Lighting.Brightness = 2
        end
    end))
end

function Fullbright.Enable()
    local Lighting = game:GetService("Lighting")
    Lighting.Ambient = Color3.fromRGB(200, 200, 200)
    Lighting.Brightness = 2
end

function Fullbright.Disable(Core)
    local Lighting = game:GetService("Lighting")
    Lighting.Ambient = Core.originalAmbient
    Lighting.Brightness = Core.originalBrightness
end

return Fullbright