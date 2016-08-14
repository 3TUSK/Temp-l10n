-- Author @3TUSK
-- This language file updater is licensed under CC-BY-SA 4.0 International
-- See here for more details about license: 
-- https://creativecommons.org/licenses/by-sa/4.0/
-- ------------------------------------------------------------------------
-- User instruction:
-- 1.Put language files and this script into one folder
-- 2.Install lua 5.3.2
-- 3.Execute: lua Tool_Auto-merge.lua <en_US.lang> <zh_CN> ...
--   where <en_US.lang> is the file name of English language file
--   and <zh_CN> ... are all names of different Chinese language files
-- 4.Find the result file named zh_CN-finalOutput.lang.csv. 
--   don't forget to report bugs!
-- -----------------------------------------------------------------------

local Entry = require("lib/entry")

function loadZH(file)
  local array = {}
  local count = 1
  for s in file:lines() do
  if (s:match(".*=.*")) then
    array[count] = Entry:parse(s)
  end
  count = count + 1
  return array
end

function searchValue(key, existMapping)
  if key == nil then
    return key, false
  end

  for k, v in ipairs(existMapping) do
    if v:getKey() == key:getKey() then
      key:setValue(v:getValue())
    return key, true
    end
  end

  return key, false
end

print("Pre-loading files, please stand by...")

rawLang = io.open(arg[1])

local zhCN = {}
parameters, tmpPoint = #arg, 1
while tmpPoint < parameters do
  tmpPoint = tmpPoint + 1
  zhCN[tmpPoint] = io.open(arg[tmpPoint + 1])
end

print("Pre-loading files finished.")

print("Loading translation mappings, please stand by...")

enUS_Count = 1
enUSMapping = {}
for s in rawLang:lines() do
  if (s:match(".*=.*")) then
    enUSMapping[enUS_Count] = Entry:parse(s)
  else
    enUSMapping[enUS_Count] = s
  end
  enUS_Count = enUS_Count + 1
end

local zhCNMapping = {}
for point, zhCNFile in ipairs(zhCN) do
	zhCNMapping[point] = loadZH(zhCNFile)
end

print("Loading translation mappings finished.")

print("Post-loading files, please stand by...")

finalMapping = {}
finalOutput = io.open("zh_CN-finalOutput.lang.csv", "w+")

entry = {}

for k, v in ipairs(enUSMapping) do
	if v[2] == ",>>>" then
		finalMapping[k] = v
	elseif v[1] == "" then
		finalMapping[k] = {"", "\n"}
	else
		entry = {}
		entry[1] = v[1]
		entry[2] = "="
		
		for point, zhCNMap in zhCNMapping do 
			entry[(point + 1) * 2 - 1] = ","
			entry[(point + 1) * 2] = searchValue(v[1], zhCNMap)
		end
		
		finalMapping[k] = entry
	end
end

firstLine = {}
for k, v in ipairs(arg) do
	firstLine[k * 2 - 1] = v
	firstLine[k * 2] = ","
end
firstLine[#arg * 2 + 1] = "\n"

finalOutput:write(table.concat(firstLine))

for k, v in ipairs(finalMapping) do
	finalOutput:write(table.concat(v))
end

print("Mapping finished.")

finalOutput:flush()
finalOutput:close()
rawLang:close()
for num, file in ipairs(zhCN) do
 file[num]:close
end