-- NeverLose — UI Builder (Toggle, Slider, Dropdown, Section, etc.)

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Builder = {}

function Builder.GetKeyName(keyCode)
    if not keyCode then return "none" end
    local name = keyCode.Name
    local short = {
        LeftControl = "LCtrl", RightControl = "RCtrl",
        LeftShift = "LShift", RightShift = "RShift",
        LeftAlt = "LAlt", RightAlt = "RAlt",
        Backspace = "Back", CapsLock = "Caps",
    }
    return short[name] or name
end

function Builder.CreateLockOverlay(parent, T)
    local lockOverlay = Instance.new("Frame")
    lockOverlay.Name = "Lock"
    lockOverlay.Size = UDim2.new(1, 0, 1, 0)
    lockOverlay.BackgroundColor3 = T.Background
    lockOverlay.BackgroundTransparency = 0.4
    lockOverlay.BorderSizePixel = 0
    lockOverlay.Visible = false
    lockOverlay.ZIndex = 10
    lockOverlay.Parent = parent
    Instance.new("UICorner", lockOverlay).CornerRadius = UDim.new(0, 6)

    local lockIcon = Instance.new("TextLabel")
    lockIcon.Size = UDim2.new(0, 30, 1, 0)
    lockIcon.Position = UDim2.new(1, -35, 0, 0)
    lockIcon.BackgroundTransparency = 1
    lockIcon.Text = "🔒"
    lockIcon.TextColor3 = T.TextDim
    lockIcon.TextSize = 12
    lockIcon.Font = Enum.Font.Gotham
    lockIcon.ZIndex = 11
    lockIcon.Parent = lockOverlay

    return lockOverlay
end

function Builder.CreateTabContent(Storage, tabName)
    local holder = Instance.new("Frame")
    holder.Name = tabName
    holder.Size = UDim2.new(1, 0, 0, 0)
    holder.AutomaticSize = Enum.AutomaticSize.Y
    holder.BackgroundTransparency = 1
    holder.Visible = (tabName == Storage.currentTab)
    holder.Parent = Storage.RightPanel
    local l = Instance.new("UIListLayout", holder)
    l.SortOrder = Enum.SortOrder.LayoutOrder
    l.Padding = UDim.new(0, 5)
    Storage.tabFrames[tabName] = holder
    return holder
end

function Builder.CreateSectionHeader(parent, text, order, Storage, Theme)
    local T = Theme.GetCurrent()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 26)
    container.BackgroundTransparency = 1
    container.LayoutOrder = order
    container.Parent = parent

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 3, 0, 14)
    accent.Position = UDim2.new(0, 0, 0.5, -7)
    accent.BackgroundColor3 = T.Accent
    accent.BorderSizePixel = 0
    accent.Parent = container
    Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 2)
    table.insert(Storage.themedElements, {obj = accent, prop = "BackgroundColor3", key = "Accent"})

    local h = Instance.new("TextLabel")
    h.Size = UDim2.new(1, -12, 1, 0)
    h.Position = UDim2.new(0, 12, 0, 0)
    h.BackgroundTransparency = 1
    h.Text = text:upper()
    h.TextColor3 = T.Accent
    h.TextSize = 10
    h.Font = Enum.Font.GothamBold
    h.TextXAlignment = Enum.TextXAlignment.Left
    h.Parent = container
    table.insert(Storage.themedElements, {obj = h, prop = "TextColor3", key = "Accent"})

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -80, 0, 1)
    line.Position = UDim2.new(0, 75, 0.5, 0)
    line.BackgroundColor3 = T.Border
    line.BackgroundTransparency = 0.6
    line.BorderSizePixel = 0
    line.Parent = container
    table.insert(Storage.themedElements, {obj = line, prop = "BackgroundColor3", key = "Border"})
end

function Builder.CreateSeparator(parent, order)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, 0, 0, 6)
    s.BackgroundTransparency = 1
    s.BorderSizePixel = 0
    s.LayoutOrder = order
    s.Parent = parent
end

