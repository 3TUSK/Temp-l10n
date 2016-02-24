-- Author @3TUSK
-- This language file updater is licensed under CC-BY-SA 4.0 International
-- See here for more details about license: 
-- https://creativecommons.org/licenses/by-sa/4.0/

local mode = arg[1]
local file = arg[2]

-- Note: the empty strings is on purpose and they will be changed later
rawFile = io.open("")
outputFinal = io.open("", "w")

print(rawFile)
print(outputFinal)

print("Clean up has started, please stand by...")

local str = ''

for s in rawFile:lines("L") do
	if (string.gmatch(s, "([%w%s%.]*)=.*\n")) then
		str = string.gsub(s, "([%w%s%.]*)=.*", "%1=\n")
		outputFinal:write(str)
		elseif (string.gmatch(s, "%#.*")) then
			str = s
			outputFinal:write(s)
			outputFinal:write("\n")
		else
			outputFinal:write("\n")
	end
end

outputFinal:flush()
outputFinal:close()
rawFile:close()
