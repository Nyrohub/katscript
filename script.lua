-- Required libraries
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")

-- Function to aim the player at the nearest enemy
function aimbot()
    local player = Players.LocalPlayer
    local nearestEnemy = nil
    local nearestDistance = math.huge

    for _, enemyPlayer in pairs(Players:GetPlayers()) do
        if enemyPlayer ~= Players.LocalPlayer then
            local distance = (enemyPlayer.Character.Head.Position - player.Character.Head.Position).Magnitude
            if distance < nearestDistance then
                nearestEnemy = enemyPlayer
                nearestDistance = distance
            end
        end
    end

    if nearestEnemy ~= nil then
        player.Character.Humanoid.AutoRotate = false
        player.Character.Humanoid:MoveTo(nearestEnemy.Character.Head.Position)
        wait(0.1)
        player.Character.Humanoid.AutoRotate = true
    end
end

-- Function to enable ESP (enemy spotting)
function enableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            player.Character.Head.Transparency = 0.5
        end
    end
end

-- Function to disable ESP
function disableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            player.Character.Head.Transparency = 1
        end
    end
end

-- Function to perform a wallshot (shoot through walls)
function wallshot()
    local player = Players.LocalPlayer
    local rayOrigin = player.Character.Head.Position
    local rayDirection = player.Character.Head.CFrame.LookVector

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {player.Character}

    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

    if raycastResult then
        local hitPart = raycastResult.Instance
        if hitPart:IsA("BasePart") then
            hitPart:BreakJoints()
        end
    end
end

-- Function to enable infinite yield
function enableInfiniteYield()
    Players.LocalPlayer.Character.Humanoid.AutoRotate = false
    Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
end

-- Function to disable infinite yield
function disableInfiniteYield()
    Players.LocalPlayer.Character.Humanoid.AutoRotate = true
    Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end

-- Function to kill all players (except the user)
function killAllPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            player.Character.Humanoid:TakeDamage(100)
        end
    end
end

-- GUI setup
local gui = Instance.new("Nyrohub")
local mainFrame = Instance.new("main")
local aimbotButton = Instance.new("aimbot")
local espButton = Instance.new("esp")
local wallshotButton = Instance.new("wallshots")
local infiniteYieldButton = Instance.new("inf yield")
local killAllButton = Instance.new("killall")

gui.Parent = CoreGui

mainFrame.Parent = gui
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BackgroundTransparency = 0.5
mainFrame.Position = UDim2.new(0, 0, 0, 0)
mainFrame.Size = UDim2.new(0, 200, 0, 300)

aimbotButton.Parent = mainFrame
aimbotButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
aimbotButton.Text = "Aimbot"
aimbotButton.Size = UDim2.new(0, 100, 0, 30)
aimbotButton.Position = UDim2.new(0, 50, 0, 50)
aimbotButton.MouseButton1Click:Connect(function()
    aimbot()
end)

espButton.Parent = mainFrame
espButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
espButton.Text = "ESP"
espButton.Size = UDim2.new(0, 100, 0, 30)
espButton.Position = UDim2.new(0, 50, 0, 90)
espButton.MouseButton1Click:Connect(function()
    enableESP()
    wait(5)
    disableESP()
end)

wallshotButton.Parent = mainFrame
wallshotButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
wallshotButton.Text = "Wallshot"
wallshotButton.Size = UDim2.new(0, 100, 0, 30)
wallshotButton.Position = UDim2.new(0, 50, 0, 130)
wallshotButton.MouseButton1Click:Connect(function()
    wallshot()
end)

infiniteYieldButton.Parent = mainFrame
infiniteYieldButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
infiniteYieldButton.Text = "Infinite Yield"
infiniteYieldButton.Size = UDim2.new(0, 100, 0, 30)
infiniteYieldButton.Position = UDim2.new(0, 50, 0, 170)
infiniteYieldButton.MouseButton1Click:Connect(function()
    enableInfiniteYield()
    wait(5)
    disableInfiniteYield()
end)

killAllButton.Parent = mainFrame
killAllButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
killAllButton.Text = "Kill All"
killAllButton.Size = UDim2.new(0, 100, 0, 30)
killAllButton.Position = UDim2.new(0, 50, 0, 210)
killAllButton.MouseButton1Click:Connect(function()
    killAllPlayers()
end)
