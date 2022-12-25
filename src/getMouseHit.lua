--!strict
--[[
   getMouseHit.lua
   Made in : 2022-12-23 20:07:55
]]
local userInputService = game:GetService("UserInputService")
local currentCamera = workspace.CurrentCamera
return function(ignoreList : RaycastParams)
    local mousePosition = userInputService:GetMouseLocation()
    local viewportPoint = currentCamera:ViewportPointToRay(mousePosition.X, mousePosition.Y)
    local cast = workspace:Raycast(viewportPoint.Origin, viewportPoint.Direction * 1000, ignoreList)
    return cast
end