--[[
	Localization.cn.lua
		Translations for VikingHud

--]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'zhCN')
if not L then return end

--profiles
L.ProfileCreated = '建立新方案 "%s"'
L.ProfileLoaded = '方案设置为 "%s"'
L.ProfileDeleted = '删除方案 "%s"'
L.ProfileCopied = '已复制方案"%s"的设置到当前方案'
L.ProfileReset = '重置方案 "%s"'
L.CantDeleteCurrentProfile = '不能删除当前在用的方案'
L.InvalidProfile = '无效的方案或者已是当前方案 "%s"'
