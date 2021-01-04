
SaveYourself = false
HasDied = true
demspeed = 50
local punchreachz = false
local stuff = {"[Bat]", "[Knife]" ,"[StopSign]"}
Player = game:GetService("Players").LocalPlayer
local spyfunction = true
local bspeed = 250

	Whitelist = true
local plrs = game:GetService("Players")
local TeamBased = false ; local teambasedswitch = "o"
local presskeytoaim = true; local aimkey = "e"
local raycast = false
local espupdatetime = 5; autoesp = false
local lockaim = true; local lockangle = 5
 local PLAYERSERVERS = Instance.new("Folder", workspace)
PLAYERSERVERS.Name = "WhitelistedAmmo"
local plrsforaim = {}
 local bruh = false
local lplr = game:GetService("Players").LocalPlayer
local godblock = false

f = {}
local espforlder
 
f.addesp = function()
    --print("ESP ran")
    if espforlder then
    else
        espforlder = Instance.new("Folder")
        espforlder.Parent = game.Workspace.CurrentCamera
    end
    for i, v in pairs(espforlder:GetChildren()) do
        v:Destroy()
    end
    for _, plr in pairs(plrs:GetChildren()) do
        if plr.Character and plr.Character.Humanoid.Health > 0 and plr.Name ~= lplr.Name then
            if TeamBased == true then
                if plr.Team.Name ~= plrs.LocalPlayer.Team.Name  then
                    local e = espforlder:FindFirstChild(plr.Name)
                    if not e then
                        --print("Added esp for team based")
                        local bill = Instance.new("BillboardGui", espforlder)
                        bill.Name = plr.Name
                        bill.AlwaysOnTop = true
                        bill.Size = UDim2.new(1,0,1,0)
                        bill.Adornee = plr.Character.Head
                        local Frame = Instance.new('Frame',bill)
                        Frame.Active = true
                        Frame.BackgroundColor3 = Color3.new(0/255,255/255,0/255)
                        Frame.BackgroundTransparency = 0
                        Frame.BorderSizePixel = 0
                        Frame.AnchorPoint = Vector2.new(.5, .5)
                        Frame.Position = UDim2.new (0.5,0,0.5,0)
                        Frame.Size = UDim2.new (1,0,1,0)
                        Frame.Rotation = 0
                        plr.Character.Humanoid.Died:Connect(function()
                            bill:Destroy()
                        end)
                    end
                end
            else
                local e = espforlder:FindFirstChild(plr.Name)
                if not e then
                    --print("Added esp")
                    local bill = Instance.new("BillboardGui", espforlder)
                    bill.Name = plr.Name
                    bill.AlwaysOnTop = true
                    bill.Size = UDim2.new(1,0,1,0)
                    bill.Adornee = plr.Character.Head
                    local Frame = Instance.new('Frame',bill)
                    Frame.Active = true
                    Frame.BackgroundColor3 = Color3.new(0/255,255/255,0/255)
                    Frame.BackgroundTransparency = 0
                    Frame.BorderSizePixel = 0
                    Frame.AnchorPoint = Vector2.new(.5, .5)
                    Frame.Position = UDim2.new (0.5,0,0.5,0)
                    Frame.Size = UDim2.new (1,0,1,0)
                    Frame.Rotation = 0
                    plr.Character.Humanoid.Died:Connect(function()
                        bill:Destroy()
                    end)
                end
            end
           
           
        end
    end
end
local cam = game.Workspace.CurrentCamera
 
local mouse = lplr:GetMouse()
local switch = false

local aimatpart = nil

 
function getfovxyz (p0, p1, deg)
    local x1, y1, z1 = p0:ToOrientation()
    local cf = CFrame.new(p0.p, p1.p)
    local x2, y2, z2 = cf:ToOrientation()
    --local d = math.deg
    if deg then
        --return Vector3.new(d(x1-x2), d(y1-y2), d(z1-z2))
    else
        return Vector3.new((x1-x2), (y1-y2), (z1-z2))
    end
end
 
function getaimbotplrs()
    plrsforaim = {}
    for i, plr in pairs(plrs:GetChildren()) do
        if plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 and plr.Name ~= lplr.Name and plr.Character.Head then
           
            if TeamBased == true then
                if plr.Team.Name ~= lplr.Team.Name then
                    local cf = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, plr.Character.Head.CFrame.p)
                    local r = Ray.new(cf, cf.LookVector * 10000)
                    local ign = {}
                    for i, v in pairs(plrs.LocalPlayer.Character:GetChildren()) do
                        if v:IsA("BasePart") then
                            table.insert(ign , v)
                        end
                    end
                    local obj = game.Workspace:FindPartOnRayWithIgnoreList(r, ign)
                    if obj.Parent == plr.Character and obj.Parent ~= lplr.Character then
                        table.insert(plrsforaim, obj)
                    end
                end
            else
                local cf = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, plr.Character.Head.CFrame.p)
                local r = Ray.new(cf, cf.LookVector * 10000)
                local ign = {}
                for i, v in pairs(plrs.LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        table.insert(ign , v)
                    end
                end
                local obj = game.Workspace:FindPartOnRayWithIgnoreList(r, ign)
                if obj.Parent == plr.Character and obj.Parent ~= lplr.Character then
                    table.insert(plrsforaim, obj)
                end
            end
           
           
        end
    end
end

local heazd = false
 
function aimat(part)
    cam.CFrame = CFrame.new(cam.CFrame.p, part.CFrame.p)
end
function checkfov (part)
    local fov = getfovxyz(game.Workspace.CurrentCamera.CFrame, part.CFrame)
    local angle = math.abs(fov.X) + math.abs(fov.Y)
    return angle
end
 

   
   
--  if switch == true then
--      local maxangle = 99999
--     
--      --print("Loop")
--      if true and raycast == false then
--          for i, plr in pairs(plrs:GetChildren()) do
--              if plr.Name ~= lplr.Name and plr.Character and plr.Character.Head and plr.Character.Humanoid and plr.Character.Humanoid.Health > 1 then
--                  if TeamBased then
--                      if plr.Team.Name ~= lplr.Team.Name or plr.Team.TeamColor ~= lplr.Team.TeamColor then
--                          local an = checkfov(plr.Character.Head)
--                          if an < maxangle then
--                              maxangle = an
--                              aimatpart = plr.Character.Head
--                              if an < lockangle then
--                                  break
--                              end
--                          end
--                      end
--                  else
--                      local an = checkfov(plr.Character.Head)
--                          if an < maxangle then
--                              maxangle = an
--                              aimatpart = plr.Character.Head
--                              if an < lockangle then
--                                  break
--                              end
--                          end
--                  end
--                 
--                 
--                 
--                 
--              end
--          end
--      elseif raycast == true then
--         
--      end
       
        




cashdrop = false
clip = false
local nuking = false
shittymelee = "[Knife]"
local SaveYourself = true
local punchreachrr = "idk"
local nukerowner = ""
lagspike = false
local crashserver = false
 local flying = false

local autostomp = false
local loopbring = false
niceknife = false
local fog = 500
local valtomove = 4
function tp(x,y,z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(x,y,z))
end


guntype = "idk"
maus = game.Players.LocalPlayer:GetMouse()
reload = false
sped = false
DoThing = false
respawn = false
maus.KeyDown:Connect(function(key)
if key == "b" then
	if not aimatpart then
local maxangle = math.rad(20)
for i, plr in pairs(plrs:GetChildren()) do
if plr.Name ~= lplr.Name and plr.Character and plr.Character.Head and plr.Character.Humanoid and plr.Character.Humanoid.Health > 1 then
if TeamBased == true then
if plr.Team.Name ~= lplr.Team.Name then
local an = checkfov(plr.Character.Head)
if an < maxangle then
maxangle = an
aimatpart = plr.Character.Head
end
end
else
local an = checkfov(plr.Character.Head)
if an < maxangle then
maxangle = an
nukerowner = plr.Character.Name
aimatpart = plr.Character.Head
end
--print(plr)
end
local old = aimatpart


end
end
else
aimatpart = nil
canaimat = false
delay(1.1, function()
canaimat = true
end)
end


elseif key == "z" then

if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") then
        game.Players.LocalPlayer.Backpack:FindFirstChild("Combat").Parent = game.Players.LocalPlayer.Character
end
      wait()
      game.Players.LocalPlayer.Character:FindFirstChild("Combat"):Activate()
      if game.Players.LocalPlayer.Character then
        if game.Players.LocalPlayer.character:FindFirstChild("HumanoidRootPart") then
          returnpos = game.Players.LocalPlayer.character:FindFirstChild("HumanoidRootPart").CFrame
        end
      end    
      wait(1.1)
     
for i,v in pairs(game.Players:GetChildren()) do
if v.Name ~= game.Players.LocalPlayer.Name and v.Name ~= "Vortextures" and v.Name ~= "Vortexturize" and v.Name ~= "Vortexturable" then
if v.Character then
if v.Character:FindFirstChild("HumanoidRootPart") then
distance = game.Players.LocalPlayer:DistanceFromCharacter(v.Character.HumanoidRootPart.Position)

if distance < 35 then
for i = 1,5 do
        if v then
          if v.Character and game.Players.LocalPlayer.Character then
            if v.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 10 then
              game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,0.7)
            end
          end
        end
	game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, v.Character.HumanoidRootPart.CFrame.p)
        wait(0.05)
end
      
end

end
end
end
end



elseif key == "v" then
	if punchreachz == false then
			game.Players.LocalPlayer.Character.RightHand.Size = Vector3.new(20, 20, 20)
	game.Players.LocalPlayer.Character.LeftHand.Size = Vector3.new(20, 20, 20)
	game.Players.LocalPlayer.Character.RightHand.Massless = true
	game.Players.LocalPlayer.Character.LeftHand.Massless = true
	punchreachz = true
	elseif punchreachz == true then
		punchreachz = false
	game.Players.LocalPlayer.Character.RightHand.Size = Vector3.new(1, 1, 1)
	game.Players.LocalPlayer.Character.LeftHand.Size = Vector3.new(1, 1, 1)
	game.Players.LocalPlayer.Character.RightHand.Massless = true
	game.Players.LocalPlayer.Character.LeftHand.Massless = true
 end
elseif key == "x" then
	if flying == false then
	flying = true
	

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
 
        localplayer = plr
       
        if workspace:FindFirstChild("Core") then
            workspace.Core:Destroy()
        end
       
        local Core = Instance.new("Part")
        Core.Name = "Core"
        Core.Size = Vector3.new(0.05, 0.05, 0.05)
 local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        spawn(function()
            Core.Parent = workspace
            local Weld = Instance.new("Weld", Core)
            Weld.Part0 = Core
            Weld.Part1 = localplayer.Character.LowerTorso
            Weld.C0 = CFrame.new(0, 0, 0)
        end)
       
        workspace:WaitForChild("Core")
       
        local torso = workspace.Core
       
        local speed=20
        local keys={a=false,d=false,w=false,s=false}
        local e1
        local e2
        local function start()
            local pos = Instance.new("BodyPosition",torso)
            local gyro = Instance.new("BodyGyro",torso)
            pos.Name="EPIXPOS"
            pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
            pos.position = torso.Position
            gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            gyro.cframe = torso.CFrame
            repeat
                wait()
              hum.PlatformStand=true
                local new=gyro.cframe - gyro.cframe.p + pos.position
                if not keys.w and not keys.s and not keys.a and not keys.d then
                    speed=10
                end
                if keys.w then
                    new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+0
                end
                if keys.s then
                    new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                    speed=speed+0
                end
                if keys.d then
                    new = new * CFrame.new(speed,0,0)
                    speed=speed+0
                end
                if keys.a then
                    new = new * CFrame.new(-speed,0,0)
                    speed=speed+0
                end
                if speed>20 then
                    speed=10
                end
                pos.position=new.p
                if keys.w then
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
                elseif keys.s then
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
                else
                    gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                end
            until flying == false
            if gyro then gyro:Destroy() end
            if pos then pos:Destroy() end
            flying=false
          hum.PlatformStand=false
            speed=20
        end
        e1=mouse.KeyDown:connect(function(key)
            if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
            if key=="w" then
                keys.w=true
            elseif key=="s" then
                keys.s=true
            elseif key=="a" then
                keys.a=true
            elseif key=="d" then
                keys.d=true
           
            end
        end)
        e2=mouse.KeyUp:connect(function(key)
            if key=="w" then
                keys.w=false
            elseif key=="s" then
                keys.s=false
            elseif key=="a" then
                keys.a=false
            elseif key=="d" then
                keys.d=false
            end
        end)
 
	       start()

	else
       if workspace:FindFirstChild("Core") then
            workspace.Core:Destroy()
        end
	flying = false

end
	
elseif key == "p" then
game.Players.LocalPlayer.Character:Destroy()
elseif key == "l" and sped == false then
sped = true
game.Players.LocalPlayer.Character.Humanoid.Name = "Humz"
game.Players.LocalPlayer.Character.Humz.WalkSpeed = 100
game.Players.LocalPlayer.Character.Humz.JumpPower = 200
demspeed = 200
elseif key == "l" and sped == true then
sped = false
game.Players.LocalPlayer.Character.Humz.WalkSpeed = 16
game.Players.LocalPlayer.Character.Humz.JumpPower = 50
demspeed = 50
game.Players.LocalPlayer.Character.Humz.Name = "Humanoid"
elseif key == "k" and clip == false then
clip = true
local RunService = game:GetService('RunService')

 
RunService.Heartbeat:Connect(function(step)
	if clip == true then
		game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
	end
end)
elseif key == "k" and clip == true then
clip = false

