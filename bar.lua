FOOBAR = {}


function FOOBAR:init()
  self:CreateEvents()
end

function FOOBAR:HandleEvents()
  VikingHud.debug(self:GetBuffs())
end

local count = 0
function FOOBAR:CreateEvents()
  VikingHud.debug('createEvents')
  local endTime = GetTime() + 1
  while (count >= 0 and count <= 2) do
    if (GetTime() >= endTime) then
      count = count + 1
      self:HandleEvents()
      self:CreateEvents()
      break
    end
  end
end

function FOOBAR:GetBuffs(unitId)
    local maxBuffCount = 2
    local playerbuffs = {}

    for i = 1, maxBuffCount do
        local buff, icon, _, _, duration, expTime, caster, _, _, spellId = UnitAura(unitId, i, "spell")

        if not buff then break; end

        playerbuffs[i] = {};
        playerbuffs[i].index = i
        playerbuffs[i]["buff"] = buff;
        -- playerbuffs[i]["Rank"] = BUFFWATCHADDON.GetSpellRankText(spellId);
        playerbuffs[i]["icon"] = icon;
        playerbuffs[i]["duration"] = duration;
        playerbuffs[i]["expTime"] = expTime;
        playerbuffs[i]["caster"] = caster;
        playerbuffs[i]["spellId"] = spellId;
        playerbuffs[i].target = unitId
        playerbuffs[i].type = "spell"
    end

    return playerbuffs
end

function FOOBAR:CreateBuff()
end

function FOOBAR:RenderBuffs()
end

local SPELLS = {
  "Mark of the Wild",
  "Thorns",
  "Ice Armor",
  "Ice Barrier",
  "Windfury Totem",
  "Travel Form",
  "Arcane Intellect",
  "Power Word: Fortitude",
}

local function MakeSpell()
  local i = math.random(1, #SPELLS)
  local name = SPELLS[i]
  return
    name,
    "icon__" .. name,
    "count__" .. name,
    "debuffType__" .. name,
    "duration__" .. name,
    "expirationTime__" .. name,
    "source__" .. name,
    "isStealable__" .. name,
    "nameplateShowPersonal__" .. name,
    "spellId__" .. name,
    "canApplyAura__" .. name,
    "isBossDebuff__" .. name,
    "castByPlayer__" .. name,
    "nameplateShowAll__" .. name,
    "timeMod__" .. name
end

function UnitAura(unitId, i, type)
  return MakeSpell()
end

function GetTime()
  return os.time()
end

-- VikingHud.debug(FOOBAR:GetBuffs("player"))
FOOBAR:init()

math.randomseed( os.time() )