--[[Script Spy v1.0.0]]--
--[[Made by topit]]--

--[[variables:]]--
local PlayerService = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local plr = PlayerService.LocalPlayer
local scanoccur = false


--script icons uploaded by me
local ScriptIcons = {
    Unknown = "rbxassetid://6755591268",
    Module  = "rbxassetid://6755590361",
    Script  = "rbxassetid://6755590813",
    Local   = "rbxassetid://6755603069"
}

--alternate uploads incase the first one doesnt work
local AltScriptIcons1 = {
    Unknown = "rbxassetid://6755763421",
    Module  = "rbxassetid://6755763921",
    Script  = "rbxassetid://6755764311",
    Local   = "rbxassetid://6755764933"
}

--random ones from other people that work
local AltScriptIcons2 = {
    Unknown = "rbxassetid://49115947",
    Module  = "rbxassetid://5168594717",
    Script  = "rbxassetid://99340892",
    Local   = "rbxassetid://5168599578"
}

local Dragging = {}
local Dragging2 = {}

local CaughtScripts = {}

local IconMenuItems = {}
local ScriptsMenuItems = {}
local DeleteMenuItems = {}
local InfoMenuItems = {}

local version = "1.0.0<font size='20'>-REL</font>" -- -REL (release) -BETA (beta preview) -DEV (developer build) -SUB (sub branch)

--[[themes:]]--

local font = Enum.Font.Nunito

local Theme_Dark = {
	Color3.fromRGB(25, 25, 25),   --Top bar
	Color3.fromRGB(10, 10, 10),   --Background
	Color3.fromRGB(40, 40, 40),   --Border color
	Color3.fromRGB(35, 35, 35),   --Button background
	Color3.fromRGB(20, 20, 20),   --Unused
	Color3.fromRGB(25, 100, 45),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}
local Theme_Steel = {
	Color3.fromRGB(25, 25, 35),   --Top bar
	Color3.fromRGB(10, 10, 20),   --Background
	Color3.fromRGB(40, 40, 50),   --Border color
	Color3.fromRGB(35, 35, 45),   --Button background
	Color3.fromRGB(20, 20, 25),   --Unused
	Color3.fromRGB(25, 100, 55),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}
local Theme_Rust = {
	Color3.fromRGB(45, 25, 25),   
	Color3.fromRGB(30, 10, 10),   
	Color3.fromRGB(60, 40, 40),   
	Color3.fromRGB(55, 35, 35),   
	Color3.fromRGB(40, 20, 20),   
	Color3.fromRGB(45, 100, 45),  
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(255, 245, 255),
	Color3.fromRGB(175, 155, 255) 
}
local Theme_Violet = {
	Color3.fromRGB(35, 25, 45),   --Top bar
	Color3.fromRGB(20, 10, 30),   --Background
	Color3.fromRGB(50, 40, 60),   --Border color
	Color3.fromRGB(45, 35, 55),   --Button background
	Color3.fromRGB(30, 20, 40),   --Unused
	Color3.fromRGB(35, 100, 65),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}
local Theme_Space = {
	Color3.fromRGB(10, 10, 10),   --Top bar
	Color3.fromRGB(0, 0, 0),   --Background
	Color3.fromRGB(20, 20, 20),   --Border color
	Color3.fromRGB(15, 15, 15),   --Button background
	Color3.fromRGB(5, 5, 5),   --Unused
	Color3.fromRGB(20, 25, 50),  --Button highlight
	Color3.fromRGB(255, 255, 255),--Text title
	Color3.fromRGB(245, 245, 255),--Text generic
	Color3.fromRGB(155, 155, 255) --Text highlight
}


local SelectedTheme = math.random(1,5)
if SelectedTheme == 1 then
    SelectedTheme = Theme_Steel
elseif SelectedTheme == 2 then
    SelectedTheme = Theme_Dark
elseif SelectedTheme == 3 then
    SelectedTheme = Theme_Rust
elseif SelectedTheme == 4 then
    SelectedTheme = Theme_Violet
elseif SelectedTheme == 5 then
    SelectedTheme = Theme_Space
end



--[[instances:]]--
local ScreenGui      = Instance.new("ScreenGui")
local TitleBar       = Instance.new("Frame")
local Shadow         = Instance.new("Frame")
local Menu           = Instance.new("ScrollingFrame")
local Display        = Instance.new("ScrollingFrame")

local Title1         = Instance.new("TextLabel")
local Title2         = Instance.new("TextLabel")
local CreditText     = Instance.new("TextLabel")


local ScriptsMenu = {}
ScriptsMenu.Title  = Instance.new("TextLabel")
ScriptsMenu.Menu   = Instance.new("Frame")
ScriptsMenu.Layout = Instance.new("UIListLayout")

local DeleteMenu = {}
DeleteMenu.Menu   = Instance.new("Frame")
DeleteMenu.Layout = Instance.new("UIListLayout")

local InfoMenu = {}
InfoMenu.Menu   = Instance.new("Frame")
InfoMenu.Layout = Instance.new("UIListLayout")

local IconMenu = {}
IconMenu.Menu = Instance.new("Frame")
IconMenu.Layout = Instance.new("UIListLayout")

