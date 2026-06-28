-- NeverLose — UI Animations

local Animations = {}

function Animations.ShowMenu(MainFrame)
	MainFrame.Visible = true
end

function Animations.HideMenu(MainFrame)
	MainFrame.Visible = false
end

return Animations
