-- TemporaryLocalization-lib
-- Authored by 3TUSK, licensed under CC-BY-SA 4.0 International
-- Yes, I have wrote Java too much and I want to do something

local Entry = {}
Entry.__index = Entry

function Entry:create(K, V)
 return setmetatable({key = K, value = V}, Entry)
end

function Entry:parse(keyValuePair)
 local K, V = string.match(keyValuePair, "(.+)=.+"), string.match(keyValuePair, ".+=(.*)")
 return setmetatable({key = K, value = V}, Entry)
end

-- TODO: override the metamethod so that we can simply use ==
function Entry:toString()
 return self.key .. "=" .. self.value
end

function Entry:getKey()
 return self.key
end

function Entry:getValue()
 return self.value
end

function Entry:setValue(translation)
 self.value = translation
end

-- TODO: override the metamethod so that we can simply use ==
function Entry:equals(anEntry)
 return anEntry:getKey() == self.key
end

return Entry
