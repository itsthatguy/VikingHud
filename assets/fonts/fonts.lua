local addonName, addon = ...

local LSM = LibStub("LibSharedMedia-3.0")

if not LSM then return end -- Oh No Mr. Nil!

local folder = [[VikingHud\assets\fonts\]]

local FONTS = {
  -- Interface\Addons\VikingHud\fonts\FORCED_SQUARE.ttf
  { name = "FORCED SQUARE", path = [[Interface\Addons\]] .. folder .. [[FORCED_SQUARE.ttf]] },
  { name = "Geo Regular", path = [[Interface\Addons\]] .. folder .. [[Geo-Regular.ttf]] },
  { name = "Hack Bold", path = [[Interface\Addons\]] .. folder .. [[Hack-Bold.ttf]] },
  { name = "Hack BoldItalic", path = [[Interface\Addons\]] .. folder .. [[Hack-BoltItalic.ttf]] },
  { name = "Hack Italic", path = [[Interface\Addons\]] .. folder .. [[Hack-Italic.ttf]] },
  { name = "Hack Regular", path = [[Interface\Addons\]] .. folder .. [[Hack-Regular.ttf]] },
  { name = "Jockey One", path = [[Interface\Addons\]] .. folder .. [[JockeyOne-Regular.ttf]] },
  { name = "Jolly Lodger", path = [[Interface\Addons\]] .. folder .. [[JollyLodger-Regular.ttf]] },
  { name = "Secular One", path = [[Interface\Addons\]] .. folder .. [[SecularOne-Regular.ttf]] },
  { name = "Source Code Pro", path = [[Interface\Addons\]] .. folder .. [[SourceCodePro-Medium.ttf]] },
  { name = "Squada One", path = [[Interface\Addons\]] .. folder .. [[SquadaOne-Regular.ttf]] },
  { name = "Staatliches", path = [[Interface\Addons\]] .. folder .. [[Staatliches-Regular.ttf]] },
  { name = "Montserrat Bold", path = [[Interface\Addons\]] .. folder .. [[Montserrat-Bold.ttf]] },
  { name = "Montserrat Medium", path = [[Interface\Addons\]] .. folder .. [[Montserrat-Medium.ttf]] },
  { name = "Montserrat Regular", path = [[Interface\Addons\]] .. folder .. [[Montserrat-Regular.ttf]] },
  { name = "Montserrat SemiBold", path = [[Interface\Addons\]] .. folder .. [[Montserrat-SemiBold.ttf]] },

}

for _, font in ipairs(FONTS) do
  LSM:Register("font", font.name, font.path)
end
