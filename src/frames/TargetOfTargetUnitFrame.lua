-- local LSM = LibStub("LibSharedMedia-3.0")
local VSL = LibStub("VikingSharedLib")
local Taka = LibStub("Taka-0.0")

local addonName, addon = ...
local TargetUnitFrameBase = {}
local TargetUnitFrame = {}; addon.TargetUnitFrame = TargetUnitFrame

local function new(parent, side, unitID)
  local frame = CreateFrame("Button", "VH_TargetTargetFrame", parent, "SecureUnitButtonTemplate")
  VSL:ApplyMixin(frame, TargetUnitFrameBase)
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

  frame:SetSize(
    addon.Settings.db.profile.spacing - 20,
    addon.Settings.db.profile.height + addon.Settings.db.profile.fontSize + 4
  )
  frame:SetPoint("TOPLEFT", parent, "TOPRIGHT", 20, 0)

  frame.container = addon.Frame:Super(addon.Frame):New(frame)
  frame.container:SetAllPoints(frame)

  --@debug@
  -- frame:SetBackdrop({
  --   bgFile = LSM:Fetch("background", "Solid"),
  --   insets = { left = -1, right = -1, top = -1, bottom = -1}
  -- })
  -- frame:SetBackdropColor(VSL.Colors:NewRGBA(VSL.Colors.GREEN, 0.8):ToList())
  --@end-debug@

  frame.health = addon.PlayerHealthFrame:New(frame.container, "RIGHT", frame.unitID)
  frame.mana = addon.PlayerPowerFrame:New(frame.container, "RIGHT", frame.unitID, 0)
  frame.energy = addon.PlayerPowerFrame:New(frame.container, "RIGHT", frame.unitID, 3)
  frame.rage = addon.PlayerPowerFrame:New(frame.container, "RIGHT", frame.unitID, 1)

  frame.targetText = frame.container:CreateFontString(nil, "OVERLAY")
  frame.targetText:SetJustifyH("LEFT")
  frame.targetText:SetFont(addon.Settings.db.profile.font, addon.Settings.db.profile.targetTarget.fontSize)
  frame.targetText:SetPoint(
    "BOTTOMLEFT",
    frame.container,
    "TOPLEFT",
    0,
    addon.Settings.db.profile.target.nameY
  )
  frame.targetText:SetText("")

  frame:EnableMouse(true)
  frame:SetDontSavePosition(true)

  return frame
end

function TargetUnitFrame:New(...)
  local frame = new(...)

  frame:UpdateVisibility()
  frame:Update()

  return frame
end

function TargetUnitFrameBase:SetTargetText(txt)
  self.targetText:SetText(txt)
end

local MANA = 0
local RAGE = 1
local ENERGY = 3

local POWER_TYPES = {
  [0] = "MANA",
  [1] = "RAGE",
  [3] = "ENERGY"
}

function TargetUnitFrameBase:UpdateVisibility()
  if UnitExists(self.unitID) then
    self.container:Show()
  else
    return self.container:Hide()
  end
  local powerType = UnitPowerType(self.unitID)
  if UnitClass(self.unitID) == "Druid" then
    if powerType == MANA then
      self.mana:Show()
      self.rage:Hide()
      self.energy:Hide()

    elseif powerType == RAGE then
      self.rage:Show()
      self.mana:Show()
      self.energy:Hide()

    elseif powerType == ENERGY then
      self.energy:Show()
      self.mana:Show()
      self.rage:Hide()
    end
  else
    if powerType == MANA then
      self.mana:Show()
      self.rage:Hide()
      self.energy:Hide()

    elseif powerType == RAGE then
      self.mana:Hide()
      self.energy:Hide()
      self.rage:Show()

    elseif powerType == ENERGY then
      self.mana:Hide()
      self.rage:Hide()
      self.energy:Show()

    else
      self.mana:Hide()
      self.rage:Hide()
      self.energy:Hide()
    end
  end
end

function TargetUnitFrameBase:Redraw()
  self:UpdateVisibility()
  self:UpdateSize()
  self:Update()
end

function TargetUnitFrameBase:Update()
  self.health:Update()
  self.mana:Update()
  self.energy:Update()
  self.rage:Update()
end


function TargetUnitFrameBase:UpdateSize()
  local pool = {
    self.health,
  }

  local powerType = UnitPowerType(self.unitID)
  if UnitClass(self.unitID) == "Druid" then
    tinsert(pool, self.mana)

    if (powerType == RAGE) then
      tinsert(pool, self.rage)
    elseif (powerType == ENERGY) then
      tinsert(pool, self.energy)
    end

  else
    if powerType == MANA then tinsert(pool, self.mana)
    elseif powerType == RAGE then tinsert(pool, self.rage)
    elseif powerType == ENERGY then tinsert(pool, self.energy)
    end
  end

  local count = #pool
  for i, v in ipairs(pool) do
    local x = (addon.Settings.db.profile.width / count) * (i - 1)
    v:SetPoint("TOPLEFT", self.container, "TOPLEFT", x, 0)
  end

  local width, height = (addon.Settings.db.profile.width / count) - 10, addon.Settings.db.profile.height

  self.health:SetSize(width, height)
  self.mana:SetSize(width, height)
  self.energy:SetSize(width, height)
  self.rage:SetSize(width, height)
  if not InCombatLockdown() then
    self:SetSize(
      addon.Settings.db.profile.width,
      addon.Settings.db.profile.height + addon.Settings.db.profile.fontSize + 4
    )
  end
  -- self.health:SetPoint("TOP", self.container, "TOP", 10, 0)
  -- self.mana:SetPoint("TOP", self.container, "TOP", 10, 0)
  -- self.energy:SetPoint("TOP", self.container, "TOP", 10, 0)
  -- self.rage:SetPoint("TOP", self.container, "TOP", 10, 0)
end


function TargetUnitFrameBase:UpdateFont()
  self.health:UpdateFont()
  self.mana:UpdateFont()
  self.energy:UpdateFont()
  self.rage:UpdateFont()
  self.targetText:SetFont(addon.Settings.db.profile.font, addon.Settings.db.profile.targetTarget.fontSize)
end