-- NeverLose — Unload

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local Unload = {}

function Unload.Do(ENV)
    local Config = ENV.Config
    local Storage = ENV.Storage
    local Core = ENV.Core
    local Connections = ENV.Connections

    Storage.isSprinting = false
    Storage.flying = false
    Storage.noclipping = false
    Config.Panic = false

    local char = Players.LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
    end

    Lighting.Ambient = Core.originalAmbient
    Lighting.Brightness = Core.originalBrightness
    Lighting.FogStart = Core.savedFog.FogStart
    Lighting.FogEnd = Core.savedFog.FogEnd
    Lighting.FogColor = Core.savedFog.FogColor

    if Core.savedAtmosphere then
        local obj = Core.savedAtmosphere[1]
        if obj and obj.Parent then
            obj.Density = Core.savedAtmosphere[2]
            obj.Offset = Core.savedAtmosphere[3]
        end
    end

    for _, o in pairs(Storage.espObjects) do
        if o and o.Parent then o:Destroy() end
    end
    for _, line in pairs(Storage.tracerLines) do
        if line then line:Remove() end
    end

    if ENV.Hitbox then ENV.Hitbox.Reset() end

    Connections.DisconnectAll(Storage)

    Storage.ScreenGui:Destroy()
    print("[NeverLose] unloaded")
end

return Unload