elseif key == "j" and niceknife == false then
niceknife = true
for i, v in ipairs(stuff) do
if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") then
local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
if tool.Name == v then
shittymelee = tool.name
game:GetService("Players").LocalPlayer.Character[shittymelee].Handle.Size = Vector3.new(30, 30, 30)
end
end
end
elseif key == "j" and niceknife == true then
niceknife = false
for i, v in ipairs(stuff) do
if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") then
local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
if tool.Name == v then
shittymelee = tool.name
game:GetService("Players").LocalPlayer.Character[shittymelee].Handle.Size = Vector3.new(1, 1, 1)
end
end
end
elseif key == "x" and DoThing  == false then
DoThing = true
local Part = Instance.new("Part",workspace)
Part.Name = "GetFucked"
Part.Anchored = false
Part.CanCollide = false
Part.Transparency = 1
local Part1= Instance.new("Part",workspace)
Part1.Name = "GetFucked1"
Part1.Anchored = true
Part1.CanCollide = false
Part1.Transparency = 1

local Weld = Instance.new("Weld", Part1)
Weld.Part0 = Part1
Weld.Part1 = Part
Weld.C0 = CFrame.new(0, 0, 10000)
local cor = coroutine.wrap(function()
wait(2)
Part:Destroy()
Part1:Destroy()
Weld:Destroy()
DoThing = false
end)
cor()
pcall(function()
	if game.Players.LocalPlayer.Character.RightHand:FindFirstChildOfClass("Model") then
		game.Players.LocalPlayer.Character.RightHand.Model.RightWrist:Destroy()
	end
game.Players.LocalPlayer.Character.RightHand.RightWrist:Destroy()
end)
local laugh = 0
repeat

laugh = laugh+200
Part1.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, laugh, math.pi/-2)
local lol = game.Players.LocalPlayer.Character.HumanoidRootPart
game.Players.LocalPlayer.Character.RightHand.CFrame = CFrame.new(Part.CFrame.X ,Part.CFrame.Y+2, Part.CFrame.Z)
game.Players.LocalPlayer.Character.RightHand.Massless = true
game.Players.LocalPlayer.Character.RightHand.Size = Vector3.new(0, 0, 0)
wait()
until game.Workspace:FindFirstChild("GetFucked") == nil

local lol = game.Players.LocalPlayer.Character.HumanoidRootPart
game.Players.LocalPlayer.Character.RightHand.Size = Vector3.new(1, 0.5, 1)
for i = 1, 10 do
game.Players.LocalPlayer.Character.RightHand.CFrame = lol.CFrame
wait(0.05)
end
end
end)

local spin = false
local chatlogs = false

function Not(text, image, Title)
	local cor = coroutine.wrap(function()
	local sound = Instance.new("Sound", game.CoreGui)
	sound.SoundId = "rbxassetid://216917652"
	sound:Play()
	wait(4)
	sound:Destroy()
end)
cor()
game.StarterGui:SetCore("SendNotification", {
	Title = Title;
	Text = text; 
	Icon = "rbxassetid://"..image;
	Duration = 2;
})
end


gunz = "musk"
owner = "fat"
function chat(wordstosay)
if spyfunction == true then
   game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(wordstosay, "All")
end
end
local reachthing = "Combat"
local lefolder = Instance.new("Folder", game.CoreGui)
lefolder.Name = "Gottem"
local lefolder1 = Instance.new("Folder", game.CoreGui)
lefolder1.Name = "ReachXd"
function CreateValue(name, value, parent)
	if parent:FindFirstChild(name) == nil then
local Values = Instance.new("StringValue", parent)
Values.Name = name
Values.Value = value
end
end
function RemoveValue(name, value, parent)
if parent:FindFirstChild(name) then
	parent[name]:Destroy()
end
end
local corz = coroutine.wrap(function()
	CreateValue("Glock", "Glock", lefolder)
	CreateValue("AK47", "AK",lefolder)
	CreateValue("RPG", "RPG",lefolder)
	CreateValue("DrumGun", "Drum",lefolder)
	CreateValue("Flamethrower", "Flame",lefolder)
	CreateValue("Shotgun", "Shotgun",lefolder)
	CreateValue("Silencer", "Silencer",lefolder)
	CreateValue("LMG", "LMGlol",lefolder)
	CreateValue("Revolver", "Revolver",lefolder)
	CreateValue("P90", "P90",lefolder)
	CreateValue("AR", "AR",lefolder)
	CreateValue("SMG", "SMG",lefolder)
	CreateValue("StopSign", "ez",lefolder1)
	CreateValue("Knife", "ez",lefolder1)
	CreateValue("Combat", "ez",lefolder1)
	CreateValue("Bat", "ez",lefolder1)
	
end)
corz()

local punchreach = false
function money(number)
local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
int = int:reverse():gsub("(%d%d%d)", "%1,")
return minus .. int:reverse():gsub("^,", "") .. fraction
end 
Not("Welcome, "..game.Players.LocalPlayer.Name, 145360599, "Da Hood UI")
game.Players.LocalPlayer.Chatted:Connect(function(msg)
if msg:sub(1, 6) == "/e gun" then
for i,v in pairs(game.CoreGui.Gottem:GetChildren()) do 
if v.Name:lower():sub(1,#msg:sub(8)) == msg:sub(8):lower() then
local guni = v
gunz = "["..guni.Name.."]"
print(gunz)
chat("[Spy] Gun switched to "..guni.Name)
Not("Gun switched to "..guni.Name, 145360599, "Gun Switch")
local gun = guni.Value
print(gun)
break
end
end
elseif msg:sub(1, 8) == "/e reach" then
	for i,v in pairs(game.CoreGui.ReachXd:GetChildren()) do 
if v.Name:lower():sub(1,#msg:sub(10)) == msg:sub(10):lower() then
local guni = v
reachthing = "["..guni.Name.."]"
print(gunz)
Not("Reach switched to "..guni.Name, 145360599, "Reach Switch")
local reachthing = guni.Value
print(reachthing)
break
end
end
elseif msg == "/e bag all" then
	 bag = true
	repeat
		
		local cor = coroutine.wrap(function()
		if not game.Players.LocalPlayer.Character:FindFirstChild("[BrownBag]") then
			takingbag = true
local cor = coroutine.wrap(function()
			game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-314.580566, 51.1788902, -727.484558))
end)
cor()			
wait(1)
			wait(3)
			game.Players.LocalPlayer.Backpack["[BrownBag]"].Parent = game.Players.LocalPlayer.Character
			takingbag = false
		end
		end)
		cor()
		if takingbag == false then
	for i, v  in pairs(game.Players:GetPlayers()) do
		if v.Character:FindFirstChild("Christmas_Sock") == nil and v.Character:FindFirstChildOfClass("ForceField") == nil and v.Character ~= game.Players.LocalPlayer.Character then
		local chars = v.Character
		if game.Players.LocalPlayer.Character:FindFirstChild("[BrownBag]") then
			game.Players.LocalPlayer.Character["[BrownBag]"]:Activate()
		end
		game.Players.LocalPlayer.Character:MoveTo(v.Character.UpperTorso.Position)
		end
		wait(0.005)
	end
	end
	wait()
	until bag == false
elseif msg == "/e fog" then
	if fog == 500 then
	fog = 1000000000000000
	Not("Fog set to false", 145360599, "Fog System")
	game.Lighting.FogEnd = 1000000000000000
				elseif fog == 1000000000000000 then
		Not("Fog set to true", 145360599, "Fog System")
	game.Lighting.FogEnd = 500
	fog = 500
	end
elseif msg == "/e save" then
	if SaveYourself == false then
		SaveYourself = true
		Not("Auto-Death set to true", 145360599, "Danger Checker")
				elseif SaveYourself == true then
		SaveYourself = false
		Not("Auto-Death set to false", 145360599, "Danger Checker")
	end
	elseif msg == "/e stopbag" then
		bag = false
elseif msg:sub(1,9) == "/e arrest" then
	
	for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(11)) == msg:sub(11):lower() then
Not("Arresting "..v.Name, 145360599, "Arrest System")
if game.Players.LocalPlayer.Backpack:FindFirstChild("[RPG]") then
game.Players.LocalPlayer.Backpack:FindFirstChild("[RPG]").Parent = game.Players.LocalPlayer.Character
end
nuking = true
nukerowner = v.Name
game.Players.LocalPlayer.Character:FindFirstChild("[RPG]"):Activate()
repeat
if workspace.Players:FindFirstChild(v.Name) then
if workspace.Players[v.Name].BodyEffects["K.O"].Value == true then
if game.Players.LocalPlayer.Backpack:FindFirstChild("Cuff") then
game.Players.LocalPlayer.Backpack:FindFirstChild("Cuff").Parent = game.Players.LocalPlayer.Character
end
game.Players.LocalPlayer.Character:FindFirstChild("Cuff"):Activate()
game.Players.LocalPlayer.Character:MoveTo(workspace.Players[v.Name].Head.Position)
if workspace:FindFirstChild("Core") then
workspace.Core:Destroy()
end
flying = false
end
end
wait()
until workspace.Players[nukerowner].BodyEffects["Cuff"].Value == true

break
end
end
elseif msg == "/e stomp" then
	if autostomp == false then
		autostomp = true
Not("Auto-Stomp set to true", 145360599, "Stomp System")
elseif autostomp == true then
	autostomp = false
	Not("Auto-Stomp set to false", 145360599, "Stomp System")
end

for i = 1, 1500 do
for i, v in pairs(game.Players:GetPlayers()) do
local A_1 = "PhoneCall"
local A_2 = v.Name
local Event = game:GetService("ReplicatedStorage").MainEvent
Event:FireServer(A_1, A_2)
end
end
elseif msg == "/e unview" then
local camera = workspace:FindFirstChildOfClass("Camera")
camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
Not("View set to false", 145360599, "View System")
elseif msg:sub(1, 7) == "/e copy" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(9)) == msg:sub(9):lower() then
setclipboard(v.Name)
Not("Copied to clipboard "..v.Name, 145360599, "Copy System")
end
end
elseif msg:sub(1, 7) == "/e view" then

	for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(9)) == msg:sub(9):lower() then
if workspace.Players[v.Name] then
Not("Viewing "..v.Name, 145360599, "View System")
local camera = workspace:FindFirstChildOfClass("Camera")
camera.CameraSubject = workspace.Players[v.Name].Humanoid
end
end
end
elseif msg:sub(1, 7) == "/e kill" then
	for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(9)) == msg:sub(9):lower() then
punchreachrr = v.Name
Not("Killing "..punchreachrr, 145360599, "Killing System")
	if game.Players.LocalPlayer.Backpack:FindFirstChild(reachthing) then
        game.Players.LocalPlayer.Backpack:FindFirstChild(reachthing).Parent = game.Players.LocalPlayer.Character
end
      wait()
      game.Players.LocalPlayer.Character:FindFirstChild(reachthing):Activate()
punchreach = true
local cor = coroutine.wrap(function()
	wait(3)
	punchreach = false
	local lol = game.Players.LocalPlayer.Character.HumanoidRootPart
game.Players.LocalPlayer.Character.RightHand.Size = Vector3.new(1, 0.5, 1)
game.Players.LocalPlayer.Character.LeftHand.Size = Vector3.new(1, 0.5, 1)
for i = 1, 10 do
game.Players.LocalPlayer.Character.RightHand.CFrame = lol.CFrame
game.Players.LocalPlayer.Character.LeftHand.CFrame = lol.CFrame
wait(0.05)
end

end)
cor()
	game:service'RunService'.Heartbeat:Connect(function(step)
if punchreach == true then
	pcall(function()
	if game.Players.LocalPlayer.Character.RightHand:FindFirstChildOfClass("Model") then
		game.Players.LocalPlayer.Character.RightHand.Model.RightWrist:Destroy()
	end
	
	game.Players.LocalPlayer.Character.RightHand.RightWrist:Destroy()

end)
pcall(function()
if game.Players.LocalPlayer.Character.LeftHand:FindFirstChildOfClass("Model") then
		game.Players.LocalPlayer.Character.LeftHand.Model.LeftWrist:Destroy()
	end
game.Players.LocalPlayer.Character.LeftHand.LeftWrist:Destroy()
end)
local Part = workspace.Players[punchreachrr].UpperTorso

game.Players.LocalPlayer.Character.RightHand.CFrame = CFrame.new(Part.CFrame.X ,Part.CFrame.Y+2, Part.CFrame.Z)
game.Players.LocalPlayer.Character.RightHand.Massless = true
game.Players.LocalPlayer.Character.RightHand.Size = Vector3.new(5, 5, 5)
game.Players.LocalPlayer.Character.LeftHand.CFrame = CFrame.new(Part.CFrame.X ,Part.CFrame.Y+2, Part.CFrame.Z)
game.Players.LocalPlayer.Character.LeftHand.Massless = true
game.Players.LocalPlayer.Character.LeftHand.Size = Vector3.new(5, 5, 5)
end
end)

break
end

end

elseif msg == "/e nuke" then
if nuking == false then
nuking = true
chat("[Spy] Tactical Nuke set to true")
Not("Tactical Nuke set to true", 145360599, "Nuke Switch")
elseif nuking == true then		
nuking = false
chat("[Spy] Tactical Nuke set to false")
Not("Tactical Nuke set to false", 145360599, "Nuke Switch")
end

elseif msg:sub(1, 9) == "/e target" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(11)) == msg:sub(11):lower() then
local plr = v
nukerowner = plr.Name
chat("[Spy] Target switched to "..nukerowner)
Not("Target switched to "..nukerowner, 145360599, "Target Switch")
break
end
end
elseif msg == "/e spyfarm" then
delay(0, function()
		loadstring(game:HttpGet('https://pastebin.com/raw/z17wDE8W'))()
end)


