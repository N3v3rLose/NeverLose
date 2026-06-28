-- NeverLose — Connections Manager

local Connections = {}

function Connections.Add(Storage, connection)
    table.insert(Storage.connections, connection)
    return connection
end

function Connections.DisconnectAll(Storage)
    for _, c in pairs(Storage.connections) do
        if c and c.Connected then
            c:Disconnect()
        end
    end
    Storage.connections = {}
end

return Connections