-- NeverLose — NoFog

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local NoFog = {}

function NoFog.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        if Config.NoFog then
            Lighting.FogStart = 1000000
            Lighting.FogEnd = 1000000
        end
    end))
end

function NoFog.Enable(Core)
    Lighting.FogStart = 1000000
    Lighting.FogEnd = 1000000
    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("Atmosphere") then
            Core.savedAtmosphere = {obj, obj.Density, obj.Offset}
            obj.Density = 0
            obj.Offset = 0
        end
    end
end

function NoFog.Disable(Core)
    Lighting.FogStart = Core.savedFog.FogStart
    Lighting.FogEnd = Core.savedFog.FogEnd
    Lighting.FogColor = Core.savedFog.FogColor
    if Core.savedAtmosphere then
        local obj = Core.savedAtmosphere[1]
        if obj and obj.Parent then
            obj.Density = Core.savedAtmosphere[2]
            obj.Offset = Core.savedAtmosphere[3]
        end
        Core.savedAtmosphere = nil
    end
end

return NoFog