-- TemporaryLocalization-lib
-- Authored by 3TUSK, licensed under CC-BY-SA 4.0 International
-- Yes, I have wrote Java too much and I want to do something

local Entry = {}
Entry.__index = Entry

Entry.__eq = function(obj)
  return (self.key == obj.key) and (self.value == obj.value)
end

Entry.__tostring = function(v)
 return v:getKey() .. "=" .. v:getValue()
end

function Entry:create(K, V)
 return setmetatable({key = K, value = V}, Entry)
end

function Entry:parse(keyValuePair)
 local K, V = string.match(keyValuePair, "(.+)=.+"), string.match(keyValuePair, ".+=(.*)")
 return setmetatable({key = K, value = V}, Entry)
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

return Entry
