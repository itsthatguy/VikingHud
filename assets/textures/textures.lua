local LSM = LibStub("LibSharedMedia-3.0")

if not LSM then return end -- Oh No Mr. Nil!

local folder = [[VikingHud\textures\]]

VH_TEXTURES = {
  -- Interface\Addons\VikingHud\textures\
  DRUID_ICON = {
    type = "background",
    name = "Druid Icon",
    path = [[Interface\Addons\]] .. folder .. [[druid.tga]],
  },
  {
    type = "background",
    name = "Hunter Icon",
    path = [[Interface\Addons\]] .. folder .. [[hunter.tga]],
  },
  {
    type = "background",
    name = "Mage Icon",
    path = [[Interface\Addons\]] .. folder .. [[mage.tga]],
  },
  {
    type = "background",
    name = "Paladin Icon",
    path = [[Interface\Addons\]] .. folder .. [[paladin.tga]],
  },
  {
    type = "background",
    name = "Priest Icon",
    path = [[Interface\Addons\]] .. folder .. [[priest.tga]],
  },
  {
    type = "background",
    name = "Rogue Icon",
    path = [[Interface\Addons\]] .. folder .. [[rogue.tga]],
  },
  {
    type = "background",
    name = "Shaman Icon",
    path = [[Interface\Addons\]] .. folder .. [[shaman.tga]],
  },
  {
    type = "background",
    name = "Warlock Icon",
    path = [[Interface\Addons\]] .. folder .. [[warlock.tga]],
  },
  {
    type = "background",
    name = "Warrior Icon",
    path = [[Interface\Addons\]] .. folder .. [[warrior.tga]],
  },

  SOLID = {
    type = "background",
    name = "solid",
    path = [[Interface\Addons\]] .. folder .. [[solid.tga]],
  },
  STATUSBAR = {
    type = "statusbar",
    name = "slanted dash",
    path = [[Interface\Addons\]] .. folder .. [[status-bar.tga]]
  },
  STATUSBAR_RIGHT = {
    type = "statusbar",
    name = "slanted dash right",
    path = [[Interface\Addons\]] .. folder .. [[status-bar-right.tga]]
  },
}

-- From SharedMedia
for name, data in pairs(VH_TEXTURES) do
  LSM:Register(data.type, data.name, data.path)
end