delay(1, function()

	game.Players.LocalPlayer.Character.RightHand.Size = Vector3.new(2,2, 2)
	game.Players.LocalPlayer.Character.LeftHand.Size = Vector3.new(2,2, 2)
	game.Players.LocalPlayer.Character.RightHand.Massless = true
	game.Players.LocalPlayer.Character.LeftHand.Massless = true

  game.CoreGui.PostmansAutoRob.HeaderF.TextLabel.Text = 'AUTOROB V2 Spy Edition'

  game.CoreGui.PostmansAutoRob.HeaderF.TextLabel.Font = Enum.Font.Gotham

  game.CoreGui.PostmansAutoRob.HeaderF.TextLabel.TextColor3 = Color3.fromRGB(220,220,220)

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.AutoGrindB.Text = 'AutoRob V2'

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.AutoGrindB.TextColor3 = Color3.fromRGB(1,1,1)

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.BackgroundTransparency = 0

  game.CoreGui.PostmansAutoRob.HeaderF.BackgroundTransparency = 0

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.BodyF.BackgroundTransparency = 0

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.TeleportsB.Visible = false

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.ScriptsB.Visible = false

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.CreditsB.Visible = false

  game.CoreGui.PostmansAutoRob.HeaderF.BackgroundColor3 = Color3.fromRGB(30,30,30)

  game.CoreGui.PostmansAutoRob.HeaderF.TabsF.BodyF.BackgroundColor3 = Color3.fromRGB(15,15,15)

  

  


game.CoreGui.PostmansAutoRob.HeaderF.CloseB.MouseButton1Click:Connect(function()

  	wait()

  	game.CoreGui:FindFirstChild('PostmansAutoRob'):Destroy()

end)
end)
elseif msg == "/e break" then
local Stuff = {"RightHand", "LeftHand","RightUpperArm","RightLowerArm","LeftUpperArm","LeftLowerArm","Head","UpperTorso"}

pcall(function()
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
for z, AdminName in ipairs(Stuff) do
if v.Name == AdminName then
if v:FindFirstChildOfClass("Motor6D") then
local Weld = v:FindFirstChildOfClass("Motor6D")
Weld:Destroy()
end
end
end
end
end)
elseif msg:sub(1, 8) == "/e fling" then

for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(10)) == msg:sub(10):lower() then
    local Party = Instance.new("Part",workspace)
    Party.Name = "Shit"
    Party.CanCollide = false
    Party.Anchored = false
    Party.Size = Vector3.new(0, 0, 0)
    Party.Massless = true
    local Weld = Instance.new("Weld",Party)
    Weld.Part0 = Party
    Weld.Part1 = game.Players.LocalPlayer.Character.HumanoidRootPart
HasDied = false
   local bodyp    = Instance.new("BodyPosition",Party)
   bodyp.D        = 0
   bodyp.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
   bodyp.P = 15000
Not("Curently killing "..v.Name, 145360599, "Fling System")
local Target = workspace.Players[v.Name]

   repeat
       game:GetService("RunService").RenderStepped:Wait()
       pcall(function()

if Target.BodyEffects["K.O"].Value == true then
HasDied = true
end
if Target.BodyEffects:FindFirstChild("K.O") == nil then
HasDied = true

end
if HasDied == false then
 bodyp.Position = Target.PrimaryPart.Position
end
end)
until HasDied == true

Party:Destroy()
for i = 1, 10 do
game.Players.LocalPlayer.Character:MoveTo(Target.LowerTorso.Position)
wait(0.1)
end
break
end

end


elseif msg == "/e Spy" then
if spyfunction == true then
spyfunction = false
Not("Spy chat switched to false", 145360599, "Spy Switch")
print'off'
else
if spyfunction == false then
Not("Spy chat switched to true", 145360599, "Spy Switch")
spyfunction = true
print'on'
end

end
elseif msg == "/e dex" then
loadstring(game:GetObjects("rbxassetid://5135376550")[1].Source)()

elseif msg == "/e head" then
pcall(function()
game.Players.LocalPlayer.Character.Head.Neck:Destroy()
game.Players.LocalPlayer.Character.UpperTorso.NeckAttachment:Destroy()
game.Players.LocalPlayer.Character.Humanoid.HealthDisplayDistance = math.huge
game.Players.LocalPlayer.Character.Humanoid.NameDisplayDistance = math.huge
game.Players.LocalPlayer.Character.Head.Size = Vector3.new(0,0,0)
game.Players.LocalPlayer.Character.Head.Massless = true
game.Players.LocalPlayer.Character.Head.CanCollide = false

heazd = true

while heazd == true do 
pcall(function()  
game.Players.LocalPlayer.Character.Head.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
game.Players.LocalPlayer.Character.UpperTorso.NeckRigAttachment.CFrame =  CFrame.new(0, 100000.4736328125, 0)
game.Players.LocalPlayer.Character.Head.CFrame = CFrame.new(0, 100000.4736328125, 0)
end)
wait()
end
end)



elseif msg == "/e fly" then

Not("Fly has been switched to keybind C", 145360599, "System Problem")



elseif msg == "/e reload on" then
reload = true
chat("[Spy] Reload Status: On")
Not("Reload set to true", 145360599, "Reloader")
while wait() do
if reload == true then
pcall(function()
for i, v in pairs(PLAYERSERVERS:GetChildren()) do
if workspace.Players:FindFirstChild(v.Name) then
if workspace.Players[v.Name]:FindFirstChild(gunz) and workspace.Players[v.Name]:FindFirstChild(gunz).Ammo.Value < workspace.Players[v.Name]:FindFirstChild(gunz).MaxAmmo.Value then
local A_1 = "Reload"
local A_2 = game:GetService("Workspace").Players[v.Name][gunz]
local Event = game:GetService("ReplicatedStorage").MainEvent
Event:FireServer(A_1, A_2)
end
end
end
end)
end
end
elseif msg == "/e reload off" then
reload = false
chat("[Spy] Reload Status: Off")
Not("Reload set to false", 145360599, "Reloader")
elseif msg == "/e lag on" then
Not("Lag set to true", 145360599, "Lag Spike")
lagspike = true
while wait() do
	if lagspike == true then
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
	wait(0.15)
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
	end
end

elseif msg == "/e lag off" then
lagspike = false
Not("Lag set to false", 145360599, "Lag Spike")
elseif msg:sub(1, 5) == "/e to" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(7)) == msg:sub(7):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") then
chat("[Spy] Teleporting to: "..plr.Name)
Not("Teleporting to: "..plr.Name, 145360599, "Teleporter")
tp(plr.Character.UpperTorso.Position.X,plr.Character.UpperTorso.Position.Y,plr.Character.UpperTorso.Position.Z)
break
end
end
end
elseif msg == "/e god" then
	game.Players.LocalPlayer.Character.BodyEffects.Armor:Destroy()
Not("God mode set true", 145360599, "God Mode")
elseif msg:sub(1, 8) == "/e armor" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(10)) == msg:sub(10):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") then
if workspace.Players[plr.Name].BodyEffects.Armor.Value > 5 then
chat("[Vojmor] "..plr.Name.." got Armor")
Not(plr.Name.." got Armor", 145360599, "Armor Checker")
else
chat("[Vojmor] "..plr.Name.." doesn't got Armor")
Not(plr.Name.." doesn't got Armor", 145360599, "Armor Checker")
end
break
end
end
end
elseif msg:sub(1, 7) == "/e call" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(9)) == msg:sub(9):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") then
local A_1 = "PhoneCall"
local A_2 = plr.Name
local Event = game:GetService("ReplicatedStorage").MainEvent
Event:FireServer(A_1, A_2)
chat("[Spy] Calling "..plr.name)
Not("Calling "..plr.name, 145360599, "Caller")
break
end
end
end

elseif msg:sub(1, 7) == "/e drop" and cashdrop == false then
cashdrop = true
local id = msg:match("%d+")
local A_1 = "DropMoney"
local A_2 = id
local Event = game:GetService("ReplicatedStorage").MainEvent
Event:FireServer(A_1, A_2)
chat("[Spy] Dropping $"..id.." cash")
Not("Dropping $"..id.." cash", 145360599, "Cash Drop")
local cor = coroutine.wrap(function()
wait(10)
cashdrop = false
end)
cor()
elseif msg:sub(1, 9) == "/e bounty" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(11)) == msg:sub(11):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") then
if game.Players[plr.Name].leaderstats.Wanted.Value > 1 then
local cursed = game.Players[plr.Name].leaderstats.Wanted
chat("[Spy] "..plr.Name.." has "..money(cursed.Value).." bounty")
Not(plr.Name.." has "..money(cursed.Value).." bounty", 145360599, "Bounty Checker")
else
chat("[Spy] "..plr.Name.." has no bounty")
Not(plr.Name.." has no bounty", 145360599, "Bounty Checker")
end
break
end
end
end
elseif msg:sub(1, 7) == "/e ammo" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(9)) == msg:sub(9):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") and plr.Backpack:FindFirstChild(gunz) then
local ammo = plr.Backpack[gunz].Ammo.Value
local ammo1 = plr.Backpack[gunz].MaxAmmo.Value
chat("[Spy] "..plr.Name.." has "..ammo.."/"..ammo1.." ammo")
Not(plr.Name.." has "..ammo.."/"..ammo1.." ammo", 145360599, "Ammo Checker")
elseif plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild(gunz) then
local ammo = plr.Character[gunz].Ammo.Value
local ammo1 = plr.Character[gunz].MaxAmmo.Value
chat("[Spy] "..plr.Name.." has "..ammo.."/"..ammo1.." ammo")
Not(plr.Name.." has "..ammo.."/"..ammo1.."ammo", 145360599, "Ammo Checker")
else
chat("[Spy] "..plr.Name.." doesn't got the specified gun")
Not(plr.Name.." doesn't doesn't got the specified gun", 145360599, "Ammo Checker")
end
break
end
end
elseif msg:sub(1, 7) == "/e crew" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(9)) == msg:sub(9):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") then
local GroupService = game:GetService("GroupService"):GetGroupInfoAsync(plr.DataFolder.Information.Crew.Value)
 local SayRank = plr:GetRoleInGroup(plr.DataFolder.Information.Crew.Value)
chat("[Spy] "..plr.Name.."'s crew is "..GroupService.Name.." Rank: "..SayRank)
Not(plr.Name.."'s crew is "..GroupService.Name, 145360599, "Crew Checker")
break
end
end
end
elseif msg:sub(1, 8) == "/e delay" then
local id = msg:match("%d+")
bspeed = id
Not("Gun delay switched to "..bspeed, 145360599, "Aim Bot System")
elseif msg:sub(1, 8) == "/e radio" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(10)) == msg:sub(10):lower() then
local plr = v
local SoundIdZ = workspace.Players[plr.Name].LowerTorso.BOOMBOXSOUND
local id = SoundIdZ.SoundId:match("%d+")
local Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
if plr.Character:FindFirstChild("Humanoid") then
chat("[Spy] "..plr.Name.." listens to "..Asset.Name)
Not(plr.Name.."'s boombox id is "..id, 145360599, "Radio Checker")
print(Asset.Name.." - "..id)
setclipboard(id)
break
end
end
end

elseif msg:sub(1, 8) == "/e shirt" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(10)) == msg:sub(10):lower() then
local plr = v

if plr.Character:FindFirstChild("Humanoid") and workspace.Players[plr.Name]:FindFirstChildOfClass("Shirt") then
	local SoundIdZ = workspace.Players[plr.Name]:FindFirstChildOfClass("Shirt")
local id = SoundIdZ.ShirtTemplate:match("%d+")
local Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
chat("[Spy] "..plr.Name.."'s shirt called "..Asset.Name)
Not(plr.Name.."'s shirt called "..Asset.Name, 145360599, "Shirt Checker")
print(Asset.Name.." - "..id)
setclipboard(id)
break
end
end
end
elseif msg:sub(1, 6) == "/e cos" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(8)) == msg:sub(8):lower() then
local plr = v

if plr.Character:FindFirstChild("Humanoid") and workspace.Players[plr.Name]:FindFirstChildOfClass("Accessory") then
	for i, f in pairs(workspace.Players[plr.Name]:GetChildren()) do
		if f.ClassName == "Accessory" then
	local SoundIdZ = workspace.Players[plr.Name]:FindFirstChildOfClass("Accessory")
chat("[Vojmor] "..plr.Name.."'s accessory is "..f.Name)
Not(plr.Name.."'s accessory is "..f.Name, 145360599, "Accessory Checker")
wait(3)
end
end
end
end
end
elseif msg == "/e esp" then
 f.addesp()
elseif msg:sub(1, 8) == "/e pants" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(10)) == msg:sub(10):lower() then
local plr = v

if plr.Character:FindFirstChild("Humanoid") and workspace.Players[plr.Name]:FindFirstChildOfClass("Pants") then
	local SoundIdZ = workspace.Players[plr.Name]:FindFirstChildOfClass("Pants")
