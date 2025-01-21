-- โหลด Library ของ UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Key ที่ถูกต้อง
local CorrectKey = "MOMOMI00SHOP1"

-- ฟังก์ชันสำหรับตรวจสอบ Key
local function checkKey(inputKey)
    return inputKey == CorrectKey
end

-- UI สำหรับกรอก Key
local KeyGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local Button = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")
local LinkLabel = Instance.new("TextLabel")
local ImageFrame = Instance.new("Frame")
local ImageButton = Instance.new("ImageButton")
local UIStroke = Instance.new("UIStroke")

-- ตั้งค่า GUI
KeyGui.Name = "KeyGui"
KeyGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Name = "KeyFrame"
Frame.Parent = KeyGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Position = UDim2.new(0.35, 0, 0.4, 0)
Frame.Size = UDim2.new(0.3, 0, 0.4, 0)

UICorner.CornerRadius = UDim.new(0.1, 0)
UICorner.Parent = Frame

UIStroke.Parent = Frame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 170, 255)

TextBox.Name = "KeyTextBox"
TextBox.Parent = Frame
TextBox.Size = UDim2.new(0.8, 0, 0.15, 0)
TextBox.Position = UDim2.new(0.1, 0, 0.15, 0)
TextBox.PlaceholderText = "Enter your key"
TextBox.Text = ""
TextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 16

Button.Name = "SubmitButton"
Button.Parent = Frame
Button.Size = UDim2.new(0.8, 0, 0.15, 0)
Button.Position = UDim2.new(0.1, 0, 0.35, 0)
Button.Text = "Submit Key"
Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.Gotham
Button.TextSize = 16

ButtonCorner.CornerRadius = UDim.new(0.1, 0)
ButtonCorner.Parent = Button

LinkLabel.Name = "LinkLabel"
LinkLabel.Parent = Frame
LinkLabel.Size = UDim2.new(0.8, 0, 0.15, 0)
LinkLabel.Position = UDim2.new(0.1, 0, 0.55, 0)
LinkLabel.Text = "Click here to get your https://sub4unlock.io/trwMO"
LinkLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LinkLabel.BackgroundTransparency = 1
LinkLabel.TextWrapped = true
LinkLabel.Font = Enum.Font.Gotham
LinkLabel.TextSize = 14

-- UI สำหรับแสดงรูปภาพ
ImageFrame.Name = "ImageFrame"
ImageFrame.Parent = Frame
ImageFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ImageFrame.Position = UDim2.new(0.1, 0, 0.75, 0)
ImageFrame.Size = UDim2.new(0.8, 0, 0.2, 0)
ImageFrame.Visible = false

ImageButton.Name = "ImageButton"
ImageButton.Parent = ImageFrame
ImageButton.Size = UDim2.new(1, 0, 1, 0)
ImageButton.Image = "rbxassetid://12345678" -- เปลี่ยนเป็น Asset ID ของรูปภาพที่ต้องการ

UIStroke.Parent = ImageFrame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255, 255, 255)

-- ฟังก์ชันเปิด/ปิด ImageFrame
local isImageFrameVisible = false
local function toggleImageFrame()
    isImageFrameVisible = not isImageFrameVisible
    ImageFrame.Visible = isImageFrameVisible
end

ImageButton.MouseButton1Click:Connect(function()
    toggleImageFrame()
end)

-- ฟังก์ชันตรวจสอบ Key และแสดง UI
Button.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    if checkKey(enteredKey) then
        print("Correct Key! Showing UI...")
        KeyGui:Destroy() -- ลบ GUI ของ Key
        -- เปิด UI หลัก
        local Window = Library.CreateLib("MOMO HUB", "DarkTheme")

        local Tab = Window:NewTab("DUPE")
        local Section = Tab:NewSection("DUPE")

        Section:NewToggle("UTC", "DUPE", function(state)
            if state then
                print("DUPE Enabled")
            else
                print("DUPE Disabled")
            end
        end)

    else
        print("Incorrect Key! Please try again.")
        TextBox.Text = "" -- ล้างข้อความใน TextBox
    end
end)
