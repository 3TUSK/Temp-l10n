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
	if (string.match(s, "([%w%s%.]*)=.*")) then
		str = string.match(s, "([%w%s%.]*)=.*")
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
	if (string.match(s, "([%w%s%.]*)=.*")) then
		pair = {string.gsub(s, "([%w%s%.]*)=.*", "%1"), string.gsub(s, "[%w%s%.]*=([.]*)", "%1")}
		zhCN[count] = pair
		count = count + 1
	end
end

print(count)

finalPair = {}

for i, v in ipairs(mapping) do
	print(v)

	if (string.match(v, "(#.*)")) then
		tmpStr = string.gsub(v, "(^\n)", "%1")
		finalPair = {tmpStr, "\n"}
		outputFinal:write(table.concat(finalPair))
	end

--	if (v == "") then
--		outputFinal:write("\n")
--	end

	if (string.match(v, "([%w%s%.]*)")) then
		found = false
		for j, w in ipairs(zhCN) do
			if (v == w[1]) then
				finalPair = {v, "=", w[2], "\n"}
				outputFinal:write(table.concat(finalPair))
				found = true
				break
			end
		end
		if (found == false) then
			if not (string.sub(v, 1, 1) == "\n") then
				if not (string.sub(v, 1, 1) == "#") then
					finalPair = {v, "\n"}
					outputFinal:write(table.concat(finalPair))
				end
			end
		end
	end
end 

print("Language file successfully updated")

outputFinal:flush()
outputFinal:close()
enUSFile:close()
zhCNFile:close()
