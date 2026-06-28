-- NeverLose — Tracers

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Tracers = {}

function Tracers.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Theme = ENV.Theme
    local Connections = ENV.Connections
    local player = Players.LocalPlayer

    Connections.Add(Storage, RunService.RenderStepped:Connect(function()
        for _, line in pairs(Storage.tracerLines) do
            if line then line:Remove() end
        end
        Storage.tracerLines = {}

        if Config.Panic or not Config.Tracers then return end

        local T = Theme.GetCurrent()
        local cam = workspace.CurrentCamera
        local viewportSize = cam.ViewportSize

        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                local oHRP = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                if oHRP then
                    local isFriend = player:IsFriendsWith(otherPlayer.UserId)
                    if isFriend and not Config.TracersFriends then continue end

                    local pos, onScreen = cam:WorldToViewportPoint(oHRP.Position)
                    if onScreen then
                        local friendColor = Color3.fromRGB(50, 200, 100)
                        local tracerColor = (Config.TracersFriends and isFriend) and friendColor or T.Accent
                        local line = Drawing.new("Line")
                        line.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                        line.To = Vector2.new(pos.X, pos.Y)
                        line.Color = tracerColor
                        line.Thickness = 1.5
                        line.Transparency = 0.8
                        line.Visible = true
                        table.insert(Storage.tracerLines, line)
                    end
                end
            end
        end
    end))
end

return Tracers