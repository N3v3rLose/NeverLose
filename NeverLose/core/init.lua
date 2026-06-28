-- NeverLose — Core Init

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

local Core = {}

Core.originalAmbient = Lighting.Ambient
Core.originalBrightness = Lighting.Brightness
Core.savedFog = {
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    FogColor = Lighting.FogColor,
}
Core.savedAtmosphere = nil

Core.player = Players.LocalPlayer
Core.mouse = Core.player:GetMouse()
Core.camera = workspace.CurrentCamera

function Core.Start(ENV)
    ENV.Storage.ENV = ENV

    -- Удалить старый GUI
    if Core.player.PlayerGui:FindFirstChild("NeverLoseGUI") then
        Core.player.PlayerGui.NeverLoseGUI:Destroy()
    end

    -- Создать GUI
    ENV.UI.Create(ENV)

    -- Инициализировать модули
    if ENV.Sprint and ENV.Sprint.Init then ENV.Sprint.Init(ENV) end
    if ENV.Jump and ENV.Jump.Init then ENV.Jump.Init(ENV) end
    if ENV.NoClip and ENV.NoClip.Init then ENV.NoClip.Init(ENV) end
    if ENV.Fly and ENV.Fly.Init then ENV.Fly.Init(ENV) end
    if ENV.Glide and ENV.Glide.Init then ENV.Glide.Init(ENV) end
    if ENV.ESP and ENV.ESP.Init then ENV.ESP.Init(ENV) end
    if ENV.Tracers and ENV.Tracers.Init then ENV.Tracers.Init(ENV) end
    if ENV.Fullbright and ENV.Fullbright.Init then ENV.Fullbright.Init(ENV) end
    if ENV.NoFog and ENV.NoFog.Init then ENV.NoFog.Init(ENV) end
    if ENV.FakeLag and ENV.FakeLag.Init then ENV.FakeLag.Init(ENV) end
    if ENV.Hitbox and ENV.Hitbox.Init then ENV.Hitbox.Init(ENV) end
    if ENV.Teleport and ENV.Teleport.Init then ENV.Teleport.Init(ENV) end
    if ENV.AntiAFK and ENV.AntiAFK.Init then ENV.AntiAFK.Init(ENV) end
    if ENV.Panic and ENV.Panic.Init then ENV.Panic.Init(ENV) end

    -- Input handler
    ENV.UI.InitInput(ENV)

    -- Respawn handler
    local Connections = ENV.Connections
    Connections.Add(ENV.Storage, Core.player.CharacterAdded:Connect(function()
        task.wait(0.5)
        if ENV.Fly and ENV.Fly.OnRespawn then ENV.Fly.OnRespawn(ENV) end
    end))
end

return Core