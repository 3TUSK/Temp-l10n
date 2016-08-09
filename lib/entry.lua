-- TemporaryLocalization-lib
-- Authored by 3TUSK, licensed under CC-BY-SA 4.0 International
-- Yes, I have wrote Java too much and I want to do something

local Entry = {}
Entry.__index = Entry

Enrty.__eq =  function (obj)
  return self.key == obj.key && self.value == obj.value
end

Entry.__tostring = function (v)
 str = {self.key, "=", self.value}
 return table.concat(str)
end

function Entry:create(K, V)
 return setmetatable(Entry, {key = K, value = V})
end

function Entry:parse(keyValuePair)
 local K, V = string.match(keyValuePair, "(.+)=.+"), string.match(keyValuePair, ".+=(.*)")
 return setmetatable(Entry, {key = K, value = V})
end

function Entry:toString()
 return self.key.."="..self.value
end

function Entry:getKey()
 return self.key
end

function Entry:getValue()
 return self.text
end

function Entry:setValue(translation)
 self.translation = translation
end

-- TODO: override the metamethod so that we can simply use ==
function Entry:equals(anEntry)
 return anEntry:getKey() == self.key
end

return Entry