local Scans = {}
Scans.Game      = Instance.new("TextButton")
Scans.Workspace = Instance.new("TextButton")
Scans.Player    = Instance.new("TextButton")
Scans.Character = Instance.new("TextButton")

local InfoPopup = {}
InfoPopup.TitleBar       = Instance.new("Frame")
InfoPopup.Shadow         = Instance.new("Frame")
InfoPopup.Menu           = Instance.new("ScrollingFrame")
InfoPopup.Title1         = Instance.new("TextLabel")
InfoPopup.Title2         = Instance.new("TextLabel")
InfoPopup.Info           = Instance.new("TextLabel")
InfoPopup.Script         = Instance.new("TextLabel")
InfoPopup.CloseButton    = Instance.new("TextButton")

local CloseButton    = Instance.new("TextButton")

ScreenGui.Name = "NaturedGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.Enabled = true

TitleBar.Parent = ScreenGui
TitleBar.BackgroundColor3 = SelectedTheme[1]
TitleBar.BorderColor3 = SelectedTheme[3]
TitleBar.Size = UDim2.new(0, 400, 0, 350)
TitleBar.Position = UDim2.new(1.1, 0, 0.5, -(TitleBar.Size.Y.Offset / 2))
TitleBar.ZIndex = 100

Shadow.Parent = TitleBar
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.5
Shadow.BorderSizePixel = 0
Shadow.Position = UDim2.new(0, 5, 0, 5)
Shadow.Size = TitleBar.Size
Shadow.ZIndex = 50

Menu.Parent = TitleBar
Menu.BackgroundColor3 = SelectedTheme[2]
Menu.BorderColor3 = SelectedTheme[3]
Menu.AnchorPoint = Vector2.new(0,0)
Menu.Position = UDim2.new(0, 0, 0, 25)
Menu.Size = UDim2.new(0, 400, 0, 325)
Menu.CanvasSize = UDim2.new(0, TitleBar.Size.X, 0, 250)
Menu.ScrollBarImageTransparency = 0.5
Menu.ZIndex = 200

Title1.Parent = TitleBar
Title1.AnchorPoint = Vector2.new(0, 0)
Title1.Position = UDim2.new(0, 10, 0, 0)
Title1.Size = UDim2.new(0, 200, 0, 25)
Title1.Font = font
Title1.Text = "ScriptSpy v"..version
Title1.RichText = true
Title1.TextColor3 = SelectedTheme[8]
Title1.TextSize = 28
Title1.ZIndex = 300
Title1.BackgroundTransparency = 1
Title1.TextYAlignment = Enum.TextYAlignment.Center
Title1.TextXAlignment = Enum.TextXAlignment.Left

Title2.Parent = Title1
Title2.AnchorPoint = Vector2.new(0, 0)
Title2.Position = UDim2.new(0, 3, 0, 3)
Title2.Size = Title1.Size
Title2.Font = font
Title2.Text = Title1.text
Title2.RichText = true
Title2.TextColor3 = Color3.new(0, 0, 0)
Title2.TextSize = 28
Title2.ZIndex = 299
Title2.BackgroundTransparency = 1
Title2.TextYAlignment = Enum.TextYAlignment.Center
Title2.TextXAlignment = Enum.TextXAlignment.Left

CreditText.Parent = Menu
CreditText.Position = UDim2.new(0, 10, 1, -60)
CreditText.Font = font
CreditText.Text = "<br/>Note: pressing delete <b>deletes</b> that script, <b>permanently.</b><br/>Deleting a server script does nothing.<br/>Sorry if the icons aren't visible.<br/>Made by topit"
CreditText.TextColor3 = SelectedTheme[7]
CreditText.TextSize = 20
CreditText.TextXAlignment = Enum.TextXAlignment.Left
CreditText.ZIndex = 300
CreditText.RichText = true
CreditText.BackgroundTransparency = 1

Scans.Game.Parent = Menu
Scans.Game.BackgroundColor3 = SelectedTheme[4]
Scans.Game.BorderColor3 = SelectedTheme[3]
Scans.Game.TextColor3 = SelectedTheme[7]
Scans.Game.Position = UDim2.new(0, 0, 0, 0)
Scans.Game.Size = UDim2.new(0, 100, 0, 25)
Scans.Game.Font = font
Scans.Game.Text = "Scan game"
Scans.Game.TextScaled = false
Scans.Game.TextSize = 16
Scans.Game.ZIndex = 300

Scans.Workspace.Parent = Menu
Scans.Workspace.BackgroundColor3 = SelectedTheme[4]
Scans.Workspace.BorderColor3 = SelectedTheme[3]
Scans.Workspace.TextColor3 = SelectedTheme[7]
Scans.Workspace.Position = UDim2.new(0, 100, 0, 0)
Scans.Workspace.Size = UDim2.new(0, 100, 0, 25)
Scans.Workspace.Font = font
Scans.Workspace.Text = "Scan workspace"
Scans.Workspace.TextScaled = false
Scans.Workspace.TextSize = 16
Scans.Workspace.ZIndex = 300