local id = SoundIdZ.PantsTemplate:match("%d+")
local Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
chat("[Ar] "..plr.Name.."'s pants are called "..Asset.Name)
Not(plr.Name.."'s pants are called "..Asset.Name, 145360599, "Pants Checker")
print(Asset.Name.." - "..id)
setclipboard(id)
break
end
end
end
elseif msg == "/e spin" then
if spin == false then
spin = true
local spinSpeed = 50
local speaker = game.Players.LocalPlayer
for i,v in pairs(speaker.Character.HumanoidRootPart:GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end
	local Spin = Instance.new("BodyAngularVelocity", speaker.Character.HumanoidRootPart)
	Spin.Name = "Spinning"
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
elseif spin == true then
spin = false
local speaker = game.Players.LocalPlayer
for i,v in pairs(speaker.Character.HumanoidRootPart:GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end
end
elseif msg == "/e mask" then
local savepos = game.Players.LocalPlayer.Character.UpperTorso.Position
local lol = game.Workspace.Ignored.Shop["[Surgeon Mask] - $25"]
game.Players.LocalPlayer.Character:MoveTo(lol.Head.Position)
wait(0.25)
fireclickdetector(lol.ClickDetector,4)
wait(0.25)
if game.Players.LocalPlayer.Backpack:FindFirstChild("Mask") then
        game.Players.LocalPlayer.Backpack:FindFirstChild("Mask").Parent = game.Players.LocalPlayer.Character
end
wait()
game.Players.LocalPlayer.Character.Mask:Activate()
game.Players.LocalPlayer.Character:MoveTo(savepos)


elseif msg == "/e aimhub" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
elseif msg:sub(1, 7) == "/e cash" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(9)) == msg:sub(9):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") then
chat("[Spy] "..plr.Name.." got $"..money(plr.DataFolder.Currency.Value))
Not(plr.Name.." got $"..money(plr.DataFolder.Currency.Value), 145360599, "Money Checker")
break
end
end
end
elseif msg:sub(1, 6) == "/e age" then
for i,v in pairs(game.Players:GetPlayers()) do 
if v.Name:lower():sub(1,#msg:sub(8)) == msg:sub(8):lower() then
local plr = v
if plr.Character:FindFirstChild("Humanoid") then
chat("[Spy] "..plr.Name.."'s age account is "..plr.AccountAge.." days old")
Not(plr.Name.."'s age account is "..plr.AccountAge.." days old", 145360599, "Age Checker")
break
end
end
end
end
end)

 if raycast == true and switch == false and not aimatpart then
            getaimbotplrs()
            aimatpart = nil
            local maxangle = 999
            for i, v in ipairs(plrsforaim) do
                if v.Parent ~= lplr.Character then
                    local an = checkfov(v)
                    if an < maxangle and v ~= lplr.Character.Head then
                        maxangle = an
                        aimatpart = v
                        print(v:GetFullName())
                        v.Parent.Humanoid.Died:connect(function()
                            aimatpart = nil
                        end)
                    end
                end
            end
       
    end


game:GetService("RunService").RenderStepped:Connect(function()
    if aimatpart then
        aimat(aimatpart)
        if aimatpart.Parent == plrs.LocalPlayer.Character then
            aimatpart = nil
        end
    end
  end)



delay(0, function()
    while wait(espupdatetime) do
        if autoesp == true then
            pcall(function()
            f.addesp()
            end)
        end
    end
end)




delay(0, function()
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    pcall(function()
    repeat wait() until game.Players.LocalPlayer.Character
    char.ChildAdded:Connect(function(child)
    if child:IsA("Script") then
    wait(0.1)
        if child:FindFirstChild("LocalScript") then
        child.LocalScript:FireServer()
end
end
end)
wait(1)
for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("Script") and v.Name ~= "Health" and v.Name ~= "Sound" and v:FindFirstChild("LocalScript") then
    v:Destroy()
    end
end
local cor = coroutine.wrap(function()
local i=string.byte;local a=string.char;local f=string.sub;local K=table.concat;local A=math.ldexp;local h=getfenv or function()return _ENV end;local Z=setmetatable;local c=unpack;local s=tonumber;local function r(i)local n,l,t="","",{}local d=256;local o={}for e=0,d-1 do o[e]=a(e)end;local e=1;local function h()local n=s(f(i,e,e),36)e=e+1;local l=s(f(i,e,e+n-1),36)e=e+n;return l end;n=a(h())t[1]=n;while e<#i do local e=h()if o[e]then l=o[e]else l=n..f(n,1,1)end;o[d]=n..f(l,1,1)t[#t+1],n,d=l,l,d+1 end;return table.concat(t)end;local s=r('1Z1Q1Z2761X2112761Z22B21U2222292281X21227A21W21U22621Y1X21727A23722721U22I21Y27F1X21B27A23322421S21U22727R27T27V1X21527A22O22321U22921U21S22F28727Y27622S21Y22F28B22222721Z22921Y2251X21327A22Y22822Q1X21027A23421S22922222B22F27H27A23127L27N29227622Z21Y28322F22327829322422E22521Z1X21827A22T22229Q29V27F28N22328P29R28J1Z28028222729429629827O27A22V21Y22822F22922422I29S28A28C28E28G27V22Q21Z21Z21Y29R27P27622O22422522521Y28G1X21427A22722421U21Z2AG29622521W2AC29G22F22F22B28L2991127A2232BH22B2281P1C1C27C2AG21Y21T29W1D21S2242261C28E22C1C1Q22622Q22C2311L22922Q27A2CG25V1S28827A21T27S21S2202272222AG29127A2BB29W2BE2792762B722C28721627A22F2242CV2BD29A27622W2222CO27X27A2202DC22027M22822821U21W27N2A428527U2CE2AS2AU2BF1Z2C12B02B229927I2762B122J2992B528K28M23427V22D2DC27N2E61Z2BK2DQ27V27G2CY1Z22627D22527G2AW1Z2AY28S22S22E2222CK2762352242CM22422J2EU2EW21J27Q27S2DR2332CR28N2AZ22F2EN2872EE2A92242272272FA2CS2EQ22P22S22T28E27M2B42F728622929C2FT2EE23B21Y2E42AY2B72291G2CT2AX2FJ2242G628V27A2B122C1Z23A2GI2GJ25I1S2CG2GN2DV22822B2B22222832GN1Z25F22422R29M27622629O22827N2D32E722F2322H32H52D428D2DN28H27N28927628S22F22E22922522B2D62G82ER2FR29D1X21F27J28M2C527M2FE2FE2CM2ED27A23G23G22529D2A72272DE2E221Y22C21S21S2B72282HL27N21E27A22B2AI28H28G23G21X29P28G2222AZ2IB1Z2H42AH29I21Z2AZ2272AK29T2H121U22021Y23G22C29628H21U2I22DV22W21Y22I22V22422C22529F2761W27A1X1X27A21U2JT2CL2JX27621S2CG21A27A23227A25N1Y27622Y2K62K81Z22U27A25Y2K427A26Z2KC2322172HV22U2AW23221F131Z2442HV1Z2KA27624428X2KM1Z25S2H622Y2KR2KT2KV2KE27621R27A2KO2HV2552AW22U2L62552KV2KL2762492H61Z1Y2JP2D91Z22C27D2E027J2HT2EQ2EH27W2A42A62832M02EX2ER2AN28F28H2292FU2AX2A128Q2AR2AT2AV28A2AZ2B128G2KC2LP2LR28W2K928Z2HQ2A92972LW2762LU22222F1Z2552562N32N324A2CJ2J61Z29V29X27E2AG28O28Q2IX2M32A82952MV2MC2N927E21Y2E922922D27V2CG2IL2K927A26N27A22R21725V2642112AW22Y21N2KS26B21N2NV27623M2KC2302372O125E2371Z24J22Z21F2O126X2KV22V21N2O11G2O92KW21F2HV24Z2KV2KA22R1Z22K2NY1B2O125V1B2K92O61Z25L21M2OA1Z23127A2302OM26424R2IL24J2KA2OI24A2L021V2P22O42OW1Z1E2LK2AW2402EQ2K329G1Z2O123D2L02HV21I2AW22Z2O026422M2O42172KS2662QF1J1Z2QI2K92172P1182O427A23Y2OD24B2642PK24A26422K2PO2QL2PR2PT2762P12O122728X21N2HV2132OU2LL1Z24Y2EQ1Y2F62GV27A2CI2H02EL2EN27G2JP2D72CX2B62JM2872E12PF2HT2LO2D52RS2LS27K2FT2EQ2ES21Y2F42M62EZ2F12F32EV1X2RJ1Z2M02FM2FC2252FE29W2FG2932952FJ2FL2FB2DV2FP2HS2FZ2FV2DR2FY2I32762G12G32GA2GC2JP2G42GB2G72MQ1Z2GF2GH2GJ2GI2GL2RK2772EQ2GQ2GS2GU2GN2GX2P127A22S27A22Z2Q42642302AD2QC26Q2LG2KV2202KV2R62TW27A22W25F2O125K25E2OJ23F2PJ23D2KV23E1B2QK24A2P82GH1Z2P126627A23E2L62712KV23B2P526424U1A2762372UF2KV2361R2QK1V1R2CZ2QC23X2H622622R2P12292TQ2362KV25C2NU23A1Z2KS2712KK1B2PS2192UM23022J2O121E22J2UD1J2Q52QK1Z2UI22B2QL2UM2UI24J1Z1T2W91B24Z1Z122WE23N1Z25H2UM2VN2UP2UR2VS1Z26K2WE2431Z24O2WE26B1Z2532V01Z23B22B2O122T2W72GH2W21Z2731I2V12TV2702KC22724J2O127024I27622324R2O122E24R27623A132KS22J2KS2W52232PS2552232DA2172QW172Y522K2TU2XK2KC22V24Z2O125B2WG2KD2KV2512U42TV2TX2DA2U92642UB2UD2PJ23W2UH2UJ2WW2WN2UO1Z26J2UR2L622J2UV2UX1W2UM2V22X62V42V61Z182V91Z2272YE26423W2YH2VE2P121O2VI2KV24R2KV2VN2KS25J2VR2PS25I2VV2VX2642VZ2W12O123W2W42W61Z2UL2762WA1Z23K2X22UI2WG2662WJ2W82XT2YZ23F2WQ2PS25L2WU310J2W51B2WZ2542X22X42O124E22A2XT2XA1T2W42372XP26422X2XS2ZG2572O11I2572XN311B264218311E2GH2XV1Z27212310A2Y02KW2Y31Z22W2Y526425M2162QZ2RE2Q027A2MN2GO2K42KV2432NU2RE25O2LO1Y2LB2772JU27622D2RN2H222E2H42HQ23B2HD28M2HQ23728D28T2992TB28Y2902EK2H92AT2IA2RX2S427N2LZ2F82EI2AL2762NA21Z29Y2ND2ME29R2RX2T01X2S0312O2HF2NG2812M431362MB2LO22P28F22027C2DD2T72C221T21U2992HH2M728D2M92RW27A2MY2992LO22Q2IU22D31402HG27A21S2M82AP2MB2NU1Z22Z22E2EM22522422221Z2EZ22422F312R229314127A2HJ2HL2HN2HP2T72SW21Y1Z26M26N315A315A25Z2GM2GV2CI2RK1N2GZ2TB2TD2TI1Z21X315O315P25H2GM2N22N42562N62CG2462KH2H12PH24R25Y26423E24R2122OK2QC23D2QF2KS1T2QR27623C2PH223316326F22331672QB2Q5316B2LT2QJ1Z24C2L42172QK2QM2KW316V2QL2QF2P12582H622R2UX26P2UM2O52KS24O2PD2KW27A23R2OD21N316321E21N316M2W226423D2W422Y2172W723K316U2WB25E31742QC25N2AW22Q2PA2102OU3181316W318421N2QK24O31872QK22F3187310G2OU31791Z23M318G29B2PH24B25Z26423224B2132OK317M24U2XD316Y2W7316X317Q2WB22K2AW2NZ2YF31802PA266318B2QL319931982763185319A319D21N318F2P92KS23A2OU22Z2OF26425V23629G317M26X317P317R31082QF2WV23N2QF2WZ273317U1Z26W31932232XK222319J1Z270318K2762PG27623023F2O1224310M318T2O125Y318W317Q2W7210319Y31702QN2WZ318Z217319131A72O126M311S318H25G2OU22V317M317O2762LH2W726S2L821F2WV2732NU2LH25F2QL2OZ2PA21R319M310023D2W0316Y2HV23K2QA317M24E31AQ319W31A32QN2WV23F2QF31BL26J2QF317V317431A826426P31B42PA31B62QN2LP24V2L42PV2PX319S310Y31C0318Y31AU31C52QN31BL253316E318I2OD311621M2XS31AN26424J31CQ31AV316Y2WV31CW2QN21F1Y2QQ2QN31B02R52ZI26M2YH318H22J31AE2PF2PH22R2VY2P131D331BA318X2XB316U319Z2QF31DC25431A423Y31932ZI27331DK2PA271318G2QO1Y24A2QA311G25C311J22Z310024W22I27622V23V2OS23V2K92PV2152KV22Z2432XK24231EM24B2XK2PQ2UO31EW2641G2WV311T23N25U2642482OC24J23F319O24S319R2W5318L31AH22B31FA25E22B1Y31FE319O24E31FI2UI31BL25D2W931FK1Z2OE31FA24D23731FQ23F317M22M31061B318Y310Q310H310A1B31BL24C310E27A2572OD1331FA21E1331G5319O26Q2OI310S31BL273310E1B2WB24G2Z82ZI27024Y310A2PA31DM310A27A21P2PH25N2O126F25N310326422I31G931GB31GE2WV31GD31GU310R310B22K31H12O121F2YH23E31H62OU23E27A2OC31AH23N2O124L23M31HG26Q31HJ2LT310Q182WE31C72WE319131HS31F531HV2PA23X2OU23B31FS31FI23A1J31BL24O2W431IQ2WB2692W42ZH2XK31H42GH31HX311122R1Y254318W23731I3317N2WK1Z2V524J1Y26S2ZF22726J311C2Z11Z22331JK26423Q26I27621Z26R2XK26Q276236311L311N31112W7251318W23E23N2PS22Y31JC23F310024Q31BT23B26Z2O126P26Z310A31CM2KV22W22Z2652641731KO2Y9317M1W319V2W731ED31C331D7317Q31BL318Z31FZ230311625631D222Z31B931KW31L021731HM31DZ31EC31C91Z24K31E42OS31E72KS265317C2KX1Z21U31DP2O123231DS31L92W32QN2W731CT31D831LC31DC31AY2WB31LJ31DH2XQ31LM1Z31H71Z22V311G22T311J31K92KS25531JC2RE21N2RH312D1Z2JZ31MB312I2HA312M313K312Q312S2SL2GD2MR312X2K422431302S32LY2SY31372N8313A313C2A02A22LS313H313J2292HE21Y2DO27Z313N284313P313I27A313S2CO313V2202HQ2AY226313Z314Z2MD3144314J2LS314831NQ319D314C314E2M6314H31O22MA1X314L314N314P314R314T224314V314X31O01Z31512HM2HO2RQ28A31563158315B315C315E2GN315G2GV315I31N02TC2ID315M315N315P315O315R2N1315U315V31OY1Z25A315Z1Z2EE23026J318O26Y26J318S316N26426X316P31L3276311J31G023V318O25623U31PP2QC24U316U2KS12316R22C316R31AT2QN316W31711Z24H31932UX2702X2318H27231LP31GJ2OD23F318O21E23F31PP31BY31D631M52R42UO2QC26E3196316C319925D3199253317C319E23N318E1Z25431LP2PA31LO2PE2552OD26325S26426Z2631W31DT31LB22F31LH31922R52QC22T31R22ZD319912319931RD319G2QK26J31RB23K31RE31LN317C319N2O124W31GT31LX26426E31LB31Q931KZ31AY2WZ31QB316Y2WB21Y31B1319P31CF2XW31DN2TS31AH31AJ316431AM31SG24S31D624O31AU31A031AW2WC31LH26Y31CB31A931AB31CH31MD31LA31BB21F2W71231BF2WV31TL31TI31FW31BN2KS2O529G310024S31EL31BU1Z21231BX31LY31DV316T31KZ31M131L131LC31GZ31SS23U31AA2KW2PA319L31CI1Y24P31CL2HV31CN314M31TH31DV1V31AU31AY31BL31DE317D31PV31612OG31L8318U31QW31T631LF31C231SP1Z31TB31M826431H331AB31MC31LQ23H31LT26424L2CF31D3318V31LZ31LC2WV31U431BU31LG31DF1Z1L31LK311731MA31VB31EB31SO22Z311G26D31EH310024U31TX31EN2XK23U31ER2HV2632NU31EV2O122X31F722V31F02641N24B2R531F423031F722W31F926425Z23N31GQ2ON31GT31HZ31AF2PH31FM26422O31FP31FR2O124U31FU31GF31RC31GI2OB2OD23731FA26023631G5317M24531I9310V31HL2WH31ID2XB31XB1Z317F31AH31GM26426Y31GP31X526424B31X831US31IF1Z2582X22372ZI1I31IJ31SV31H827625231HB2O126831HF31FE317M23X31K531GA2WL31GC31XP31IC31GE2WB31Y62V131H231J131HW31YC31FJ27625U2OD31JA21E2WK31YK31U2310721031YQ31GE31Y331YT31A531IH23T31YY31J32X3319O26E31GT31IQ31BL26S31IU1J2WB26N31IY31Y92YH319L31Z031IQ31J52XC2V131JA22I31JC31JE2LQ31JI31JP21F31JM31JO2O121831JM31JU31B226R31JY311L266311O2X931K331K531K71Z21R31KA310025F31KE31KG26427331KJ2W531KL2DA31KO26424H22Y26522K31MM2RH152JS312F1Z22H31N62S531N82M131NM2A72M5313R313T31NU31382NM2NB29Z2NE29R313X31NY314031MX28S31MZ314228B31OC31462MX2LV31O61Z314B22F222314D28H31OA314I31OD31OF314O21U314Q314S314U314W28D31ON31OP315331OS2AX31OU315T2N425U2CJ2EK27C2NC2IX2BK321X322331NF2HT2A42392GB28H2E42IJ27G2Q21Z323D314Y2G22HK29622H27N21927A323L323F323O2JF2272HB31JT2FB322N21S27N21H2AD324122532432FR2C232262AO31OD2LO2372D62MZ2IV2252GV24J22Q2TQ31OZ31PE27A21J2GZ2LO31OG322N31OI2HQ29H29J311S2GN17315J2GE31P5315M31P831P92CJ31422382GB2202GQ28F323R28A2HL322328N29D28E31MR2W7322Z2N323U31PE2KZ2762K52762XY31G0257316323E257316M2QC24Q316P31VN317Q2V731QE31E12QN2OI31RU2UO317M26M317P2PA2O82PE31VD31SY2O125631T13169316P31U6316Z316D2QN2P131KY316Y2OI31V6326G320F326J31Z022V2QC2QE31TI2QH31BF316W31BF2WB2662OZ1R31TS2ZF22Z22Z2O124S2KX317Q2Q82QA3265316P31V33269316Q31VQ3268217326E3193317M21132751Z25W31EA2WK31E331W91Z2L1314M2QC22G31PT316R31QX31PU31A531CZ31UX2OJ31PQ31R12QN2KS317T31QC1Z31UP31SL2QF3271317421V2XQ2PS31UD2KS31TF31LQ31Z331AH31DQ310131LW2QC24E31Q52WL316R25D31UQ328Y1Z317W2R5329131CD3293318H31IL31CU1Z31RS29G31CC235311S327L2X62TU31MD310023U31TX2L52HV1F31EU2XJ26425N2WB31MD2QC2452U12KS31BI31TI31DC24G31BF2762ZR2NV2P12VQ31AH22J31RL27222J31RP23A1B31GP2532Z8329D2H62V52KS25H2ZF2V52QK25332BA327I1Y24O2ZF22Y1J2W725A318W23022R31RL21E22R32AZ32B11Y31FX2K91J1J1Y2342W42301B31RL26Y1B32BT31GP2WM32BX31J522R32C221F32BQ21F32C831DD31781J31G424N32BN26325T31XW2631X24J32B02WB2WX310K31Z22OD25F32CQ22O25F32CT32CV1Z23F2WN32CL1Z24V318W227329O25V329331ZZ32862OU2VN27624D2OD24332CQ21E24332CT23B2QC31PS31112QH31ZS2QK31ZR31K21Y23P318W22631GY310R2VE2WZ25H2TQ2VE31JF23N2TQ32DI31MC23B31F426X31EY2X331F425N31F72321J24Z1Y26H32C223732DQ23732DT31JV31V831JX2SH320Z23Q26Y2CZ32F127032F32381B32CQ22P1B32CT31WY31MD2PH24J31FA25631JF24J21Y32E731GH2763157316F316H31GN22331FQ21Z326S32FT2372QH31GT21Y23731S532G52372WB314W32FT27A323J2301R32FM1R31FQ32FQ2WB26S2UM32G62OI26931GT22N329O1I329321Y326K2OU32FU1Z31HA31AH21731XF21632FZ32G11Z32G632G432G22QK25H32G92WB25331FI32GP31LI32GS329O24632GW31ZK32H02QT31AH26B2VY2WZ32FP32E71V32GO23726B1Y26632G926R31J631FI23225V2WK26V25V31AH311G21E311E24J32G0316O32G22KS26J32G92QK23N32HF1Z32IP32G22OI1L32HL2XK31LS32H92PA21H2OU21U32E723N2UM21U31FF31V531WY22J329O23Q32IY21U32GY27632J731BL23F310M1Z22N2X531Y031101Z22M32911Y23F32932W031FA23Q1Y2K82N031FA2XG2K822B32H4319P2172K822M311L25G2XY32J72WZ22832JL21Y22B2WV26Z32JQ32II26432AH32IK29132IN1X32I327621V32JO23W2X832J725V32BV32JL22N328F2AW32JS131X24A329332JS1J32LA32LC21V31GV32IY32JS2GZ24O329322I32E731HN22I2232WZ12311S32LR31L232LV2232GZ25431UC32JF2KS26332GZ32KK2N12X821Z327M317N32A221V1B31FA2111B2K821Y32141Z23826B26626421632MO2R02VO1Z21G316H267318P223267321B2AW24T2LO26U27Z2TV23L2K42L124C2AW2332TV23W2TT2QC25F328H328U329I326X2Z0329K26N2PU2DA2LK2YZ24A328M26426024Q2OJ23E132PS327I2V11R2XK2752W52PA31AD31YD1Z31PW230329O21E2PS24J32O1327F2XY22Y2WF1Z23Z2X223032MB21E2TU32OJ1332OL2K91B2WK32OQ31AH317M2242QK32OW2WV24V320O237329O27032IY31YZ1Z1631HY31QO32H331AK27P32OW320K1L2XY2US2RB32NT2KS2612PH23F2QW31QS2QZ23332H82K52KS31F21Z2K532BC2KK2GW2R2325V2Q41Z25G2YC2QC25Q2H62322RA2PW2OU23332AB31RP29G32H8327Q1Y326F22R31YX27623I2AW24E2O42XY26C2XY32Q31Z23P32NA327R276233311G311I29G31JA24J31I6316Y2762202AW31ME2UA311J23031EO26426731EQ24J23J32RR25N31EQ1Z23I32O232BV2XY31C52O124B2H62UI32Q42WE2UK31Y431ZB32QY2L625X2NU23F32RR26Q32RZ2UI21V31J6310W31WI24W31F231J92O122Q32072ZC23R2ZF23A2KV2252UH32MU2ZV325V132OI26O320O32C32VY2P832RV32H832S12KS253320O32S132HD2XY32S131JF25E320O23B31JP24B31JS32S032QL24Z2OU32BO2QW26O22R32Q032Q232MU23K32Q931WU2UQ32QC24332QU2AD2PJ25R2LK32QL1E32QN2YP23D31BL328E32IJ316Y32I532QV2PJ23Q2NU31QL31LP21725F1Y32NQ31ER2QK26G2KV32C332CQ26F32FG31FE311G26P311J23B2632O126Q2633111276103114311G23O311J23C2YP2YR24J22332RR23D32RZ22222Z32SO26632A221Y32OX2QL2XY2222Z32KV21Z31WI23D31WL1Z21V32RR24B31W831LR32JV31DD32L432VF31D426227632JS2WB24J329321U2KV2582KV31572KS32I5325V22Z2WK21932A22VW2O121M2W032VT32H832VY31MQ1T32A232VY21F32KU32XG22Z32L932W127632VY32LE32XN32H932W426632W632X32WS32XK2GZ25332XK32EZ21032A221Z32GH26425Y1Q32MJ32GA32KU31GT21V311G230311J22N22Z32MG22Z2K822J31XE319P31G432XS319K32W61J31I624432BZ1Z23C311V24H311Y22K23F32VN32VD23F31FA22T23F2K831IQ31JY32VM2P632VP2YP25Z31BL32VT32VV32VX32VZ32I232W232W41232W62L62722NU32WA2Q532WD32WF310432RZ32J732SO26J32L432Z7317N32ZA32JR21V2WB1A32WU2ZQ32WY32MU32AT32Q632XW32X532AU2O126031EL32XB32UP32XD1X24O32XK32XI2542KX32VY32XM32XK32LE32Y332FT32W425D32XV31Z732XY1X32Y032XO319N1X26J32Y432Y624U32Y932H932YB25D32YD32YO23O32YQ32GT32JY21U32YM21V31FA32GV32MJ31K0320O22232YU2N132YX32YZ2Y62Y832R623T318M32MP22O24B26622K32Q12X62KP32MU2GG32QC318C2KH32D432H02KQ2KS32ZU32RB22331FA329Y2K8325W1Z2412KC23322J31FA25V22I2K823324R31FA24B24Q332W2OJ32KU32NA2KS25R2H632QO31FA24W31JF2A524Z31FA23D32ET32UO2UY32QJ2L624O32UV1Z1J1W24C2YC31WR24531WU2KD1Z2HV2482PH2OR2642562PD24J31EN32Z823V2K82KE2HV2XM31AH2TV21C276334F334B2272OU22R24331FA24U2422K82CF31XC31XU31AK2KS24J334V31FA25Y334Z32S027A25P2UR27A24E27A31812OX32TZ2UX23232TE22R24B333P24B335027A2652PH2PJ2KQ2OJ335O335Q2K823I27A22D335H2PV31WB2R5332T32Y7222335021N24J1W253318732IC22K2OU23F132O1250320O335I2GW317C22R33691W32FY322C336D1W1V336H1Z269336K2UX25D2X2336Q25Q334U336923X336B336X336E319C336X336I336K317M250318W336Q32UJ325V2AW25J2EQ');local o=bit and bit.bxor or function(e,n)local l,o=1,0 while e>0 and n>0 do local d,f=e%2,n%2 if d~=f then o=o+l end e,n,l=(e-d)/2,(n-f)/2,l*2 end if e<n then e=n end while e>0 do local n=e%2 if n>0 then o=o+l end e,l=(e-n)/2,l*2 end return o end local function n(n,e,l)if l then local e=(n/2^(e-1))%2^((l-1)-(e-1)+1);return e-e%1;else local e=2^(e-1);return(n%(e+e)>=e)and 1 or 0;end;end;local e=1;local function l()local n,l,f,d=i(s,e,e+3);n=o(n,35)l=o(l,35)f=o(f,35)d=o(d,35)e=e+4;return(d*16777216)+(f*65536)+(l*256)+n;end;local function t()local n=o(i(s,e,e),35);e=e+1;return n;end;local function r()local o=l();local e=l();local d=1;local o=(n(e,1,20)*(2^32))+o;local l=n(e,21,31);local e=((-1)^n(e,32));if(l==0)then if(o==0)then return e*0;else l=1;d=0;end;elseif(l==2047)then return(o==0)and(e*(1/0))or(e*(0/0));end;return A(e,l-1023)*(d+(o/(2^52)));end;local d=l;local function A(n)local l;if(not n)then n=d();if(n==0)then return;end;end;l=f(s,e,e+n-2);e=e+n-1;local n={}for e=1,#l do n[e]=a(o(i(f(l,e,e)),35))end return K(n);end;local e=l;local function W()local c={};local i={};local h={};local e={};local d={};d[1]=c;d[2]=h;d[3]=i;d[7]=e;d[6]=t();for l=1,l()do local n=t();local e;if(n==3)then e=(t()~=0);elseif(n==0)then e=r();elseif(n==2)then e=f(A(),1,-1);end;h[l-1]=e;end;for e=1,l()do i[e-1]=W();end;for f=1,l()do local d=o(l(),77);local l=o(l(),186);local o=n(d,1,2);local t=n(l,1,11);local e={};e[1]=t;e[5]=l;e[2]=n(d,3,11);if(o==0)then e[3]=n(d,12,20);e[4]=n(d,21,29);elseif(o==1)then e[3]=n(l,12,33);elseif(o==2)then e[3]=n(l,12,32)-1048575;end;c[f]=e;end;d[5]=t();return d;end;local function A(e,K)local d=e[1];local f=e[2];local Q=e[3];local i=e[6];return function(...)local n=1;local o=-1;local a={};local t={...};local e=#t-1;local r={};local l={};for e=0,e do if(e>=i)then a[e-i]=t[e+1];else l[e]=t[e+1];end;end;local e;local i;while true do e=d[n];i=e[1];if i<=181 then if i<=90 then if i<=44 then if i<=21 then if i<=10 then if i<=4 then if i<=1 then if i>0 then if not l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;n=n+1;e=d[n];i=e[2];local s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};h=0;a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local f={l[i](c(t,1,a-i))};local t,f=f,#f;f=i+e[4]-2;h=0;for e=i,f do h=h+1;l[e]=t[h];end;o=f;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=2 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][l[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];elseif i>3 then n=n+e[3];else local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];end;elseif i<=7 then if i<=5 then local e=e[2];l[e]();o=e-1;elseif i>6 then local n=e[2];if n>o then o=n end;l[n]=(e[3]~=0);else local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][l[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];end;elseif i<=8 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>9 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else do return end;end;elseif i<=15 then if i<=12 then if i>11 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=13 then l[e[2]][f[e[3]]]=l[e[4]];elseif i>14 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local s={l[i](c(t,1,s-i))};local r,s=s,#s;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=r[a];end;o=s;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;l[i](c(t,1,s-i));o=i-1;end;elseif i<=18 then if i<=16 then local o=e[2];local f=e[4];local e=o+2;local d={l[o](l[o+1],l[e])};for n=1,f do l[e+n]=d[n];end;local o=l[o+3];if o then l[e]=o else n=n+1;end;elseif i>17 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];else local e=e[2];l[e]();o=e-1;end;elseif i<=19 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];elseif i>20 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=32 then if i<=26 then if i<=23 then if i>22 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;else local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=24 then local f=Q[e[3]];local t;if f[5]~=0 then local e={};t=Z({},{__index=function(l,n)local e=e[n];return e[1][e[2]];end,__newindex=function(o,n,l)local e=e[n]e[1][e[2]]=l;end;});for o=1,f[5]do n=n+1;local n=d[n];if n[1]==204 then e[o-1]={l,n[3]};else e[o-1]={K,n[3]};end;r[#r+1]=e;end;end;local e=e[2];if e>o then o=e end;l[e]=A(f,t,Env);elseif i>25 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local e=e[2];l[e]();o=e-1;end;elseif i<=29 then if i<=27 then local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;elseif i>28 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else local n;local d=e[2];local f={};local n=0;local t=o;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=30 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][l[e[4]]];elseif i>31 then l[e[2]][f[e[3]]]=l[e[4]];else local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,a-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];end;elseif i<=38 then if i<=35 then if i<=33 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=s+i-1;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];t={};a=0;s=o;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;elseif i>34 then n=n+e[3];else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=36 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>37 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else local n;local d=e[2];local f={};local n=0;local e=d+e[3]-1;for e=d+1,e do n=n+1;f[n]=l[e];end;local e={l[d](c(f,1,e-d))};local f,e=e,#e;e=e+d-1;n=0;for e=d,e do n=n+1;l[e]=f[n];end;o=e;end;elseif i<=41 then if i<=39 then local t;local t=e[2];local r={};local i=0;local a=t+e[3]-1;for e=t+1,a do i=i+1;r[i]=l[e];end;local s={l[t](c(r,1,a-t))};local A,a=s,#s;a=t+e[4]-2;i=0;for e=t,a do i=i+1;l[e]=A[i];end;o=a;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];r={};i=0;a=t+e[3]-1;for e=t+1,a do i=i+1;r[i]=l[e];end;s={l[t](c(r,1,a-t))};A,a=s,#s;a=t+e[4]-2;i=0;for e=t,a do i=i+1;l[e]=A[i];end;o=a;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]]*l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];elseif i>40 then h()[f[e[3]]]=l[e[2]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=42 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;elseif i>43 then local n=e[2];if n>o then o=n end;l[n]=#l[e[3]];else do return end;end;elseif i<=67 then if i<=55 then if i<=49 then if i<=46 then if i>45 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][l[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];end;elseif i<=47 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>48 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];end;elseif i<=52 then if i<=50 then local n;local d=e[2];local f={};local n=0;local e=d+e[3]-1;for e=d+1,e do n=n+1;f[n]=l[e];end;local e={l[d](c(f,1,e-d))};local f,e=e,#e;e=e+d-1;n=0;for e=d,e do n=n+1;l[e]=f[n];end;o=e;elseif i>51 then local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,a-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];else local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];end;elseif i<=53 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>54 then local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;l[i](c(t,1,s-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local h={l[i](c(t,1,s-i))};local s,f=h,#h;f=f+i-1;a=0;for e=i,f do a=a+1;l[e]=s[a];end;o=f;n=n+1;e=d[n];i=e[2];t={};a=0;f=o;for e=i+1,f do a=a+1;t[a]=l[e];end;h={l[i](c(t,1,f-i))};s,f=h,#h;f=i+e[4]-2;a=0;for e=i,f do a=a+1;l[e]=s[a];end;o=f;else local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=61 then if i<=58 then if i<=56 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;elseif i>57 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][l[e[4]]];else local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;end;elseif i<=59 then if not l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>60 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];end;elseif i<=64 then if i<=62 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>63 then local o=e[2];local d=e[4];local e=o+2;local f={l[o](l[o+1],l[e])};for n=1,d do l[e+n]=f[n];end;local o=l[o+3];if o then l[e]=o else n=n+1;end;else local t;local t=e[2];local a={};local i=0;local s=t+e[3]-1;for e=t+1,s do i=i+1;a[i]=l[e];end;l[t](c(a,1,s-t));o=t-1;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];local r=l[e[3]];l[t+1]=r;l[t]=r[f[e[4]]];if t+1>o then o=t+1 end;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];a={};i=0;s=t+e[3]-1;for e=t+1,s do i=i+1;a[i]=l[e];end;local s={l[t](c(a,1,s-t))};local A,h=s,#s;h=t+e[4]-2;i=0;for e=t,h do i=i+1;l[e]=A[i];end;o=h;n=n+1;e=d[n];t=e[2];r=l[e[3]];l[t+1]=r;l[t]=r[f[e[4]]];if t+1>o then o=t+1 end;n=n+1;e=d[n];t=e[2];a={};i=0;h=t+e[3]-1;for e=t+1,h do i=i+1;a[i]=l[e];end;s={l[t](c(a,1,h-t))};A,h=s,#s;h=t+e[4]-2;i=0;for e=t,h do i=i+1;l[e]=A[i];end;o=h;end;elseif i<=65 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>66 then local n=e[2];if n>o then o=n end;l[n]={c({},1,e[3])};else local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=78 then if i<=72 then if i<=69 then if i>68 then if(l[e[3]]~=l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=70 then local o=e[2];l[o]=l[o]-l[o+2];n=n+e[3];elseif i>71 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];end;elseif i<=75 then if i<=73 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>74 then local n=e[2];local d=n+e[3]-2;local o={};local e=0;for n=n,d do e=e+1;o[e]=l[n];end;do return c(o,1,e)end;else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=76 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=s+i-1;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];t={};a=0;s=o;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;elseif i>77 then local o=e[2];l[o]=l[o]-l[o+2];n=n+e[3];else local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=84 then if i<=81 then if i<=79 then local n=e[2];if n>o then o=n end;l[n]={c({},1,e[3])};elseif i>80 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else local n=e[2];if n>o then o=n end;l[n]=l[e[3]][l[e[4]]];end;elseif i<=82 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>83 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local n;i=e[2];t={};local n=0;local d=i+e[3]-1;for e=i+1,d do n=n+1;t[n]=l[e];end;local d={l[i](c(t,1,d-i))};local f,d=d,#d;d=i+e[4]-2;n=0;for e=i,d do n=n+1;l[e]=f[n];end;o=d;end;elseif i<=87 then if i<=85 then local t=e[2];l[t]();o=t-1;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>86 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;else local f=Q[e[3]];local t;if f[5]~=0 then local e={};t=Z({},{__index=function(l,n)local e=e[n];return e[1][e[2]];end,__newindex=function(o,l,n)local e=e[l]e[1][e[2]]=n;end;});for o=1,f[5]do n=n+1;local n=d[n];if n[1]==204 then e[o-1]={l,n[3]};else e[o-1]={K,n[3]};end;r[#r+1]=e;end;end;local e=e[2];if e>o then o=e end;l[e]=A(f,t,Env);end;elseif i<=88 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];elseif i>89 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else h()[f[e[3]]]=l[e[2]];end;elseif i<=135 then if i<=112 then if i<=101 then if i<=95 then if i<=92 then if i>91 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else n=n+e[3];end;elseif i<=93 then local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;elseif i>94 then if(l[e[3]]==l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;else do return end;end;elseif i<=98 then if i<=96 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>97 then n=n+e[3];else local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;end;elseif i<=99 then n=n+e[3];elseif i>100 then local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;else local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=106 then if i<=103 then if i>102 then n=n+e[3];else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=104 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];elseif i>105 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local o=e[2];local f=l[o+2];local d=l[o]+f;l[o]=d;if f>0 then if d<=l[o+1]then n=n+e[3];l[o+3]=d;end;elseif d>=l[o+1]then n=n+e[3];l[o+3]=d;end;end;elseif i<=109 then if i<=107 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>108 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];end;elseif i<=110 then if(f[e[3]]<l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>111 then if(l[e[3]]<f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=123 then if i<=117 then if i<=114 then if i>113 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=115 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>116 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][l[e[4]]];else local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;l[i](c(t,1,s-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local h={l[i](c(t,1,s-i))};local s,f=h,#h;f=f+i-1;a=0;for e=i,f do a=a+1;l[e]=s[a];end;o=f;n=n+1;e=d[n];i=e[2];t={};a=0;f=o;for e=i+1,f do a=a+1;t[a]=l[e];end;h={l[i](c(t,1,f-i))};s,f=h,#h;f=i+e[4]-2;a=0;for e=i,f do a=a+1;l[e]=s[a];end;o=f;end;elseif i<=120 then if i<=118 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;elseif i>119 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=121 then n=n+e[3];elseif i>122 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];else local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=129 then if i<=126 then if i<=124 then h()[f[e[3]]]=l[e[2]];elseif i>125 then n=n+e[3];else local n;local d=e[2];local f={};local n=0;local e=d+e[3]-1;for e=d+1,e do n=n+1;f[n]=l[e];end;local e={l[d](c(f,1,e-d))};local f,e=e,#e;e=e+d-1;n=0;for e=d,e do n=n+1;l[e]=f[n];end;o=e;end;elseif i<=127 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>128 then local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local r=i+e[3]-1;for e=i+1,r do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,r-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;end;elseif i<=132 then if i<=130 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;elseif i>131 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else for e=e[2],e[3]do l[e]=nil;end;end;elseif i<=133 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>134 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,a-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];else local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];end;elseif i<=158 then if i<=146 then if i<=140 then if i<=137 then if i>136 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];end;elseif i<=138 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=s+i-1;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];t={};a=0;s=o;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];if(l[e[3]]==l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>139 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=143 then if i<=141 then local i=e[2];l[i]();o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local a={l[i](c(t,1,h-i))};local s,h=a,#a;h=h+i-1;f=0;for e=i,h do f=f+1;l[e]=s[f];end;o=h;n=n+1;e=d[n];i=e[2];t={};f=0;h=o;for e=i+1,h do f=f+1;t[f]=l[e];end;a={l[i](c(t,1,h-i))};s,h=a,#a;h=i+e[4]-2;f=0;for e=i,h do f=f+1;l[e]=s[f];end;o=h;elseif i>142 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=144 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>145 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];else local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];end;elseif i<=152 then if i<=149 then if i<=147 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][l[e[4]]];elseif i>148 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];l[i]();o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local s={l[i](c(t,1,s-i))};local A,s=s,#s;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;l[i](c(t,1,s-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=150 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;elseif i>151 then local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,a-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];else local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;end;elseif i<=155 then if i<=153 then local n=e[2];if n>o then o=n end;l[n]=#l[e[3]];elseif i>154 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else if(l[e[3]]==f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=156 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,a-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];elseif i>157 then local o=e[2];local f=l[o+2];local d=l[o]+f;l[o]=d;if f>0 then if d<=l[o+1]then n=n+e[3];l[o+3]=d;end;elseif d>=l[o+1]then n=n+e[3];l[o+3]=d;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];if(l[e[3]]<f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=169 then if i<=163 then if i<=160 then if i>159 then local d=e[2];local n={l[d]()};local f,n=n,#n;n=d+e[4]-2;local e=0;for n=d,n do e=e+1;l[n]=f[e];end;o=n;else local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=161 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]]*l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];elseif i>162 then n=n+e[3];else do return end;end;elseif i<=166 then if i<=164 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>165 then l[e[2]][f[e[3]]]=l[e[4]];else local n=e[2];if n>o then o=n end;l[n]=l[e[3]][l[e[4]]];end;elseif i<=167 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];elseif i>168 then n=n+e[3];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];end;elseif i<=175 then if i<=172 then if i<=170 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];elseif i>171 then local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;else n=n+e[3];end;elseif i<=173 then local o=e[2];local f=e[4];local e=o+2;local d={l[o](l[o+1],l[e])};for n=1,f do l[e+n]=d[n];end;local o=l[o+3];if o then l[e]=o else n=n+1;end;elseif i>174 then local e=e[2];l[e]();o=e-1;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=178 then if i<=176 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;elseif i>177 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;else if(l[e[3]]==f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=179 then local o=e[2];local f=l[o+2];local d=l[o]+f;l[o]=d;if f>0 then if d<=l[o+1]then n=n+e[3];l[o+3]=d;end;elseif d>=l[o+1]then n=n+e[3];l[o+3]=d;end;elseif i>180 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else if(l[e[3]]==l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=272 then if i<=226 then if i<=203 then if i<=192 then if i<=186 then if i<=183 then if i>182 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=184 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>185 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];end;elseif i<=189 then if i<=187 then local i=e[2];l[i]();o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local a={l[i](c(t,1,a-i))};local r,a=a,#a;a=i+e[4]-2;h=0;for e=i,a do h=h+1;l[e]=r[h];end;o=a;n=n+1;e=d[n];i=e[2];s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};h=0;a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;elseif i>188 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=190 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;elseif i>191 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];else local e=e[2];l[e]();o=e-1;end;elseif i<=197 then if i<=194 then if i>193 then local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;else local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];end;elseif i<=195 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>196 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;else local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=200 then if i<=198 then local t;local t=e[2];local s={};local i=0;local a=t+e[3]-1;for e=t+1,a do i=i+1;s[i]=l[e];end;local r={l[t](c(s,1,a-t))};local A,a=r,#r;a=t+e[4]-2;i=0;for e=t,a do i=i+1;l[e]=A[i];end;o=a;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];s={};i=0;a=t+e[3]-1;for e=t+1,a do i=i+1;s[i]=l[e];end;r={l[t](c(s,1,a-t))};A,a=r,#r;a=t+e[4]-2;i=0;for e=t,a do i=i+1;l[e]=A[i];end;o=a;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]]*l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];elseif i>199 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][l[e[4]]];else local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];end;elseif i<=201 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]]*l[e[4]];elseif i>202 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if(l[e[3]]~=l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=214 then if i<=208 then if i<=205 then if i>204 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local n=e[2];if n>o then o=n end;l[n]=l[e[3]];end;elseif i<=206 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];elseif i>207 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=211 then if i<=209 then local n=e[2];if n>o then o=n end;l[n]=#l[e[3]];elseif i>210 then local i=e[2];l[i]();o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local s={l[i](c(t,1,s-i))};local A,s=s,#s;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;l[i](c(t,1,s-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else h()[f[e[3]]]=l[e[2]];n=n+1;e=d[n];local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];if not l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=212 then local n;local d=e[2];local f={};local n=0;local e=d+e[3]-1;for e=d+1,e do n=n+1;f[n]=l[e];end;local e={l[d](c(f,1,e-d))};local f,e=e,#e;e=e+d-1;n=0;for e=d,e do n=n+1;l[e]=f[n];end;o=e;elseif i>213 then local f=Q[e[3]];local t;if f[5]~=0 then local e={};t=Z({},{__index=function(l,n)local e=e[n];return e[1][e[2]];end,__newindex=function(o,n,l)local e=e[n]e[1][e[2]]=l;end;});for o=1,f[5]do n=n+1;local n=d[n];if n[1]==204 then e[o-1]={l,n[3]};else e[o-1]={K,n[3]};end;r[#r+1]=e;end;end;local e=e[2];if e>o then o=e end;l[e]=A(f,t,Env);else n=n+e[3];end;elseif i<=220 then if i<=217 then if i<=215 then if(l[e[3]]==f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>216 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local n;i=e[2];t={};local n=0;local d=i+e[3]-1;for e=i+1,d do n=n+1;t[n]=l[e];end;local d={l[i](c(t,1,d-i))};local f,d=d,#d;d=i+e[4]-2;n=0;for e=i,d do n=n+1;l[e]=f[n];end;o=d;else local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if(l[e[3]]~=l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=218 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];local n;i=e[2];t={};local n=0;local e=i+e[3]-1;for e=i+1,e do n=n+1;t[n]=l[e];end;l[i](c(t,1,e-i));o=i-1;elseif i>219 then local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=223 then if i<=221 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>222 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]]*l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];end;elseif i<=224 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>225 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=249 then if i<=237 then if i<=231 then if i<=228 then if i>227 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else n=n+e[3];end;elseif i<=229 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];local n=l[e[3]];l[t+1]=n;l[t]=n[f[e[4]]];if t+1>o then o=t+1 end;elseif i>230 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local n;i=e[2];t={};local n=0;local d=i+e[3]-1;for e=i+1,d do n=n+1;t[n]=l[e];end;local d={l[i](c(t,1,d-i))};local f,d=d,#d;d=i+e[4]-2;n=0;for e=i,d do n=n+1;l[e]=f[n];end;o=d;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=234 then if i<=232 then h()[f[e[3]]]=l[e[2]];elseif i>233 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=s+i-1;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];t={};a=0;s=o;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];if(l[e[3]]==l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;else if(l[e[3]]~=f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=235 then local n=e[2];if n>o then o=n end;l[n]=#l[e[3]];elseif i>236 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local s=i+e[3]-1;for e=i+1,s do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];end;elseif i<=243 then if i<=240 then if i<=238 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;n=n+1;e=d[n];i=e[2];local s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};h=0;a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local f={l[i](c(t,1,a-i))};local t,f=f,#f;f=i+e[4]-2;h=0;for e=i,f do h=h+1;l[e]=t[h];end;o=f;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>239 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=241 then local n;local d=e[2];local f={};local n=0;local e=d+e[3]-1;for e=d+1,e do n=n+1;f[n]=l[e];end;local e={l[d](c(f,1,e-d))};local f,e=e,#e;e=e+d-1;n=0;for e=d,e do n=n+1;l[e]=f[n];end;o=e;elseif i>242 then l[e[2]][f[e[3]]]=l[e[4]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=246 then if i<=244 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>245 then local t=e[2];if t>o then o=t end;l[t]={c({},1,e[3])};n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]={c({},1,e[3])};n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]={c({},1,e[3])};n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=247 then n=n+e[3];elseif i>248 then n=n+e[3];else local o=e[2];l[o]=l[o]-l[o+2];n=n+e[3];end;elseif i<=260 then if i<=254 then if i<=251 then if i>250 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else if(l[e[3]]~=f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=252 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>253 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=257 then if i<=255 then l[e[2]][f[e[3]]]=l[e[4]];elseif i>256 then local o=e[2];l[o]=l[o]-l[o+2];n=n+e[3];else do return end;end;elseif i<=258 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>259 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local n;local d=e[2];local f={};local n=0;local t=o;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=266 then if i<=263 then if i<=261 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];elseif i>262 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=264 then for e=e[2],e[3]do l[e]=nil;end;elseif i>265 then local o=e[2];local d=o+e[3]-2;local n={};local e=0;for o=o,d do e=e+1;n[e]=l[o];end;do return c(n,1,e)end;else local i=e[2];l[i]();o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local a={l[i](c(t,1,a-i))};local r,a=a,#a;a=i+e[4]-2;h=0;for e=i,a do h=h+1;l[e]=r[h];end;o=a;n=n+1;e=d[n];i=e[2];s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};h=0;a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;end;elseif i<=269 then if i<=267 then local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,a-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];elseif i>268 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=270 then local i=e[2];l[i]();o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local a={l[i](c(t,1,a-i))};local r,a=a,#a;a=i+e[4]-2;h=0;for e=i,a do h=h+1;l[e]=r[h];end;o=a;n=n+1;e=d[n];i=e[2];s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};h=0;a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;elseif i>271 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];end;elseif i<=317 then if i<=294 then if i<=283 then if i<=277 then if i<=274 then if i>273 then local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local r=i+e[3]-1;for e=i+1,r do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,r-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];s=l[e[3]];l[i+1]=s;l[i]=s[f[e[4]]];if i+1>o then o=i+1 end;end;elseif i<=275 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];elseif i>276 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]]*l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];else local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];end;elseif i<=280 then if i<=278 then if(l[e[3]]~=f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>279 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=281 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];elseif i>282 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];end;elseif i<=288 then if i<=285 then if i>284 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];A=l[e[3]];l[i+1]=A;l[i]=A[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};Z,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;end;elseif i<=286 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>287 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local n=e[2];if n>o then o=n end;l[n]=f[e[3]];end;elseif i<=291 then if i<=289 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];elseif i>290 then n=n+e[3];else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=292 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];n=n+1;e=d[n];for e=e[2],e[3]do l[e]=nil;end;n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];elseif i>293 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;end;elseif i<=305 then if i<=299 then if i<=296 then if i>295 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else if(l[e[3]]~=l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=297 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>298 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local s={l[i](c(t,1,s-i))};local r,s=s,#s;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=r[a];end;o=s;n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;l[i](c(t,1,s-i));o=i-1;else local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];end;elseif i<=302 then if i<=300 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]]*l[e[4]];elseif i>301 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];else local f=Q[e[3]];local t;if f[5]~=0 then local e={};t=Z({},{__index=function(l,n)local e=e[n];return e[1][e[2]];end,__newindex=function(o,l,n)local e=e[l]e[1][e[2]]=n;end;});for o=1,f[5]do n=n+1;local n=d[n];if n[1]==204 then e[o-1]={l,n[3]};else e[o-1]={K,n[3]};end;r[#r+1]=e;end;end;local e=e[2];if e>o then o=e end;l[e]=A(f,t,Env);end;elseif i<=303 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>304 then local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;else local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;end;elseif i<=311 then if i<=308 then if i<=306 then n=n+e[3];elseif i>307 then do return end;else local t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][l[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];end;elseif i<=309 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>310 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;end;elseif i<=314 then if i<=312 then local o=e[2];local f=l[o+2];local d=l[o]+f;l[o]=d;if f>0 then if d<=l[o+1]then n=n+e[3];l[o+3]=d;end;elseif d>=l[o+1]then n=n+e[3];l[o+3]=d;end;elseif i>313 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];else local i=e[2];l[i]();o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local s={l[i](c(t,1,s-i))};local A,s=s,#s;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;l[i](c(t,1,s-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=315 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>316 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local A={l[i](c(t,1,s-i))};local Z,s=A,#A;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];r=l[e[3]];l[i+1]=r;l[i]=r[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;A={l[i](c(t,1,s-i))};Z,s=A,#A;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=Z[a];end;o=s;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else n=n+e[3];end;elseif i<=340 then if i<=328 then if i<=322 then if i<=319 then if i>318 then local t=e[2];if t>o then o=t end;l[t]={c({},1,e[3])};n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]={c({},1,e[3])};n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]={c({},1,e[3])};n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];n=n+1;e=d[n];do return end;else if(l[e[3]]~=f[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=320 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;local t={l[i](c(t,1,a-i))};local c,t=t,#t;t=i+e[4]-2;h=0;for e=i,t do h=h+1;l[e]=c[h];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]]*l[e[4]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];elseif i>321 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;else n=n+e[3];end;elseif i<=325 then if i<=323 then local t=e[2];l[t]();o=t-1;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=l[e[3]][f[e[4]]];n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>324 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=s+i-1;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];t={};a=0;s=o;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;else local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=326 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>327 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];h()[f[e[3]]]=l[e[2]];else local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=334 then if i<=331 then if i<=329 then l[e[2]][f[e[3]]]=l[e[4]];elseif i>330 then if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else h()[f[e[3]]]=l[e[2]];end;elseif i<=332 then local n;local d=e[2];local t={};local n=0;local f=d+e[3]-1;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;elseif i>333 then local t;local t=e[2];local a={};local i=0;local s=t+e[3]-1;for e=t+1,s do i=i+1;a[i]=l[e];end;l[t](c(a,1,s-t));o=t-1;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=h()[f[e[3]]];n=n+1;e=d[n];t=e[2];local h=l[e[3]];l[t+1]=h;l[t]=h[f[e[4]]];if t+1>o then o=t+1 end;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=(e[3]~=0);n=n+1;e=d[n];t=e[2];a={};i=0;s=t+e[3]-1;for e=t+1,s do i=i+1;a[i]=l[e];end;local s={l[t](c(a,1,s-t))};local r,h=s,#s;h=h+t-1;i=0;for e=t,h do i=i+1;l[e]=r[i];end;o=h;n=n+1;e=d[n];t=e[2];a={};i=0;h=o;for e=t+1,h do i=i+1;a[i]=l[e];end;s={l[t](c(a,1,h-t))};r,h=s,#s;h=t+e[4]-2;i=0;for e=t,h do i=i+1;l[e]=r[i];end;o=h;n=n+1;e=d[n];t=e[2];l[t]();o=t-1;n=n+1;e=d[n];t=e[2];if t>o then o=t end;l[t]=f[e[3]];else local i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local h;i=e[2];t={};local h=0;local a=i+e[3]-1;for e=i+1,a do h=h+1;t[h]=l[e];end;l[i](c(t,1,a-i));o=i-1;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];end;elseif i<=337 then if i<=335 then local n=e[2];if n>o then o=n end;l[n]=h()[f[e[3]]];elseif i>336 then local o=e[2];l[o]=l[o]-l[o+2];n=n+e[3];else local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=338 then local n=e[2];if n>o then o=n end;l[n]={c({},1,e[3])};elseif i>339 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local o=e[2];local f=l[o+2];local d=l[o]+f;l[o]=d;if f>0 then if d<=l[o+1]then n=n+e[3];l[o+3]=d;end;elseif d>=l[o+1]then n=n+e[3];l[o+3]=d;end;end;elseif i<=351 then if i<=345 then if i<=342 then if i>341 then local n=e[2];local d={l[n]()};local f,d=d,#d;d=n+e[4]-2;local e=0;for n=n,d do e=e+1;l[n]=f[e];end;o=d;else do return end;end;elseif i<=343 then local f=Q[e[3]];local t;if f[5]~=0 then local e={};t=Z({},{__index=function(l,n)local e=e[n];return e[1][e[2]];end,__newindex=function(o,n,l)local e=e[n]e[1][e[2]]=l;end;});for o=1,f[5]do n=n+1;local n=d[n];if n[1]==204 then e[o-1]={l,n[3]};else e[o-1]={K,n[3]};end;r[#r+1]=e;end;end;local e=e[2];if e>o then o=e end;l[e]=A(f,t,Env);elseif i>344 then local n;local d=e[2];local f={};local n=0;local e=d+e[3]-1;for e=d+1,e do n=n+1;f[n]=l[e];end;local e={l[d](c(f,1,e-d))};local f,e=e,#e;e=e+d-1;n=0;for e=d,e do n=n+1;l[e]=f[n];end;o=e;else local f=Q[e[3]];local t;if f[5]~=0 then local e={};t=Z({},{__index=function(l,n)local e=e[n];return e[1][e[2]];end,__newindex=function(o,l,n)local e=e[l]e[1][e[2]]=n;end;});for o=1,f[5]do n=n+1;local n=d[n];if n[1]==204 then e[o-1]={l,n[3]};else e[o-1]={K,n[3]};end;r[#r+1]=e;end;end;local e=e[2];if e>o then o=e end;l[e]=A(f,t,Env);end;elseif i<=348 then if i<=346 then local n;local n=e[2];local f={};local d=0;local e=n+e[3]-1;for e=n+1,e do d=d+1;f[d]=l[e];end;l[n](c(f,1,e-n));o=n-1;elseif i>347 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local n;i=e[2];t={};local n=0;local d=i+e[3]-1;for e=i+1,d do n=n+1;t[n]=l[e];end;local d={l[i](c(t,1,d-i))};local f,d=d,#d;d=i+e[4]-2;n=0;for e=i,d do n=n+1;l[e]=f[n];end;o=d;else local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;end;elseif i<=349 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;elseif i>350 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local h=l[e[3]];l[i+1]=h;l[i]=h[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local f;i=e[2];t={};local f=0;local h=i+e[3]-1;for e=i+1,h do f=f+1;t[f]=l[e];end;local t={l[i](c(t,1,h-i))};local h,t=t,#t;t=i+e[4]-2;f=0;for e=i,t do f=f+1;l[e]=h[f];end;o=t;n=n+1;e=d[n];if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;else local n;local d=e[2];local f={};local n=0;local t=o;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=357 then if i<=354 then if i<=352 then h()[f[e[3]]]=l[e[2]];elseif i>353 then l[e[2]][f[e[3]]]=l[e[4]];else if l[e[2]]then n=n+1;else n=n+d[n+1][3]+1;end;end;elseif i<=355 then local n=e[2];local d=l[e[3]];l[n+1]=d;l[n]=d[f[e[4]]];if n+1>o then o=n+1 end;elseif i>356 then local n=e[2];if n>o then o=n end;l[n]=f[e[3]];else local n;local d=e[2];local t={};local n=0;local f=o;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=360 then if i<=358 then local n=e[2];if n>o then o=n end;l[n]=l[e[3]][f[e[4]]];elseif i>359 then local i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local r={l[i](c(t,1,s-i))};local A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][l[e[4]]];n=n+1;e=d[n];i=e[2];t={};a=0;s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=s+i-1;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;n=n+1;e=d[n];i=e[2];t={};a=0;s=o;for e=i+1,s do a=a+1;t[a]=l[e];end;r={l[i](c(t,1,s-i))};A,s=r,#r;s=i+e[4]-2;a=0;for e=i,s do a=a+1;l[e]=A[a];end;o=s;else local n;local d=e[2];local f={};local n=0;local t=d+e[3]-1;for e=d+1,t do n=n+1;f[n]=l[e];end;local f={l[d](c(f,1,t-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;elseif i<=361 then if(l[e[3]]==l[e[4]])then n=n+1;else n=n+d[n+1][3]+1;end;elseif i>362 then local i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];local a=l[e[3]];l[i+1]=a;l[i]=a[f[e[4]]];if i+1>o then o=i+1 end;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=f[e[3]];n=n+1;e=d[n];local a;i=e[2];t={};local a=0;local s=i+e[3]-1;for e=i+1,s do a=a+1;t[a]=l[e];end;local t={l[i](c(t,1,s-i))};local c,t=t,#t;t=i+e[4]-2;a=0;for e=i,t do a=a+1;l[e]=c[a];end;o=t;n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=h()[f[e[3]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];i=e[2];if i>o then o=i end;l[i]=l[e[3]][f[e[4]]];n=n+1;e=d[n];l[e[2]][f[e[3]]]=l[e[4]];else local n;local d=e[2];local t={};local n=0;local f=o;for e=d+1,f do n=n+1;t[n]=l[e];end;local f={l[d](c(t,1,f-d))};local t,f=f,#f;f=d+e[4]-2;n=0;for e=d,f do n=n+1;l[e]=t[n];end;o=f;end;n=n+1;end;end;end;return A(W(),{})();
end)
cor()
end)
end)
end)

