-- NeverLose — Menu Tab

return function(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local B = ENV.UIBuilder
    local InfoModule = ENV.Info
    local PanicModule = ENV.Panic
    local UnloadModule = ENV.Unload

    local T = Theme.GetCurrent()
    local tab = B.CreateTabContent(Storage, "menu")

    B.CreateSectionHeader(tab, "cheat control", 1, Storage, Theme)

    -- Unload
    B.CreateButton(tab, "UNLOAD CHEAT", 2, function()
        UnloadModule.Do(ENV)
    end, Storage, Theme)

    B.CreateSeparator(tab, 3)

    -- Panic
    B.CreateButton(tab, "PANIC MODE (RShift+RCtrl+H to restore)", 4, function()
        PanicModule.Activate(ENV)
    end, Storage, Theme)

    B.CreateSeparator(tab, 5)

    -- Reset
    B.CreateButton(tab, "Reset All Settings", 6, function()
        for name, elem in pairs(Storage.allElements) do
            if elem.setValue then elem.setValue(false) end
        end
    end, Storage, Theme)

    B.CreateSeparator(tab, 7)
    B.CreateSectionHeader(tab, "info", 8, Storage, Theme)

    -- Version info
    local verFrame = Instance.new("Frame")
    verFrame.Size = UDim2.new(1, 0, 0, 40)
    verFrame.BackgroundColor3 = T.Surface
    verFrame.BackgroundTransparency = 0
    verFrame.BorderSizePixel = 0
    verFrame.LayoutOrder = 9
    verFrame.Parent = tab
    Instance.new("UICorner", verFrame).CornerRadius = UDim.new(0, 6)

    local verLabel = Instance.new("TextLabel")
    verLabel.Size = UDim2.new(1, -20, 1, 0)
    verLabel.Position = UDim2.new(0, 12, 0, 0)
    verLabel.BackgroundTransparency = 1
    verLabel.Text = InfoModule.Name .. "  —  " .. InfoModule.Version
    verLabel.TextColor3 = T.TextPrimary
    verLabel.TextSize = 13
    verLabel.Font = Enum.Font.GothamBold
    verLabel.TextXAlignment = Enum.TextXAlignment.Left
    verLabel.Parent = verFrame

    B.CreateSeparator(tab, 10)
    B.CreateSectionHeader(tab, "changelog", 11, Storage, Theme)

    local changelogFrame = Instance.new("Frame")
    changelogFrame.Size = UDim2.new(1, 0, 0, 140)
    changelogFrame.BackgroundColor3 = T.Surface
    changelogFrame.BackgroundTransparency = 0
    changelogFrame.BorderSizePixel = 0
    changelogFrame.LayoutOrder = 12
    changelogFrame.Parent = tab
    Instance.new("UICorner", changelogFrame).CornerRadius = UDim.new(0, 6)

    local changelogText = Instance.new("TextLabel")
    changelogText.Size = UDim2.new(1, -20, 1, -12)
    changelogText.Position = UDim2.new(0, 12, 0, 6)
    changelogText.BackgroundTransparency = 1
    changelogText.Text = InfoModule.Changelog
    changelogText.TextColor3 = T.TextDim
    changelogText.TextSize = 10
    changelogText.Font = Enum.Font.Gotham
    changelogText.TextXAlignment = Enum.TextXAlignment.Left
    changelogText.TextYAlignment = Enum.TextYAlignment.Top
    changelogText.TextWrapped = true
    changelogText.Parent = changelogFrame
end