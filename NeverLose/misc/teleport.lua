-- NeverLose — Teleport (Click TP + Position TP)

local Teleport = {}

-- Click TP обрабатывается в ui/init.lua через input handler
-- Здесь вспомогательные функции

function Teleport.ToPosition(x, y, z)
    local Players = game:GetService("Players")
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        return true
    end
    return false
end

function Teleport.ToPlayer(targetName)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local target = Players:FindFirstChild(targetName)
    if not target or not target.Character then return false, "player not found" end

    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local myChar = player.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")

    if targetHRP and myHRP then
        myHRP.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
        return true, "teleported to " .. targetName
    end

    return false, "failed"
end

function Teleport.Init(ENV)
    -- Нет постоянных подключений
end

return Teleport