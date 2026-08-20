local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--------------------------------------------------
-- SETTINGS
--------------------------------------------------

local MASTER_ENABLED = true

local ESP_ENABLED = true
local PLAYER_INFO_ENABLED = true
local AIMLOCK_ENABLED = true
local FOV_ENABLED = true
local SILENT_AIM_AI_ENABLED = false

local FOV_RADIUS = 250

--------------------------------------------------
-- VISUALS
--------------------------------------------------

Lighting.Brightness = 3
Lighting.ExposureCompensation = 1
Lighting.ClockTime = 14

Lighting.FogStart = 100000
Lighting.FogEnd = 100000

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")

gui.Name = "PlayerControlPanel"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = PlayerGui

--------------------------------------------------
-- FOV
--------------------------------------------------

local fov = Instance.new("Frame")

fov.Size =
	UDim2.fromOffset(
		FOV_RADIUS * 2,
		FOV_RADIUS * 2
	)

fov.AnchorPoint =
	Vector2.new(0.5, 0.5)

fov.BackgroundTransparency = 1
fov.Visible = true
fov.Parent = gui

local fovCorner =
	Instance.new("UICorner")

fovCorner.CornerRadius =
	UDim.new(1, 0)

fovCorner.Parent = fov

local stroke =
	Instance.new("UIStroke")

stroke.Color =
	Color3.fromRGB(255, 255, 255)

stroke.Thickness = 2
stroke.Transparency = 0.15
stroke.Parent = fov

--------------------------------------------------
-- PANEL
--------------------------------------------------

local panel = Instance.new("Frame")

panel.Size =
	UDim2.fromOffset(330, 455)

panel.Position =
	UDim2.new(0, 30, 0.5, -225)

panel.BackgroundColor3 =
	Color3.fromRGB(24, 24, 30)

panel.BorderSizePixel = 0
panel.Parent = gui

local panelCorner =
	Instance.new("UICorner")

panelCorner.CornerRadius =
	UDim.new(0, 12)

panelCorner.Parent = panel

--------------------------------------------------
-- TITLE
--------------------------------------------------

local title =
	Instance.new("TextLabel")

title.Size =
	UDim2.new(1, -55, 0, 50)

title.Position =
	UDim2.fromOffset(15, 0)

title.BackgroundTransparency = 1

title.Text =
	"PLAYER CONTROL"

title.TextColor3 =
	Color3.fromRGB(255, 255, 255)

title.Font =
	Enum.Font.GothamBold

title.TextSize = 19

title.TextXAlignment =
	Enum.TextXAlignment.Left

title.Parent = panel

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

local minimize =
	Instance.new("TextButton")

minimize.Size =
	UDim2.fromOffset(35, 35)

minimize.Position =
	UDim2.new(1, -45, 0, 8)

minimize.Text = "−"

minimize.TextColor3 =
	Color3.fromRGB(255, 255, 255)

minimize.Font =
	Enum.Font.GothamBold

minimize.TextSize = 22

minimize.BackgroundColor3 =
	Color3.fromRGB(50, 50, 60)

minimize.Parent = panel

local mc =
	Instance.new("UICorner")

mc.CornerRadius =
	UDim.new(0, 8)

mc.Parent = minimize

--------------------------------------------------
-- TOGGLE CREATOR
--------------------------------------------------

local function createToggle(text, y, getter, setter)

	local button =
		Instance.new("TextButton")

	button.Size =
		UDim2.new(1, -30, 0, 42)

	button.Position =
		UDim2.fromOffset(15, y)

	button.BorderSizePixel = 0

	button.Font =
		Enum.Font.GothamBold

	button.TextSize = 14

	button.TextColor3 =
		Color3.fromRGB(255, 255, 255)

	button.Parent = panel

	local corner =
		Instance.new("UICorner")

	corner.CornerRadius =
		UDim.new(0, 8)

	corner.Parent = button

	local function update()

		if getter() then

			button.Text =
				text .. "    [ ON ]"

			button.BackgroundColor3 =
				Color3.fromRGB(45, 120, 70)

		else

			button.Text =
				text .. "    [ OFF ]"

			button.BackgroundColor3 =
				Color3.fromRGB(55, 55, 65)

		end
	end

	button.MouseButton1Click:Connect(
		function()

			setter(not getter())

			update()

		end
	)

	update()

	return button
end

--------------------------------------------------
-- BUTTONS
--------------------------------------------------

createToggle(
	"MASTER",
	60,
	function()
		return MASTER_ENABLED
	end,
	function(value)
		MASTER_ENABLED = value
	end
)

createToggle(
	"ESP",
	108,
	function()
		return ESP_ENABLED
	end,
	function(value)
		ESP_ENABLED = value
	end
)

createToggle(
	"PLAYER INFO",
	156,
	function()
		return PLAYER_INFO_ENABLED
	end,
	function(value)
		PLAYER_INFO_ENABLED = value
	end
)

createToggle(
	"AIM LOCK",
	204,
	function()
		return AIMLOCK_ENABLED
	end,
	function(value)
		AIMLOCK_ENABLED = value
	end
)

createToggle(
	"FOV CIRCLE",
	252,
	function()
		return FOV_ENABLED
	end,
	function(value)
		FOV_ENABLED = value
	end
)

createToggle(
	"SILENT AIM AI",
	300,
	function()
		return SILENT_AIM_AI_ENABLED
	end,
	function(value)

		SILENT_AIM_AI_ENABLED = value

		if _G.SetSilentAimAI then
			_G.SetSilentAimAI(value)
		end

	end
)

