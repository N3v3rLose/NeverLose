-- NeverLose GitHub Loader v0.0.5
-- by N3v3rLose

local baseUrl = "https://raw.githubusercontent.com/N3v3rLose/NeverLose/main/NeverLose/"

local function load(path)
    local url = baseUrl .. path .. ".lua"
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success or content:find("404") then
        warn("[NeverLose] File not found: " .. path)
        return nil
    end

    local ok, result = pcall(function()
        return loadstring(content, "@" .. path)()
    end)
    
    if not ok then
        warn("[NeverLose] Failed to load: " .. path)
        warn("Error: " .. tostring(result))
        return nil
    end
    return result
end

print("[NeverLose] Starting cloud modular load...")

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

print("[NeverLose] v0.0.5 loaded successfully (Cloud Mode)")
print("[NeverLose] Press RightShift to open the menu")
