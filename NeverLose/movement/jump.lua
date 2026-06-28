-- NeverLose — Jump (Infinite, Double, Air, Long)

local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Jump = {}

function Jump.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections

    -- Track floor state
    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        local char = Players.LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        if hum.FloorMaterial ~= Enum.Material.Air then
            Storage.hasDoubleJumped = false
        end

        if Config.InfiniteJump then
            hum.JumpPower = Config.JumpPower
        end
    end))

    -- Jump request
    Connections.Add(Storage, UIS.JumpRequest:Connect(function()
        if Config.Panic then return end
        local char = Players.LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum then return end

        if Config.InfiniteJump then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            return
        end

        if Config.AirJump then
            if hum.FloorMaterial == Enum.Material.Air then
                if tick() - Storage.lastJumpTick > 0.15 then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    Storage.lastJumpTick = tick()
                end
            end
            return
        end

        if Config.DoubleJump then
            if hum.FloorMaterial == Enum.Material.Air and not Storage.hasDoubleJumped then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                Storage.hasDoubleJumped = true
            end
        end

        if Config.LongJump and hrp then
            local cam = workspace.CurrentCamera
            local lookDir = cam.CFrame.LookVector
            local flatDir = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
            hrp.Velocity = hrp.Velocity + flatDir * Config.LongJumpForce
        end
    end))
end

return Jump