function Builder.CreateToggle(parent, name, default, order, hasBind, callback, Storage, Theme, Config)
    local T = Theme.GetCurrent()
    local mouse = Players.LocalPlayer:GetMouse()

    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 0, 34)
    frame.BackgroundColor3 = T.Surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.LayoutOrder = order
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    local fStroke = Instance.new("UIStroke")
    fStroke.Color = T.Border
    fStroke.Thickness = 1
    fStroke.Transparency = 0.5
    fStroke.Parent = frame
    table.insert(Storage.themedElements, {obj = frame, prop = "BackgroundColor3", key = "Surface"})
    table.insert(Storage.themedElements, {obj = fStroke, prop = "Color", key = "Border"})

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(hasBind and 0.50 or 0.75, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = T.TextSecondary
    label.TextSize = 12
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    table.insert(Storage.themedElements, {obj = label, prop = "TextColor3", key = "TextSecondary"})

    local bindBtn
    if hasBind then
        bindBtn = Instance.new("TextButton")
        bindBtn.Size = UDim2.new(0, 58, 0, 22)
        bindBtn.Position = UDim2.new(1, -92, 0.5, -11)
        bindBtn.BackgroundColor3 = T.SurfaceAlt
        bindBtn.BorderSizePixel = 0
        bindBtn.Text = "[" .. Builder.GetKeyName(Config.Binds[name]) .. "]"
        bindBtn.TextColor3 = T.TextDim
        bindBtn.TextSize = 10
        bindBtn.Font = Enum.Font.GothamSemibold
        bindBtn.AutoButtonColor = false
        bindBtn.Parent = frame
        Instance.new("UICorner", bindBtn).CornerRadius = UDim.new(0, 4)
        local bindStroke = Instance.new("UIStroke")
        bindStroke.Color = T.Border
        bindStroke.Thickness = 1
        bindStroke.Parent = bindBtn
        table.insert(Storage.themedElements, {obj = bindBtn, prop = "BackgroundColor3", key = "SurfaceAlt"})
        table.insert(Storage.themedElements, {obj = bindStroke, prop = "Color", key = "Border"})

        bindBtn.MouseButton1Click:Connect(function()
            bindBtn.Text = "[...]"
            bindBtn.TextColor3 = T.Accent
            Storage.bindListening = name
        end)
    end

    -- Toggle switch
    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 28, 0, 16)
    switchBg.Position = UDim2.new(1, -36, 0.5, -8)
    switchBg.BackgroundColor3 = default and T.Accent or T.SurfaceAlt
    switchBg.BorderSizePixel = 0
    switchBg.Parent = frame
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)
    local swStroke = Instance.new("UIStroke")
    swStroke.Color = default and T.AccentDark or T.Border
    swStroke.Thickness = 1
    swStroke.Parent = switchBg

    local switchKnob = Instance.new("Frame")
    switchKnob.Size = UDim2.new(0, 12, 0, 12)
    switchKnob.Position = default and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    switchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    switchKnob.BorderSizePixel = 0
    switchKnob.Parent = switchBg
    Instance.new("UICorner", switchKnob).CornerRadius = UDim.new(1, 0)

    local lockOverlay = Builder.CreateLockOverlay(frame, T)

    local toggled = default
    local locked = false

    local function doToggle()
        if locked then return end
        toggled = not toggled

        local curT = Theme.GetCurrent()
        TweenService:Create(switchBg, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundColor3 = toggled and curT.Accent or curT.SurfaceAlt
        }):Play()
        TweenService:Create(swStroke, TweenInfo.new(0.2), {
            Color = toggled and curT.AccentDark or curT.Border
        }):Play()
        TweenService:Create(switchKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = toggled and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
        }):Play()

        callback(toggled)
    end

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 34, 1, 0)
    toggleBtn.Position = UDim2.new(1, -40, 0, 0)
    toggleBtn.BackgroundTransparency = 1
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 5
    toggleBtn.Parent = frame
    toggleBtn.MouseButton1Click:Connect(doToggle)

    -- Hover
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and not locked then
            TweenService:Create(fStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            TweenService:Create(fStroke, TweenInfo.new(0.15), {Transparency = 0.5}):Play()
        end
    end)

    Storage.toggleCallbacks[name] = doToggle

    local element = {
        frame = frame,
        bindBtn = bindBtn,
        switchBg = switchBg,
        switchKnob = switchKnob,
        swStroke = swStroke,
        setLocked = function(isLocked)
            locked = isLocked
            lockOverlay.Visible = isLocked
            local curT = Theme.GetCurrent()
            label.TextColor3 = isLocked and curT.TextDim or curT.TextSecondary
        end,
        setValue = function(val)
            toggled = val
            local curT = Theme.GetCurrent()
            switchBg.BackgroundColor3 = val and curT.Accent or curT.SurfaceAlt
            swStroke.Color = val and curT.AccentDark or curT.Border
            switchKnob.Position = val and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
            callback(val)
        end,
        getValue = function() return toggled end,
    }
    Storage.allElements[name] = element
    return element
