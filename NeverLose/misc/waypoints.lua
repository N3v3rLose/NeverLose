-- NeverLose — Waypoints

local Players = game:GetService("Players")

local Waypoints = {}

function Waypoints.Save(Storage, name)
    local char = Players.LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    if name == "" then name = "wp " .. (#Storage.waypoints + 1) end
    table.insert(Storage.waypoints, {name = name, pos = hrp.Position, bind = nil})
    return true
end

function Waypoints.Delete(Storage, index)
    table.remove(Storage.waypoints, index)
end

function Waypoints.TeleportTo(Storage, index)
    local wp = Storage.waypoints[index]
    if not wp then return end
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(wp.pos)
    end
end

return Waypoints