-- Author @3TUSK
-- This file is licensed under CC-BY-SA 4.0 International
-- See here for more details about license: 
-- https://creativecommons.org/licenses/by-sa/4.0/
-- -----------------------------------------------------------------------
-- This is a test converter
-- Designed for converting from Miencraft *.lang format to *.pot format
-- Author 3TUSK
-- User instruction:
-- 1. Put this script and en_US.lang at the same folder
-- 2. Run this script
-- 3. The result is template.pot
-- -----------------------------------------------------------------------

local entry = require("lib/entry")

local epix = function (s)
  return s:gsub("(.+)=(.+)", 'msgctxt "%1"\nmsgid "%2"')
end

local isEntry = function(line)
  local value = entry:parse(line)
  return value ~= null, value
end

local baseLangFile = io.open("en_US.lang")
local outputTemplete = io.open("template.pot", "w+")

for line in baseLangFile:lines() do
  if isEntry(line) then
    outputTemplete:write(epix(line).."\n\n")
  else
    outputTemplete:write(line.."\n")
  end
end

outputTemplete:flush()
outputTemplete:close()

print("The templete.pot has generated, check it out.")

baseLangFile:close()