delay(0, function()
    while wait() do
        if godblock == true then
local A_1 = "Block"
local A_2 = true
local Event = game:GetService("ReplicatedStorage").MainEvent
Event:FireServer(A_1, A_2)
        end
    end
end)


delay(0, function()
while wait() do
pcall(function()
if game.Players.LocalPlayer.Character:FindFirstChild("Christmas_Sock") then
 game.Players.LocalPlayer.Character["Christmas_Sock"]:Destroy()
end
end)
end
end)

delay(0, function()
game.Players.LocalPlayer.Character:Destroy()
respawn = false
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)

respawn = true
    wait(1)


char.BodyEffects.Defense:Destroy()
local bruh = char:FindFirstChildOfClass("Humanoid")
local cor = coroutine.wrap(function()
	while wait() do
		if respawn == true then
		bruh.JumpPower = demspeed
		end
	end
end)
cor()
print(bruh.Name)
bruh.HealthChanged:Connect(function()
	if SaveYourself == true then
if bruh.Health <= 10 or bruh.Health <= 20 or bruh.Health <= 30 then
if respawn == true then
respawn = false
heazd = false
Not("Danger situation, re-spawning", 145360599, "Danger Checker")
char:Destroy()
end
end
end
wait()
end)
end)

end)


delay(0, function()
pcall(function()
while wait() do
 local mouse = game.Players.LocalPlayer:GetMouse()
local Shit_1 = "UpdateMousePos"
local Shit_2 = Vector3.new(mouse.Hit.Position.X, mouse.Hit.Position.Y,mouse.Hit.Position.Z)
local Event = game:GetService("ReplicatedStorage").MainEvent
Event:FireServer(Shit_1, Shit_2)
end
end)
end)

