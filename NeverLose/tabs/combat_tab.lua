-- NeverLose — Combat Tab

return function(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local B = ENV.UIBuilder

    local T = Theme.GetCurrent()
    local tab = B.CreateTabContent(Storage, "combat")

    B.CreateSectionHeader(tab, "fake lag", 1, Storage, Theme)

    B.CreateToggle(tab, "fake lag", false, 2, true, function(v)
        Config.FakeLagEnabled = v
        local deps = {"lag mode", "lag interval", "lag duration", "lag intensity", "visual indicator", "desync", "on key hold", "first person smooth"}
        for _, name in ipairs(deps) do
            if Storage.allElements[name] then Storage.allElements[name].setLocked(not v) end
        end

        if not v then
            local char = game.Players.LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Anchored = false end
            end
        end
    end, Storage, Theme, Config)

    B.CreateDropdown(tab, "lag mode", {"pulse", "random", "adaptive", "stutter", "constant"}, "pulse", 3, function(v)
        Config.FakeLagMode = v
    end, Storage, Theme)

    B.CreateSlider(tab, "lag interval", 50, 1000, 200, 4, function(v) Config.FakeLagInterval = v end, Storage, Theme)
    B.CreateSlider(tab, "lag duration", 50, 2000, 500, 5, function(v) Config.FakeLagDuration = v end, Storage, Theme)
    B.CreateSlider(tab, "lag intensity", 10, 100, 80, 6, function(v) Config.FakeLagIntensity = v end, Storage, Theme)

    B.CreateToggle(tab, "visual indicator", true, 7, false, function(v)
        Config.FakeLagVisual = v
    end, Storage, Theme, Config)

    B.CreateToggle(tab, "desync", false, 8, false, function(v)
        Config.FakeLagDesync = v
    end, Storage, Theme, Config)

    B.CreateToggle(tab, "on key hold", false, 9, false, function(v)
        Config.FakeLagOnKey = v
    end, Storage, Theme, Config)

    -- === НОВАЯ ОПЦИЯ: First Person Smooth ===
    B.CreateToggle(tab, "first person smooth", true, 10, false, function(v)
        Config.FakeLagFirstPerson = v
    end, Storage, Theme, Config)

    local fpInfo = Instance.new("TextLabel")
    fpInfo.Size = UDim2.new(1, 0, 0, 28)
    fpInfo.BackgroundTransparency = 1
    fpInfo.Text = "   when on: you move smooth, others see lag\n   when off: you also see your own lag"
    fpInfo.TextColor3 = T.TextDim
    fpInfo.TextSize = 10
    fpInfo.Font = Enum.Font.Gotham
    fpInfo.TextXAlignment = Enum.TextXAlignment.Left
    fpInfo.TextYAlignment = Enum.TextYAlignment.Top
    fpInfo.LayoutOrder = 11
    fpInfo.Parent = tab

    B.CreateSeparator(tab, 12)
    B.CreateSectionHeader(tab, "hitbox expander", 13, Storage, Theme)

    B.CreateToggle(tab, "hitbox", false, 14, true, function(v)
        Config.HitboxEnabled = v
        for _, name in ipairs({"hitbox size", "hitbox transparency", "hitbox visible"}) do
            if Storage.allElements[name] then Storage.allElements[name].setLocked(not v) end
        end
        if not v and ENV.Hitbox then ENV.Hitbox.Reset() end
    end, Storage, Theme, Config)

    B.CreateSlider(tab, "hitbox size", 2, 30, 10, 15, function(v) Config.HitboxSize = v end, Storage, Theme)
    B.CreateSlider(tab, "hitbox transparency", 0, 100, 70, 16, function(v) Config.HitboxTransparency = v / 100 end, Storage, Theme)

    B.CreateToggle(tab, "hitbox visible", true, 17, false, function(v)
        Config.HitboxVisible = v
    end, Storage, Theme, Config)

    -- Lock defaults
    task.defer(function()
        local deps = {"lag mode", "lag interval", "lag duration", "lag intensity", "visual indicator", "desync", "on key hold", "first person smooth", "hitbox size", "hitbox transparency", "hitbox visible"}
        for _, name in ipairs(deps) do
            if Storage.allElements[name] then Storage.allElements[name].setLocked(true) end
        end
    end)
end