--------------------------------------------------
-- FOV CONTROL
--------------------------------------------------

local fovLabel =
	Instance.new("TextLabel")

fovLabel.Size =
	UDim2.fromOffset(120, 40)

fovLabel.Position =
	UDim2.fromOffset(15, 355)

fovLabel.BackgroundTransparency = 1

fovLabel.TextColor3 =
	Color3.fromRGB(255, 255, 255)

fovLabel.Font =
	Enum.Font.GothamBold

fovLabel.TextSize = 14

fovLabel.TextXAlignment =
	Enum.TextXAlignment.Left

fovLabel.Parent = panel

local minus =
	Instance.new("TextButton")

minus.Size =
	UDim2.fromOffset(45, 40)

minus.Position =
	UDim2.fromOffset(145, 355)

minus.Text = "−"

minus.Font =
	Enum.Font.GothamBold

minus.TextSize = 22

minus.TextColor3 =
	Color3.fromRGB(255, 255, 255)

minus.BackgroundColor3 =
	Color3.fromRGB(50, 50, 60)

minus.Parent = panel

local plus =
	Instance.new("TextButton")

plus.Size =
	UDim2.fromOffset(45, 40)

plus.Position =
	UDim2.fromOffset(205, 355)

plus.Text = "+"

plus.Font =
	Enum.Font.GothamBold

plus.TextSize = 22

plus.TextColor3 =
	Color3.fromRGB(255, 255, 255)

plus.BackgroundColor3 =
	Color3.fromRGB(50, 50, 60)

plus.Parent = panel

local function updateFOV()

	fovLabel.Text =
		"FOV: " .. FOV_RADIUS

	fov.Size =
		UDim2.fromOffset(
			FOV_RADIUS * 2,
			FOV_RADIUS * 2
		)

	if _G.SetSilentAimFOV then
		_G.SetSilentAimFOV(FOV_RADIUS)
	end
end

minus.MouseButton1Click:Connect(
	function()

		FOV_RADIUS =
			math.max(
				50,
				FOV_RADIUS - 25
			)

		updateFOV()
	end
)

plus.MouseButton1Click:Connect(
	function()

		FOV_RADIUS =
			math.min(
				600,
				FOV_RADIUS + 25
			)

		updateFOV()
	end
)

updateFOV()

--------------------------------------------------
-- RMB AIM LOCK
--------------------------------------------------

local aiming = false

local function getClosestTarget()

	local camera =
		workspace.CurrentCamera

	if not camera then
		return nil
	end

	local mouse =
		UserInputService:GetMouseLocation()

	local closest
	local closestDistance =
		FOV_RADIUS

	for _, player in ipairs(
		Players:GetPlayers()
	) do

		if player ~= LocalPlayer then

			local character =
				player.Character

			if character then

				local humanoid =
					character:FindFirstChildOfClass(
						"Humanoid"
					)

				local head =
					character:FindFirstChild("Head")

				if humanoid
					and humanoid.Health > 0
					and head then

					local position, onScreen =
						camera:WorldToViewportPoint(
							head.Position
						)

					if onScreen
						and position.Z > 0 then

						local distance =
							(
								Vector2.new(
									position.X,
									position.Y
								)
								- mouse
							).Magnitude

						if distance <=
							closestDistance then

							closestDistance =
								distance

							closest = head
						end
					end
				end
			end
		end
	end

	return closest
end

UserInputService.InputBegan:Connect(
	function(input, processed)

		if processed then
			return
		end

		if input.UserInputType ==
			Enum.UserInputType.MouseButton2 then

			if MASTER_ENABLED
				and AIMLOCK_ENABLED then

				aiming = true
			end
		end
	end
)

UserInputService.InputEnded:Connect(
	function(input)

		if input.UserInputType ==
			Enum.UserInputType.MouseButton2 then

			aiming = false
		end
	end
)

--------------------------------------------------
-- F1
--------------------------------------------------

UserInputService.InputBegan:Connect(
	function(input, processed)

		if processed then
			return
		end

		if input.KeyCode ==
			Enum.KeyCode.F1 then

			MASTER_ENABLED =
				not MASTER_ENABLED

			if not MASTER_ENABLED then
				aiming = false
			end
		end
	end
)

--------------------------------------------------
-- RIGHT SHIFT
--------------------------------------------------

UserInputService.InputBegan:Connect(
	function(input, processed)

		if processed then
			return
		end

		if input.KeyCode ==
			Enum.KeyCode.RightShift then

			panel.Visible =
				not panel.Visible

		end
	end
)

--------------------------------------------------
-- MAIN LOOP
--------------------------------------------------

RunService:BindToRenderStep(
	"PlayerControl",
	Enum.RenderPriority.Camera.Value + 1,

	function()

		local camera =
			workspace.CurrentCamera

		if not camera then
			return
		end

		local mouse =
			UserInputService:GetMouseLocation()

		fov.Position =
			UDim2.fromOffset(
				mouse.X,
				mouse.Y
			)

		fov.Visible =
			MASTER_ENABLED
			and FOV_ENABLED

		if not MASTER_ENABLED
			or not AIMLOCK_ENABLED
			or not aiming then

			return
		end

		local target =
			getClosestTarget()

		if target then

			camera.CFrame =
				CFrame.lookAt(
					camera.CFrame.Position,
					target.Position
				)

		end
	end
)

print("Complete Player Control loaded")
print("F1 = Master ON/OFF")
print("RightShift = Panel")
print("RMB = Aim Lock")
print("Silent Aim AI = Panel toggle")
