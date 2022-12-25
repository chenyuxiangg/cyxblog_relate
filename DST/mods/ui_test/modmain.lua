local fn = require "examples/template_votecontrol"
local ZDEBUG = require("debug/debug")
local _g = GLOBAL

local Widget = require("widgets/widget")

local function DealByKeyK(key, down)
    if not down then
        return
    end
    if _g.TheInput:IsKeyDown(_g.KEY_K) then
        local curscreen = TheFrontEnd:GetActiveScreen()
        ZDEBUG:zprint(urscreen.name)
        if curscreen.name == "screenroot" and curscreen.votewindow ~= nil then
            ZDEBUG:zprint("clear votewindow focus.")
            curscreen.votewindow:ClearFocus()
        end
    end
end

local function DealByMouseButton(button, down, x, y)
    -- sim_x,sim_y = TheSim:GetPosition()
    -- screen_pos = _g.TheInput:GetScreenPosition()
    -- world_pos = _g.TheInput:GetWorldPosition()
    -- target = _g.TheInput:GetWorldEntityUnderMouse()
    target = TheSim:GetEntitiesAtScreenPoint(TheSim:GetPosition())
    if target and target.value then
        ZDEBUG:zprint("cyx: ")
        ZDEBUG:zprint(target.value)
    end
end

local function Simfn()
    _g.TheInput:AddKeyHandler(DealByKeyK)
    _g.TheInput:AddMouseButtonHandler(DealByMouseButton)
end

AddSimPostInit(Simfn)
AddClassPostConstruct("screens/playerhud", fn)