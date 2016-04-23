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

-- key as string, existMapping as weak table of string
function findExistedEntry(key, existMapping)
	if key == nil then
		return key
	end

	if key == "" then
		return key
	end

	for k, v in ipairs(existMapping) do
		if v[1] == key then
			return table.concat({key, "=", v[2]})
		end
	end

	return table.concat({key, "="})
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
	if (string.match(s, "([%w%s%.:_]*)=.*")) then
		str = string.match(s, "([%w%s%.:_]*)=.*")
		mapping[count] = str
		elseif (string.match(s, "#.*")) then
			str = string.gsub(s, "(^\n)", "%1")
			mapping[count] = str
		else
			str = ""
			mapping[count] = str
	end
	
	count = count + 1
end

debug = {"Readed ", count, " lines in en_US.lang"}
print(table.concat(debug))

count = 1

pair = {}

for s in zhCNFile:lines() do
	if (string.match(s, "([%w%s%.:_]*)=.*")) then
		pair = {string.gsub(s, "([%w%s%.:_]*)=.*", "%1"), string.gsub(s, "[%w%s%.:_]*=([.]*)", "%1")}
		zhCN[count] = pair
		count = count + 1
	end
end

debug = {"Readed ", count, " lines in zh_CN.lang"}
print(table.concat(debug))

finalPair = {}

for i, v in ipairs(mapping) do
	finalPair = {findExistedEntry(v, zhCN), "\n"}
	outputFinal:write(table.concat(finalPair));
end 

print("Language file successfully updated.")

outputFinal:flush()
outputFinal:close()
enUSFile:close()
zhCNFile:close()
