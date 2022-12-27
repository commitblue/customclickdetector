--!strict
local fastSignal = require(script.Parent.Packages.fastSignal)
--[=[
    @class clickDetectorClass

    This class is created by module.new.
    Class that contains hovericon, events.
]=]
local clickDetectorClass = {}
clickDetectorClass.__index = clickDetectorClass
function clickDetectorClass:_returnSelf()
    return self
end
function clickDetectorClass:_cleanup()
    local function signalWrapper(...)
        for _,signal in {...} do
            signal:DisconnectAll()
            signal:Destroy() 
        end
    end
    signalWrapper(
        clickDetectorClass.mouseDown, 
        clickDetectorClass.rightMouseDown, 
        clickDetectorClass.mouseUp,
        clickDetectorClass.rightMouseUp,
        clickDetectorClass.mouseEnter,
        clickDetectorClass.mouseLeave
    )
end
--[=[
    @within clickDetectorClass
    Whenever you parent an object to another one, this function is handy.
    
    @param instance Instance
]=]
function clickDetectorClass:changeInstance(instance)
    self.instance = instance
end
clickDetectorClass.mouseDown = fastSignal.new()
clickDetectorClass.rightMouseDown = fastSignal.new()
clickDetectorClass.mouseUp = fastSignal.new()
clickDetectorClass.rightMouseUp = fastSignal.new()
clickDetectorClass.mouseEnter = fastSignal.new()
clickDetectorClass.mouseLeave = fastSignal.new()
return clickDetectorClass