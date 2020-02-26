local VSL = LibStub("VikingSharedLib")

local addonName, addon = ...
local Events = addon.Frame(); addon.Events = Events

function Events:OnLoad()
  VSL:Print("Events:OnLoad")
  self:RegisterEvents()
  return self
end

-- local function HandleEvents(self, event, unit)
--   VSL:Print("[HandleEvents] event:", event, "  unit:", unit)

--   if (event == "PLAYER_ENTERING_WORLD") then

--   elseif (event == "PLAYER_TARGET_CHANGED") then

--   elseif (event == "UPDATE_SHAPESHIFT_FORM") then
--   elseif (event == "UNIT_HEALTH") then

--   elseif (event == "UNIT_POWER_UPDATE") then

--   elseif (event == "UNIT_SPELLCAST_START") then
--   elseif (event == "UNIT_SPELLCAST_STOP") then
--   elseif (event == "UNIT_SPELLCAST_DELAYED") then
--   elseif (event == "UNIT_SPELLCAST_CHANNEL_START") then
--   elseif (event == "UNIT_SPELLCAST_CHANNEL_STOP") then
--   elseif (event == "UNIT_SPELLCAST_CHANNEL_UPDATE") then
--   end
-- end

local function UpdateForUnit(unit, ...)
  if (unit == "player") then
    addon.playerUnitFrame:Update()
  elseif (unit == "target") then
    addon.targetUnitFrame:Update()
  elseif (unit == "targettarget") then
    addon.targetTargetUnitFrame:Update()
  end
end

function Events:PLAYER_ENTERING_WORLD(unit, ...)
  addon.playerUnitFrame:UpdateVisibility()
  addon.playerUnitFrame:UpdateSize()
  addon.playerUnitFrame:Update()

  addon.targetTargetUnitFrame:Redraw()
  addon.targetUnitFrame:UpdateVisibility()
  addon.targetUnitFrame:UpdateSize()
  addon.targetUnitFrame:Update()
end

function Events:PLAYER_TARGET_CHANGED(unit, ...)
  addon.targetTargetUnitFrame:Redraw()

  addon.targetUnitFrame:UpdateVisibility()
  addon.targetUnitFrame:UpdateSize()
  addon.targetUnitFrame:Update()
  addon:UpdateTargetText("target")
  addon:UpdateTargetText("targettarget")
  addon.targetUnitFrame:UpdateModel()

end

function Events:UNIT_TARGET(unit, ...)
  addon.targetTargetUnitFrame:Redraw()

  addon:UpdateTargetText("target")
  addon:UpdateTargetText("targettarget")
end

function Events:UPDATE_SHAPESHIFT_FORM(...)
  addon.playerUnitFrame:UpdateVisibility()
  -- addon.targetUnitFrame:RefreshModel()
end

function Events:UNIT_DISPLAYPOWER(...)
  addon.targetTargetUnitFrame:Redraw()
  addon.targetUnitFrame:UpdateVisibility()
  -- addon.targetUnitFrame:RefreshModel()
end

function Events:UNIT_HEALTH(unit, ...)
  UpdateForUnit(unit)
end

function Events:UNIT_STATS(unit, ...)
  UpdateForUnit(unit)
end

function Events:UNIT_POWER_UPDATE(_, ...)
  UpdateForUnit("player")
  UpdateForUnit("target")
  UpdateForUnit("targettarget")
end

function Events:RAID_TARGET_UPDATE(...)
  addon:UpdateTargetText("target")
  addon:UpdateTargetText("targettarget")
end

function Events:UNIT_SPELLCAST_START(unit, ...)
end

function Events:UNIT_SPELLCAST_STOP(unit, ...)
end

function Events:UNIT_SPELLCAST_DELAYED(unit, ...)
end

function Events:UNIT_SPELLCAST_CHANNEL_START(unit, ...)
end

function Events:UNIT_SPELLCAST_CHANNEL_STOP(unit, ...)
end

function Events:UNIT_SPELLCAST_CHANNEL_UPDATE(unit, ...)
end


function Events:RegisterEvents()
  VSL:Print("Events:RegisterEvents")

  -- Global
  self:RegisterEvent('PLAYER_ENTERING_WORLD')
  self:RegisterEvent("PLAYER_TARGET_CHANGED")
  self:RegisterUnitEvent("UNIT_TARGET", "target")

  -- Health/Power
  self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "player")
  self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "target")
  self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "targettarget")
  self:RegisterUnitEvent("UNIT_STATS", "player")
  self:RegisterUnitEvent("UNIT_STATS", "target")
  self:RegisterUnitEvent("UNIT_STATS", "targettarget")
  self:RegisterUnitEvent("UNIT_DISPLAYPOWER", "player")
  self:RegisterUnitEvent("UNIT_DISPLAYPOWER", "target")
  self:RegisterUnitEvent("UNIT_DISPLAYPOWER", "targettarget")
  self:RegisterUnitEvent("UNIT_HEALTH", "player")
  self:RegisterUnitEvent("UNIT_HEALTH", "target")
  self:RegisterUnitEvent("UNIT_HEALTH", "targettarget")
  self:RegisterUnitEvent("UNIT_POWER_UPDATE", nil, "player")
  self:RegisterEvent("RAID_TARGET_UPDATE")

  -- Casting
  self:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
  self:RegisterUnitEvent("UNIT_SPELLCAST_START", "target")
  self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
  self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "target")
  self:RegisterUnitEvent("UNIT_SPELLCAST_DELAYED", "player")
  self:RegisterUnitEvent("UNIT_SPELLCAST_DELAYED", "target")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "target")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "target")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "target")


  self:SetScript("OnEvent", function(this, event, ...)
    -- VSL:Print(this, event, ...)
    Events[event](this, ...)
  end)
end