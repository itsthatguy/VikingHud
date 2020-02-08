
local addonName, addon = ...
local Events = addon.Frame(); addon.Events = Events

function Events:OnLoad()
  addon:Print("Events:OnLoad")
  self:RegisterEvents()
  return self
end

-- local function HandleEvents(self, event, unit)
--   addon:Print("[HandleEvents] event:", event, "  unit:", unit)

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
  addon:UpdateTargetText()
  addon.targetUnitFrame:UpdateModel()
end

function Events:UNIT_TARGET(unit, ...)
  addon.targetTargetUnitFrame:Redraw()

  addon:UpdateTargetText()
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
  if (unit == "player") then
    addon.playerUnitFrame:Update()
  else
    addon.targetUnitFrame:Update()
  end
end

function Events:UNIT_POWER_UPDATE(unit, ...)
  addon.playerUnitFrame:Update()
  addon.targetUnitFrame:Update()
end

function Events:RAID_TARGET_UPDATE(...)
  addon:UpdateTargetText()
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
  addon:Print("Events:RegisterEvents")

  -- Global
  self:RegisterEvent('PLAYER_ENTERING_WORLD')
  self:RegisterEvent("PLAYER_TARGET_CHANGED")
  self:RegisterUnitEvent("UNIT_TARGET", "target")

  -- Health/Power
  self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "player", "target")
  self:RegisterUnitEvent("UNIT_DISPLAYPOWER", "target", "targettarget")
  self:RegisterUnitEvent("UNIT_HEALTH", "player", "target")
  self:RegisterUnitEvent("UNIT_POWER_UPDATE", "player", "target", "targettarget")
  self:RegisterEvent("RAID_TARGET_UPDATE")

  -- Casting
  self:RegisterUnitEvent("UNIT_SPELLCAST_START", "player", "target")
  self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player", "target")
  self:RegisterUnitEvent("UNIT_SPELLCAST_DELAYED", "player", "target")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "player", "target")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player", "target")
  self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player", "target")


  self:SetScript("OnEvent", function(this, event, ...)
    -- addon:Print(this, event, ...)
    Events[event](this, ...)
  end)
end