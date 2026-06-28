-- NeverLose — Visual Tab

return function(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local B = ENV.UIBuilder
    local Core = ENV.Core

    local tab = B.CreateTabContent(Storage, "visual")

    B.CreateSectionHeader(tab, "esp", 1, Storage, Theme)

    B.CreateToggle(tab, "esp enabled", false, 2, true, function(v)
        Config.ESPEnabled = v
        for _, name in ipairs({"esp mode", "esp names", "esp distance", "esp health", "esp friends"}) do
            if Storage.allElements[name] then Storage.allElements[name].setLocked(not v) end
        end
        if not v then
            for _, o in pairs(Storage.espObjects) do
                if o and o.Parent then o:Destroy() end
            end
            Storage.espObjects = {}
        end
    end, Storage, Theme, Config)

    B.CreateDropdown(tab, "esp mode", {"outline", "box", "glow"}, "outline", 3, function(v)
        Config.ESPMode = v
    end, Storage, Theme)

    B.CreateToggle(tab, "esp names", false, 4, false, function(v) Config.ESPNames = v end, Storage, Theme, Config)
    B.CreateToggle(tab, "esp distance", false, 5, false, function(v) Config.ESPDistance = v end, Storage, Theme, Config)
    B.CreateToggle(tab, "esp health", false, 6, false, function(v) Config.ESPHealth = v end, Storage, Theme, Config)
    B.CreateToggle(tab, "esp friends", false, 7, false, function(v) Config.ESPFriends = v end, Storage, Theme, Config)

    B.CreateSeparator(tab, 8)
    B.CreateSectionHeader(tab, "tracers", 9, Storage, Theme)

    B.CreateToggle(tab, "tracers", false, 10, true, function(v)
        Config.Tracers = v
        if Storage.allElements["tracers friends"] then Storage.allElements["tracers friends"].setLocked(not v) end
        if not v then
            for _, line in pairs(Storage.tracerLines) do
                if line then line:Remove() end
            end
            Storage.tracerLines = {}
        end
    end, Storage, Theme, Config)

    B.CreateToggle(tab, "tracers friends", false, 11, false, function(v)
        Config.TracersFriends = v
    end, Storage, Theme, Config)

    B.CreateSeparator(tab, 12)
    B.CreateSectionHeader(tab, "world", 13, Storage, Theme)

    B.CreateToggle(tab, "fullbright", false, 14, true, function(v)
        Config.Fullbright = v
        if v then
            ENV.Fullbright.Enable()
        else
            ENV.Fullbright.Disable(Core)
        end
    end, Storage, Theme, Config)

    B.CreateToggle(tab, "no fog", false, 15, false, function(v)
        Config.NoFog = v
        if v then
            ENV.NoFog.Enable(Core)
        else
            ENV.NoFog.Disable(Core)
        end
    end, Storage, Theme, Config)

    task.defer(function()
        for _, name in ipairs({"esp mode", "esp names", "esp distance", "esp health", "esp friends", "tracers friends"}) do
            if Storage.allElements[name] then Storage.allElements[name].setLocked(true) end
        end
    end)
end