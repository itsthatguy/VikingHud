------------------------------------------------------------------------------------
-- BuffFrame
-- TODO: Refactor this into a new file
-- TODO: Remove VHPlayerBuffs declaration at the top of this file
------------------------------------------------------------------------------------
local VHPlayerBuffs = {
  buffbuttons = {}
}

local function GetEnchantInfo()
  local hasMainHandEnchant, mainHandExpiration, mainHandCharges, mainHandEnchantID, hasOffHandEnchant, offHandExpiration, offHandCharges, offHandEnchantId = GetWeaponEnchantInfo()
  local IDS = {
    [1] = "Rockbiter 3",
    [2] = "Frostbrand 1",
    [3] = "Flametongue 3",
    [4] = "Flametongue 2",
    [5] = "Flametongue 1",
    [6] = "Rockbiter 2",
    [12] = "Frostbrand 2",
    [29] = "Rockbiter 1",
    [283] = "Windfury 1",
    [284] = "Windfury 2",
    [503] = "Rockbiter 4",
    [523] = "Flametongue 4",
    [524] = "Frostbrand 3",
    [525] = "Windfury 3",
    [683] = "Rockbiter 6",
    [1663] = "Rockbiter 5",
    [1664] = "Rockbiter 7",
    [1665] = "Flametongue 5",
    [1666] = "Flametongue 6",
    [1667] = "Frostbrand 4",
    [1668] = "Frostbrand 5",
    [1669] = "Windfury 4",
    [2632] = "Rockbiter 8",
    [2633] = "Rockbiter 9",
    [2634] = "Flametongue 7",
    [2635] = "Frostbrand 6",
    [2636] = "Windfury 5",
  }

  if (hasMainHandEnchant == true and IDS[mainHandEnchantID]) then
    local enchantID = IDS[mainHandEnchantID]
    local enchant = {}
    return {
      buff = enchantID,
      icon = mainHandEnchantID,
      duration = GetTime() - mainHandExpiration,
      expTime = mainHandExpiration,
      caster = "player",
      spellId = enchantID,
      target = "player"
    }
  else
    return nil
  end
end

local function GetBuffs(unitId, type)
  local maxBuffCount = 32
  local playerbuffs = { };

  for i = 1, maxBuffCount do
      local buff, icon, _, _, duration, expTime, caster, _, _, spellId = UnitAura(unitId, i, type);

      if not buff then break; end

      playerbuffs[i] = { };
      playerbuffs[i]["buff"] = buff;
      -- playerbuffs[i]["Rank"] = BUFFWATCHADDON.GetSpellRankText(spellId);
      playerbuffs[i]["icon"] = icon;
      playerbuffs[i]["duration"] = duration;
      playerbuffs[i]["expTime"] = expTime;
      playerbuffs[i]["caster"] = caster;
      playerbuffs[i]["spellId"] = spellId;
      playerbuffs[i].target = unitId
      playerbuffs[i].index = index
  end

  if (hasMainHandEnchant == true) then
    local enchant = GetEnchantInfo()
    enchant.index = #playerbuffs+1

    playerbuffs[enchant.index] = enchant
  end

  return playerbuffs;
end

