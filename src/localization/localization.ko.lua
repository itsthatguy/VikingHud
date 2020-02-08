--[[
	localization.koKR.lua
		Translations for VikingHud

	Korean
]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'koKR')
if not L then return end

--profiles
L.ProfileCreated = '"%s"에 대해 새 프로필이 생성되었습니다.'
L.ProfileLoaded = '프로필을 "%s"|1으로;로; 설정합니다.'
L.ProfileDeleted = '프로필 "%s"|1이;가; 삭제되었습니다.'
L.ProfileCopied = '"%s"에서 설정이 복사되었습니다.'
L.ProfileReset = '프로필 "%s"|1을;를; 초기화합니다.'
L.CantDeleteCurrentProfile = '현재 프로필을 삭제할 수 없습니다.'
L.InvalidProfile = '잘못된 프로필 "%s"'
