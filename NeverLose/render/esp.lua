-- NeverLose — ESP

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local ESP = {}

function ESP.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local Connections = ENV.Connections
    local player = Players.LocalPlayer

    Connections.Add(Storage, RunService.RenderStepped:Connect(function()
        -- Очистка старых объектов
        for _, o in pairs(Storage.espObjects) do
            if o and o.Parent then o:Destroy() end
        end
        Storage.espObjects = {}

        if Config.Panic or not Config.ESPEnabled then return end

        local T = Theme.GetCurrent()
        local myChar = player.Character
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end

        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                local oChar = otherPlayer.Character
                local oHRP = oChar:FindFirstChild("HumanoidRootPart")
                local oHum = oChar:FindFirstChildOfClass("Humanoid")

                if oHRP and oHum then
                    local isFriend = player:IsFriendsWith(otherPlayer.UserId)
                    local friendColor = Color3.fromRGB(50, 200, 100)
                    local enemyColor = T.Accent
                    local espColor = (Config.ESPFriends and isFriend) and friendColor or enemyColor

                    -- Highlight
                    if Config.ESPMode == "outline" then
                        local hl = Instance.new("Highlight")
                        hl.Adornee = oChar
                        hl.FillTransparency = 1
                        hl.OutlineColor = espColor
                        hl.OutlineTransparency = 0
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = oChar
                        table.insert(Storage.espObjects, hl)
                    elseif Config.ESPMode == "box" then
                        local hl = Instance.new("Highlight")
                        hl.Adornee = oChar
                        hl.FillColor = espColor
                        hl.FillTransparency = 0.7
                        hl.OutlineColor = espColor
                        hl.OutlineTransparency = 0
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = oChar
                        table.insert(Storage.espObjects, hl)
                    elseif Config.ESPMode == "glow" then
                        local hl = Instance.new("Highlight")
                        hl.Adornee = oChar
                        hl.FillColor = espColor
                        hl.FillTransparency = 0.4
                        hl.OutlineColor = espColor
                        hl.OutlineTransparency = 0.3
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = oChar
                        table.insert(Storage.espObjects, hl)
                    end

                    -- Info labels
                    local showInfo = Config.ESPNames or Config.ESPDistance or Config.ESPHealth
                    if showInfo then
                        local bb = Instance.new("BillboardGui")
                        bb.Size = UDim2.new(0, 200, 0, 60)
                        bb.Adornee = oHRP
                        bb.AlwaysOnTop = true
                        bb.StudsOffset = Vector3.new(0, 3.5, 0)
                        bb.Parent = oChar
                        table.insert(Storage.espObjects, bb)

                        local yOff = 0

                        if Config.ESPNames then
                            local n = Instance.new("TextLabel")
                            n.Size = UDim2.new(1, 0, 0, 15)
                            n.Position = UDim2.new(0, 0, 0, yOff)
                            n.BackgroundTransparency = 1
                            n.Text = (isFriend and "★ " or "") .. otherPlayer.Name
                            n.TextColor3 = espColor
                            n.TextSize = 13
                            n.Font = Enum.Font.GothamBold
                            n.TextStrokeTransparency = 0.5
                            n.Parent = bb
                            yOff = yOff + 15
                        end

                        if Config.ESPHealth then
                            local h = Instance.new("TextLabel")
                            h.Size = UDim2.new(1, 0, 0, 13)
                            h.Position = UDim2.new(0, 0, 0, yOff)
                            h.BackgroundTransparency = 1
                            h.Text = math.floor(oHum.Health) .. "/" .. math.floor(oHum.MaxHealth)
                            h.TextColor3 = T.Success
                            h.TextSize = 11
                            h.Font = Enum.Font.GothamSemibold
                            h.TextStrokeTransparency = 0.5
                            h.Parent = bb
                            yOff = yOff + 13
                        end

                        if Config.ESPDistance then
                            local dist = math.floor((myHRP.Position - oHRP.Position).Magnitude)
                            local d = Instance.new("TextLabel")
                            d.Size = UDim2.new(1, 0, 0, 13)
                            d.Position = UDim2.new(0, 0, 0, yOff)
                            d.BackgroundTransparency = 1
                            d.Text = dist .. "m"
                            d.TextColor3 = T.TextSecondary
                            d.TextSize = 10
                            d.Font = Enum.Font.Gotham
                            d.TextStrokeTransparency = 0.5
                            d.Parent = bb
                        end
                    end
                end
            end
        end
    end))
end

return ESP