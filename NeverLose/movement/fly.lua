-- NeverLose — Fly

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Fly = {}

function Fly.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        if not Config.FlyEnabled then return end

        local char = Players.LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local bv = hrp:FindFirstChild("FlyVelocity")
        local bg = hrp:FindFirstChild("FlyGyro")
        if bv and bg then
            local cam = workspace.CurrentCamera
            local dir = Vector3.new(0, 0, 0)
            if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0, 1, 0) end
            if dir.Magnitude > 0 then dir = dir.Unit end
            bv.Velocity = dir * Config.FlySpeed
            bg.CFrame = cam.CFrame
        end
    end))
end

function Fly.Enable(ENV)
    local char = Players.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local bv = Instance.new("BodyVelocity")
    bv.Name = "FlyVelocity"
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = hrp

    local bg = Instance.new("BodyGyro")
    bg.Name = "FlyGyro"
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.D = 200
    bg.Parent = hrp
end

function Fly.Disable(ENV)
    local char = Players.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local bv = hrp:FindFirstChild("FlyVelocity")
    local bg = hrp:FindFirstChild("FlyGyro")
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

function Fly.OnRespawn(ENV)
    if ENV.Config.FlyEnabled then
        Fly.Enable(ENV)
    end
end

return Fly