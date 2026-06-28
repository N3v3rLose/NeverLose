-- NeverLose — Storage (глобальное хранилище)

local Storage = {
    tabFrames = {},
    tabButtons = {},
    allElements = {},
    toggleCallbacks = {},
    tracerLines = {},
    waypoints = {},
    themedElements = {},
    espObjects = {},
    connections = {},

    guiOpen = false,
    isSprinting = false,
    noclipping = false,
    flying = false,
    currentTab = "movement",
    bindListening = nil,

    -- Ссылки на GUI объекты (заполняются позже)
    ScreenGui = nil,
    MainFrame = nil,
    RightPanel = nil,
    TabHolder = nil,
    LeftPanel = nil,
    TopBar = nil,
    TitleBar = nil,

    -- Fake Lag
    fakeLagIsLagging = false,
    fakeLagLastSwitch = 0,
    fakeLagSavedPos = nil,
    fakeLagIndicator = nil,
    fakeLagLabel = nil,

    -- Jump
    hasDoubleJumped = false,
    lastJumpTick = 0,

    -- Panic
    panicSavedStates = {},
}

-- Общая функция получения ENV (устанавливается позже)
Storage.ENV = nil

return Storage