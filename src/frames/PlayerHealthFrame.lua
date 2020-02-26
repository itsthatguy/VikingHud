local Taka = LibStub("Taka-0.0")
local VSL = LibStub("VikingSharedLib")

local addonName, addon = ...

local PlayerHealthFrame = Taka:NewClass("Frame", "VH_HealthFrame")
addon.PlayerHealthFrame = PlayerHealthFrame

function PlayerHealthFrame:New(parent, side, unitID)
  local frame = PlayerHealthFrame:Super(PlayerHealthFrame):New(parent)
  frame:SetSize(addon.Settings.db.profile.width, addon.Settings.db.profile.height)

  frame.unitID = unitID
  frame.statusBar = addon.StatusBar:New(frame, side)

  frame.statusBar:SetBackdropColor(VSL.Colors:NewRGBA(VSL.Colors.BG, 0.8):ToList())
  frame.statusBar:SetBarColor(VSL.Colors:NewRGBA(VSL.Colors.RED, 1.0):ToList())
  return frame
end

function PlayerHealthFrame:UpdateFont()
  self.statusBar:UpdateFont()
end

function PlayerHealthFrame:Update()
  self.statusBar:SetValues(
    0,
    UnitHealthMax(self.unitID),
    UnitHealth(self.unitID)
  )

  return self
end

function PlayerHealthFrame:Unregister()
  self.statusBar:Unregister()
end

function PlayerHealthFrame:Register()
  self.statusBar:Register()
end