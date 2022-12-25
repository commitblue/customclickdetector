--!strict
--[[
   init.lua
   Made in : 2022-12-23 20:03:16
]]
local constructor = require(script.constructor)
local runService = game:GetService("RunService")
assert(not runService:IsServer(), "Only clients can require this module")
return {
    new = constructor.new,
    startLoop = constructor.startLoop,
    stopLoop = constructor.stopLoop,
    cleanup = constructor.cleanup
}