delay(0, function()
pcall(function()
while wait() do
if autostomp == true then
local A_1 = "Stomp"
local Event = game:GetService("ReplicatedStorage").MainEvent
Event:FireServer(A_1)
end
end
end)
end)

local Imput = game:GetService("UserInputService")
local Plr = game.Players.LocalPlayer
local Mouse = Plr:GetMouse()

spam = false

function To(position)
local Chr = Plr.Character
local sound2 = Instance.new("Sound")
sound2.SoundId = "rbxassetid://3398620867"
sound2.Parent = game:GetService("SoundService")
if Chr ~= nil then
for index, part in pairs(game:GetDescendants()) do
if part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then --// Checks Part Properties
    part.CFrame = CFrame.new(position) --TP Part To Mouse
    sound2:Play()

    if spam == true and part:FindFirstChild("BodyGyro") == nil then 
    local bodyPos = Instance.new("BodyPosition")
    bodyPos.Position = part.Position
    bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyPos.P = 1e6
    bodyPos.Parent = part
    end
end
end
wait(.1)
end
end


function getfovxyz (p0, p1, deg)
local x1, y1, z1 = p0:ToOrientation()
local cf = CFrame.new(p0.p, p1.p)
local x2, y2, z2 = cf:ToOrientation()
local d = math.deg
if deg then
return Vector3.new(d(x1-x2), d(y1-y2), d(z1-z2))
else
return Vector3.new((x1-x2), (y1-y2), (z1-z2))
end
end
local ballisticsboost = 0

