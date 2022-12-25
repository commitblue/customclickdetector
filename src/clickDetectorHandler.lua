--!strict
--handles the clickdetector loop
local players = game:GetService("Players")
local getMouseHit = require(script.Parent.getMouseHit)
local instanceEqual = require(script.Parent.instanceEqual)
local mouse = players.LocalPlayer:GetMouse()
local class = {
    clickDetectorClasses = {

    },
    lastObjectMouseEntered = nil,
    raycastParams = RaycastParams.new()
}
players.LocalPlayer.CharacterAdded:Connect(function(character)
    class.raycastParams.FilterDescendantsInstances = {character}
end)
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local function loopFunction()
    local mouseHit = getMouseHit(class.raycastParams)
    for _,v in class.clickDetectorClasses do
        if mouseHit ~= nil then
            if instanceEqual(mouseHit.Instance, v.instance) and not instanceEqual(mouseHit.Instance, class.lastObjectMouseEntered) then
                if (mouseHit.Instance.Position - players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < v.maxDistance then
                    class.lastObjectMouseEntered = v.instance
                    mouse.Icon = v.hoverIcon
                    v.mouseEnter:Fire(mouseHit) 
                end
            elseif class.lastObjectMouseEntered then
                if not instanceEqual(mouseHit.Instance, class.lastObjectMouseEntered) then
                    class.lastObjectMouseEntered = nil
                    mouse.Icon = v.unhoverIcon
                    v.mouseLeave:Fire(mouseHit) 
                end
            end 
        end
    end
end
local function beganWrapprer(f)
    local mouseHit = getMouseHit(class.raycastParams)
    if mouseHit.Instance ~= nil then
        if mouseHit.Instance:IsA("BasePart") then
            local fetched = class.clickDetectorClasses[mouseHit.Instance] 
            if fetched then
                if (mouseHit.Instance.Position - players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < fetched.maxDistance then
                    f(mouseHit, fetched)
                end
            end
        end
    end
end
local function inputBegan(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        beganWrapprer(function(mouseHit, fetched)
            fetched.mouseDown:Fire(mouseHit)
        end)
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        beganWrapprer(function(mouseHit, fetched)
            fetched.rightMouseDown:Fire(mouseHit)
        end)
    end
end
local function endedWrapper(f)
    local mouseHit = getMouseHit(class.raycastParams)
    if mouseHit.Instance ~= nil then
        if mouseHit.Instance:IsA("BasePart") then
            local fetched = class.clickDetectorClasses[mouseHit.Instance] 
            if fetched then
                if (mouseHit.Instance.Position - players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < fetched.maxDistance then
                    f(mouseHit, fetched)
                end
            end
        end
    end
end
local function inputEnded(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        endedWrapper(function(mouseHit, fetched)
            fetched.mouseUp:Fire(mouseHit)
        end)
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        endedWrapper(function(mouseHit, fetched)
            fetched.rightMouseUp:Fire(mouseHit)
        end)
    end
end
function class.addClassToLoopTask(classToAdd)
    class.clickDetectorClasses[classToAdd.instance] = classToAdd
end
function class.removeClassFromLoopTask(inst)
    class.clickDetectorClasses[inst]:_cleanup()
    class.clickDetectorClasses[inst] = nil
end
function class.startLoop()
    class._heartbeat = runService.Heartbeat:Connect(loopFunction)
    class._inputBegan = userInputService.InputBegan:Connect(inputBegan)
    class._inputEnded = userInputService.InputEnded:Connect(inputEnded)
end
function class.stopLoop()
    class._heartbeat:Disconnect()
    class._inputBegan:Disconnect()
    class._inputEnded:Disconnect()
end
function class.cleanup()
    local function cleanConnections(...)
        for _, connection in {...} do
            if connection then
                connection:Disconnect()
            end
        end
    end
    cleanConnections(class._heartbeat, class._inputBegan, class._inputEnded)
    for _,v in class.clickDetectorClasses do
        v:_cleanup()
    end
    class = nil
end
return class