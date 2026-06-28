-- NeverLose — Movement Tab

return function(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local B = ENV.UIBuilder
    local Fly = ENV.Fly

    local tab = B.CreateTabContent(Storage, "movement")

    B.CreateSectionHeader(tab, "sprint", 1, Storage, Theme)

    B.CreateToggle(tab, "sprint enabled", false, 2, true, function(val)
        Config.SprintEnabled = val
        Storage.allElements["walk speed"].setLocked(not val)
        Storage.allElements["sprint speed"].setLocked(not val)
        Storage.allElements["toggle sprint"].setLocked(not val)
        if not val then Storage.isSprinting = false end
    end, Storage, Theme, Config)

    B.CreateSlider(tab, "walk speed", 0, 100, 16, 3, function(v) Config.WalkSpeed = v end, Storage, Theme)
    B.CreateSlider(tab, "sprint speed", 0, 200, 35, 4, function(v) Config.SprintSpeed = v end, Storage, Theme)
    B.CreateToggle(tab, "toggle sprint", false, 5, false, function(v)
        Config.ToggleMode = v
        if not v then Storage.isSprinting = false end
    end, Storage, Theme, Config)

    B.CreateSeparator(tab, 6)
    B.CreateSectionHeader(tab, "jump", 7, Storage, Theme)

    B.CreateToggle(tab, "infinite jump", false, 8, true, function(v)
        Config.InfiniteJump = v
        Storage.allElements["jump power"].setLocked(not v)
    end, Storage, Theme, Config)

    B.CreateSlider(tab, "jump power", 0, 200, 50, 9, function(v) Config.JumpPower = v end, Storage, Theme)

    B.CreateToggle(tab, "double jump", false, 10, false, function(v)
        Config.DoubleJump = v
    end, Storage, Theme, Config)

    B.CreateToggle(tab, "air jump", false, 11, true, function(v)
        Config.AirJump = v
    end, Storage, Theme, Config)

    B.CreateSeparator(tab, 12)
    B.CreateSectionHeader(tab, "long jump", 13, Storage, Theme)

    B.CreateToggle(tab, "long jump", false, 14, true, function(v)
        Config.LongJump = v
        Storage.allElements["long jump force"].setLocked(not v)
    end, Storage, Theme, Config)

    B.CreateSlider(tab, "long jump force", 10, 150, 50, 15, function(v) Config.LongJumpForce = v end, Storage, Theme)

    B.CreateSeparator(tab, 16)
    B.CreateSectionHeader(tab, "noclip", 17, Storage, Theme)

    B.CreateToggle(tab, "noclip", false, 18, true, function(v)
        Config.NoClip = v
        Storage.allElements["noclip speed"].setLocked(not v)
    end, Storage, Theme, Config)

    B.CreateSlider(tab, "noclip speed", 0, 200, 50, 19, function(v) Config.NoClipSpeed = v end, Storage, Theme)

    B.CreateSeparator(tab, 20)
    B.CreateSectionHeader(tab, "fly", 21, Storage, Theme)

    B.CreateToggle(tab, "fly enabled", false, 22, true, function(v)
        Config.FlyEnabled = v
        Storage.flying = v
        Storage.allElements["fly speed"].setLocked(not v)
        if v then
            Fly.Enable(ENV)
        else
            Fly.Disable(ENV)
        end
    end, Storage, Theme, Config)

    B.CreateSlider(tab, "fly speed", 0, 200, 50, 23, function(v) Config.FlySpeed = v end, Storage, Theme)

    B.CreateSeparator(tab, 24)
    B.CreateSectionHeader(tab, "glide", 25, Storage, Theme)

    B.CreateToggle(tab, "glide", false, 26, true, function(v)
        Config.GlideEnabled = v
        Storage.allElements["glide speed"].setLocked(not v)
    end, Storage, Theme, Config)

    B.CreateSlider(tab, "glide speed", 5, 100, 30, 27, function(v) Config.GlideSpeed = v end, Storage, Theme)

    -- Lock defaults
    task.defer(function()
        Storage.allElements["walk speed"].setLocked(true)
        Storage.allElements["sprint speed"].setLocked(true)
        Storage.allElements["toggle sprint"].setLocked(true)
        Storage.allElements["jump power"].setLocked(true)
        Storage.allElements["long jump force"].setLocked(true)
        Storage.allElements["noclip speed"].setLocked(true)
        Storage.allElements["fly speed"].setLocked(true)
        Storage.allElements["glide speed"].setLocked(true)
    end)
end