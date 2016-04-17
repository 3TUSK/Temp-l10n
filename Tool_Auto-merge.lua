-- Author @3TUSK
-- This language file updater is licensed under CC-BY-SA 4.0 International
-- See here for more details about license: 
-- https://creativecommons.org/licenses/by-sa/4.0/
-- ------------------------------------------------------------------------
-- User instruction:
-- 1.Put language files and this script into one folder
-- 2.Install lua 5.3.2
-- 3.Type lua Tool_Auto-merge.lua [1] [2] [3] [4] [5] [6]
--   where 1 is the file name of English language file
--   and 2-6 are all names of different Chinese language files
-- 4.Find the result file named zh_CN-finalOutput.lang.csv. 
--   don't forget to report bugs!
-- -----------------------------------------------------------------------

function loadZH(file)
	local array = {}
	local tempCount = 1
	for l in file:lines() do
		if (string.match(l, "([%w%s%.]+)=.*")) then
			local key, value = string.gsub(l, "([%w%s%.]*)=.*", "%1"), string.gsub(l, "[%w%s%.]*=([.]*)", "%1")
			array[tempCount] = {key, value}
			tempCount = tempCount + 1
		end
	end
	return array
end

function searchValue(key, mapping)
	for k, v in ipairs(mapping) do
		if v[1] == key then
			return v[2]
		end
	end

	return "null"
end

print("Pre-loading files, please stand by...")

rawLang = io.open(arg[1])

local zhCN = {}
parameters, tmpPoint = #arg, 1
while tmpPoint < parameters do
	if tmpPoint >= parameters then
		break
	end
	zhCN[tmpPoint] = io.open(arg[tmpPoint + 1])
	tmpPoint = tmpPoint + 1
end

print("Pre-loading finished.")

print("Loading files, please stand by...")

enUS_Count = 1
enUSMapping = {}
for s in rawLang:lines() do
	identify = string.sub(s, 1, 1)
	if (identify == "#") then
		local tmpTable = {s, ",>>>", ",>>>", ",>>>", ",>>>", ",>>>", "\n"}
		enUSMapping[enUS_Count] = tmpTable
		enUS_Count = enUS_Count + 1
		elseif (#s == 0) then
			enUSMapping[enUS_Count] = {"newline", ",>>>", ",>>>", ",>>>", ",>>>", ",>>>", "\n"}
			enUS_Count = enUS_Count + 1
		else
			tmpKey = string.gsub(s, "([%w%s%.]+)=.*", "%1")
			tmpTable = {tmpKey, "=", "\n"}

			enUSMapping[enUS_Count] = tmpTable
			enUS_Count = enUS_Count + 1
		end
end

print("Loading finished.")

local zhCNMapping = {}
for point, zhCNFile in ipairs(zhCN) do
	zhCNMapping[point] = loadZH(zhCNFile)
end

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
	file[2]:close
end