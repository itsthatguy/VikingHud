local addonName, addon = ...

local LSM = LibStub("LibSharedMedia-3.0")
local Console = LibStub("AceConsole-3.0")
local L = LibStub('AceLocale-3.0'):GetLocale(addonName)
local Settings = {}; addon.Settings = Settings

function Settings:GetDatabaseDefaults()
  return {
    profile = {
      positionX = 0,
      positionY = 275,
      spacing = 260,
      spacingY = 4,
      width = 240,
      height = 2,
      font = LSM:Fetch("font", "Montserrat SemiBold"),
      fontSize = 18,

      target = {
        nameY = 54,
      },

      showPortrait = true,
      camera = {
        x = 4.65,
        y = 0,
        z = 0,
        distance = 8.94,
      },

      model = {
        x = 0,
        y = 0,
        z = 1,
        scale = 1,
        rotation = 0.4,
        pitch = 0,
        animation = 26
      }
    }
  }
end

function Settings:OnLoad()
  self.db = LibStub("AceDB-3.0"):New("VikingHudDB", self:GetDatabaseDefaults(), true)
  self.db.RegisterCallback(self, "OnProfileChanged", "RefreshSettings")
  self.db.RegisterCallback(self, "OnProfileCopied", "RefreshSettings")
  self.db.RegisterCallback(self, "OnProfileReset", "RefreshSettings")
end

function Settings:RefreshSettings()
  local model = addon.targetUnitFrame.portrait
  model:SetAnimation(addon.Settings.db.profile.model.animation)
  model:SetPitch(addon.Settings.db.profile.model.pitch)
  model:SetFacing(addon.Settings.db.profile.model.rotation)
  model:SetPortraitZoom(addon.Settings.db.profile.model.scale)
  model:SetPosition(addon.Settings.db.profile.model.x, addon.Settings.db.profile.model.y, addon.Settings.db.profile.model.z)
  -- model:SetCameraDistance(addon.Settings.db.profile.camera.distance)
  model:SetCameraPosition(addon.Settings.db.profile.camera.x, addon.Settings.db.profile.camera.y, addon.Settings.db.profile.camera.z)
  addon:UpdateFont()
  addon:UpdateSize()
  addon:UpdatePosition()
  addon.targetUnitFrame:TogglePortrait()
end
