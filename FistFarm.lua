local sowd = getrawmetatable(game)
local sucks = sowd.__namecall
local player = game.Players.LocalPlayer
setreadonly(sowd, false)
sowd.__namecall = newcclosure(function(name, ...)
local tabs = {...}
if getnamecallmethod() == "FireServer"  and tostring(name) == "MainEvent" then
if tabs[1] == "CHECKER_1" or tabs[1] == "TeleportDetect" or tabs[1] == "OneMoreTime" then
return wait(9e9)
end
end
return sucks(name, unpack(tabs))
end)
setreadonly(sowd, true)
print("wait")