function VHPlayerBuffs:CreatePlayerBuffs(buffs)
  print("CreatePlayerBuffs:")
  local buff = {}
  local iconsize = 36
  local iconxoffset = 5
  for i,v in pairs(self.buffbuttons) do
    v:Hide()
  end
  for i,v in pairs(buffs) do
    local buffname = "VH_PLAYER_FRAME_BUFF_" .. v.spellId
    buff.button = CreateFrame("Button", buffname, UIParent, "SecureActionButtonTemplate")
    buff.button:EnableMouse(true)
    buff.index = v.index
    buff.button:SetID(v.spellId)
    buff.button:SetPoint("TOPRIGHT", "VH_PLAYER_FRAME_BUFFS", "TOPRIGHT", (i == 1) and 0 or -(iconsize * (i-1)) - iconxoffset, 0)
    buff.button:SetSize(iconsize, iconsize)
    buff.button:SetNormalTexture(v.icon);
    buff.cooldown = CreateFrame("Cooldown", buffname, buff.button, "CooldownFrameTemplate")
    buff.cooldown:SetAllPoints()
    buff.cooldown:SetReverse(true)
    buff.cooldown:SetDrawEdge(false)
    buff.cooldown:SetDrawBling(true)

    local now = GetTime()
    local duration = (v.expTime - now)
    print(now, v.expTime, duration)
    buff.cooldown:SetCooldown(now, duration)

    buff.button:SetScript("OnEnter", function(this)
      -- print(self.buffbuttons)
      for index, vvv in pairs(self.buffbuttons) do
        print(index)
        for xxx,yyy in pairs(self.buffbuttons[index]) do
            print(xxx)
        end
        -- for k, vv in pairs(self.buffbuttons[index]) do
        --   print("value  -- ", k, vv)
        -- end

      end
      -- for i,v in pairs(a.cooldown) do
      --   print("a.cooldown  -- ", i, v)
      -- end
      print('GetId() -- ', this:GetID())
      -- GameTooltip:SetUnitBuff(value.target, self.buffbuttons[this:GetID()].spellId)
      GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT")
      GameTooltip:AddLine("butt")
      GameTooltip:Show()
    end)

    -- buffbutton:SetScript("OnLeave", function()
    --   GameTooltip:Hide()
    -- end)

    -- buffbutton.icon = buffbutton:CreateTexture(nil, "ARTWORK")
    -- buffbutton.icon:SetAllPoints(buffbutton)
    buff.button:Show()

    self.buffbuttons["BUFF_"..v.spellId] = buff
  end
  VH_BUFFS = self.buffbuttons
end

function VHPlayerBuffs:CreatePlayerDebuffs(buffs)
  print("CreatePlayerDebuffs:", buffs[1].buff)
  for i,v in pairs(buffs) do
    local buffbutton = CreateFrame("Button", "VH_PLAYER_FRAME_BUFF_" .. v.SpellId, UIParent)
    print(v.icon)
  end
end

function VHPlayerBuffs:HandleBuffEvent(_event)
  print("HandleBuffEvent")
  local buffs = GetBuffs("player", "HELPFUL")
  local debuffs = GetBuffs("player", "HARMFUL")

  self:CreatePlayerBuffs(buffs)
  -- self:CreatePlayerDebuffs(debuffs)
end

function VHPlayerBuffs:CreateBuffFrame()
  local buffFrame = CreateFrame("Frame", VH_FRAMES.PLAYER_FRAME .. "_BUFFS", nil)
  buffFrame:EnableMouse(false)
  buffFrame:SetPoint("TOP", UIParent, "BOTTOM", 0, 200)
  buffFrame:SetSize(900, 30)

  -- remove this start
  local texture = buffFrame:CreateTexture(nil, "BACKGROUND")
  texture:SetAllPoints()
  texture:SetColorTexture(1,1,1,.5)
  -- remove this end
  buffFrame:RegisterEvent("UNIT_AURA");
  buffFrame:SetScript("OnEvent", function(_, event, target)
    self:HandleBuffEvent(event, target, "HELPFUL")
  end)
  return buffFrame
end

------------------------------------------------------------------------------------
-- PlayerFrame
------------------------------------------------------------------------------------
local VHPlayerFrame = {}

-- target frames
function VHPlayerFrame:init()
  PlayerFrame:SetScript("OnEvent", nil);
  PlayerFrame:Hide();

  self.frame, self.controller = self:CreateContainer()
  self:CreateBars()
  self:CreateEvents(self.frame)

  self.playerHealthTextFrame = self.PlayerHealthText:create()
  self.playerHealthTextFrame:init()

  self.playerPowerTextFrame = self.PlayerPowerText:create()
  self.playerPowerTextFrame:init()

  self:CreateDividers()
  self:CreateMP6()
  self:CreateCastbar()
end

function VHPlayerFrame:CreateDividers()
  local dividerLeftFrame = CreateFrame("Frame", VH_FRAMES.PLAYER_FRAME .. "_DIVIDER_LEFT", UIParent)
  dividerLeftFrame:SetPoint("TOPRIGHT", VH_FRAMES.PLAYER_FRAME, "TOP", -32, 0)
  dividerLeftFrame:SetSize(4, 60)
  local textureLeft = dividerLeftFrame:CreateTexture(nil, "BACKGROUND")
  textureLeft:SetAllPoints()
  textureLeft:SetColorTexture(1,1,1,1)

  local dividerRightFrame = CreateFrame("Frame", VH_FRAMES.PLAYER_FRAME .. "_DIVIDER_RIGHT", UIParent)
  dividerRightFrame:SetPoint("TOPLEFT", VH_FRAMES.PLAYER_FRAME, "TOP", 32, 0)
  dividerRightFrame:SetSize(4, 60)
  local textureRight = dividerRightFrame:CreateTexture(nil, "BACKGROUND")
  textureRight:SetAllPoints()
  textureRight:SetColorTexture(1,1,1,1)
