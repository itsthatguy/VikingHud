--[[
	Localization.lua
		Translations for VikingHud

	English: Default language
--]]
local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'enUS', true)

--profiles
L.ProfileCreated = 'Created new profile "%s"'
L.ProfileLoaded = 'Set profile to "%s"'
L.ProfileDeleted = 'Deleted profile "%s"'
L.ProfileCopied = 'Copied settings from "%s"'
L.ProfileReset = 'Reset profile "%s"'
L.CantDeleteCurrentProfile = 'Cannot delete the current profile'
L.InvalidProfile = 'Invalid profile "%s"'
L.ActionBarDisplayName = "Action Bar %s"

--options
L['Bar Size and position'] = 'Bar Size and position'
L['Horizontal Postition'] = 'Horizontal Postition'
L['Vertical Postition'] = 'Vertical Postition'

-- Font Shit
L["Font & Text Settings"] = "Font & Text Settings"
L['Font Family'] = 'Global Font Family'
L['Target Text Vertical Postition'] = 'Target Text Vertical Postition'
L['Target Font Size'] = 'Target Font Size'
L['Target of Target Font Size'] = 'Target of Target Font Size'
L['Bars Font Size'] = 'Bars Font Size'

-- Bar size & position
L['Horizonal Spacing'] = 'Horizonal Spacing'
L['How much space between the left and right bars?'] = 'How much space between the left and right bars?'
L['Vertical Spacing'] = 'Vertical Spacing'
L['How much space between the unit and target frames?'] = 'How much space between the unit and target frames?'
L['Frame Width'] = 'Frame Width'
L['Bar Height'] = 'Bar Height'

-- Camera Shit
L['Model Options'] = 'Model Options'
L['Show Target 3D Portrait'] = 'Show Target 3D Portrait'
L['Camera'] = 'Camera'
L['x'] = 'x'
L['y'] = 'y'
L['z'] = 'z'
L['Model'] = 'Model'
L['Scale'] = 'Scale'
L['Rotation'] = 'Rotation'
L['Pitch'] = 'Pitch'
L['Animation'] = 'Animation'