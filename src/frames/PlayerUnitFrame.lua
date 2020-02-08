local LSM = LibStub("LibSharedMedia-3.0")
local Taka = LibStub("Taka-0.0")

local addonName, addon = ...
local PlayerUnitFrame = Taka:NewClass("Button", "VH_UnitFrame", "SecureActionButtonTemplate")
addon.PlayerUnitFrame = PlayerUnitFrame

function PlayerUnitFrame:New(parent, side, unitID)
  local frame = PlayerUnitFrame:Super(PlayerUnitFrame):New(parent)
  frame.unitID = unitID
  frame:EnableMouse(true)
  frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  frame:SetAttribute("type1", "target")
  frame:SetAttribute("type2", "togglemenu")
  frame:SetAttribute("unit", unitID)

  local dirMod = side == "LEFT" and -1 or 1
  local dirPoint = side == "LEFT" and "RIGHT" or "LEFT"
  local dirPointRelative = side == "LEFT" and "LEFT" or "RIGHT"
  frame.dirMod = dirMod
  frame.dirPoint = dirPoint
  frame.dirPointRelative = dirPointRelative

  local frameHeight = addon.Settings.db.profile.height + addon.Settings.db.profile.fontSize + 4

  frame:SetSize(
    (addon.Settings.db.profile.width * 2) + addon.Settings.db.profile.spacing,
    frameHeight
  )
  frame:SetPoint("TOP", parent, "TOP", 0, unitID == "target" and frameHeight + addon.Settings.db.profile.spacingY or 0)

  frame.container = addon.Frame:Super(addon.Frame):New(frame)
  frame.container:SetAllPoints(frame)

  frame.health = addon.PlayerHealthFrame:New(frame.container, "LEFT", frame.unitID)
  frame.health:SetPoint("TOP" .. dirPointRelative, frame.container, "TOP" .. dirPointRelative, 0, 0)

  frame.mana = addon.PlayerPowerFrame:New(frame.container, "RIGHT", frame.unitID, 0)
  frame.mana:SetPoint("TOP" .. dirPoint, frame.container, "TOP" .. dirPoint, 0, 0)

  frame.energy = addon.PlayerPowerFrame:New(frame.container, "RIGHT", frame.unitID, 3)
  frame.energy:SetPoint("TOP" .. dirPoint, frame.container, "TOP" .. dirPoint, 0, 0)

  frame.rage = addon.PlayerPowerFrame:New(frame.container, "RIGHT", frame.unitID, 1)
  frame.rage:SetPoint("TOP" .. dirPoint, frame.container, "TOP" .. dirPoint, 0, 0)

    --@debug@
    -- frame:SetBackdrop({
    --   bgFile = LSM:Fetch("background", "Solid"),
    --   insets = { left = -1, right = -1, top = -1, bottom = -1}
    -- })
    -- frame:SetBackdropColor(addon.Colors:NewRGBA(addon.Colors[unitID == "target" and "CYAN" or "YELLOW"], 0.8):ToList())
    --@debug end@

  if (unitID == "target") then
    frame.portrait = CreateFrame("PlayerModel", nil, frame.health)
    frame.portrait:SetPoint("BOTTOMLEFT", frame.health, "TOPLEFT", -40, 0)
    frame.portrait:SetFrameStrata("BACKGROUND")
    frame.portrait:SetSize(addon.Settings.db.profile.width, addon.Settings.db.profile.width * 0.56)

    frame.portrait:SetScript("OnModelLoaded", function(model)
      model:SetPortraitZoom(1)
      model:MakeCurrentCameraCustom()
      model:SetCustomCamera(1)
      model:SetModelScale(1)
      model:SetPosition(addon.Settings.db.profile.model.x, addon.Settings.db.profile.model.y, addon.Settings.db.profile.model.z)
      model:SetCameraPosition(addon.Settings.db.profile.camera.x, addon.Settings.db.profile.camera.y, addon.Settings.db.profile.camera.z)
      model:SetFacing(addon.Settings.db.profile.model.rotation)
      local model = _G["VH_UnitFrame2"].portrait
      model:UseModelCenterToTransform(true)
      model:SetModelScale(1.5)
      model:SetViewTranslation(0,-50)
      model:SetCameraTarget(0,0,0.5)
      model:SetAnimation(addon.Settings.db.profile.model.animation)

    end)

    frame.targetText = frame.container:CreateFontString(nil, "OVERLAY")
    frame.targetText:SetJustifyH("CENTER")
    frame.targetText:SetFont(addon.Settings.db.profile.font, addon.Settings.db.profile.fontSize * 1.25)
    frame.targetText:SetPoint("BOTTOM", frame.container, "TOP", 0, addon.Settings.db.profile.target.nameY)
    frame.targetText:SetText("")
    frame:TogglePortrait()
  end

  frame:EnableMouse(true)
  frame:SetDontSavePosition(true)
  frame:UpdateVisibility()
  frame:Update()

  return frame
end

local MANA = 0
local RAGE = 1
local ENERGY = 3

local POWER_TYPES = {
  [0] = "MANA",
  [1] = "RAGE",
  [3] = "ENERGY"
}

function PlayerUnitFrame:TogglePortrait()
  if (addon.Settings.db.profile.showPortrait) then
    self.portrait:Show()
  else
    self.portrait:Hide()
  end
end

