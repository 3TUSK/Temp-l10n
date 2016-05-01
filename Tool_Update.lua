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
  return ""
 end

 for k, v in ipairs(existMapping) do
  if v:getKey() == key:getKey() then
   return key:translate(v:getText())
  end
 end

 return key
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
 elseif (string.match(s, "#.*")) then
  mapping[count] = Comment:parse(s)
 else
  mapping[count] = ""
 end

 count = count + 1
end

debug = {"Readed ", count, " lines in en_US.lang"}
print(table.concat(debug))

count = 1

for s in zhCNFile:lines() do
 if (string.match(s, ".*=.*")) then
  zhCN[count] = Entry:parse(s)
  count = count + 1
 end
end

debug = {"Readed ", count, " entries in zh_CN.lang"}
print(table.concat(debug))

finalPair = {}

for i, v in ipairs(mapping) do
 if (v = "") then
  outputFinal:write("")
  outputFinal:write("\n")
 else 
  translated = findExistedEntry(v, zhCN)
  finalPair = {translated:toString(), "\n"}
  outputFinal:write(table.concat(finalPair))
 end
end 

print("Language file successfully updated.")

outputFinal:flush()
outputFinal:close()
enUSFile:close()
zhCNFile:close()