end

function Builder.CreateSlider(parent, name, min, max, default, order, callback, Storage, Theme)
    local T = Theme.GetCurrent()
    local mouse = Players.LocalPlayer:GetMouse()

    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.BackgroundColor3 = T.Surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.LayoutOrder = order
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    local fStroke = Instance.new("UIStroke")
    fStroke.Color = T.Border
    fStroke.Thickness = 1
    fStroke.Transparency = 0.5
    fStroke.Parent = frame
    table.insert(Storage.themedElements, {obj = frame, prop = "BackgroundColor3", key = "Surface"})
    table.insert(Storage.themedElements, {obj = fStroke, prop = "Color", key = "Border"})

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 20)
    label.Position = UDim2.new(0, 12, 0, 4)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = T.TextSecondary
    label.TextSize = 11
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.35, -8, 0, 20)
    valueLabel.Position = UDim2.new(0.6, 0, 0, 4)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = T.Accent
    valueLabel.TextSize = 11
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = frame
    table.insert(Storage.themedElements, {obj = valueLabel, prop = "TextColor3", key = "Accent"})

    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -24, 0, 6)
    sliderBg.Position = UDim2.new(0, 12, 0, 30)
    sliderBg.BackgroundColor3 = T.SurfaceAlt
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)
    table.insert(Storage.themedElements, {obj = sliderBg, prop = "BackgroundColor3", key = "SurfaceAlt"})

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = T.Accent
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
    table.insert(Storage.themedElements, {obj = sliderFill, prop = "BackgroundColor3", key = "Accent"})

    local fillGlow = Instance.new("UIGradient")
    fillGlow.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.8, 0),
        NumberSequenceKeypoint.new(1, 0.3),
    }
    fillGlow.Parent = sliderFill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 3
    knob.Parent = sliderBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local knobStroke = Instance.new("UIStroke")
    knobStroke.Color = T.Accent
    knobStroke.Thickness = 2
    knobStroke.Parent = knob
    table.insert(Storage.themedElements, {obj = knobStroke, prop = "Color", key = "Accent"})

    local lockOverlay = Builder.CreateLockOverlay(frame, T)

    local sliding = false
    local locked = false

    local function updateSlider(inputX)
        if locked then return end
        local absPos = sliderBg.AbsolutePosition.X
        local absSize = sliderBg.AbsoluteSize.X
        local rel = math.clamp((inputX - absPos) / absSize, 0, 1)
        local val = math.floor(min + (max - min) * rel)
        sliderFill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -7, 0.5, -7)
        valueLabel.Text = tostring(val)
        callback(val)
    end

    local hit = Instance.new("TextButton")
    hit.Size = UDim2.new(1, 0, 0, 24)
    hit.Position = UDim2.new(0, 0, 0, -9)
    hit.BackgroundTransparency = 1
    hit.Text = ""
    hit.ZIndex = 4
    hit.Parent = sliderBg
    hit.MouseButton1Down:Connect(function()
        if locked then return end
        sliding = true
        updateSlider(mouse.X)
    end)

    local Connections = require and nil -- мы используем Storage напрямую
    table.insert(Storage.connections, UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
    end))
    table.insert(Storage.connections, RunService.RenderStepped:Connect(function()
        if sliding and not locked then updateSlider(mouse.X) end
    end))

    local element = {
        frame = frame,
        setLocked = function(isLocked)
            locked = isLocked
            lockOverlay.Visible = isLocked
            local curT = Theme.GetCurrent()
            label.TextColor3 = isLocked and curT.TextDim or curT.TextSecondary
            valueLabel.TextColor3 = isLocked and curT.TextDim or curT.Accent
        end,
    }
    Storage.allElements[name] = element
    return element
end