Scans.Player.Parent = Menu
Scans.Player.BackgroundColor3 = SelectedTheme[4]
Scans.Player.BorderColor3 = SelectedTheme[3]
Scans.Player.TextColor3 = SelectedTheme[7]
Scans.Player.Position = UDim2.new(0, 200, 0, 0)
Scans.Player.Size = UDim2.new(0, 100, 0, 25)
Scans.Player.Font = font
Scans.Player.Text = "Scan localplayer"
Scans.Player.TextScaled = false
Scans.Player.TextSize = 16
Scans.Player.ZIndex = 300

Scans.Character.Parent = Menu
Scans.Character.BackgroundColor3 = SelectedTheme[4]
Scans.Character.BorderColor3 = SelectedTheme[3]
Scans.Character.TextColor3 = SelectedTheme[7]
Scans.Character.Position = UDim2.new(0, 300, 0, 0)
Scans.Character.Size = UDim2.new(0, 86, 0, 25)
Scans.Character.Font = font
Scans.Character.Text = "Scan localchar"
Scans.Character.TextScaled = false
Scans.Character.TextSize = 16
Scans.Character.ZIndex = 300

Display.Parent = Menu
Display.BackgroundColor3 = SelectedTheme[2]
Display.BorderColor3 = SelectedTheme[3]
Display.AnchorPoint = Vector2.new(0,0)
Display.Position = UDim2.new(0, 0, 0, 25)
Display.Size = UDim2.new(0, 386, 0, 200)
Display.CanvasSize = UDim2.new(0, 100, 0, 50)
Display.AutomaticCanvasSize = Enum.AutomaticSize.Y
Display.ScrollBarImageTransparency = 0.5
Display.ZIndex = 200

IconMenu.Menu.Parent = Display
IconMenu.Menu.BackgroundTransparency = 1
IconMenu.Menu.BorderSizePixel = 0
IconMenu.Menu.BorderColor3 = SelectedTheme[3]
IconMenu.Menu.Position = UDim2.new(0, 0, 0, 26)
IconMenu.Menu.Size = UDim2.new(0, 25, 0, Display.CanvasSize.Y.Offset)
IconMenu.Menu.ZIndex = 200

IconMenu.Layout.FillDirection = Enum.FillDirection.Vertical
IconMenu.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
IconMenu.Layout.SortOrder = Enum.SortOrder.Name
IconMenu.Layout.Parent = IconMenu.Menu

ScriptsMenu.Title.Parent = Display
ScriptsMenu.Title.AnchorPoint = Vector2.new(0, 0)
ScriptsMenu.Title.Position = UDim2.new(0, 0, 0, 0)
ScriptsMenu.Title.Size = UDim2.new(0, 375, 0, 25)
ScriptsMenu.Title.Font = font
ScriptsMenu.Title.Text = "Found scripts - game scan"
ScriptsMenu.Title.RichText = true
ScriptsMenu.Title.TextColor3 = SelectedTheme[8]
ScriptsMenu.Title.TextSize = 28
ScriptsMenu.Title.ZIndex = 300
ScriptsMenu.Title.TextScaled = true
ScriptsMenu.Title.BackgroundTransparency = 1
ScriptsMenu.Title.TextYAlignment = Enum.TextYAlignment.Center
ScriptsMenu.Title.TextXAlignment = Enum.TextXAlignment.Center

ScriptsMenu.Menu.Parent = Display
ScriptsMenu.Menu.BackgroundTransparency = 1 
ScriptsMenu.Menu.BorderSizePixel = 0
ScriptsMenu.Menu.BorderColor3 = SelectedTheme[3]
ScriptsMenu.Menu.Position = UDim2.new(0, 25, 0, 26)
ScriptsMenu.Menu.Size = UDim2.new(0, 175, 0, Display.CanvasSize.Y.Offset)
ScriptsMenu.Menu.ZIndex = 200

ScriptsMenu.Layout.FillDirection = Enum.FillDirection.Vertical
ScriptsMenu.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
ScriptsMenu.Layout.SortOrder = Enum.SortOrder.Name
ScriptsMenu.Layout.Parent = ScriptsMenu.Menu

DeleteMenu.Menu.Parent = Display
DeleteMenu.Menu.BackgroundTransparency = 1
DeleteMenu.Menu.BorderSizePixel = 0
DeleteMenu.Menu.BorderColor3 = SelectedTheme[3]
DeleteMenu.Menu.Position = UDim2.new(0, 200, 0, 26)
DeleteMenu.Menu.Size = UDim2.new(0, 50, 0, Display.CanvasSize.Y.Offset)
DeleteMenu.Menu.ZIndex = 200

DeleteMenu.Layout.FillDirection = Enum.FillDirection.Vertical
DeleteMenu.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
DeleteMenu.Layout.SortOrder = Enum.SortOrder.Name
DeleteMenu.Layout.Parent = DeleteMenu.Menu

InfoMenu.Menu.Parent = Display
InfoMenu.Menu.BackgroundTransparency = 1
InfoMenu.Menu.BorderSizePixel = 0
InfoMenu.Menu.BorderColor3 = SelectedTheme[3]
InfoMenu.Menu.Position = UDim2.new(0, 300, 0, 26)
InfoMenu.Menu.Size = UDim2.new(0, 50, 0, Display.CanvasSize.Y.Offset)
InfoMenu.Menu.ZIndex = 200

