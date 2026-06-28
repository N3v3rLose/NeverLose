-- NeverLose — UI Init (создание основного окна)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local UIModule = {}

function UIModule.Create(ENV)
    local Storage = ENV.Storage
    local Theme = ENV.Theme
    local Config = ENV.Config
    local Builder = ENV.UIBuilder
    local Drag = ENV.UIDrag
    local TabsModule = ENV.UITabs

    local T = Theme.GetCurrent()
    local player = Players.LocalPlayer

    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NeverLoseGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = player.PlayerGui
    Storage.ScreenGui = ScreenGui

    -- MainFrame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "Main"
    MainFrame.Size = UDim2.new(0, 640, 0, 440)
    MainFrame.Position = UDim2.new(0.5, -320, 0.5, -220)
    MainFrame.BackgroundColor3 = T.Background
    MainFrame.BackgroundTransparency = 0
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    Storage.MainFrame = MainFrame
    table.insert(Storage.themedElements, {obj = MainFrame, prop = "BackgroundColor3", key = "Background"})

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = T.Border
    MainStroke.Thickness = 1.5
    MainStroke.Parent = MainFrame
    table.insert(Storage.themedElements, {obj = MainStroke, prop = "Color", key = "Border"})

    -- Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.6
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame

    -- Top accent bar
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 3)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = T.Accent
    TopBar.BorderSizePixel = 0
    TopBar.ZIndex = 5
    TopBar.Parent = MainFrame
    Storage.TopBar = TopBar
    table.insert(Storage.themedElements, {obj = TopBar, prop = "BackgroundColor3", key = "Accent"})

    local topGradient = Instance.new("UIGradient")
    topGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, T.TopBarGradient1),
        ColorSequenceKeypoint.new(0.5, T.TopBarGradient2),
        ColorSequenceKeypoint.new(1, T.TopBarGradient1),
    }
    topGradient.Parent = TopBar
    table.insert(Storage.themedElements, {obj = topGradient, prop = "gradient_topbar"})

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 36)
    TitleBar.Position = UDim2.new(0, 0, 0, 3)
    TitleBar.BackgroundColor3 = T.BackgroundAlt
    TitleBar.BackgroundTransparency = 0
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 3
    TitleBar.Parent = MainFrame
    Storage.TitleBar = TitleBar
    table.insert(Storage.themedElements, {obj = TitleBar, prop = "BackgroundColor3", key = "BackgroundAlt"})

    -- Logo
    local LogoIcon = Instance.new("TextLabel")
    LogoIcon.Size = UDim2.new(0, 24, 0, 24)
    LogoIcon.Position = UDim2.new(0, 12, 0.5, -12)
    LogoIcon.BackgroundColor3 = T.Accent
    LogoIcon.BackgroundTransparency = 0.1
    LogoIcon.Text = "N"
    LogoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoIcon.TextSize = 13
    LogoIcon.Font = Enum.Font.GothamBold
    LogoIcon.ZIndex = 4
    LogoIcon.Parent = TitleBar
    table.insert(Storage.themedElements, {obj = LogoIcon, prop = "BackgroundColor3", key = "Accent"})
    Instance.new("UICorner", LogoIcon).CornerRadius = UDim.new(0, 6)

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(0, 100, 1, 0)
    TitleText.Position = UDim2.new(0, 44, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = "NeverLose"
    TitleText.TextColor3 = T.TextPrimary
    TitleText.TextSize = 14
    TitleText.Font = Enum.Font.GothamBold
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.ZIndex = 4
    TitleText.Parent = TitleBar
    table.insert(Storage.themedElements, {obj = TitleText, prop = "TextColor3", key = "TextPrimary"})

    local VersionTitle = Instance.new("TextLabel")
    VersionTitle.Size = UDim2.new(0, 50, 1, 0)
    VersionTitle.Position = UDim2.new(0, 143, 0, 1)
    VersionTitle.BackgroundTransparency = 1
    VersionTitle.Text = "v0.0.5"
    VersionTitle.TextColor3 = T.TextDim
    VersionTitle.TextSize = 10
    VersionTitle.Font = Enum.Font.Gotham
    VersionTitle.TextXAlignment = Enum.TextXAlignment.Left
    VersionTitle.ZIndex = 4
    VersionTitle.Parent = TitleBar
    table.insert(Storage.themedElements, {obj = VersionTitle, prop = "TextColor3", key = "TextDim"})

    -- Title separator
    local TitleSep = Instance.new("Frame")
    TitleSep.Size = UDim2.new(1, 0, 0, 1)
    TitleSep.Position = UDim2.new(0, 0, 1, 0)
    TitleSep.BackgroundColor3 = T.Border
    TitleSep.BackgroundTransparency = 0.5
    TitleSep.BorderSizePixel = 0
    TitleSep.ZIndex = 4
    TitleSep.Parent = TitleBar
    table.insert(Storage.themedElements, {obj = TitleSep, prop = "BackgroundColor3", key = "Border"})

    -- Left Panel
    local LeftPanel = Instance.new("Frame")
    LeftPanel.Name = "LeftPanel"
    LeftPanel.Size = UDim2.new(0, 140, 1, -39)
    LeftPanel.Position = UDim2.new(0, 0, 0, 39)
    LeftPanel.BackgroundColor3 = T.BackgroundAlt
    LeftPanel.BackgroundTransparency = 0.3
    LeftPanel.BorderSizePixel = 0
    LeftPanel.ClipsDescendants = true
    LeftPanel.Parent = MainFrame
    Storage.LeftPanel = LeftPanel
    table.insert(Storage.themedElements, {obj = LeftPanel, prop = "BackgroundColor3", key = "BackgroundAlt"})

    local LeftSep = Instance.new("Frame")
    LeftSep.Size = UDim2.new(0, 1, 1, -39)
    LeftSep.Position = UDim2.new(0, 140, 0, 39)
    LeftSep.BackgroundColor3 = T.Border
    LeftSep.BackgroundTransparency = 0.5
    LeftSep.BorderSizePixel = 0
    LeftSep.Parent = MainFrame
    table.insert(Storage.themedElements, {obj = LeftSep, prop = "BackgroundColor3", key = "Border"})

    local TabHolder = Instance.new("Frame")
    TabHolder.Name = "TabHolder"
    TabHolder.Size = UDim2.new(1, -8, 1, -8)
    TabHolder.Position = UDim2.new(0, 4, 0, 4)
    TabHolder.BackgroundTransparency = 1
    TabHolder.BorderSizePixel = 0
    TabHolder.Parent = LeftPanel
    Storage.TabHolder = TabHolder

    local leftLayout = Instance.new("UIListLayout", TabHolder)
    leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    leftLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    leftLayout.Padding = UDim.new(0, 3)

    -- Right Panel
    local RightPanel = Instance.new("ScrollingFrame")
    RightPanel.Name = "RightPanel"
    RightPanel.Size = UDim2.new(1, -141, 1, -39)
    RightPanel.Position = UDim2.new(0, 141, 0, 39)
    RightPanel.BackgroundTransparency = 1
    RightPanel.ScrollBarThickness = 3
    RightPanel.ScrollBarImageColor3 = T.Accent
    RightPanel.BorderSizePixel = 0
    RightPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    RightPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    RightPanel.Parent = MainFrame
    Storage.RightPanel = RightPanel
    table.insert(Storage.themedElements, {obj = RightPanel, prop = "ScrollBarImageColor3", key = "Accent"})

    local RL = Instance.new("UIListLayout", RightPanel)
    RL.SortOrder = Enum.SortOrder.LayoutOrder
    RL.Padding = UDim.new(0, 5)

    local RPad = Instance.new("UIPadding", RightPanel)
    RPad.PaddingTop = UDim.new(0, 8)
    RPad.PaddingLeft = UDim.new(0, 10)
    RPad.PaddingRight = UDim.new(0, 10)
    RPad.PaddingBottom = UDim.new(0, 8)

    -- Drag
    Drag.Init(MainFrame, Storage)

    -- Create tabs
    TabsModule.CreateTab("movement", "⚡", 1, Storage, Theme)
    TabsModule.CreateTab("visual", "👁", 2, Storage, Theme)
    TabsModule.CreateTab("other", "🔧", 3, Storage, Theme)
    TabsModule.CreateTab("combat", "⚔", 4, Storage, Theme)
    TabsModule.CreateTab("misc", "📦", 5, Storage, Theme)
    TabsModule.CreateTab("theme", "🎨", 6, Storage, Theme)
    TabsModule.CreateTab("menu", "☰", 7, Storage, Theme)

    -- Create tab contents (вызов всех вкладок)
    -- Каждый tabs/*.lua файл создаёт свой контент
    -- Они вызываются из loader.lua после загрузки всех модулей

    -- Fake Lag indicator
    local fakeLagIndicator = Instance.new("Frame")
    fakeLagIndicator.Size = UDim2.new(0, 8, 0, 8)
    fakeLagIndicator.Position = UDim2.new(0.5, -4, 0, 50)
    fakeLagIndicator.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    fakeLagIndicator.BorderSizePixel = 0
    fakeLagIndicator.Visible = false
    fakeLagIndicator.ZIndex = 100
    fakeLagIndicator.Parent = ScreenGui
    Instance.new("UICorner", fakeLagIndicator).CornerRadius = UDim.new(1, 0)
    local flStroke = Instance.new("UIStroke")
    flStroke.Color = Color3.fromRGB(0, 0, 0)
    flStroke.Thickness = 1
    flStroke.Parent = fakeLagIndicator
    Storage.fakeLagIndicator = fakeLagIndicator

    local fakeLagLabel = Instance.new("TextLabel")
    fakeLagLabel.Size = UDim2.new(0, 60, 0, 14)
    fakeLagLabel.Position = UDim2.new(0.5, -30, 0, 60)
    fakeLagLabel.BackgroundTransparency = 1
    fakeLagLabel.Text = "FAKE LAG"
    fakeLagLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    fakeLagLabel.TextSize = 9
    fakeLagLabel.Font = Enum.Font.GothamBold
    fakeLagLabel.Visible = false
    fakeLagLabel.ZIndex = 100
    fakeLagLabel.Parent = ScreenGui
    Storage.fakeLagLabel = fakeLagLabel
end

function UIModule.InitInput(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local Builder = ENV.UIBuilder
    local Core = ENV.Core
    local UIS = game:GetService("UserInputService")

    table.insert(Storage.connections, UIS.InputBegan:Connect(function(input, gp)
        -- Panic restore
        if input.KeyCode == Enum.KeyCode.H then
            if UIS:IsKeyDown(Enum.KeyCode.RightShift) and UIS:IsKeyDown(Enum.KeyCode.RightControl) then
                if Config.Panic then
                    if ENV.Panic and ENV.Panic.Deactivate then
                        ENV.Panic.Deactivate(ENV)
                    end
                    Storage.guiOpen = true
                    Storage.MainFrame.Visible = true
                    return
                end
            end
        end

        if Config.Panic then return end

        -- Bind listening
        if Storage.bindListening and input.UserInputType == Enum.UserInputType.Keyboard then
            local T = Theme.GetCurrent()
            if input.KeyCode == Enum.KeyCode.Escape then
                Config.Binds[Storage.bindListening] = nil
                local el = Storage.allElements[Storage.bindListening]
                if el and el.bindBtn then
                    el.bindBtn.Text = "[none]"
                    el.bindBtn.TextColor3 = T.TextDim
                end
            else
                Config.Binds[Storage.bindListening] = input.KeyCode
                local el = Storage.allElements[Storage.bindListening]
                if el and el.bindBtn then
                    el.bindBtn.Text = "[" .. Builder.GetKeyName(input.KeyCode) .. "]"
                    el.bindBtn.TextColor3 = T.TextDim
                end
            end
            Storage.bindListening = nil
            return
        end

        -- Menu toggle
        if input.KeyCode == Enum.KeyCode.RightShift and not UIS:IsKeyDown(Enum.KeyCode.RightControl) then
            Storage.guiOpen = not Storage.guiOpen
            Storage.MainFrame.Visible = Storage.guiOpen
            return
        end

        if gp then return end

        if input.UserInputType == Enum.UserInputType.Keyboard then
            for name, keyCode in pairs(Config.Binds) do
                if keyCode and input.KeyCode == keyCode then
                    if name == "sprint enabled" and Config.SprintEnabled then
                        if Config.ToggleMode then
                            Storage.isSprinting = not Storage.isSprinting
                        else
                            Storage.isSprinting = true
                        end
                    elseif name == "rejoin" then
                        if ENV.Rejoin and ENV.Rejoin.Do then ENV.Rejoin.Do() end
                    elseif Storage.toggleCallbacks[name] and name ~= "sprint enabled" then
                        Storage.toggleCallbacks[name]()
                    end
                end
            end

            -- Waypoint binds
            for _, wp in ipairs(Storage.waypoints) do
                if wp.bind and input.KeyCode == wp.bind then
                    local char = Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(wp.pos)
                    end
                end
            end
        end

        -- Click TP
        if input.UserInputType == Enum.UserInputType.MouseButton1 and Config.ClickTP then
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl) then
                local char = Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local target = Core.mouse.Hit
                    if target then
                        char.HumanoidRootPart.CFrame = target + Vector3.new(0, 3, 0)
                    end
                end
            end
        end
    end))

    -- Sprint release
    table.insert(Storage.connections, UIS.InputEnded:Connect(function(input)
        local sprintBind = Config.Binds["sprint enabled"]
        if sprintBind and input.KeyCode == sprintBind and Config.SprintEnabled then
            if not Config.ToggleMode then
                Storage.isSprinting = false
            end
        end
    end))
end

return UIModule