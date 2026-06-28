-- NeverLose — Config

local Config = {
    SprintEnabled = false,
    WalkSpeed = 16,
    SprintSpeed = 35,
    ToggleMode = false,
    InfiniteJump = false,
    JumpPower = 50,
    NoClip = false,
    NoClipSpeed = 50,
    DoubleJump = false,
    AirJump = false,
    LongJump = false,
    LongJumpForce = 50,

    ESPEnabled = false,
    ESPMode = "outline",
    ESPNames = false,
    ESPDistance = false,
    ESPHealth = false,
    ESPFriends = false,
    Fullbright = false,
    NoFog = false,
    Tracers = false,
    TracersFriends = false,

    ClickTP = false,
    FlyEnabled = false,
    FlySpeed = 50,
    GlideEnabled = false,
    GlideSpeed = 30,

    AntiAFK = false,
    Panic = false,

    -- Fake Lag
    FakeLagEnabled = false,
    FakeLagMode = "pulse",
    FakeLagInterval = 200,
    FakeLagDuration = 500,
    FakeLagIntensity = 80,
    FakeLagVisual = true,
    FakeLagDesync = false,
    FakeLagOnKey = false,
    FakeLagKey = Enum.KeyCode.V,
    FakeLagFirstPerson = true, -- НЕ лагать от первого лица для себя

    -- Hitbox
    HitboxEnabled = false,
    HitboxSize = 10,
    HitboxTransparency = 0.7,
    HitboxVisible = true,

    -- Binds
    Binds = {
        ["sprint enabled"] = Enum.KeyCode.LeftShift,
        ["infinite jump"] = nil,
        ["noclip"] = nil,
        ["fly enabled"] = nil,
        ["click tp"] = nil,
        ["esp enabled"] = nil,
        ["fullbright"] = nil,
        ["air jump"] = nil,
        ["long jump"] = nil,
        ["tracers"] = nil,
        ["rejoin"] = nil,
        ["glide"] = nil,
        ["fake lag"] = nil,
        ["hitbox"] = nil,
    }
}

return Config