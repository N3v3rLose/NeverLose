-- NeverLose — Panic Mode

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local PanicModule = {}

function PanicModule.Activate(ENV)
    local Config = ENV.Config
    local Storage = ENV.Storage
    local Core = ENV.Core

    Config.Panic = true
    Storage.guiOpen = false
    Storage.MainFrame.Visible = false

    -- Сохранить состояния
    Storage.panicSavedStates = {}
    for name, elem in pairs(Storage.allElements) do
        if elem.getValue then
            Storage.panicSavedStates[name] = elem.getValue()
            if elem.getValue() then
                elem.setValue(false)
            end
        end
    end

    local char = Players.LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Anchored = false
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end

    Lighting.Ambient = Core.originalAmbient
    Lighting.Brightness = Core.originalBrightness
    Lighting.FogStart = Core.savedFog.FogStart
    Lighting.FogEnd = Core.savedFog.FogEnd

    for _, o in pairs(Storage.espObjects) do
        if o and o.Parent then o:Destroy() end
    end
    Storage.espObjects = {}
    for _, line in pairs(Storage.tracerLines) do
        if line then line:Remove() end
    end
    Storage.tracerLines = {}

    if ENV.Hitbox then ENV.Hitbox.Reset() end

    Storage.isSprinting = false
    Storage.flying = false
end

function PanicModule.Deactivate(ENV)
    local Config = ENV.Config
    local Storage = ENV.Storage

    Config.Panic = false

    for name, val in pairs(Storage.panicSavedStates) do
        local elem = Storage.allElements[name]
        if elem and elem.setValue and val then
            elem.setValue(true)
        end
    end
    Storage.panicSavedStates = {}
end

function PanicModule.Init(ENV)
    -- Обработка через input handler в ui/init.lua
end

return PanicModule