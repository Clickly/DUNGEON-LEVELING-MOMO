local oldGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("LockTargetUI")
if oldGui then
    oldGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Footer = Instance.new("TextLabel")
local CollapseButton = Instance.new("TextButton") -- ปุ่มย่อ
local AutoLockButton = Instance.new("TextButton") -- ปุ่มขยาย

ScreenGui.Name = "LockTargetUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.75, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 120)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -25, 0.25, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.Font = Enum.Font.Cartoon
Title.Text = "Lock Target"
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left

CollapseButton.Name = "CollapseButton"
CollapseButton.Parent = MainFrame
CollapseButton.Position = UDim2.new(1, -25, 0, 0)
CollapseButton.Size = UDim2.new(0, 20, 0, 20)
CollapseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CollapseButton.TextColor3 = Color3.new(1, 1, 1)
CollapseButton.Text = "-"
CollapseButton.Font = Enum.Font.GothamBold
CollapseButton.TextSize = 18
CollapseButton.BorderSizePixel = 0

Footer.Name = "Footer"
Footer.Parent = MainFrame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0.05, 0, 0.75, 0)
Footer.Size = UDim2.new(0.9, 0, 0.2, 0)
Footer.Font = Enum.Font.Cartoon
Footer.Text = "YouTube: MOMO MI"
Footer.TextSize = 16
Footer.TextColor3 = Color3.fromRGB(255, 255, 255)
Footer.TextXAlignment = Enum.TextXAlignment.Left

-- ปุ่ม Auto Lock
AutoLockButton.Name = "AutoLockButton"
AutoLockButton.Parent = MainFrame
AutoLockButton.Position = UDim2.new(0.05, 0, 0.55, 0)
AutoLockButton.Size = UDim2.new(0.9, 0, 0.2, 0)
AutoLockButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AutoLockButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
AutoLockButton.Font = Enum.Font.Cartoon
AutoLockButton.Text = "Auto Lock: Off"
AutoLockButton.TextSize = 18
AutoLockButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ตัวแปรเก็บสถานะของ Auto Lock
local autoLockEnabled = false
local target = nil

-- ฟังก์ชันการเลือกเป้าหมายจากโฟลเดอร์ Characters
local function getTargetFromCharactersFolder()
    for _, character in pairs(workspace.Characters:GetChildren()) do
        if character:IsA("Model") and character:FindFirstChild("Head") then
            return character -- เลือกตัวละครที่มีส่วนหัว
        end
    end
    return nil -- หากไม่พบเป้าหมาย
end

-- ฟังก์ชันที่ให้ตัวละครหันหน้าไปหามอนสเตอร์
local function faceTarget()
    if target then
        local targetPosition = target:WaitForChild("Head").Position
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- คำนวณทิศทางที่ตัวละครต้องหันไป
            local direction = (targetPosition - character.HumanoidRootPart.Position).unit
            -- หันหน้าไปที่ทิศทางเป้าหมาย
            character:SetPrimaryPartCFrame(CFrame.lookAt(character.HumanoidRootPart.Position, targetPosition))
        end
    end
end

-- ฟังก์ชันตรวจสอบว่าเป้าหมายตายหรือไม่
local function isTargetDead()
    if target and target:FindFirstChild("Humanoid") then
        return target.Humanoid.Health <= 0
    end
    return false
end

-- ฟังก์ชันเลือกเป้าหมายใหม่หากเป้าหมายตาย
local function updateTarget()
    if isTargetDead() then
        target = getTargetFromCharactersFolder() -- เลือกเป้าหมายใหม่
    end
end

-- การอัปเดตตำแหน่งในทุกเฟรม
game:GetService("RunService").RenderStepped:Connect(function()
    if autoLockEnabled then
        updateTarget() -- อัปเดตเป้าหมายหากจำเป็น
        faceTarget()   -- ให้ตัวละครหันหน้าไปหามอนสเตอร์ทุกเฟรม
    end
end)

-- Collapse / Expand UI
local collapsed = false
CollapseButton.MouseButton1Click:Connect(function()
    collapsed = not collapsed

    if collapsed then
        Footer.Visible = false
        MainFrame.Size = UDim2.new(0, 200, 0, 30)
        CollapseButton.Text = "+"
    else
        Footer.Visible = true
        MainFrame.Size = UDim2.new(0, 200, 0, 120)
        CollapseButton.Text = "-"
    end
end)

-- เปลี่ยนสถานะ Auto Lock เมื่อคลิกปุ่ม
AutoLockButton.MouseButton1Click:Connect(function()
    autoLockEnabled = not autoLockEnabled
    if autoLockEnabled then
        AutoLockButton.Text = "Auto Lock: On"
        AutoLockButton.TextColor3 = Color3.fromRGB(0, 255, 0) -- เปลี่ยนสีเมื่อเปิด Auto Lock
    else
        AutoLockButton.Text = "Auto Lock: Off"
        AutoLockButton.TextColor3 = Color3.fromRGB(255, 0, 0) -- เปลี่ยนสีเมื่อปิด Auto Lock
    end
end)

-- เลือกเป้าหมายจากโฟลเดอร์ Characters เมื่อเริ่มต้น
target = getTargetFromCharactersFolder()
