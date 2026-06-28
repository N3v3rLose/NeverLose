-- NeverLose — Theme Tab

return function(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local B = ENV.UIBuilder

    local RunService = game:GetService("RunService")
    local T = Theme.GetCurrent()
    local tab = B.CreateTabContent(Storage, "theme")

    B.CreateSectionHeader(tab, "preset themes", 1, Storage, Theme)

    local themeNames = {"crimson", "ocean", "purple", "emerald", "rose", "midnight"}

    for i, themeName in ipairs(themeNames) do
        local tData = Theme.Themes[themeName]
        local tFrame = Instance.new("Frame")
        tFrame.Size = UDim2.new(1, 0, 0, 36)
        tFrame.BackgroundColor3 = T.Surface
        tFrame.BackgroundTransparency = 0
        tFrame.BorderSizePixel = 0
        tFrame.LayoutOrder = 1 + i
        tFrame.Parent = tab
        Instance.new("UICorner", tFrame).CornerRadius = UDim.new(0, 6)

        -- Color dots
        local dot1 = Instance.new("Frame")
        dot1.Size = UDim2.new(0, 14, 0, 14)
        dot1.Position = UDim2.new(0, 12, 0.5, -7)
        dot1.BackgroundColor3 = tData.Accent
        dot1.BorderSizePixel = 0
        dot1.Parent = tFrame
        Instance.new("UICorner", dot1).CornerRadius = UDim.new(1, 0)

        local tName = Instance.new("TextLabel")
        tName.Size = UDim2.new(0.5, 0, 1, 0)
        tName.Position = UDim2.new(0, 34, 0, 0)
        tName.BackgroundTransparency = 1
        tName.Text = themeName
        tName.TextColor3 = T.TextSecondary
        tName.TextSize = 12
        tName.Font = Enum.Font.GothamSemibold
        tName.TextXAlignment = Enum.TextXAlignment.Left
        tName.Parent = tFrame

        local applyBtn = Instance.new("TextButton")
        applyBtn.Size = UDim2.new(0, 60, 0, 22)
        applyBtn.Position = UDim2.new(1, -68, 0.5, -11)
        applyBtn.BackgroundColor3 = tData.Accent
        applyBtn.BackgroundTransparency = 0.15
        applyBtn.BorderSizePixel = 0
        applyBtn.Text = Theme.currentThemeName == themeName and "active" or "apply"
        applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        applyBtn.TextSize = 10
        applyBtn.Font = Enum.Font.GothamBold
        applyBtn.AutoButtonColor = false
        applyBtn.Parent = tFrame
        Instance.new("UICorner", applyBtn).CornerRadius = UDim.new(0, 4)

        applyBtn.MouseButton1Click:Connect(function()
            Theme.currentThemeName = themeName
            Theme.CustomTheme.UseCustom = false
            Theme.ApplyTheme(Storage)

            for _, child in pairs(tab:GetDescendants()) do
                if child:IsA("TextButton") and (child.Text == "active" or child.Text == "apply") then
                    child.Text = "apply"
                end
            end
            applyBtn.Text = "active"
        end)
    end

    B.CreateSeparator(tab, 20)
    B.CreateSectionHeader(tab, "custom accent", 21, Storage, Theme)

    B.CreateSlider(tab, "accent red", 0, 255, 180, 22, function(v) Theme.CustomTheme.AccentR = v end, Storage, Theme)
    B.CreateSlider(tab, "accent green", 0, 255, 50, 23, function(v) Theme.CustomTheme.AccentG = v end, Storage, Theme)
    B.CreateSlider(tab, "accent blue", 0, 255, 50, 24, function(v) Theme.CustomTheme.AccentB = v end, Storage, Theme)

    B.CreateButton(tab, "apply custom accent", 25, function()
        Theme.CustomTheme.UseCustom = true
        Theme.ApplyTheme(Storage)
    end, Storage, Theme)
end