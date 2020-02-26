local LSM = LibStub("LibSharedMedia-3.0")
local VSL = LibStub("VikingSharedLib")
local Taka = LibStub("Taka-0.0")

local addonName, addon = ...

local StatusBar = Taka:NewClass("StatusBar", "VH_Bar")
addon.StatusBar = StatusBar

function StatusBar:New(parent, side, textSide)
  local statusBar = self:Super(StatusBar):New(parent)
  local dirMod = side == "LEFT" and -1 or 1
  local dirPoint = side == "LEFT" and "RIGHT" or "LEFT"
  local dirPointRelative = side == "LEFT" and "LEFT" or "RIGHT"

  statusBar:SetBackdrop({
    bgFile = LSM:Fetch("background", "Solid"),
    insets = { left = 0, right = 0, top = 0, bottom = 0}
  })
  statusBar:SetAllPoints(parent)
  statusBar:SetOrientation("HORIZONTAL")
  statusBar:SetReverseFill(side == "LEFT")
  statusBar:SetStatusBarTexture(LSM:Fetch("background", "Solid"), 'ARTWORK')
  statusBar.value = 0
  statusBar.min = 0
  statusBar.max = 0

  -- statusBar.divider = addon.Frame:New(statusBar)
  -- statusBar.divider:SetSize(16, 2)
  -- statusBar.divider:SetBackdrop({
  --   bgFile = LSM:Fetch("background", "Solid"),
  --   insets = { left = 0, right = 0, top = 0, bottom = 0}
  -- })
  -- statusBar.divider:SetPoint("TOP", statusBar.currentText, "BOTTOM", 0, 0)
  -- statusBar.divider:SetBackdropColor(VSL.Colors:NewRGBA(VSL.Colors.BG, 0.5):ToList())

  statusBar.maxText = statusBar:CreateFontString(nil, "Artwork")
  statusBar.maxText:SetJustifyH(dirPointRelative)
  statusBar.maxText:SetFont(addon.Settings.db.profile.font, addon.Settings.db.profile.fontSize * 0.6)
  statusBar.maxText:SetPoint("TOP" .. dirPointRelative, statusBar, "BOTTOM" .. dirPointRelative, 0, -2)
  statusBar.maxText:SetText("")

  statusBar.currentText = statusBar:CreateFontString(nil, "Artwork")
  statusBar.currentText:SetJustifyH(dirPoint)
  statusBar.currentText:SetFont(addon.Settings.db.profile.font, addon.Settings.db.profile.fontSize)
  statusBar.currentText:SetPoint("TOP" .. dirPoint, statusBar, "BOTTOM" .. dirPoint, 0, -2)
  statusBar.currentText:SetText("")

  statusBar:Register()

  return statusBar
end

function StatusBar:AnimateValue(limit)
  local cur = self:GetValue()
  if (cur == self.value) then
    return self:Unregister()
  end

  local speed = 9
  local new = cur + min((self.value-cur)/speed, max(self.value-cur, limit))
  if new ~= new then
    -- Mad hax to prevent QNAN.
    new = self.value
  end

  self:SetValue(new)
  self.currentText:SetFormattedText("%i", new)
  self.maxText:SetFormattedText("%i", self.max)
  if cur == self.value or abs(new - self.value) < 2 then
    self.currentText:SetFormattedText("%i", self.value)
    self.maxText:SetFormattedText("%i", self.max)
    self:SetValue(self.value)
  end
end

function StatusBar:SetBarColor(r, g, b, a)
  self:SetStatusBarColor(r, g, b, a)
  return self
end

function StatusBar:SetValues(minimum, maximum, current)
  if self.value ~= current then self:Register() end
  self.min = minimum
  self.max = maximum
  self.value = current

  self:SetMinMaxValues(minimum, maximum)
end

function StatusBar:UpdateFont()
  self.currentText:SetFont(addon.Settings.db.profile.font, addon.Settings.db.profile.fontSize)
end


function StatusBar:Unregister()
  self:SetScript('OnUpdate', nil)
end

function StatusBar:Register()
  self:SetScript('OnUpdate', self.OnUpdate)
end

function StatusBar:OnUpdate()
  local limit = 30 / GetFramerate()
  self:AnimateValue(limit)
end