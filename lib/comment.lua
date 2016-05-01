local Comment = {}
Comment.__index = Comment

function Comment:create(comment)
 return setmetatable({comment = comment}, Comment)
end

function Comment:parse(fullComment)
 local comment = string.match(fullComment, "#(.*)")
 return setmetatable({comment = comment}, Comment)
end

function Comment:toString()
 return table.concat({"#", self.comment})
end

function Comment:getContext()
 return self.comment
end

return Comment