InfoMenu.Layout.FillDirection = Enum.FillDirection.Vertical
InfoMenu.Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
InfoMenu.Layout.SortOrder = Enum.SortOrder.Name
InfoMenu.Layout.Parent = InfoMenu.Menu


InfoPopup.TitleBar.Parent = ScreenGui
InfoPopup.TitleBar.BackgroundColor3 = SelectedTheme[1]
InfoPopup.TitleBar.BorderColor3 = SelectedTheme[3]
InfoPopup.TitleBar.Size = UDim2.new(0, 500, 0, 400)
InfoPopup.TitleBar.Position = UDim2.new(1.5, 0, 0.5, -(InfoPopup.TitleBar.Size.Y.Offset / 2))
InfoPopup.TitleBar.ZIndex = 600

InfoPopup.Shadow.Parent = InfoPopup.TitleBar
InfoPopup.Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InfoPopup.Shadow.BackgroundTransparency = 0.5
InfoPopup.Shadow.BorderSizePixel = 0
InfoPopup.Shadow.Position = UDim2.new(0, 5, 0, 5)
InfoPopup.Shadow.Size = InfoPopup.TitleBar.Size
InfoPopup.Shadow.ZIndex = 550

InfoPopup.Menu.Parent = InfoPopup.TitleBar
InfoPopup.Menu.BackgroundColor3 = SelectedTheme[2]
InfoPopup.Menu.BorderColor3 = SelectedTheme[3]
InfoPopup.Menu.Position = UDim2.new(0, 0, 0, 25)
InfoPopup.Menu.Size = UDim2.new(0, 500, 0, 375)
InfoPopup.Menu.CanvasSize = UDim2.new(0, 300, 0, 300)
InfoPopup.Menu.AutomaticCanvasSize = Enum.AutomaticSize.XY
InfoPopup.Menu.ScrollBarImageTransparency = 0.5
InfoPopup.Menu.ZIndex = 700

InfoPopup.Title1.Parent = InfoPopup.TitleBar
InfoPopup.Title1.Position = UDim2.new(0, 10, 0, 0)
InfoPopup.Title1.Size = UDim2.new(0, 200, 0, 25)
InfoPopup.Title1.Font = font
InfoPopup.Title1.Text = "Information"
InfoPopup.Title1.TextColor3 = SelectedTheme[8]
InfoPopup.Title1.TextSize = 28
InfoPopup.Title1.ZIndex = 800
InfoPopup.Title1.BackgroundTransparency = 1
InfoPopup.Title1.TextYAlignment = Enum.TextYAlignment.Center
InfoPopup.Title1.TextXAlignment = Enum.TextXAlignment.Left

InfoPopup.Title2.Parent = InfoPopup.Title1
InfoPopup.Title2.Position = UDim2.new(0, 3, 0, 3)
InfoPopup.Title2.Size = InfoPopup.Title1.Size
InfoPopup.Title2.Font = font
InfoPopup.Title2.Text = InfoPopup.Title1.text
InfoPopup.Title2.TextColor3 = Color3.new(0, 0, 0)
InfoPopup.Title2.TextSize = 28
InfoPopup.Title2.ZIndex = 799
InfoPopup.Title2.BackgroundTransparency = 1
InfoPopup.Title2.TextYAlignment = Enum.TextYAlignment.Center
InfoPopup.Title2.TextXAlignment = Enum.TextXAlignment.Left

InfoPopup.Info.Parent = InfoPopup.Menu
InfoPopup.Info.Position = UDim2.new(0, 10, 0, -10)
InfoPopup.Info.Size = UDim2.new(0, 500, 0, 600)
InfoPopup.Info.Font = font
InfoPopup.Info.Text = "<br/>Loading info..."
InfoPopup.Info.RichText = true
InfoPopup.Info.TextColor3 = SelectedTheme[8]
InfoPopup.Info.TextSize = 22
InfoPopup.Info.ZIndex = 800
InfoPopup.Info.BackgroundTransparency = 1
InfoPopup.Info.TextYAlignment = Enum.TextYAlignment.Top
InfoPopup.Info.TextXAlignment = Enum.TextXAlignment.Left

InfoPopup.Script.Parent = InfoPopup.Menu
InfoPopup.Script.Position = UDim2.new(0, 10, 0, 115)
InfoPopup.Script.Size = UDim2.new(0, 500, 0, 2000)
InfoPopup.Script.Font = Enum.Font.Code
InfoPopup.Script.Text = "Loading script..."
InfoPopup.Script.RichText = false
InfoPopup.Script.TextColor3 = SelectedTheme[8]
InfoPopup.Script.TextSize = 14
InfoPopup.Script.ZIndex = 800
InfoPopup.Script.BackgroundTransparency = 1
InfoPopup.Script.TextYAlignment = Enum.TextYAlignment.Top
InfoPopup.Script.TextXAlignment = Enum.TextXAlignment.Left

