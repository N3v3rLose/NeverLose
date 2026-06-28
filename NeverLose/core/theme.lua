-- NeverLose — Theme System

local Theme = {}

Theme.Themes = {
	["crimson"] = {
		Name             = "crimson",
		Accent           = Color3.fromRGB(180, 50, 50),
		AccentLight      = Color3.fromRGB(220, 80, 80),
		AccentDark       = Color3.fromRGB(140, 35, 35),
		Background       = Color3.fromRGB(18, 18, 22),
		BackgroundAlt    = Color3.fromRGB(24, 24, 30),
		Surface          = Color3.fromRGB(30, 30, 38),
		SurfaceAlt       = Color3.fromRGB(38, 38, 48),
		Border           = Color3.fromRGB(50, 50, 62),
		TextPrimary      = Color3.fromRGB(220, 220, 230),
		TextSecondary    = Color3.fromRGB(140, 140, 155),
		TextDim          = Color3.fromRGB(80, 80, 95),
		Success          = Color3.fromRGB(50, 200, 100),
		Warning          = Color3.fromRGB(220, 180, 50),
		TopBarGradient1  = Color3.fromRGB(180, 50, 50),
		TopBarGradient2  = Color3.fromRGB(220, 80, 60),
	},
	["ocean"] = {
		Name             = "ocean",
		Accent           = Color3.fromRGB(40, 120, 200),
		AccentLight      = Color3.fromRGB(70, 150, 230),
		AccentDark       = Color3.fromRGB(25, 85, 160),
		Background       = Color3.fromRGB(14, 18, 26),
		BackgroundAlt    = Color3.fromRGB(18, 24, 35),
		Surface          = Color3.fromRGB(24, 32, 45),
		SurfaceAlt       = Color3.fromRGB(32, 42, 58),
		Border           = Color3.fromRGB(40, 55, 75),
		TextPrimary      = Color3.fromRGB(210, 225, 240),
		TextSecondary    = Color3.fromRGB(130, 150, 175),
		TextDim          = Color3.fromRGB(70, 90, 110),
		Success          = Color3.fromRGB(50, 200, 120),
		Warning          = Color3.fromRGB(220, 180, 50),
		TopBarGradient1  = Color3.fromRGB(40, 120, 200),
		TopBarGradient2  = Color3.fromRGB(60, 180, 220),
	},
	["purple"] = {
		Name             = "purple",
		Accent           = Color3.fromRGB(140, 60, 200),
		AccentLight      = Color3.fromRGB(170, 90, 230),
		AccentDark       = Color3.fromRGB(100, 40, 160),
		Background       = Color3.fromRGB(16, 14, 24),
		BackgroundAlt    = Color3.fromRGB(22, 18, 32),
		Surface          = Color3.fromRGB(28, 24, 42),
		SurfaceAlt       = Color3.fromRGB(38, 32, 55),
		Border           = Color3.fromRGB(55, 45, 72),
		TextPrimary      = Color3.fromRGB(225, 215, 240),
		TextSecondary    = Color3.fromRGB(150, 135, 170),
		TextDim          = Color3.fromRGB(90, 75, 110),
		Success          = Color3.fromRGB(80, 210, 120),
		Warning          = Color3.fromRGB(220, 180, 50),
		TopBarGradient1  = Color3.fromRGB(140, 60, 200),
		TopBarGradient2  = Color3.fromRGB(200, 80, 180),
	},
	["emerald"] = {
		Name             = "emerald",
		Accent           = Color3.fromRGB(40, 180, 100),
		AccentLight      = Color3.fromRGB(60, 210, 130),
		AccentDark       = Color3.fromRGB(25, 140, 75),
		Background       = Color3.fromRGB(14, 20, 18),
		BackgroundAlt    = Color3.fromRGB(18, 26, 22),
		Surface          = Color3.fromRGB(24, 34, 30),
		SurfaceAlt       = Color3.fromRGB(32, 45, 38),
		Border           = Color3.fromRGB(42, 60, 50),
		TextPrimary      = Color3.fromRGB(210, 235, 220),
		TextSecondary    = Color3.fromRGB(130, 160, 145),
		TextDim          = Color3.fromRGB(70, 100, 85),
		Success          = Color3.fromRGB(60, 220, 120),
		Warning          = Color3.fromRGB(220, 180, 50),
		TopBarGradient1  = Color3.fromRGB(40, 180, 100),
		TopBarGradient2  = Color3.fromRGB(60, 220, 160),
	},
	["rose"] = {
		Name             = "rose",
		Accent           = Color3.fromRGB(220, 70, 120),
		AccentLight      = Color3.fromRGB(245, 100, 150),
		AccentDark       = Color3.fromRGB(180, 50, 90),
		Background       = Color3.fromRGB(20, 14, 18),
		BackgroundAlt    = Color3.fromRGB(28, 18, 24),
		Surface          = Color3.fromRGB(36, 24, 32),
		SurfaceAlt       = Color3.fromRGB(48, 32, 42),
		Border           = Color3.fromRGB(65, 42, 55),
		TextPrimary      = Color3.fromRGB(240, 215, 225),
		TextSecondary    = Color3.fromRGB(170, 135, 150),
		TextDim          = Color3.fromRGB(110, 75, 90),
		Success          = Color3.fromRGB(80, 210, 120),
		Warning          = Color3.fromRGB(220, 180, 50),
		TopBarGradient1  = Color3.fromRGB(220, 70, 120),
		TopBarGradient2  = Color3.fromRGB(255, 100, 80),
	},
	["midnight"] = {
		Name             = "midnight",
		Accent           = Color3.fromRGB(100, 100, 180),
		AccentLight      = Color3.fromRGB(130, 130, 210),
		AccentDark       = Color3.fromRGB(70, 70, 140),
		Background       = Color3.fromRGB(10, 10, 16),
		BackgroundAlt    = Color3.fromRGB(14, 14, 22),
		Surface          = Color3.fromRGB(20, 20, 32),
		SurfaceAlt       = Color3.fromRGB(28, 28, 42),
		Border           = Color3.fromRGB(40, 40, 58),
		TextPrimary      = Color3.fromRGB(200, 200, 220),
		TextSecondary    = Color3.fromRGB(120, 120, 150),
		TextDim          = Color3.fromRGB(65, 65, 90),
		Success          = Color3.fromRGB(80, 200, 120),
		Warning          = Color3.fromRGB(220, 180, 50),
		TopBarGradient1  = Color3.fromRGB(80, 80, 160),
		TopBarGradient2  = Color3.fromRGB(140, 100, 200),
	},
}

