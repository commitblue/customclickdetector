---
sidebar_position: 2
---

## Creating the class

Before we start, here are some notes:
1. this module was intended for localscripts only (or anywhere on the client)
2. this is not the same as roblox's clickdetectors

In customclickdetector, we use classes to create those
clickdetectors instead of the clickdetector instance
This is how we do it:
```lua
local customClickDetector = require(path.to.customclickdetector)
local myClickDetector = customClickDetector.new({
    instance = workspace.Part -- "workspace.Part" can be any object inside workspace
}) -- creates a new clickdetector class
```
This does almost nothing yet. Atleast visually, so
lets make it that whenever you click the part it should print
"Hello world"
```lua
local myClickDetector = customClickDetector.new({
    instance = workspace.Part
})
myClickDetector.mouseDown:Connect(function()
   print("Hello world")
end) -- event which when mouse is clicked, the function fires
customClickDetector.startLoop() -- starts the loop which handles the click detectors
```
You must include `customClickDetector.startLoop()` because that
starts the loop of which basically handles all of the click detectors you
made via this module.

## Events

Normally, you would want more than just a `mouseDown` event, yes,
this module has more events than just that (unlike roblox's click detector
which only has two)

There are many events related to mouse, but each are self explainatory
```lua
local myClickDetector = customClickDetector.new({
    instance = workspace.Part
})
myClickDetector.mouseDown:Connect(function()
   print("Mouse is holding (you can use this as a clicked event too)")
end) -- event which fires when mouse's left button is holding down or is clicked
myClickDetector.mouseUp:Connect(function()
   print("Mouse released")
end) -- event which fires when mouse's left button releases
myClickDetector.rightMouseDown:Connect(function()
   print("Right mouse button is holding (or clicked)")
end) -- event which fires when mouse's right button is holding down (or is clicked)
myClickDetector.rightMouseUp:Connect(function()
   print("Right mouse button is released")
end) -- event which fires when the right mouse button is released
myClickDetector.mouseEnter:Connect(function()
   print("Mouse hovered on object")
end) -- event which fires when mouse is hovering on the object
myClickDetector.mouseLeave:Connect(function()
   print("Mouse left the object")
end) -- event which fires when mouse stopped hovering on the object
customClickDetector.startLoop() -- starts the loop which handles the click detectors
```
Fun fact: Unlike roblox's clickdetectors, these mouse related events dont pass the
player object (it dosent need to! you just need `game.Players.LocalPlayer`) but it
instead passes the ray calculated from the mouse. Check it out
```lua
local myClickDetector = customClickDetector.new({
    instance = workspace.Part
})
myClickDetector.mouseDown:Connect(function(rayCalculated)
   print(rayCalculated) -- the ray calculated
end)
customClickDetector.startLoop()
```
## Stopping classes and the custom clickdetector loop

This one is pretty easy. but you might want to do it sometimes,
if you are ever in need to stop the loop or a specific class,
do this
```lua
local myClickDetector = customClickDetector.new({
    instance = workspace.Part
})
local myOtherClickDetector = customClickDetector.new({
    instance = workspace.Part2
})
myClickDetector.mouseDown:Connect(function()
   print("Hello world")
end)
customClickDetector.startLoop()
task.wait(15)
print("Stopping the loop")
customClickDetector.stopLoop()
```