InfoPopup.CloseButton.Parent = InfoPopup.TitleBar
InfoPopup.CloseButton.BackgroundColor3 = SelectedTheme[4]
InfoPopup.CloseButton.BorderColor3 = SelectedTheme[3]
InfoPopup.CloseButton.TextColor3 = SelectedTheme[7]
InfoPopup.CloseButton.Position = UDim2.new(1, -25, 0, 0)
InfoPopup.CloseButton.Size = UDim2.new(0, 25, 0, 24)
InfoPopup.CloseButton.Font = font
InfoPopup.CloseButton.Text = "X"
InfoPopup.CloseButton.ZIndex = 800
InfoPopup.CloseButton.TextSize = 14



CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = SelectedTheme[4]
CloseButton.BorderColor3 = SelectedTheme[3]
CloseButton.TextColor3 = SelectedTheme[7]
CloseButton.Position = UDim2.new(1, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 24)
CloseButton.Font = font
CloseButton.Text = "X"
CloseButton.ZIndex = 300
CloseButton.TextSize = 14

--[[Functions]]--

local function OpenObject(object)
    TweenService:Create(object,TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundColor3 = SelectedTheme[6] }):Play()
end

local function CloseObject(object)
    TweenService:Create(object,TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundColor3 = SelectedTheme[4] }):Play()
end
    
local function TweenPosition(object, dest, timing, dir)
    timing = timing or 0.25
    dir = dir or Enum.EasingDirection.Out
    game.TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, dir),{ Position = dest  }):Play()
end


local function TweenSize(object, dest, timing, dir)
    timing = timing or 0.25
    dir = dir or Enum.EasingDirection.Out
    TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, dir),{Size = dest}):Play()
end

