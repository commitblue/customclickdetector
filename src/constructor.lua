--!strict
local clickDetectorClass = require(script.Parent.clickDetectorClass)
local clickDetectorHandler = require(script.Parent.clickDetectorHandler)
type initialPropsType = {
    instance: BasePart,
    maxDistance: number | nil,
    hoverIcon: string | nil,
    unhoverIcon: string | nil
}
return {
    new = function(initialProps: initialPropsType)
        local class = {
            instance = initialProps.instance,
            maxDistance = initialProps.maxDistance or 32,
            hoverIcon = initialProps.hoverIcon or "",
            unhoverIcon = initialProps.unhoverIcon or ""
        }
        function class:destroy()
            clickDetectorHandler.removeClassFromLoopTask(class.instance)
        end
        setmetatable(class, clickDetectorClass)
        clickDetectorHandler.addClassToLoopTask(setmetatable({}, {
            __index = function(self, index)
                if class[index] then
                    return class[index] 
                end
            end
        }))
        return class
    end,
    startLoop = clickDetectorHandler.startLoop,
    stopLoop = clickDetectorHandler.stopLoop,
    cleanup = clickDetectorHandler.cleanup
}