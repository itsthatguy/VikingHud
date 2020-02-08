--[[
	Localization.fr.lua
		Translations for Dominos

	French
--]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'frFR')
if not L then return end

--profiles
L.ProfileCreated = 'Cr\195\169ation nouveau profil "%s"'
L.ProfileLoaded = 'Charger profil "%s"'
L.ProfileDeleted = 'Effacer profil "%s"'
L.ProfileCopied = 'R\195\169glages copi\195\169s de "%s"'
L.ProfileReset = 'R\195\169initialisation profil "%s"'
L.CantDeleteCurrentProfile = 'Le profil courant ne peut \195\170tre effac\195\169'
L.InvalidProfile = 'Profile invalide "%s"'