local function FadeOut(object, timing)
    timing = timing or 0.75 
    for i,v in pairs(object:GetDescendants()) do
        if v:IsA("Frame") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
        elseif v:IsA("ScrollingFrame") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1, ScrollBarImageTransparency = 1}):Play()
            v.ScrollBarThickness = 0
        elseif v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1, TextTransparency = 1}):Play()
        elseif v:IsA("ImageLabel") then
            TweenService:Create(v,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1, ImageTransparency = 1}):Play()
        end
    end
    if object:IsA("Frame") then
        TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
    elseif object:IsA("TextLabel") then
        TweenService:Create(object,TweenInfo.new(timing, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
    end
end

local function Message(text, size)
    size = size or UDim2.new(0, 300, 0, 100)
    local scren = Instance.new("ScreenGui")
    local MessageFrame = Instance.new("Frame")
    local MessageLabel = Instance.new("TextButton")
    
    scren.Parent = game.CoreGui
    
    MessageFrame.Parent = scren
    MessageFrame.BackgroundColor3 = SelectedTheme[2]
    MessageFrame.BorderColor3 = SelectedTheme[3]
    MessageFrame.BorderSizePixel = 2
    MessageFrame.Position = UDim2.new(0.8, 0, 1.1, 0)
    MessageFrame.Size = size
    MessageFrame.ZIndex = 200
    
    MessageLabel.Parent = MessageFrame
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.BorderSizePixel = 0
    MessageLabel.TextColor3 = SelectedTheme[8]
    MessageLabel.Position = UDim2.new(0.5, -(size.X.Offset / 2), 0.5, -(size.Y.Offset / 2))
    MessageLabel.Size = size
    MessageLabel.Font = Enum.Font.Nunito
    MessageLabel.Text = text
    MessageLabel.RichText = true
    MessageLabel.TextScaled = false
    MessageLabel.ZIndex = 300
    MessageLabel.AutoButtonColor = false
    
    TweenPosition(MessageFrame, UDim2.new(0.8, 0, 0.89, 0), 0.75)
    wait(2)
    TweenPosition(MessageFrame, UDim2.new(0.8, 0, 1.1, 0), 0.75, Enum.EasingDirection.In)
    wait(1)
    scren:Destroy() 
end

local function ReleaseIndex(i)
    table.remove(CaughtScripts, i)
    
    ScriptsMenuItems[i]:Destroy()
    table.remove(ScriptsMenuItems, i)
    
    DeleteMenuItems[i]:Destroy()
    table.remove(DeleteMenuItems, i)
    
    InfoMenuItems[i]:Destroy()
    table.remove(InfoMenuItems, i)
    
    IconMenuItems[i]:Destroy()
    table.remove(IconMenuItems, i)
end

local function DeleteIndex(i)
    CaughtScripts[i]:Destroy()
    table.remove(CaughtScripts, i)
    
    ScriptsMenuItems[i]:Destroy()
    table.remove(ScriptsMenuItems, i)
    
    DeleteMenuItems[i]:Destroy()
    table.remove(DeleteMenuItems, i)
    
    InfoMenuItems[i]:Destroy()
    table.remove(InfoMenuItems, i)
    
    IconMenuItems[i]:Destroy()
    table.remove(IconMenuItems, i)
end

local function ReleaseScript(lscript)
    for i,v in pairs(CaughtScripts) do
        if v == lscript then
            ReleaseIndex(i)
        end
    end
end

local function InformationFromIndex(i)
    InfoPopup.Info.Text = "<br/>Loading info..."
    if syn then
        InfoPopup.Script.Text = "Loading script..."
    else
        InfoPopup.Script.Text = "Can't load script; exploit not compatible."
    end
    InfoPopup.TitleBar.BackgroundTransparency = 0
    InfoPopup.Menu.BackgroundTransparency = 0
    InfoPopup.Menu.ScrollBarThickness = 15
    InfoPopup.Title1.TextTransparency = 0
    InfoPopup.Title2.TextTransparency = 0
    InfoPopup.Info.TextTransparency = 0
    InfoPopup.CloseButton.TextTransparency = 0
    InfoPopup.CloseButton.BackgroundTransparency = 0
    InfoPopup.Script.TextTransparency = 0
    
    
    InfoPopup.TitleBar.Position = UDim2.new(0.5, -250, 0.5, -200)
    InfoPopup.TitleBar.Size = UDim2.new(0, 500, 0, 0)
    InfoPopup.Shadow.Size = UDim2.new(0, 500, 0, 0)
    InfoPopup.Menu.Size = UDim2.new(0, 500, 0, 0)
    
    
    
    TweenSize(InfoPopup.TitleBar, UDim2.new(0, 500, 0, 400), 0.75)
    TweenSize(InfoPopup.Shadow, UDim2.new(0, 500, 0, 400), 0.75)
    TweenSize(InfoPopup.Menu, UDim2.new(0, 500, 0, 375), 0.75)
    
    
    local arg1 = tostring(CaughtScripts[i].Name)
    local arg3 = type(CaughtScripts[i])
    
    local tree1, tree2, tree3, tree4, tree5 = nil
    
    
    
    
    local finaltext = "<br/>script name: "..arg1
    finaltext = finaltext.."<br/>script type: "..arg3
    finaltext = finaltext.."<br/>script family: "
    tree1 = CaughtScripts[i].Parent
    if tree1 ~= game then
        tree2 = tree1.Parent
        if tree2 ~= game then
            tree3 = tree2.Parent
            if tree3 ~= game then
                tree4 = tree3.Parent
                if tree4 ~= game then
                    tree5 = tree4.Parent
                    finaltext = finaltext..tree5.Name.."/"..tree4.Name.."/"..tree3.Name.."/"..tree2.Name.."/"..tree1.Name.."/"..arg1
                else
                    finaltext = finaltext.."/"..tree4.Name.."/"..tree3.Name.."/"..tree2.Name.."/"..tree1.Name.."/"..arg1
                end
            else
                finaltext = finaltext..tree3.Name.."/"..tree2.Name.."/"..tree1.Name.."/"..arg1
            end
        else
            finaltext = finaltext..tree2.Name.."/"..tree1.Name.."/"..arg1
        end
    else
        finaltext = finaltext..tree1.Name.."/"..arg1
    end
    
    InfoPopup.Info.Text = finaltext
    
    if syn then
        local arg2 = decompile(CaughtScripts[i])
        
        finaltext = finaltext.."<br/>script (you should probably use dex): "
        
        InfoPopup.Info.Text = finaltext
        InfoPopup.Script.Text = arg2
        for i = 0, 10 do
            if InfoPopup.Script.TextFits == false then
                InfoPopup.Script.Size = UDim2.new(0, 500, 0, InfoPopup.Script.Size.Y.Offset + 2000)
            else
                break
            end
        end
    end
    
    for i = 0, 10 do
        if InfoPopup.Info.TextFits == false then
            InfoPopup.Info.Size = UDim2.new(0, InfoPopup.Info.Size.X.Offset + 50, 0, InfoPopup.Info.Size.Y.Offset)
        else
            break
        end
    end
    InfoPopup.Menu.CanvasSize = UDim2.new(0, 0, 0, 0)
end

local function CatchScript(lscript)
    Display.CanvasSize = UDim2.new(0, 100, 1, 0)
    table.insert(CaughtScripts, lscript)
    
    
    local tx = Instance.new("TextLabel")
    tx.Parent = ScriptsMenu.Menu
    tx.Size = UDim2.new(0, 175, 0, 25)
    tx.Font = font
    if #lscript.Name < 19 then
        tx.Text = lscript.Name
    else
        tx.Text = lscript.Name:sub(1,19).."..."    
    end
    tx.RichText = true
    tx.TextColor3 = SelectedTheme[8]
    tx.BackgroundColor3 = SelectedTheme[2]
    tx.BorderColor3 = SelectedTheme[3]
    tx.TextSize = 17
    tx.ZIndex = 400
    tx.BackgroundTransparency = 0.6
    table.insert(ScriptsMenuItems, tx)
    
    
    local tx2 = Instance.new("TextButton")
    tx2.Parent = DeleteMenu.Menu
    tx2.Size = UDim2.new(0, 100, 0, 25)
    tx2.Font = font
    tx2.Text = "🗑 Delete script"
    tx2.TextSize = 15
    tx2.ZIndex = 400
    tx2.BackgroundColor3 = SelectedTheme[2]
    tx2.BorderColor3 = SelectedTheme[3]
    tx2.TextColor3 = SelectedTheme[7]
    tx2.BackgroundTransparency = 0.5
    table.insert(DeleteMenuItems, tx2)
    
    tx2.MouseButton1Click:Connect(function()
        for i,v in pairs(CaughtScripts) do
            if v == lscript then
                DeleteIndex(i)
            end
        end
    end)
    
    local tx3 = Instance.new("TextButton")
    tx3.Parent = InfoMenu.Menu
    tx3.Size = UDim2.new(0, 74, 0, 25)
    tx3.Font = font
    tx3.Text = "📋 Info"
    tx3.TextSize = 15
    tx3.ZIndex = 400
    tx3.BackgroundColor3 = SelectedTheme[2]
    tx3.BorderColor3 = SelectedTheme[3]
    tx3.TextColor3 = SelectedTheme[7]
    tx3.BackgroundTransparency = 0.5
    table.insert(InfoMenuItems, tx3)
    tx3.MouseButton1Click:Connect(function()
        for i,v in pairs(CaughtScripts) do
            if v == lscript then
                InformationFromIndex(i)
            end
        end
    end)
    
    local tx4 = Instance.new("ImageLabel")
    tx4.Parent = IconMenu.Menu
    tx4.Size = UDim2.new(0, 25, 0, 25)
    tx4.ZIndex = 405
    tx4.ImageTransparency = 0
    tx4.BackgroundColor3 = SelectedTheme[2]
    tx4.BorderColor3 = SelectedTheme[3]
    tx4.BackgroundTransparency = 0.5
    if lscript:IsA("LocalScript") then
        tx4.Image = ScriptIcons.Local
    elseif lscript:IsA("ModuleScript") then
        tx4.Image = ScriptIcons.Module
    elseif lscript:IsA("Script") then
        tx4.Image = ScriptIcons.Script
    else
        tx4.Image = ScriptIcons.Unknown
    end
    table.insert(IconMenuItems, tx4)
    Display.CanvasSize = UDim2.new(0, 100, 1, 0)
    Display.AutomaticCanvasSize = Enum.AutomaticSize.Y
end

--[[Events]]--
CloseButton.MouseButton1Click:Connect(function()
    for i = 1, table.getn(CaughtScripts) do
        ReleaseIndex(1)
    end
    wait()

    TweenPosition(TitleBar, UDim2.new(TitleBar.Position.X.Scale, TitleBar.Position.X.Offset - 50, TitleBar.Position.Y.Scale, TitleBar.Position.Y.Offset), 0.25)
    FadeOut(TitleBar, 0.25)
    FadeOut(InfoPopup.TitleBar, 0.25)
	wait(0.25)
	
	--pcall(function() ContextActionService:UnbindAction("NG-MouseTP_Trigger") end)


	ScreenGui.Enabled = false
	ScreenGui:Destroy()
	
	script:Destroy()
end)

InfoPopup.CloseButton.MouseButton1Click:Connect(function()
    TweenPosition(InfoPopup.TitleBar, UDim2.new(InfoPopup.TitleBar.Position.X.Scale, InfoPopup.TitleBar.Position.X.Offset - 50, InfoPopup.TitleBar.Position.Y.Scale, InfoPopup.TitleBar.Position.Y.Offset), 0.25)
    FadeOut(InfoPopup.TitleBar, 0.25) 
end)

Scans.Game.MouseButton1Click:Connect(function()
    if scanoccur == true then
        local cofunc = coroutine.wrap(function() Message("<font size='18'>Wait for the current scan to finish!</font>", UDim2.new(0, 230, 0, 100)) end)
        cofunc()
        return
    end
    
    local err = false
    local count = 0
    ScriptsMenu.Title.Text = "Scanning..."
    
    local g = table.getn(game:GetDescendants())
    for i = 1, table.getn(CaughtScripts) do
        ReleaseIndex(1)
    end
    wait()
    scanoccur = true
    for i,v in pairs(game:GetDescendants()) do
        ScriptsMenu.Title.Text = "Scanning... ("..tostring(i).."/"..tostring(g)..")"
        if v:IsA("LocalScript") or v:IsA("ModuleScript") and count < 300 then
            CatchScript(v)
            count = count + 1
            wait()
        elseif count >= 300 then
            err = true
            break
        end
    end
    scanoccur = false
    
    if err then
        ScriptsMenu.Title.Text = "Limited scan to 300 / "..tostring(table.getn(getscripts())).." scripts - game scan"
    else
        if count == 1 then
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." script - game scan"
        else
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." scripts - game scan"
        end
    end
    count = nil
end)

Scans.Workspace.MouseButton1Click:Connect(function()
    if scanoccur == true then
        local cofunc = coroutine.wrap(function() Message("<font size='18'>Wait for the current scan to finish!</font>", UDim2.new(0, 230, 0, 100)) end)
        cofunc()
        return
    end
    
    local err = false
    local count = 0
    ScriptsMenu.Title.Text = "Scanning..."
    
    local g = table.getn(game:GetDescendants())
    for i = 1, table.getn(CaughtScripts) do
        ReleaseIndex(1)
    end
    wait()
    scanoccur = true
    for i,v in pairs(game.Workspace:GetDescendants()) do
        ScriptsMenu.Title.Text = "Scanning... ("..tostring(i).."/"..tostring(g)..")"
        if v:IsA("LocalScript") or v:IsA("ModuleScript") and count < 300 then
            CatchScript(v)
            count = count + 1
            wait()
        elseif count >= 300 then
            err = true
            break
        end
    end
    scanoccur = false
    
    if err then
        ScriptsMenu.Title.Text = "Limited scan to 300 / "..tostring(table.getn(getscripts())).." scripts - workspace scan"
    else
        if count == 1 then
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." script - workspace scan"
        else
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." scripts - workspace scan"
        end
    end
    count = nil
end)

Scans.Player.MouseButton1Click:Connect(function()
    if scanoccur == true then
        local cofunc = coroutine.wrap(function() Message("<font size='18'>Wait for the current scan to finish!</font>", UDim2.new(0, 230, 0, 100)) end)
        cofunc()
        return
    end
    local err = false
    local count = 0
    ScriptsMenu.Title.Text = "Scanning..."
    
    local g = table.getn(game:GetDescendants())
    for i = 1, table.getn(CaughtScripts) do
        ReleaseIndex(1)
    end
    wait()
    scanoccur = true
    for i,v in pairs(plr:GetDescendants()) do
        ScriptsMenu.Title.Text = "Scanning... ("..tostring(i).."/"..tostring(g)..")"
        if v:IsA("LocalScript") or v:IsA("ModuleScript") and count < 300 then
            CatchScript(v)
            count = count + 1
            wait()
        else
            if count >= 300 then
                err = true
                break
            elseif stopscan == true then
                stopscan = false
                break 
            end
        end
    end
    scanoccur = false
    
    if err then
        ScriptsMenu.Title.Text = "Limited scan to 300 / "..tostring(table.getn(getscripts())).." scripts - local player scan"
    else
        if count == 1 then
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." script - local player scan"
        else
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." scripts - local player scan"
        end
    end
    count = nil
end)

Scans.Character.MouseButton1Click:Connect(function()
    if scanoccur == true then
        local cofunc = coroutine.wrap(function() Message("<font size='18'>Wait for the current scan to finish!</font>", UDim2.new(0, 230, 0, 100)) end)
        cofunc()
        return
    end
    
    local err = false
    local count = 0
    ScriptsMenu.Title.Text = "Scanning..."
    
    local g = table.getn(game:GetDescendants())
    for i = 1, table.getn(CaughtScripts) do
        ReleaseIndex(1)
    end
    wait()
    scanoccur = true
    for i,v in pairs(plr.Character:GetDescendants()) do
        ScriptsMenu.Title.Text = "Scanning... ("..tostring(i).."/"..tostring(g)..")"
        if v:IsA("LocalScript") or v:IsA("ModuleScript") and count < 300 then
            CatchScript(v)
            count = count + 1
            wait()
        else
            if count >= 300 then
                err = true
                break
            end
        end
    end
    scanoccur = false
    
    if err then
        ScriptsMenu.Title.Text = "Limited scan to 300 / "..tostring(table.getn(getscripts())).." scripts - local character scan"
    else
        if count == 1 then
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." script - local character scan"
        else
            ScriptsMenu.Title.Text = "Caught "..tostring(count).." scripts - local character scan"
        end
    end
    count = nil
end)


TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging[1] = true
        Dragging[2] = input.Position
        Dragging[3] = TitleBar.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging[1] = false
    end
end)

InfoPopup.TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging2[1] = true
        Dragging2[2] = input.Position
        Dragging2[3] = InfoPopup.TitleBar.Position
    end
end)

