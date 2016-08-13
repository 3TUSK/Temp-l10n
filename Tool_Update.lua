-- Author @3TUSK
-- This language file updater is licensed under CC-BY-SA 4.0 International
-- See here for more details about license: 
-- https://creativecommons.org/licenses/by-sa/4.0/
-- ------------------------------------------------------------------------
-- User instruction:
-- 1.Put corresponding en_US.lang and zh_CN.lang into same folder
-- 2.Install lua 5.3.2
-- 3.Put this script where there are language files mentioned in 1.
-- 4.Run this file and you're good to go
-- -----------------------------------------------------------------------
-- local mode = arg[1]
-- local file = arg[2]

local Entry = require("lib/entry")
local Comment = require("lib/comment")

-- key as string, existMapping as weak table of string
function findExistedEntry(key, existMapping)
 if key == nil then
  return key, false
 end

 for k, v in ipairs(existMapping) do
  if v:getKey() == key:getKey() then
   key:translate(v:getText())
   return key, true
  end
 end

 return key, false
end

enUSFile = io.open("en_US.lang")
zhCNFile = io.open("zh_CN.lang")
outputFinal = io.open("zh_CN-merged.lang", "w+")

mapping = {}
zhCN = {}
mergedEntries = {}

print("Language file update started, please stand by...")

str = ''
count = 1

for s in enUSFile:lines() do
 if (string.match(s, ".*=.*")) then
  mapping[count] = Entry:parse(s)
 else then
  mapping[count] = "s"
 end

 count = count + 1
end

print("Readed "..count.." lines in en_US.lang")

count = 1

for s in zhCNFile:lines() do
 if (string.match(s, ".*=.*")) then
  zhCN[count] = Entry:parse(s)
  count = count + 1
 end
end

print("Readed "..count.." lines in zh_CN.lang")

finalPair = {}

for i, v in ipairs(mapping) do
  if (v.toString()) then
    translated = findExistedEntry(v, zhCN)
    outputFinal:write(v.toString().."\n")
  else
    outputFinal:write(v)
  end 
end 

print("Language file successfully updated.")

outputFinal:flush()
outputFinal:close()
enUSFile:close()
zhCNFile:close()
