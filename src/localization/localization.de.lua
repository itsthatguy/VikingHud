--[[
	Localization.de.lua
		Translations for VikingHud

	German language
--]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'deDE')
if not L then return end

--profiles
L.ProfileCreated = 'Neues Profil "%s" erstellt'
L.ProfileLoaded = 'Profil auf "%s" festgelegt'
L.ProfileDeleted = 'Profil "%s" gel\195\182scht'
L.ProfileCopied = 'Einstellungen von "%s" kopiert'
L.ProfileReset = 'Profil "%s" zur\195\188ckgesetzt'
L.CantDeleteCurrentProfile = 'Das aktuelle Profil kann nicht gel\195\182scht werden'
L.InvalidProfile = 'Ung\195\188ltiges Profil "%s"'