end

function VHPlayerFrame:CreateContainer() 
  local playerFrame = CreateFrame("Frame", VH_FRAMES.PLAYER_FRAME, nil)
  playerFrame:SetPoint("TOP", UIParent, "BOTTOM", 0, 200)
  playerFrame:SetSize(900, 30)

  local playerFrameController = CreateFrame("Button", VH_FRAMES.PLAYER_FRAME .. "_CONTROLLER", nil, "SecureActionButtonTemplate")
  playerFrameController:SetPoint("TOP", VH_FRAMES.PLAYER_FRAME, "TOP", 0, 0)
  playerFrameController:SetSize(500, 30)

  playerFrameController:SetAttribute("unit", "player")
  playerFrameController:EnableMouse(true)
  playerFrameController:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  playerFrameController:SetAttribute("type1", "target")
  playerFrameController:SetAttribute("type2", "togglemenu")

  -- remove this start
  -- local texture = playerFrame:CreateTexture(nil, "BACKGROUND")
  -- texture:SetAllPoints()
  -- texture:SetColorTexture(1,1,1,.02)
  -- remove this end

  return playerFrame, playerFrameController
end

function VHPlayerFrame:CreateBars()
  self.playerHP = Vikinghug.HealthBar:create()
  self.playerHP:init("player", "VH_PLAYER_HEALTH", "HEALTH", VH_COLORS.RED, VH_BAR_POSITIONS.PLAYER_HEALTH)

  self.playerMP = Vikinghug.ManaBar:create()
  self.playerMP:init("player", "VH_PLAYER_MANA", "MANA", VH_COLORS.BLUE, VH_BAR_POSITIONS.PLAYER_MANA)

  self.playerEP = Vikinghug.EnergyBar:create()
  self.playerEP:init("player", "VH_PLAYER_ENERGY", "ENERGY", VH_COLORS.YELLOW, VH_BAR_POSITIONS.PLAYER_ENERGY)

  self.playerRP = Vikinghug.RageBar:create()
  self.playerRP:init("player", "VH_PLAYER_RAGE", "RAGE", VH_COLORS.ORANGE, VH_BAR_POSITIONS.PLAYER_RAGE)    
end

function VHPlayerFrame:CreateText()
  self:CreatePowerText()
end

local function HandleEvents(self, event, ...)
  if (event == "UPDATE_SHAPESHIFT_FORM") then
    -- 1 = Bear Form
    -- 3 = Cat Form
    -- 4 = Travel Form / Aquatic Form
    return Reducer(VH_PLAYER, { type = 'SET_POWER_TYPE', value = { powerType = UnitPowerType("player") } })

  elseif (event == "UNIT_HEALTH") then
    return Reducer(VH_PLAYER, { type = 'SET_HEALTH' })


  elseif (event == "PLAYER_ENTERING_WORLD") then
    Reducer(VH_PLAYER, { type = 'SET_POWER_TYPE', value = { powerType = UnitPowerType("player") }  })
    Reducer(VH_PLAYER, { type = 'SET_HEALTH' })
    return Reducer(VH_PLAYER, { type = 'SET_MANA' })


  elseif (event == "UNIT_POWER_UPDATE") then
    return Reducer(VH_PLAYER, { type = 'SET_POWER' })
  end
end

function VHPlayerFrame:CreateEvents(frame) 
  frame:SetScript("OnEvent", HandleEvents)
  frame:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "player")

  frame:RegisterEvent("UNIT_HEALTH", "player")
  frame:RegisterEvent("UNIT_POWER_UPDATE", "player")
  frame:RegisterEvent('PLAYER_ENTERING_WORLD')
end

