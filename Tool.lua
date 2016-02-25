-- Author @3TUSK
-- This language file updater is licensed under CC-BY-SA 4.0 International
-- See here for more details about license: 
-- https://creativecommons.org/licenses/by-sa/4.0/

local mode = arg[1]
local file = arg[2]

enUSFile = io.open("en_US.lang")
zhCNFile = io.open("zh_CN.lang")
outputFinal = io.open("zh_CN-merged.lang", "w")

mapping = {}
zhCN = {}
mergedEntries = {}

print("Language file update started, please stand by...")

str = ''
count = 1

for s in enUSFile:lines("L") do
	if (string.gmatch(s, "([%w%s%.]*)=.*\n")) then
		str = string.gsub(s, "([%w%s%.]*)=.*", "%1")
--		outputFinal:write(str)
		mapping[count] = str
		else
			mapping[count] = s
	end
	
	count = count + 1
end

count = 1

pair = {}

for s in zhCN:lines("L") do
	if (string.gmatch(s, "([%w%s%.]*)=.*\n")) then
		pair = {string.gsub(s, "([%w%s%.]*)=.*", "%1"), string.gsub(s, "[%w%s%.]*=([.]*)", "%1")}
		zhCN[count] = pair
	end
	count = count + 1
end

finalPair = {}

for i, v in ipairs(mapping) do
	if (string.gmatch(v, "([%w%s%.]*)")) then
		for j, w in ipairs(zhCN) do
			if (v == w[1]) then
				finalPair = {v, "=", w[2]}
				outputFinal:write(table.concat(finalPair))
				break
			end
		end
	else
		outputFinal:write(v)
	end
end 

print(string.format("Language file successfully updated with %n new lines", #enUSFile - #zhCNFile))

outputFinal:flush()
outputFinal:close()
enUSFile:close()
zhCNFile:close()
