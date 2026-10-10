--[[
    ╔══════════════════════════════════════╗
    ║          AZAM HUB v1.0               ║
    ║    Steal Egg + Speed + Inf Jump      ║
    ║         Created by Azam              ║
    ╚══════════════════════════════════════╝
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

--=================== CONFIG ===================-- 
local CONFIG = {
    SPEED = 1000,
    JUMP_POWER = 200,
    AUTO_STEAL = true,
    STEAL_INTERVAL = 0.1,
    RARITY_FILTER = "All", -- All, Common, Uncommon, Rare, Epic, Legendary, Mythic
    IMAGE_URL = "https://ibb.co.com/xSDsX1dR", -- ganti dengan link gambarmu
    HUB_NAME = "AzamHub",
}

--=================== SAFE DELETE GUI LAMA ===================--
if CoreGui:FindFirstChild(CONFIG.HUB_NAME) then
    CoreGui[CONFIG.HUB_NAME]:Destroy()
end
if game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(CONFIG.HUB_NAME) then
    game:GetService("Players").LocalPlayer.PlayerGui[CONFIG.HUB_NAME]:Destroy()
end

--=================== BIKIN GUI ===================--
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = CONFIG.HUB_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Tombol Toggle
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "Toggle"
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(229, 35, 50)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "AZ"
ToggleBtn.TextSize = 24
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 15)

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 500)
Main.Position = UDim2.new(0.5, -170, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(229, 35, 50)
MainStroke.Thickness = 2
MainStroke.Parent = Main

-- ================= BANNER GAMBAR =================
local BannerFrame = Instance.new("Frame")
BannerFrame.Size = UDim2.new(1, 0, 0, 150)
BannerFrame.Position = UDim2.new(0, 0, 0, 0)
BannerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
BannerFrame.BorderSizePixel = 0
BannerFrame.Parent = Main
Instance.new("UICorner", BannerFrame).CornerRadius = UDim.new(0, 18)

-- Fix corner (cuma sudut atas)
local BannerFix = Instance.new("Frame")
BannerFix.Size = UDim2.new(1, 0, 0, 20)
BannerFix.Position = UDim2.new(0, 0, 1, -20)
BannerFix.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
BannerFix.BorderSizePixel = 0
BannerFix.Parent = BannerFrame

local BannerImage = Instance.new("ImageLabel")
BannerImage.Size = UDim2.new(1, 0, 1, 0)
BannerImage.BackgroundTransparency = 1
BannerImage.Image = CONFIG.IMAGE_URL
BannerImage.ScaleType = Enum.ScaleType.Crop
BannerImage.Parent = BannerFrame

-- Overlay gelap biar teks kebaca
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.4
Overlay.BorderSizePixel = 0
Overlay.Parent = BannerFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 1, -60)
Title.BackgroundTransparency = 1
Title.Text = "AZAM HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 32
Title.Font = Enum.Font.GothamBlack
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.Parent = BannerFrame

local Subtitle = UDim2.new(1, 0, 0, 20)
local Sub = Instance.new("TextLabel")
Sub.Size = Subtitle
Sub.Position = UDim2.new(0, 0, 1, -25)
Sub.BackgroundTransparency = 1
Sub.Text = "Steal Egg • Speed • Inf Jump"
Sub.TextColor3 = Color3.fromRGB(229, 35, 50)
Sub.TextSize = 12
Sub.Font = Enum.Font.GothamBold
Sub.Parent = BannerFrame

-- ================= CONTENT AREA =================
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -170)
Content.Position = UDim2.new(0, 10, 0, 160)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function makeButton(text, yPos, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 42)
    Btn.Position = UDim2.new(0, 0, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = text
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = true
    Btn.Parent = Content
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 60, 75)
    stroke.Thickness = 1
    stroke.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        callback(Btn)
    end)
    return Btn
end

--=================== SPEED ===================--
local speedEnabled = false
local speedBtn = makeButton("⚡ Speed: OFF (1000x)", 0, function(btn)
    speedEnabled = not speedEnabled
    if speedEnabled then
        btn.Text = "⚡ Speed: ON (1000x)"
        btn.BackgroundColor3 = Color3.fromRGB(229, 35, 50)
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = CONFIG.SPEED end
    else
        btn.Text = "⚡ Speed: OFF (1000x)"
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
end)

-- Loop speed (kalau game reset speednya)
task.spawn(function()
    while task.wait(0.5) do
        if speedEnabled then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.WalkSpeed ~= CONFIG.SPEED then
                    hum.WalkSpeed = CONFIG.SPEED
                end
            end
        end
    end
end)

