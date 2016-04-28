local Entry = {}
Entry.__index = Entry

function Entry:create(key, text)
 return setmetatable({key = key, text = text, translation = text}, Entry)
end

function Entry:parse(keyValuePair)
 local key, text = string.match(keyValuePair, "(.+)=.+"), string.match(keyValuePair, ".+=(.*)")
 return setmetatable({key = key, text = text, translation = text}, Entry)
end

function Entry:toString()
 str = {self.key, "=", self.text}
 return table.concat(str)
end

function Entry:toString(translate)
 if translate then
  return table.concat({self.key, "=", self.translation})
 else
  return table.concat({self.key, "=", self.text})
 end
end

function Entry:getKey()
 return self.key
end

function Entry:getText()
 return self.text
end

function Entry:translate(translation)
 self.translation = translation
end

function Entry:equals(anEntry)
 return anEntry:getKey() == self.key
end

return Entry
