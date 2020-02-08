--[[
  localization.itg.lua
    VikingHud Localization

  Italian
]]

local addonName, addon = ...
local L = LibStub('AceLocale-3.0'):NewLocale(addonName, 'itIT')
if not L then return end

--profiles
L.ProfileCreated = 'Creato il nuovo profilo "%s"'
L.ProfileLoaded = 'Impostato il profilo come "%s"'
L.ProfileDeleted = 'Il profilo "%s" è stato cancellato'
L.ProfileCopied = 'Impostazioni copiate da "%s"'
L.ProfileReset = 'Ripristino del profilo "%s"'
L.CantDeleteCurrentProfile = 'Non è possibile cancellare il profilo corrente'
L.InvalidProfile = '"%s" non è un profilo valido'
