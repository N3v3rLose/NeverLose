-- NeverLose — Tab System

local TweenService = game:GetService("TweenService")

local Tabs = {}

function Tabs.CreateTab(name, icon, order, Storage, Theme)
    local T = Theme.GetCurrent()

    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = "Tab_" .. name
    tabBtn.Size = UDim2.new(1, 0, 0, 34)
    tabBtn.BackgroundColor3 = (name == Storage.currentTab) and T.SurfaceAlt or T.BackgroundAlt
    tabBtn.BackgroundTransparency = 0
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = ""
    tabBtn.AutoButtonColor = false
    tabBtn.LayoutOrder = order
    tabBtn.Parent = Storage.TabHolder
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

    local ind = Instance.new("Frame")
    ind.Name = "Indicator"
    ind.Size = UDim2.new(0, 3, 0.6, 0)
    ind.Position = UDim2.new(0, 2, 0.2, 0)
    ind.BackgroundColor3 = T.Accent
    ind.BorderSizePixel = 0
    ind.Visible = (name == Storage.currentTab)
    ind.Parent = tabBtn
    Instance.new("UICorner", ind).CornerRadius = UDim.new(0, 2)

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 20, 1, 0)
    ico.Position = UDim2.new(0, 14, 0, 0)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextColor3 = (name == Storage.currentTab) and T.Accent or T.TextDim
    ico.TextSize = 14
    ico.Font = Enum.Font.GothamBold
    ico.TextXAlignment = Enum.TextXAlignment.Left
    ico.Parent = tabBtn

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -40, 1, 0)
    lbl.Position = UDim2.new(0, 36, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = name
    lbl.TextColor3 = (name == Storage.currentTab) and T.TextPrimary or T.TextSecondary
    lbl.TextSize = 12
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = tabBtn

    Storage.tabButtons[name] = {btn = tabBtn, indicator = ind, icon = ico, label = lbl}

    tabBtn.MouseEnter:Connect(function()
        if name ~= Storage.currentTab then
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = T.Surface}):Play()
        end
    end)
    tabBtn.MouseLeave:Connect(function()
        if name ~= Storage.currentTab then
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = T.BackgroundAlt}):Play()
        end
    end)

    tabBtn.MouseButton1Click:Connect(function()
        Storage.currentTab = name
        local curT = Theme.GetCurrent()
        for n, d in pairs(Storage.tabButtons) do
            local a = (n == name)
            d.indicator.Visible = a
            TweenService:Create(d.btn, TweenInfo.new(0.2), {
                BackgroundColor3 = a and curT.SurfaceAlt or curT.BackgroundAlt
            }):Play()
            TweenService:Create(d.icon, TweenInfo.new(0.2), {
                TextColor3 = a and curT.Accent or curT.TextDim
            }):Play()
            TweenService:Create(d.label, TweenInfo.new(0.2), {
                TextColor3 = a and curT.TextPrimary or curT.TextSecondary
            }):Play()
        end
        for n, f in pairs(Storage.tabFrames) do
            f.Visible = (n == name)
        end
    end)
end

return Tabs