function PlayerUnitFrame:RefreshModel()
  if self.portrait then
    self.portrait:SetUnit(self.unitID)
  end
end

function PlayerUnitFrame:UpdateModel()
  if self.portrait then
    self.portrait:SetPosition(0, 0, 0)
    self.portrait:SetModelScale(1)
    self.portrait:SetUnit(self.unitID)
  end
end

function PlayerUnitFrame:SetTargetText(txt)
  if self.unitID == "target" then
    self.targetText:SetText(txt)
  end
end

function PlayerUnitFrame:Unregister()
  self.health:Unregister()
  self.mana:Unregister()
  self.energy:Unregister()
  self.rage:Unregister()
  return self.container:Hide()
end

function PlayerUnitFrame:Register()
  self.health:Register()
  self.mana:Register()
  self.energy:Register()
  self.rage:Register()
  return self.container:Show()
end

function PlayerUnitFrame:UpdateVisibility()
  if UnitExists(self.unitID) then
    self:Register()
    if self.portrait then
      self:UpdateModel()
    end
  else
    -- if self.unitID == "target" then
    --   self.targetText:Hide()
    --   self.portrait:Hide()
    -- end
    self:Unregister()
  end

  local powerType = UnitPowerType(self.unitID)
  if UnitClass(self.unitID) == "Druid" then
    if powerType == MANA then
      self.mana:SetPoint("TOP" .. self.dirPoint, self.container, "TOP" .. self.dirPoint, 0, 0)
      self.mana:SetWidth(addon.Settings.db.profile.width)
      self.mana:Show()
      self.rage:Hide()
      self.energy:Hide()

    elseif powerType == RAGE then
      local halfWidth = (addon.Settings.db.profile.width / 2) - 5
      self.mana:SetWidth(halfWidth)
      self.rage:SetWidth(halfWidth)

      self.rage:Show()
      self.mana:SetPoint(
        "TOP" .. self.dirPoint, self.container, "TOP" .. self.dirPoint,
        (10 + halfWidth) * self.dirMod,
        0
      )
      self.mana:Show()
      self.energy:Hide()

    elseif powerType == ENERGY then
      local halfWidth = (addon.Settings.db.profile.width / 2) - 5
      self.mana:SetWidth(halfWidth)
      self.energy:SetWidth(halfWidth)

      self.energy:Show()
      self.mana:SetPoint("TOP" .. self.dirPoint, self.container, "TOP" .. self.dirPoint,
        (10 + halfWidth) * self.dirMod,
        0
      )
      self.mana:Show()
      self.rage:Hide()
    end
  else
    if powerType == MANA then
      self.mana:Show()
      self.rage:Hide()
      self.energy:Hide()

    elseif powerType == RAGE and UnitPowerMax(self.unitID, 1) > 0 then
      self.mana:Hide()
      self.energy:Hide()
      self.rage:Show()
      self.mana:SetPoint("TOP" .. self.dirPoint, self.container, "TOP" .. self.dirPoint, 0, 0)

    elseif powerType == ENERGY then
      self.mana:Hide()
      self.rage:Hide()
      self.energy:Show()
      self.mana:SetPoint("TOP" .. self.dirPoint, self.container, "TOP" .. self.dirPoint, 0, 0)

    else
      self.mana:Hide()
      self.rage:Hide()
      self.energy:Hide()
    end
  end
end

function PlayerUnitFrame:Update()
  self.health:Update()
  self.mana:Update()
  self.energy:Update()
  self.rage:Update()

  if( not self:GetAttribute("isHeaderDriven") ) then
		ClickCastFrames = ClickCastFrames or {}
		ClickCastFrames[self] = true
	end
end


function PlayerUnitFrame:UpdateSize()
  local width, height = addon.Settings.db.profile.width, addon.Settings.db.profile.height
  local powerWidth = width
  local offset = 0

  local powerType = UnitPowerType(self.unitID)
  if UnitClass(self.unitID) == "Druid" and (powerType == RAGE or powerType == ENERGY) then
    powerWidth = (width / 2) - 5
    offset = (10 + powerWidth) * self.dirMod
  end

  self.health:SetSize(width, height)
  self.mana:SetSize(powerWidth, height)
  self.energy:SetSize(powerWidth, height)
  self.rage:SetSize(powerWidth, height)

  local frameHeight = addon.Settings.db.profile.height + addon.Settings.db.profile.fontSize + 4
  self:SetSize(
    (addon.Settings.db.profile.width * 2) + addon.Settings.db.profile.spacing,
    frameHeight
  )
  self:SetPoint("TOP", self:GetParent(), "TOP", 0, self.unitID == "target" and frameHeight + addon.Settings.db.profile.spacingY or 0)
  if (self.unitID == "target") then
    self.targetText:SetPoint("BOTTOM", self.container, "TOP", 0, addon.Settings.db.profile.target.nameY)
  end

  self.mana:SetPoint("TOP" .. self.dirPoint, self.container, "TOP" .. self.dirPoint, offset, 0)
end


function PlayerUnitFrame:UpdateFont()
  if (self.targetText) then
    self.targetText:SetFont(addon.Settings.db.profile.font, addon.Settings.db.profile.fontSize)
  end
  self.health:UpdateFont()
  self.mana:UpdateFont()
  self.energy:UpdateFont()
  self.rage:UpdateFont()
end