local movementcounting = true
aimbothider = false
aimbothiderspeed = .5
local abs = math.abs
Aim_Assist = false

function aimat(part)
if part then
--print(part)
local d = (cam.CFrame.p - part.CFrame.p).magnitude
local calculatedrop
local timetoaim = 0
local pos2 = Vector3.new()
if movementcounting == true then
timetoaim = d/bspeed
pos2 = part.Velocity * timetoaim
end
local minuseddrop = (ballisticsboost+50)/50
if ballisticsboost ~= 0 then
calculatedrop = d - (d/minuseddrop)

else
calculatedrop = 0
end
--print(calculatedrop)
local addative = Vector3.new()
if movementcounting then
addative = pos2
end
local cf = CFrame.new(cam.CFrame.p, (addative + part.CFrame.p+ Vector3.new(0, calculatedrop, 0)))
if aimbothider == true or Aim_Assist == true then
cam.CFrame = cam.CFrame:Lerp(cf, aimbothiderspeed)
else

cam.CFrame = cf
end
--print(cf)
end
end
function checkfov (part)
local fov = getfovxyz(game.Workspace.CurrentCamera.CFrame, part.CFrame)
local angle = math.abs(fov.X) + math.abs(fov.Y)
return angle
end
pcall(function()
delay(0, function()
while wait(.32) do
if Aim_Assist and not aimatpart and canaimat and lplr.Character and lplr.Character.Humanoid and lplr.Character.Humanoid.Health > 0 then
for i, plr in pairs(plrs:GetChildren()) do


local minangle = math.rad(5.5)
local lastpart = nil
local function gg(plr)
pcall(function()
if plr.Name ~= lplr.Name and plr.Character and plr.Character.Humanoid and plr.Character.Humanoid.Health > 0 and plr.Character.Head then
local raycasted = false
local cf1 = CFrame.new(cam.CFrame.p, plr.Character.Head.CFrame.p) * CFrame.new(0, 0, -4)
local r1 = Ray.new(cf1.p, cf1.LookVector * 9000)
local obj, pos = game.Workspace:FindPartOnRayWithIgnoreList(r1,  {lplr.Character.Head})
local dist = (plr.Character.Head.CFrame.p- pos).magnitude
if dist < 4 then
raycasted = true
end
if raycasted == true then
local an1 = getfovxyz(cam.CFrame, plr.Character.Head.CFrame)
local an = abs(an1.X) + abs(an1.Y)
if an < minangle then
minangle = an
lastpart = plr.Character.Head
end
end
end
end)
end
if TeamBased then
if plr.Team.Name ~= lplr.Team.Name then
gg(plr)
end
else
gg(plr)
end
--print(math.deg(minangle))

end
end
end
end)
end)
local oldheadpos
local lastaimapart





