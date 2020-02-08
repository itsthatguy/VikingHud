local Taka = LibStub("Taka-0.0")

local addonName, addon = ...

local Frame = Taka:NewClass("Frame", "VH_Frame")
addon.Frame = Frame

function Frame:New(parent)
  local frame = self:Super(Frame):New(parent)
  return frame
end
