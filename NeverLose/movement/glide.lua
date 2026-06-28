-- NeverLose — Glide

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Glide = {}

function Glide.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        if not Config.GlideEnabled or Config.FlyEnabled then return end

        local char = Players.LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end

        if hum.FloorMaterial == Enum.Material.Air then
            local cam = workspace.CurrentCamera
            local vel = hrp.Velocity
            if vel.Y < -2 then
                hrp.Velocity = Vector3.new(vel.X, -2, vel.Z)
            end
            local dir = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if dir.Magnitude > 0 then
                dir = Vector3.new(dir.X, 0, dir.Z).Unit
                local targetVel = dir * Config.GlideSpeed
                hrp.Velocity = Vector3.new(targetVel.X, hrp.Velocity.Y, targetVel.Z)
            end
        end
    end))
end

return Glide