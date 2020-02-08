--[[
	Localization.es.lua
		Translations for VikingHud

	Español
--]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'esES')
if not L then return end

--profiles
L.ProfileCreated = 'Creado nuevo prefil "%s"'
L.ProfileLoaded = 'Perfil establecido a "%s"'
L.ProfileDeleted = 'Perfil borrado "%s"'
L.ProfileCopied = 'Copiados parámetros de "%s"'
L.ProfileReset = 'Reseteado perfil "%s"'
L.CantDeleteCurrentProfile = 'No se puede borrar el perfil actual'
L.InvalidProfile = 'Perfil inválido "%s"'