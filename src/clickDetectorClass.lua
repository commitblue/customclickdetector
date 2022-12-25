--!strict
local fastSignal = require(script.Parent.Packages.fastSignal)
local class = {}
class.__index = class
function class:_returnSelf()
    return self
end
function class:_cleanup()
    local function signalWrapper(...)
        for _,signal in {...} do
            signal:DisconnectAll()
            signal:Destroy() 
        end
    end
    signalWrapper(
        class.mouseDown, 
        class.rightMouseDown, 
        class.mouseUp,
        class.rightMouseUp,
        class.mouseEnter,
        class.mouseLeave
    )
end
function class:changeInstance(instance)
    self.instance = instance
end
class.mouseDown = fastSignal.new()
class.rightMouseDown = fastSignal.new()
class.mouseUp = fastSignal.new()
class.rightMouseUp = fastSignal.new()
class.mouseEnter = fastSignal.new()
class.mouseLeave = fastSignal.new()
return class