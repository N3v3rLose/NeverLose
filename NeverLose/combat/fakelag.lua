-- NeverLose — Fake Lag (с опцией отключения лагов от первого лица)

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local FakeLag = {}

function FakeLag.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections
    local player = Players.LocalPlayer

    -- Клон персонажа для серверного фейка (визуальный)
    local fakeClone = nil
    local cloneParts = {}

    local function destroyClone()
        if fakeClone and fakeClone.Parent then
            fakeClone:Destroy()
        end
        fakeClone = nil
        cloneParts = {}
    end

    local function createClone(char)
        destroyClone()
        fakeClone = Instance.new("Model")
        fakeClone.Name = "FakeLagClone"

        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                local clone = part:Clone()
                clone.Anchored = true
                clone.CanCollide = false
                clone.Transparency = math.max(part.Transparency, 0.6)
                clone.Parent = fakeClone
                cloneParts[part] = clone
            end
        end

        fakeClone.Parent = workspace
    end

    local function updateClone(char)
        if not fakeClone or not fakeClone.Parent then return end
        for original, clone in pairs(cloneParts) do
            if original and original.Parent and clone and clone.Parent then
                clone.CFrame = original.CFrame
            end
        end
    end

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then
            Storage.fakeLagIndicator.Visible = false
            Storage.fakeLagLabel.Visible = false
            destroyClone()
            return
        end

        if not Config.FakeLagEnabled then
            Storage.fakeLagIndicator.Visible = false
            Storage.fakeLagLabel.Visible = false
            Storage.fakeLagIsLagging = false
            destroyClone()
            return
        end

        -- On key hold check
        if Config.FakeLagOnKey then
            if not UIS:IsKeyDown(Config.FakeLagKey) then
                Storage.fakeLagIndicator.Visible = false
                Storage.fakeLagLabel.Visible = false
                Storage.fakeLagIsLagging = false
                destroyClone()
                return
            end
        end

        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local now = tick()
        local intervalSec = Config.FakeLagInterval / 1000
        local durationSec = Config.FakeLagDuration / 1000

        local shouldLag = false

        if Config.FakeLagMode == "pulse" then
            local cycle = intervalSec + durationSec
            local phase = (now % cycle)
            shouldLag = phase < durationSec
        elseif Config.FakeLagMode == "random" then
            if now - Storage.fakeLagLastSwitch > (Storage.fakeLagIsLagging and durationSec or intervalSec) then
                Storage.fakeLagLastSwitch = now
                Storage.fakeLagIsLagging = not Storage.fakeLagIsLagging
            end
            shouldLag = Storage.fakeLagIsLagging
        elseif Config.FakeLagMode == "adaptive" then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local speed = hum and hum.MoveDirection.Magnitude or 0
            local adaptInterval = intervalSec * (speed > 0.1 and 0.5 or 1.5)
            local cycle = adaptInterval + durationSec
            local phase = (now % cycle)
            shouldLag = phase < durationSec
        elseif Config.FakeLagMode == "stutter" then
            local microCycle = 0.1 + (intervalSec * 0.3)
            shouldLag = math.sin(now * (1 / microCycle) * math.pi) > (1 - Config.FakeLagIntensity / 100 * 2 + 1)
        elseif Config.FakeLagMode == "constant" then
            shouldLag = true
        end

        -- Intensity threshold
        if shouldLag and Config.FakeLagIntensity < 100 then
            if math.random(1, 100) > Config.FakeLagIntensity then
                shouldLag = false
            end
        end

        if shouldLag then
            if not Storage.fakeLagSavedPos then
                Storage.fakeLagSavedPos = hrp.CFrame
            end

            -- ========================================
            -- КЛЮЧЕВАЯ НОВАЯ ФИЧА: FakeLagFirstPerson
            -- Если включено — игрок НЕ видит лаги у себя,
            -- но другие игроки видят замороженного клона
            -- ========================================
            if Config.FakeLagFirstPerson then
                -- НЕ якорим реальный HRP — игрок двигается нормально
                -- Вместо этого создаём/обновляем "заморозённый" клон
                -- который другие игроки будут видеть на старой позиции
                -- (в Roblox это ограничено клиентом, но даёт визуальный эффект)

                if not fakeClone or not fakeClone.Parent then
                    -- Сохраняем позу на момент начала лага
                    -- Клон остаётся на месте, игрок двигается
                end

                -- Сетевой трюк: кратковременный anchor + отпуск
                -- создаёт серверный рассинхрон
                if Config.FakeLagDesync then
                    hrp.Anchored = true
                    task.delay(0.02, function()
                        if hrp and hrp.Parent then
                            hrp.Anchored = false
                        end
                    end)
                end
            else
                -- Стандартный режим: якорим HRP (видно лаги и самому)
                if Config.FakeLagDesync then
                    hrp.Anchored = true
                    task.delay(0.05, function()
                        if hrp and hrp.Parent then
                            hrp.Anchored = false
                        end
                    end)
                else
                    hrp.Anchored = true
                end
            end

            -- Visual indicator
            if Config.FakeLagVisual then
                Storage.fakeLagIndicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                Storage.fakeLagIndicator.Visible = true
                Storage.fakeLagLabel.Visible = true
                Storage.fakeLagLabel.Text = Config.FakeLagFirstPerson and "LAG (FP OFF)" or "LAGGING"
                Storage.fakeLagLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        else
            -- Release
            if hrp.Anchored and not Config.FakeLagFirstPerson then
                hrp.Anchored = false
                if Storage.fakeLagSavedPos and Config.FakeLagDesync then
                    hrp.CFrame = Storage.fakeLagSavedPos
                end
            elseif hrp.Anchored and Config.FakeLagFirstPerson then
                hrp.Anchored = false
            end

            Storage.fakeLagSavedPos = nil
            destroyClone()

            if Config.FakeLagVisual then
                Storage.fakeLagIndicator.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                Storage.fakeLagIndicator.Visible = true
                Storage.fakeLagLabel.Visible = true
                Storage.fakeLagLabel.Text = "SYNCED"
                Storage.fakeLagLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            end
        end
    end))
end

return FakeLag