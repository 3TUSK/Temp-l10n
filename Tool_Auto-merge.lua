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

zhCN1 = io.open(arg[2])
zhCN2 = io.open(arg[3])
zhCN3 = io.open(arg[4])
zhCN4 = io.open(arg[5])
zhCN5 = io.open(arg[6])

print("Pre-loading finished.")

print("Loading files, please stand by...")

enUS_Count = 1
enUSMapping = {}
for s in rawLang:lines() do
	identify = string.sub(s, 1, 1)
	if (identify == "#") then
		tmpTable = {s, ",>>>", ",>>>", ",>>>", ",>>>", ",>>>", "\n"}
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

zhCNMapping1, zhCNMapping2, zhCNMapping3, zhCNMapping4, zhCNMapping5 = loadZH(zhCN1), loadZH(zhCN2), loadZH(zhCN3), loadZH(zhCN4), loadZH(zhCN5) 

print("Loading finished.")

print("Post-loading files, please stand by...")

finalMapping = {}
finalOutput = io.open("zh_CN-finalOutput.lang.csv", "w+")

entry = {}

for k, v in ipairs(enUSMapping) do
	if v[2] == ",>>>" then
		finalMapping[k] = v
	elseif v[1] == "" then
		finalMapping[k] = {"", "", "", "", "", "", "\n"}
	else
		entry = {}
		entry[1] = v[1]
		entry[2] = "="
		entry[3], entry[5], entry[7], entry[9], entry[11] =  ",", ",", ",", ",", ","
		entry[4] = searchValue(v[1], zhCNMapping1)
		entry[6] = searchValue(v[1], zhCNMapping2)
		entry[8] = searchValue(v[1], zhCNMapping3)
		entry[10] = searchValue(v[1], zhCNMapping4)
		entry[12] = searchValue(v[1], zhCNMapping5)

		finalMapping[k] = entry
	end
end

firstLine = {arg[1], ",", arg[2], ",", arg[3], ",", arg[4], ",", arg[5], ",", arg[6], ",", "\n"}
finalOutput:write()

for k, v in ipairs(finalMapping) do
	finalOutput:write(table.concat(v))
end

print("Mapping finished.")

finalOutput:flush()
finalOutput:close()
rawLang:close()
zhCN1:close()
zhCN2:close()
zhCN3:close()
zhCN4:close()
zhCN5:close()