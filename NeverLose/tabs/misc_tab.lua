-- NeverLose — Misc Tab

return function(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local B = ENV.UIBuilder
    local Teleport = ENV.Teleport
    local Rejoin = ENV.Rejoin

    local T = Theme.GetCurrent()
    local tab = B.CreateTabContent(Storage, "misc")

    B.CreateSectionHeader(tab, "player teleport", 1, Storage, Theme)

    local playerDropdown = B.CreatePlayerDropdown(tab, "target player", 2, Storage, Theme)

    local tpBtnFrame = Instance.new("Frame")
    tpBtnFrame.Size = UDim2.new(1, 0, 0, 40)
    tpBtnFrame.BackgroundTransparency = 1
    tpBtnFrame.BorderSizePixel = 0
    tpBtnFrame.LayoutOrder = 3
    tpBtnFrame.Parent = tab

    local tpBtn = Instance.new("TextButton")
    tpBtn.Size = UDim2.new(0, 150, 0, 30)
    tpBtn.Position = UDim2.new(0, 0, 0, 4)
    tpBtn.BackgroundColor3 = T.Accent
    tpBtn.BackgroundTransparency = 0.1
    tpBtn.BorderSizePixel = 0
    tpBtn.Text = "teleport to player"
    tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpBtn.TextSize = 12
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.AutoButtonColor = false
    tpBtn.Parent = tpBtnFrame
    Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)

    local tpStatus = Instance.new("TextLabel")
    tpStatus.Size = UDim2.new(0, 200, 0, 30)
    tpStatus.Position = UDim2.new(0, 160, 0, 4)
    tpStatus.BackgroundTransparency = 1
    tpStatus.Text = ""
    tpStatus.TextColor3 = T.TextDim
    tpStatus.TextSize = 10
    tpStatus.Font = Enum.Font.Gotham
    tpStatus.TextXAlignment = Enum.TextXAlignment.Left
    tpStatus.Parent = tpBtnFrame

    tpBtn.MouseButton1Click:Connect(function()
        local targetName = playerDropdown.getSelected()
        if not targetName then
            tpStatus.Text = "no player selected"
            tpStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.delay(2, function() tpStatus.Text = "" end)
            return
        end
        local ok, msg = Teleport.ToPlayer(targetName)
        tpStatus.Text = msg
        tpStatus.TextColor3 = ok and T.Success or Color3.fromRGB(255, 100, 100)
        task.delay(2, function() tpStatus.Text = "" end)
    end)

    B.CreateSeparator(tab, 4)
    B.CreateSectionHeader(tab, "utility", 5, Storage, Theme)

    B.CreateToggle(tab, "anti afk", false, 6, false, function(v) Config.AntiAFK = v end, Storage, Theme, Config)

    B.CreateSeparator(tab, 7)
    B.CreateSectionHeader(tab, "server", 8, Storage, Theme)

    B.CreateButton(tab, "rejoin server", 9, function()
        Rejoin.Do()
    end, Storage, Theme)
end