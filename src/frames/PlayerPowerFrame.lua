local LSM = LibStub("LibSharedMedia-3.0")
local Taka = LibStub("Taka-0.0")

local addonName, addon = ...

local PlayerPowerFrame = Taka:NewClass("Frame", "VH_PowerFrame")
addon.PlayerPowerFrame = PlayerPowerFrame

local MANA = 0
local RAGE = 1
local ENERGY = 3

function PlayerPowerFrame:New(parent, side, unitID, powerType)
  local frame = PlayerPowerFrame:Super(PlayerPowerFrame):New(parent)
  frame:SetSize(addon.Settings.db.profile.width, addon.Settings.db.profile.height)

  frame.unitID = unitID
  frame.powerType = powerType

  frame.statusBar = addon.StatusBar:New(frame)

  local color

  if powerType == MANA then
    color = addon.Colors:NewRGBA(addon.Colors.BLUE, 1.0)
  elseif powerType == RAGE then
    color = addon.Colors:NewRGBA(addon.Colors.ORANGE, 1.0)
  elseif powerType == ENERGY then
    color = addon.Colors:NewRGBA(addon.Colors.YELLOW, 1.0)
  end

  frame.statusBar:SetBarColor(color:ToList())
  frame.statusBar:SetBackdropColor(addon.Colors:NewRGBA(addon.Colors.BG, 0.8):ToList())
  frame:Hide()

  return frame
end

function PlayerPowerFrame:UpdateFont()
  self.statusBar:UpdateFont()
end

function PlayerPowerFrame:Update()
  self.statusBar:SetValues(
    0,
    UnitPowerMax(self.unitID, self.powerType),
    UnitPower(self.unitID, self.powerType)
  )
  return self
end

function PlayerPowerFrame:Unregister()
  self.statusBar:Unregister()
end

function PlayerPowerFrame:Register()
  self.statusBar:Register()
end
