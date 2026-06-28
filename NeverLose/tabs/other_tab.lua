-- NeverLose — Other Tab

return function(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local B = ENV.UIBuilder
    local Teleport = ENV.Teleport
    local WaypointsModule = ENV.Waypoints

    local T = Theme.GetCurrent()
    local tab = B.CreateTabContent(Storage, "other")

    B.CreateSectionHeader(tab, "teleport", 1, Storage, Theme)

    B.CreateToggle(tab, "click tp", false, 2, true, function(v) Config.ClickTP = v end, Storage, Theme, Config)

    local ctpInfo = Instance.new("TextLabel")
    ctpInfo.Size = UDim2.new(1, 0, 0, 18)
    ctpInfo.BackgroundTransparency = 1
    ctpInfo.Text = "   hold ctrl + lmb to teleport"
    ctpInfo.TextColor3 = T.TextDim
    ctpInfo.TextSize = 10
    ctpInfo.Font = Enum.Font.Gotham
    ctpInfo.TextXAlignment = Enum.TextXAlignment.Left
    ctpInfo.LayoutOrder = 3
    ctpInfo.Parent = tab

    B.CreateSeparator(tab, 4)
    B.CreateSectionHeader(tab, "teleport to position", 5, Storage, Theme)

    -- XYZ Input frame
    local xyzFrame = Instance.new("Frame")
    xyzFrame.Size = UDim2.new(1, 0, 0, 34)
    xyzFrame.BackgroundColor3 = T.Surface
    xyzFrame.BackgroundTransparency = 0
    xyzFrame.BorderSizePixel = 0
    xyzFrame.LayoutOrder = 6
    xyzFrame.Parent = tab
    Instance.new("UICorner", xyzFrame).CornerRadius = UDim.new(0, 6)

    local function makeCoordInput(labelText, posX)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 12, 1, 0)
        lbl.Position = UDim2.new(0, posX, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = labelText
        lbl.TextColor3 = T.Accent
        lbl.TextSize = 11
        lbl.Font = Enum.Font.GothamBold
        lbl.Parent = xyzFrame

        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0, 55, 0, 22)
        box.Position = UDim2.new(0, posX + 14, 0.5, -11)
        box.BackgroundColor3 = T.SurfaceAlt
        box.BorderSizePixel = 0
        box.Text = "0"
        box.TextColor3 = T.TextPrimary
        box.PlaceholderText = "0"
        box.PlaceholderColor3 = T.TextDim
        box.TextSize = 11
        box.Font = Enum.Font.GothamSemibold
        box.ClearTextOnFocus = false
        box.Parent = xyzFrame
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
        return box
    end

    local xInput = makeCoordInput("X", 10)
    local yInput = makeCoordInput("Y", 90)
    local zInput = makeCoordInput("Z", 170)

    local tpPosBtn = Instance.new("TextButton")
    tpPosBtn.Size = UDim2.new(0, 60, 0, 22)
    tpPosBtn.Position = UDim2.new(1, -68, 0.5, -11)
    tpPosBtn.BackgroundColor3 = T.Accent
    tpPosBtn.BackgroundTransparency = 0.1
    tpPosBtn.BorderSizePixel = 0
    tpPosBtn.Text = "teleport"
    tpPosBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpPosBtn.TextSize = 10
    tpPosBtn.Font = Enum.Font.GothamBold
    tpPosBtn.AutoButtonColor = false
    tpPosBtn.Parent = xyzFrame
    Instance.new("UICorner", tpPosBtn).CornerRadius = UDim.new(0, 4)

    tpPosBtn.MouseButton1Click:Connect(function()
        Teleport.ToPosition(
            tonumber(xInput.Text) or 0,
            tonumber(yInput.Text) or 0,
            tonumber(zInput.Text) or 0
        )
    end)

    B.CreateSeparator(tab, 7)
    B.CreateSectionHeader(tab, "waypoints", 8, Storage, Theme)

    -- Waypoint save
    local wpSaveFrame = Instance.new("Frame")
    wpSaveFrame.Size = UDim2.new(1, 0, 0, 34)
    wpSaveFrame.BackgroundColor3 = T.Surface
    wpSaveFrame.BackgroundTransparency = 0
    wpSaveFrame.BorderSizePixel = 0
    wpSaveFrame.LayoutOrder = 9
    wpSaveFrame.Parent = tab
    Instance.new("UICorner", wpSaveFrame).CornerRadius = UDim.new(0, 6)

    local wpNameBox = Instance.new("TextBox")
    wpNameBox.Size = UDim2.new(0, 130, 0, 22)
    wpNameBox.Position = UDim2.new(0, 10, 0.5, -11)
    wpNameBox.BackgroundColor3 = T.SurfaceAlt
    wpNameBox.BorderSizePixel = 0
    wpNameBox.Text = ""
    wpNameBox.PlaceholderText = "waypoint name..."
    wpNameBox.PlaceholderColor3 = T.TextDim
    wpNameBox.TextColor3 = T.TextPrimary
    wpNameBox.TextSize = 11
    wpNameBox.Font = Enum.Font.GothamSemibold
    wpNameBox.ClearTextOnFocus = true
    wpNameBox.Parent = wpSaveFrame
    Instance.new("UICorner", wpNameBox).CornerRadius = UDim.new(0, 4)

    local wpSaveBtn = Instance.new("TextButton")
    wpSaveBtn.Size = UDim2.new(0, 90, 0, 22)
    wpSaveBtn.Position = UDim2.new(1, -98, 0.5, -11)
    wpSaveBtn.BackgroundColor3 = T.Accent
    wpSaveBtn.BackgroundTransparency = 0.1
    wpSaveBtn.BorderSizePixel = 0
    wpSaveBtn.Text = "save position"
    wpSaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    wpSaveBtn.TextSize = 10
    wpSaveBtn.Font = Enum.Font.GothamBold
    wpSaveBtn.AutoButtonColor = false
    wpSaveBtn.Parent = wpSaveFrame
    Instance.new("UICorner", wpSaveBtn).CornerRadius = UDim.new(0, 4)

    wpSaveBtn.MouseButton1Click:Connect(function()
        WaypointsModule.Save(Storage, wpNameBox.Text)
        wpNameBox.Text = ""
    end)
end