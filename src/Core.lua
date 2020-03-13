
local VSL = LibStub("VikingSharedLib", true)
if not VSL then return end

-- local LSM = LibStub("LibSharedMedia-3.0")
local Taka = LibStub("Taka-0.0")
local MainFrame = Taka:NewClass("Frame", "VH_MainFrame")

local addonName, addon = ...

function addon:OnInitialize()
  VSL:Print("=========== VikingHud INITIALIZE ==========")
  -- addon:SetChatBackgrounds()
  addon.Settings:OnLoad()
  addon.Options:OnLoad()

  local frame = MainFrame:Super(MainFrame):New(UIParent)
  frame:SetPoint("TOP", UIParent, "BOTTOM", addon.Settings.db.profile.positionX, addon.Settings.db.profile.positionY)
  frame:SetSize(addon.Settings.db.profile.spacing, addon.Settings.db.profile.height)

  --@debug@
  -- frame:SetBackdrop({
  --   bgFile = LSM:Fetch("background", "Solid"),
  --   insets = { left = -1, right = -1, top = -1, bottom = -1}
  -- })
  -- frame:SetBackdropColor(VSL.Colors:NewRGBA(VSL.Colors.BG, 0.8):ToList())
  --@end-debug@

  self.playerUnitFrame = addon.PlayerUnitFrame:New(frame, "LEFT", "player")
  self.targetUnitFrame = addon.PlayerUnitFrame:New(frame, "LEFT", "target")
  self.targetTargetUnitFrame = addon.TargetUnitFrame:New(self.targetUnitFrame, "LEFT", "targettarget")
  addon.Events:OnLoad()

  local DRAGGABLE_FRAMES = {
    LootFrame = nil,
    CharacterFrame = { fn = "ToggleCharacter" },
    SpellBookFrame = { fn = "ToggleSpellBook" },
    TalentFrame = { fn = "ToggleTalentFrame" },
  }

  for frameName, opts in pairs(DRAGGABLE_FRAMES) do
    if opts ~= nil then
      local blizzardFn = _G[opts.fn]
      _G[opts.fn] = function(...)
        blizzardFn(...)
        addon:HookDrag(_G[frameName], opts.parent)
      end
    else
      addon:HookDrag(_G[frameName])
    end
  end

  self.frame = frame
end

function addon:UpdateFont()
  self.playerUnitFrame:UpdateFont()
  self.targetUnitFrame:UpdateFont()
  self.targetTargetUnitFrame:UpdateFont()
end

function addon:UpdatePosition()
  local point, anchor, relativePoint = self.frame:GetPoint()
  self.frame:SetPoint(point, anchor, relativePoint, addon.Settings.db.profile.positionX, addon.Settings.db.profile.positionY)
end

function addon:UpdateSize()
  self.frame:SetSize(addon.Settings.db.profile.spacing, addon.Settings.db.profile.height)
  self.playerUnitFrame:UpdateSize()
  self.targetUnitFrame:UpdateSize()
  self.targetTargetUnitFrame:UpdateSize()
end

function addon:UpdateTargetText(unitID)
  -- if (UnitExists("target")) then
  --   self.targetText:Show()
  -- else
  --   return self.targetText:Hide()
  -- end

  local CLASS_ICONS = {
    Druid = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\druid.tga:0|t ",
    Hunter = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\hunter.tga:0|t ",
    Mage = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\mage.tga:0|t ",
    Paladin = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\paladin.tga:0|t ",
    Priest = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\priest.tga:0|t ",
    Rogue = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\rogue.tga:0|t ",
    Shaman = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\shaman.tga:0|t ",
    Warlock = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\warlock.tga:0|t ",
    Warrior = "|TInterface\\Addons\\VikingSharedLib\\assets\\textures\\warrior.tga:0|t ",
  }
  setmetatable(CLASS_ICONS, {
    __index = function()
      return ""
    end
  })

  local RAID_ICONS = {
    [1] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t ",
    [2] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t ",
    [3] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t ",
    [4] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t ",
    [5] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t ",
    [6] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t ",
    [7] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t ",
    [8] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t ",
  }
  setmetatable(RAID_ICONS, {
    __index = function()
      return ""
    end
  })

  local class = UnitClass(unitID)
  local icon = RAID_ICONS[GetRaidTargetIndex(unitID)]
  local classIcon = CLASS_ICONS[class]
  local name = UnitName(unitID)
  local level = UnitLevel(unitID)
  local classification = UnitClassification(unitID)

  local msg = level
  if classification ==  "worldboss" then
      msg = msg .. "WB"
  elseif classification == "rareelite" then
      msg = msg .. "RE"
  elseif classification == "elite" then
      msg = msg .. "E"
  elseif classification == "rare" then
      msg = msg .. "R"
  elseif classification == "normal" then
  elseif classification == "trivial" then
  end

  (unitID == "target" and self.targetUnitFrame or self.targetTargetUnitFrame):SetTargetText(
    icon ..
    VSL.Colors:NewDifficultyColor(level):ToText() ..
    ((tonumber(level) > 0) and msg or "??") .. "|r " ..
    (name or "") .. " " ..
    classIcon
  )
end


function addon:HookDrag(frame, parent)
  local draggableFrame = parent or frame
  if (frame.lastPoint ~= nil) then frame:SetPoint(unpack(frame.lastPoint)) end
  if (frame.draggable == nil) then
    frame:RegisterForDrag("LeftButton")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:SetScript("OnDragStart", function(this)
      frame:StartMoving()
    end)
    frame:SetScript("OnDragStop", function(this)
      this.lastPoint = {frame:GetPoint()}
      frame:StopMovingOrSizing()
    end)
    frame.draggable = true
  end
end

local frame = CreateFrame("Frame", "VH_INIT_FRAME")
frame:RegisterEvent("ADDON_LOADED")
local function eventHandler(self, event, ...)
  frame:SetScript("OnEvent", nil)
  frame:UnregisterAllEvents()
  frame:Hide()
  frame = nil
  addon:OnInitialize()
end
frame:SetScript("OnEvent", eventHandler)