--
--
-- Cast Bar
-- TODO: MOVE THIS
--
function VHPlayerFrame:CreateCastbar()
  local frameName = "VH_CAST_FRAME"
  local castFrame = CreateFrame("Frame", frameName, UIParent)
  castFrame:SetSize(1, 1)
  castFrame:SetPoint("TOPRIGHT", self.frame, "TOP", -18, 0)

   -- bar
  castFrame.bar = CreateFrame('StatusBar', "VH_CAST_BAR", castFrame)
  castFrame.bar:SetPoint("TOPRIGHT", frameName, "TOPRIGHT", 0, 0)
  
  -- Style it
  castFrame.bar:SetSize(10, 60)
  castFrame.bar:SetStatusBarTexture(VH_TEXTURES.SOLID)
  castFrame.bar:SetBackdrop({ bgFile = VH_TEXTURES.SOLID })
  castFrame.bar:SetBackdropColor(ParseColor(VH_COLORS.BG, 0.6))
  castFrame.bar:SetStatusBarColor(ParseColor(VH_COLORS.YELLOW, 1))
  
  castFrame.bar:SetOrientation('VERTICAL')
  castFrame.bar:SetMinMaxValues(0, 1)

  castFrame.text = castFrame:CreateFontString("VH_CAST_TEXT")
  castFrame.text:SetFont(VH_FONTS.STAATLICHES, 20)
  castFrame.text:SetJustifyH("CENTER")
  castFrame.text:SetPoint("TOP", self.frame, "BOTTOM", 0, -4)
  castFrame.text:SetText(12345)

  CFT = castFrame.text

  castFrame.nameText = castFrame:CreateFontString("VH_CAST_NAME_TEXT")
  castFrame.nameText:SetFont(VH_FONTS.STAATLICHES, 32)
  castFrame.nameText:SetJustifyH("CENTER")
  castFrame.nameText:SetPoint("TOP", self.frame, "BOTTOM", 0, -30)
  castFrame.nameText:SetText(12345)

  CNFT = castFrame.nameText

  castFrame:Hide()
  castFrame.bar:Hide()

  castFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
  castFrame:RegisterEvent("UNIT_SPELLCAST_START", "player")
  castFrame:RegisterEvent("UNIT_SPELLCAST_DELAYED", "player")
  castFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "player")
  castFrame:RegisterEvent("UNIT_SPELLCAST_STOP", "player")
  castFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
  castFrame:SetScript("OnEvent", function(self, event, arg2, arg, spellID)
    local channelUpdate = (event == "UNIT_SPELLCAST_CHANNEL_UPDATE")
    local channelStart = (event == "UNIT_SPELLCAST_CHANNEL_START")
    local delayed = (event == "UNIT_SPELLCAST_DELAYED")

      -- Animations
    if (delayed == true or channelUpdate == true) then
      local info = (channelUpdate) and ChannelInfo or CastingInfo
      local _, _, _, startTimeMS, endTimeMS = info("player")
      local duration = (endTimeMS - startTimeMS) / 1000
      local startValue = channelUpdate and (endTimeMS / 1000) - GetTime() or GetTime() - (startTimeMS / 1000)
      local endValue = channelUpdate and 0 or duration

      AnimateGroup("CAST_BAR_VALUE", {self.bar}, 'value',
        startValue,
        endValue,
        channelUpdate and endValue or endValue,
        channelUpdate and endValue or startValue,
      AnimateGroup("CAST_BAR_TEXT_VALUE", {self.text}, 'timetext',
        startValue,
        endValue,
        channelUpdate and startValue or duration - startValue
      )

    elseif (event == "UNIT_SPELLCAST_START" or channelStart) then
      local info = (channelStart) and ChannelInfo or CastingInfo
      local name, _, _, startTimeMS, endTimeMS = info("player")
      local duration = (endTimeMS - startTimeMS) / 1000
      local startValue = channelStart and duration or 0
      local endValue = channelStart and 0 or duration

      self.bar:SetMinMaxValues(0, duration)
      self:Show()
      self.nameText:SetText(name)

      AnimateGroup("CAST_BAR_ALPHA", {self.bar}, 'alpha', self.bar:GetAlpha(), 1, 0.15)
      AnimateGroup("CAST_BAR_VALUE", {self.bar}, 'value',
        startValue,
        endValue,
        channelUpdate and startValue or endValue,
        channelUpdate and endValue or startValue,
      AnimateGroup("CAST_BAR_TEXT_VALUE", {self.text}, 'timetext',
        startValue,
        endValue,
        duration
      AnimateGroup("CAST_BAR_NAME_TEXT_Y", {self.nameText}, 'y', -55, -62, 0.08)
      AnimateGroup("CAST_BAR_NAME_TEXT_HEIGHT", {self.nameText}, 'scale', 0.7, 1, 0.08, function()
        AnimateGroup("CAST_BAR_NAME_TEXT_Y", {self.nameText}, 'y', -62, -60, 0.1)
        AnimateGroup("CAST_BAR_NAME_TEXT_HEIGHT", {self.nameText}, 'scale', 1, 1, 0.1)
      end)
      AnimateGroup("CAST_BAR_TEXT_Y", {self.text}, 'y', -14, -4, 0.1)
      AnimateGroup("CAST_BAR_NAME_TEXT_Y", {self.nameText}, 'y', -25, -30, 0.15)
      AnimateGroup("CAST_BAR_NAME_TEXT_HEIGHT", {self.nameText}, 'scale', 0.7, 1, 0.05)

    elseif (event == "UNIT_SPELLCAST_STOP" or "UNIT_SPELLCAST_CHANNEL_STOP") then
      AnimateGroup("CAST_BAR_ALPHA", {self.bar}, 'alpha', self.bar:GetAlpha(), 0, 0.25)
      AnimateGroup("CAST_BAR_TEXT_ALPHA", {self.text, self.nameText}, 'alpha', self.bar:GetAlpha(), 0, 0.25)
    end
  end)
end

--
--
-- MP6 Bar
-- TODO: MOVE THIS
--
function VHPlayerFrame:CreateMP6()
  local frameName = "VH_MP6_FRAME"
  local mp6Frame = CreateFrame("Frame", frameName, UIParent)
  mp6Frame:SetSize(1, 1)
  mp6Frame:SetPoint("TOPLEFT", self.frame, "TOP", 18, 0)

   -- bar
  mp6Frame.bar = CreateFrame('StatusBar', "VH_MP6_BAR", mp6Frame)
  mp6Frame.bar:SetPoint("TOPLEFT", frameName, "TOPLEFT", 0, 0)
  
  -- Style it
  mp6Frame.bar:SetSize(10, 60)
  mp6Frame.bar:SetStatusBarTexture(VH_TEXTURES.SOLID)
  mp6Frame.bar:SetBackdrop({ bgFile = VH_TEXTURES.SOLID })
  mp6Frame.bar:SetBackdropColor(ParseColor(VH_COLORS.BG, 0.6))
  mp6Frame.bar:SetStatusBarColor(ParseColor(VH_COLORS.YELLOW, 1))
  
  mp6Frame.bar:SetOrientation('VERTICAL')
  mp6Frame.bar:SetMinMaxValues(0, 1)

  mp6Frame:Hide()
  mp6Frame.bar:Hide()

  -- TODO: Don't show MP6 until finished channeling
  mp6Frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
    if (event == "UNIT_SPELLCAST_SUCCEEDED" and ChannelInfo("player") == nil) then
  mp6Frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
  mp6Frame:SetScript("OnEvent", function(self, event, arg2, ...)
    if (event == "UNIT_SPELLCAST_SUCCEEDED" and UnitChannelInfo("player") == nil) then
      self.endTime = GetTime() + 6
      self:Show()

      AnimateGroup("MP6_BAR_VALUE", {self.bar}, 'value', 1, 0, 6, function()
        -- Reuse the same animation group name, as to kill the old animation
        AnimateGroup("MP6_BAR", {self.bar}, 'alpha', 1, 0, 0.15, function()
          self.bar:Hide()
          self:Hide()
        end)
      end)
      AnimateGroup("MP6_BAR", {self.bar}, 'alpha', 0, 1, 0.25)

    -- NOTE: Why did I have this?
    -- elseif (event == "CURRENT_SPELL_CAST_CHANGED") then
    --   self.castChangeCount = self.castChangeCount + 1
    --   if (self.castChangeCount > 2) then
    --     self.castChangeCount = 0
    --   end
    elseif (event == "UNIT_SPELLCAST_CHANNEL_STOP") then
      self.endTime = GetTime() + 6
      self:Show()

      AnimateGroup("MP6_BAR_VALUE", {self.bar}, 'value', 1, 0, 6, function()
        -- Reuse the same animation group name, as to kill the old animation
        AnimateGroup("MP6_BAR", {self.bar}, 'alpha', 1, 0, 0.15, function()
          self.bar:Hide()
          self:Hide()
        end)
      end)
      AnimateGroup("MP6_BAR", {self.bar}, 'alpha', 0, 1, 0.25)
    end
  end)
end

Vikinghug.PlayerFrame = VHPlayerFrame