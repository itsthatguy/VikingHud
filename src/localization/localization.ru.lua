--[[
	Localization.ru.lua
		Translations for VikingHud

	Russian
--]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'ruRU')
if not L then return end

--profiles
L.ProfileCreated = 'Создан новый профиль "%s"'
L.ProfileLoaded = 'Установить профиль в "%s"'
L.ProfileDeleted = 'Удален профиль "%s"'
L.ProfileCopied = 'Настройки скопированы из "%s"'
L.ProfileReset = 'Сбросить профиль "%s"'
L.CantDeleteCurrentProfile = 'Невозможно удалить текущий профиль'
L.InvalidProfile = 'Некорректный профиль "%s"'
