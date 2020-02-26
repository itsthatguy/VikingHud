--[[
  localization.tw.lua
    Translations for VikingHud

	Traditional Chinese 繁體中文
]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'zhTW')
if not L then return end

--profiles
L.ProfileCreated = '建立新的設定檔 "%s"'
L.ProfileLoaded = '已載入設定檔 "%s"'
L.ProfileDeleted = '已刪除設定檔 "%s"'
L.ProfileCopied = '已從 "%s" 複製設定'
L.ProfileReset = '重置設定檔 "%s"'
L.CantDeleteCurrentProfile = '無法刪除目前的設定檔'
L.InvalidProfile = '無效的設定檔 "%s"'