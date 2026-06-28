-- NeverLose Local Loader для Xeno
-- Запускай этот файл

local folder = "NeverLose"

local function load(path)
    local fullpath = folder .. "/" .. path .. ".lua"
    
    if not isfile(fullpath) then
        warn("[NeverLose] File not found: " .. fullpath)
        return nil
    end

    local success, result = pcall(function()
        local content = readfile(fullpath)
        return loadstring(content, "@" .. fullpath)()
    end)
    
    if not success then
        warn("[NeverLose] Failed to load: " .. fullpath)
        warn("Error: " .. tostring(result))
        return nil
    end
    return result
end

print("[NeverLose] Starting local modular load...")

-- Core
local Storage      = load("core/storage")
local Config       = load("core/config")
local Theme        = load("core/theme")
local Connections  = load("core/connections")
local Core         = load("core/init")

local ENV = {
    Storage = Storage,
    Config = Config,
    Theme = Theme,
    Connections = Connections,
    Core = Core,
    Load = load,
}

-- UI
ENV.UIBuilder    = load("ui/builder")
ENV.UIDrag       = load("ui/drag")
ENV.UITabs       = load("ui/tabs")
ENV.UIAnimations = load("ui/animations")
ENV.UI           = load("ui/init")

-- Movement
ENV.Sprint = load("movement/sprint")
ENV.Jump   = load("movement/jump")
ENV.NoClip = load("movement/noclip")
ENV.Fly    = load("movement/fly")
ENV.Glide  = load("movement/glide")

-- Render
ENV.ESP        = load("render/esp")
ENV.Tracers    = load("render/tracers")
ENV.Fullbright = load("render/fullbright")
ENV.NoFog      = load("render/nofog")

-- Combat
ENV.FakeLag = load("combat/fakelag")
ENV.Hitbox  = load("combat/hitbox")

-- Misc
ENV.Teleport  = load("misc/teleport")
ENV.Waypoints = load("misc/waypoints")
ENV.AntiAFK   = load("misc/antiafk")
ENV.Rejoin    = load("misc/rejoin")

-- Menu
ENV.Panic  = load("menu/panic")
ENV.Unload = load("menu/unload")
ENV.Info   = load("menu/info")

-- Tabs
load("tabs/movement_tab")
load("tabs/visual_tab")
load("tabs/combat_tab")
load("tabs/other_tab")
load("tabs/misc_tab")
load("tabs/theme_tab")
load("tabs/menu_tab")

-- Запуск
if Core and Core.Start then
    Core.Start(ENV)
end

print("[NeverLose] v0.0.5 loaded successfully (Local Mode)")
print("[NeverLose] Press RightShift to open the menu")