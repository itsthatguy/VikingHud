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