Theme.currentThemeName = "crimson"

Theme.CustomTheme = {
	UseCustom = false,
	AccentR   = 180,
	AccentG   = 50,
	AccentB   = 50,
}

function Theme.GetTheme()
	if Theme.CustomTheme.UseCustom then
		local base   = Theme.Themes[Theme.currentThemeName]
		local custom = {}
		for k, v in pairs(base) do custom[k] = v end
		custom.Accent = Color3.fromRGB(Theme.CustomTheme.AccentR, Theme.CustomTheme.AccentG, Theme.CustomTheme.AccentB)
		custom.AccentLight = Color3.fromRGB(
			math.min(255, Theme.CustomTheme.AccentR + 40),
			math.min(255, Theme.CustomTheme.AccentG + 40),
			math.min(255, Theme.CustomTheme.AccentB + 40)
		)
		custom.AccentDark = Color3.fromRGB(
			math.max(0, Theme.CustomTheme.AccentR - 40),
			math.max(0, Theme.CustomTheme.AccentG - 40),
			math.max(0, Theme.CustomTheme.AccentB - 40)
		)
		custom.TopBarGradient1 = custom.Accent
		custom.TopBarGradient2 = custom.AccentLight
		return custom
	end
	return Theme.Themes[Theme.currentThemeName]
end

function Theme.GetCurrent()
	return Theme.GetTheme()
end

function Theme.ApplyTheme(Storage)
	local T            = Theme.GetTheme()
	local TweenService = game:GetService("TweenService")

	for _, entry in pairs(Storage.themedElements) do
		local obj  = entry.obj
		local prop = entry.prop
		local key  = entry.key

		if not obj or not obj.Parent then continue end

		if prop == "gradient_topbar" then
			obj.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0,   T.TopBarGradient1),
				ColorSequenceKeypoint.new(0.5, T.TopBarGradient2),
				ColorSequenceKeypoint.new(1,   T.TopBarGradient1),
			}
		elseif key and T[key] then
			pcall(function()
				TweenService:Create(obj, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {[prop] = T[key]}):Play()
			end)
		end
	end

	-- Обновление кнопок вкладок
	for name, data in pairs(Storage.tabButtons) do
		local isActive = (name == Storage.currentTab)
		TweenService:Create(data.btn, TweenInfo.new(0.2), {
			BackgroundColor3 = isActive and T.SurfaceAlt or T.BackgroundAlt
		}):Play()
		data.indicator.BackgroundColor3 = T.Accent
		data.icon.TextColor3   = isActive and T.Accent       or T.TextDim
		data.label.TextColor3  = isActive and T.TextPrimary  or T.TextSecondary
	end
end

return Theme