InfoPopup.TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging2[1] = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if Dragging2[1] then
            local delta = input.Position - Dragging2[2]
            TweenPosition(InfoPopup.TitleBar, UDim2.new(Dragging2[3].X.Scale, Dragging2[3].X.Offset + delta.X, Dragging2[3].Y.Scale, Dragging2[3].Y.Offset + delta.Y), 0.75)
            --TweenSize(InfoPopup.TitleBar, UDim2.new(Dragging2[3].X.Scale, Dragging2[3].X.Offset + delta.X, Dragging2[3].Y.Scale, Dragging2[3].Y.Offset + delta.Y), 0.75)
            --TweenSize(InfoPopup.Shadow, InfoPopup.TitleBar.Size)
            --TweenSize(InfoPopup.Menu, InfoPopup.TitleBar.Size)
        elseif Dragging[1] then
            local delta = input.Position - Dragging[2]
            TweenPosition(TitleBar, UDim2.new(Dragging[3].X.Scale, Dragging[3].X.Offset + delta.X, Dragging[3].Y.Scale, Dragging[3].Y.Offset + delta.Y), 0.75)
        end 
        
    end
end)

TweenPosition(TitleBar, UDim2.new(0.75, 0, 0.5, -(TitleBar.Size.Y.Offset / 2)), 1)
local cofunc = coroutine.wrap(function() Message("<font size='25'>ScriptSpy v"..version.."</font><br/><font size='25'>Made by topit</font>", UDim2.new(0, 230, 0, 100)) end)
cofunc()


ScriptsMenu.Title.Text = "Select a scan to start."

return nil