--warn("loaded")
delay(0, function()
while wait() do
pcall(function()
if game.Workspace.Ignored:FindFirstChild("Launcher") and nuking == true and workspace.Players:FindFirstChild(nukerowner) then
local lol = game.Workspace.Ignored:FindFirstChild("Launcher")

if lol:FindFirstChildOfClass("BodyVelocity") then
wait()
lol.BodyVelocity:Destroy()
end

if lol:FindFirstChild("BodyVelocity") == nil then
lol.CFrame = CFrame.new(workspace.Players[nukerowner].Head.CFrame.X,workspace.Players[nukerowner].Head.CFrame.Y+6.5,workspace.Players[nukerowner].Head.CFrame.Z)
end

elseif game.Workspace.Ignored:FindFirstChild("Handle") and nuking == true then
local lol = game.Workspace.Ignored:FindFirstChild("Handle")

if lol:FindFirstChild("Pin") then
lol.CFrame = CFrame.new(workspace.Players[nukerowner].Head.CFrame.X,workspace.Players[nukerowner].Head.CFrame.Y+8,workspace.Players[nukerowner].Head.CFrame.Z)
end
end
end)
end
end)
Imput.InputBegan:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 and Imput:IsKeyDown(Enum.KeyCode.M) then
       To(Mouse.Hit.p)
   end
end)
delay(0, function()
    while wait() do 
    for i,v in pairs(game.Players:GetPlayers()) do
        if v == game.Players.LocalPlayer == false then
            game.Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)*math.huge
            game.Players.LocalPlayer.SimulationRadius = math.pow(math.huge,math.huge)*math.huge
            v.MaximumSimulationRadius = 0
            v.SimulationRadius = 0
    end
end
end
end)







	

print("loaded")