--=================== INFINITE JUMP ===================--
local infJumpEnabled = false
local infJumpBtn = makeButton("🦘 Infinite Jump: OFF", 52, function(btn)
    infJumpEnabled = not infJumpEnabled
    if infJumpEnabled then
        btn.Text = "🦘 Infinite Jump: ON"
        btn.BackgroundColor3 = Color3.fromRGB(229, 35, 50)
    else
        btn.Text = "🦘 Infinite Jump: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

--=================== AUTO STEAL EGG ===================--
local autoStealEnabled = false
local eggsStolen = 0

local autoStealBtn = makeButton("🥚 Auto Steal Egg: OFF", 104, function(btn)
    autoStealEnabled = not autoStealEnabled
    if autoStealEnabled then
        btn.Text = "🥚 Auto Steal Egg: ON"
        btn.BackgroundColor3 = Color3.fromRGB(229, 35, 50)
    else
        btn.Text = "🥚 Auto Steal Egg: OFF"
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    end
end)

-- Rarity Selector
local RarityLabel = Instance.new("TextLabel")
RarityLabel.Size = UDim2.new(1, 0, 0, 20)
RarityLabel.Position = UDim2.new(0, 0, 0, 150)
RarityLabel.BackgroundTransparency = 1
RarityLabel.Text = "🎯 Rarity Target:"
RarityLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
RarityLabel.TextSize = 12
RarityLabel.Font = Enum.Font.GothamBold
RarityLabel.TextXAlignment = Enum.TextXAlignment.Left
RarityLabel.Parent = Content

local RarityDropdown = Instance.new("TextButton")
RarityDropdown.Size = UDim2.new(1, 0, 0, 38)
RarityDropdown.Position = UDim2.new(0, 0, 0, 172)
RarityDropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
RarityDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
RarityDropdown.Text = "All ▼"
RarityDropdown.TextSize = 13
RarityDropdown.Font = Enum.Font.GothamBold
RarityDropdown.BorderSizePixel = 0
RarityDropdown.Parent = Content
Instance.new("UICorner", RarityDropdown).CornerRadius = UDim.new(0, 10)

local rarities = {"All", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret"}
local rarityIdx = 1

local DropdownList = Instance.new("Frame")
DropdownList.Size = UDim2.new(1, 0, 0, 0)
DropdownList.Position = UDim2.new(0, 0, 1, 2)
DropdownList.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
DropdownList.BorderSizePixel = 0
DropdownList.ClipsDescendants = true
DropdownList.Visible = false
DropdownList.Parent = RarityDropdown
Instance.new("UICorner", DropdownList).CornerRadius = UDim.new(0, 8)

for i, rar in ipairs(rarities) do
    local opt = Instance.new("TextButton")
    opt.Size = UDim2.new(1, 0, 0, 30)
    opt.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    opt.BackgroundTransparency = 1
    opt.TextColor3 = Color3.fromRGB(220, 220, 220)
    opt.Text = rar
    opt.TextSize = 12
    opt.Font = Enum.Font.Gotham
    opt.Parent = DropdownList
    
    opt.MouseButton1Click:Connect(function()
        rarityIdx = i
        CONFIG.RARITY_FILTER = rar
        RarityDropdown.Text = rar .. " ▼"
        DropdownList.Visible = false
        DropdownList.Size = UDim2.new(1, 0, 0, 0)
    end)
end

RarityDropdown.MouseButton1Click:Connect(function()
    if DropdownList.Visible then
        DropdownList.Visible = false
        DropdownList.Size = UDim2.new(1, 0, 0, 0)
    else
        DropdownList.Visible = true
        DropdownList.Size = UDim2.new(1, 0, 0, #rarities * 30)
    end
end)

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.Position = UDim2.new(0, 0, 0, 220)
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
StatusLabel.Text = "🥚 Eggs stolen: 0"
StatusLabel.TextSize = 13
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.BorderSizePixel = 0
StatusLabel.Parent = Content
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 8)

-- ================= AUTO STEAL LOGIC =================
-- Cari egg di workspace
local function findEggs()
    local eggs = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Deteksi objek yang namanya mengandung "Egg" atau punya atribut "Rarity"
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = string.lower(obj.Name)
            if string.find(name, "egg") then
                table.insert(eggs, obj)
            end
        end
    end
    return eggs
end

-- Cek rarity dari atribut/tag
local function getRarity(obj)
    if obj:GetAttribute("Rarity") then return obj:GetAttribute("Rarity") end
    if obj:GetAttribute("rarity") then return obj:GetAttribute("rarity") end
    for _, tag in pairs(obj:GetTags()) do
        if string.find(string.lower(tag), "rarity") then return tag end
    end
    return "Unknown"
end

-- Teleport ke egg & ambil
local function stealEgg(egg)
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    -- Cari posisi egg
    local targetPos
    if egg:IsA("BasePart") then
        targetPos = egg.Position
    else
        local pp = egg:FindFirstChildWhichIsA("BasePart", true)
        if pp then targetPos = pp.Position end
    end
    if not targetPos then return false end
    
    -- Teleport
    hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 5, 0))
    
    -- Coba fire proximity prompt / click detector kalau ada
    for _, desc in pairs(egg:GetDescendants()) do
        if desc:IsA("ProximityPrompt") then
            pcall(function()
                fireproximityprompt(desc)
            end)
        elseif desc:IsA("ClickDetector") then
            pcall(function()
                fireclickdetector(desc)
            end)
        end
    end
    
    return true
end

task.spawn(function()
    while task.wait(CONFIG.STEAL_INTERVAL) do
        if autoStealEnabled then
            local eggs = findEggs()
            for _, egg in ipairs(eggs) do
                local rarity = getRarity(egg)
                if CONFIG.RARITY_FILTER == "All" or rarity == CONFIG.RARITY_FILTER then
                    if stealEgg(egg) then
                        eggsStolen += 1
                        StatusLabel.Text = "🥚 Eggs stolen: " .. eggsStolen .. " (" .. rarity .. ")"
                    end
                end
            end
        end
    end
end)

--=================== TOGGLE MINIMIZE ===================--
local isOpen = true
ToggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        TweenService:Create(Main, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -170, 0.5, -250)}):Play()
    else
        TweenService:Create(Main, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -170, 1.5, -250)}):Play()
    end
end)

--=================== DRAG FRAME ===================--
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
BannerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
BannerFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

--=================== NOTIF ===================--
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AzamHub",
    Text = "Script loaded! Selamat pakai 🥚",
    Duration = 5,
})

print("[AzamHub] Loaded successfully!")