function Builder.CreateDropdown(parent, name, options, default, order, callback, Storage, Theme)
    local T = Theme.GetCurrent()

    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 0, 34)
    frame.BackgroundColor3 = T.Surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.LayoutOrder = order
    frame.ClipsDescendants = false
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    local fStroke = Instance.new("UIStroke")
    fStroke.Color = T.Border
    fStroke.Thickness = 1
    fStroke.Transparency = 0.5
    fStroke.Parent = frame
    table.insert(Storage.themedElements, {obj = frame, prop = "BackgroundColor3", key = "Surface"})

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = T.TextSecondary
    label.TextSize = 12
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local selectedBtn = Instance.new("TextButton")
    selectedBtn.Size = UDim2.new(0, 110, 0, 24)
    selectedBtn.Position = UDim2.new(1, -120, 0.5, -12)
    selectedBtn.BackgroundColor3 = T.SurfaceAlt
    selectedBtn.BorderSizePixel = 0
    selectedBtn.Text = "◄ " .. default .. " ►"
    selectedBtn.TextColor3 = T.Accent
    selectedBtn.TextSize = 11
    selectedBtn.Font = Enum.Font.GothamSemibold
    selectedBtn.AutoButtonColor = false
    selectedBtn.Parent = frame
    Instance.new("UICorner", selectedBtn).CornerRadius = UDim.new(0, 4)
    local ss = Instance.new("UIStroke")
    ss.Color = T.Border
    ss.Thickness = 1
    ss.Parent = selectedBtn
    table.insert(Storage.themedElements, {obj = selectedBtn, prop = "BackgroundColor3", key = "SurfaceAlt"})
    table.insert(Storage.themedElements, {obj = selectedBtn, prop = "TextColor3", key = "Accent"})

    local currentIndex = 1
    for i, v in ipairs(options) do
        if v == default then currentIndex = i break end
    end

    selectedBtn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex % #options + 1
        local val = options[currentIndex]
        selectedBtn.Text = "◄ " .. val .. " ►"
        callback(val)
    end)

    local lockOverlay = Builder.CreateLockOverlay(frame, T)
    local locked = false

    local element = {
        frame = frame,
        setLocked = function(isLocked)
            locked = isLocked
            lockOverlay.Visible = isLocked
            local curT = Theme.GetCurrent()
            label.TextColor3 = isLocked and curT.TextDim or curT.TextSecondary
        end,
    }
    Storage.allElements[name] = element
    return element
end

function Builder.CreatePlayerDropdown(parent, name, order, Storage, Theme)
    local T = Theme.GetCurrent()
    local player = Players.LocalPlayer

    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, 0, 0, 34)
    frame.BackgroundColor3 = T.Surface
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.LayoutOrder = order
    frame.ClipsDescendants = false
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    local fStroke = Instance.new("UIStroke")
    fStroke.Color = T.Border
    fStroke.Thickness = 1
    fStroke.Transparency = 0.5
    fStroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = T.TextSecondary
    label.TextSize = 12
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local selectedBtn = Instance.new("TextButton")
    selectedBtn.Size = UDim2.new(0, 150, 0, 24)
    selectedBtn.Position = UDim2.new(1, -160, 0.5, -12)
    selectedBtn.BackgroundColor3 = T.SurfaceAlt
    selectedBtn.BorderSizePixel = 0
    selectedBtn.Text = "◄ select ►"
    selectedBtn.TextColor3 = T.Accent
    selectedBtn.TextSize = 11
    selectedBtn.Font = Enum.Font.GothamSemibold
    selectedBtn.TextTruncate = Enum.TextTruncate.AtEnd
    selectedBtn.AutoButtonColor = false
    selectedBtn.Parent = frame
    Instance.new("UICorner", selectedBtn).CornerRadius = UDim.new(0, 4)
    local ss = Instance.new("UIStroke")
    ss.Color = T.Border
    ss.Thickness = 1
    ss.Parent = selectedBtn

    local selectedPlayer = nil

    selectedBtn.MouseButton1Click:Connect(function()
        local plrs = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then table.insert(plrs, p.Name) end
        end
        if #plrs == 0 then
            selectedBtn.Text = "◄ no players ►"
            selectedPlayer = nil
            return
        end
        local ci = 0
        if selectedPlayer then
            for i, n in ipairs(plrs) do
                if n == selectedPlayer then ci = i break end
            end
        end
        ci = ci % #plrs + 1
        selectedPlayer = plrs[ci]
        selectedBtn.Text = "◄ " .. selectedPlayer .. " ►"
    end)

    return {
        frame = frame,
        getSelected = function() return selectedPlayer end,
    }
end

function Builder.CreateButton(parent, text, order, callback, Storage, Theme)
    local T = Theme.GetCurrent()
    local TweenService = game:GetService("TweenService")

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = T.Accent
    btn.BackgroundTransparency = 0.1
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.LayoutOrder = order
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    table.insert(Storage.themedElements, {obj = btn, prop = "BackgroundColor3", key = "Accent"})

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.1}):Play()
    end)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

return Builder