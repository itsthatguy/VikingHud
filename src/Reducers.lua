VH_STATE = {
    player = {
    unit = "player",
    powerType = 0,
    health = UnitHealth("player"),
    healthMax = UnitHealthMax("player"),
    power = UnitPower("player"),
    powerMax = UnitPowerMax("player"),
    mana = UnitPower("player", 0),
    manaMax = UnitPowerMax("player", 0),
    energy = UnitPower("player", 3),
    energyMax = UnitPowerMax("player", 3),
    rage = UnitPower("player", 1),
    rageMax = UnitPowerMax("player", 1),
  },

  target = {
    unit = "target",
    powerType = 0,
    health = UnitHealth("target"),
    healthMax = UnitHealthMax("target"),
    power = UnitPower("target"),
    powerMax = UnitPowerMax("target"),
    mana = UnitPower("target", 0),
    manaMax = UnitPowerMax("target", 0),
    energy = UnitPower("target", 3),
    energyMax = UnitPowerMax("target", 3),
    rage = UnitPower("target", 1),
    rageMax = UnitPowerMax("target", 1),
    name = UnitName("target"),
    level = UnitLevel("target"),
    classification = UnitLevel("classification"),
    text = ""
  }
}

function Reducer(stateName, action)
  local newState = ShallowClone(VH_STATE[stateName])
  local actions = VH_ACTIONS[newState.unit]

  if (action.type == "SET_HEALTH") then
    newState['health'] = UnitHealth(newState.unit)
    newState['healthMax'] = UnitHealthMax(newState.unit)
    Vikinghug.callbacks:Fire(actions.updateHealth, newState)

  elseif (action.type == "SET_POWER") then
    newState['power'] = UnitPower(newState.unit)
    newState['powerMax'] = UnitPowerMax(newState.unit)
    -- TODO: IF DRUID
    newState['mana'] = UnitPower(newState.unit, 0)
    newState['manaMax'] = UnitPowerMax(newState.unit, 0)
    newState['energy'] = UnitPower(newState.unit, 3)
    newState['energyMax'] = UnitPowerMax(newState.unit, 3)
    newState['rage'] = UnitPower(newState.unit, 1)
    newState['rageMax'] = UnitPowerMax(newState.unit, 1)
    Vikinghug.callbacks:Fire(actions.updatePower, newState)

  elseif (action.type == "SET_POWER_TYPE") then
    newState['powerType'] = UnitPowerType(newState.unit)
    newState['power'] = UnitPower(newState.unit)
    newState['powerMax'] = UnitPowerMax(newState.unit)

    Vikinghug.callbacks:Fire(actions.updatePower, newState)
    Vikinghug.callbacks:Fire(actions.configureBars, newState)

  elseif (action.type == "SET_TARGET") then
    if (UnitExists(newState.unit) == false) then
      return Vikinghug.callbacks:Fire(actions.clearTarget, newState)
    end

    local name = UnitName(newState.unit)
    local level = UnitLevel(newState.unit)
    local classification = UnitClassification("target")

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

    newState['text'] =
      GetDifficultyColorText(level) ..
      ((tonumber(level) > 0) and msg or "??") .. "|r " .. name

    newState['name'] = name
    newState['level'] = level

    Vikinghug.callbacks:Fire(actions.updateTargetText, newState)
  end

  VH_STATE[stateName] = ShallowClone(newState)
end

