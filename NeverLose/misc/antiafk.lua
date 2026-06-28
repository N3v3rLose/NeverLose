-- NeverLose — Anti AFK

local RunService = game:GetService("RunService")

local AntiAFK = {}

function AntiAFK.Init(ENV)
    local Storage = ENV.Storage
    local Config = ENV.Config
    local Connections = ENV.Connections

    Connections.Add(Storage, RunService.Heartbeat:Connect(function()
        if Config.Panic then return end
        if not Config.AntiAFK then return end

        local ok, VirtualUser = pcall(function()
            return game:GetService("VirtualUser")
        end)
        if ok and VirtualUser then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end))
end

return AntiAFK