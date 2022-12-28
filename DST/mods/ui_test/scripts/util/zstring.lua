local Zstring = Class(function(self, str)
    self.str = str
    self.curPos = 1
    self.curStep = 1
end)

function Zstring:getNextStepByPos(startPos)
    if self.str == nil or #self.str == 0 then
        return self.curStep
    end
    local byteVal = string.byte(self.str, startPos)
    if byteVal > 239 then
        self.curStep = 4
    elseif byteVal > 223 then
        self.curStep = 3
    elseif byteVal > 191 then
        self.curStep = 2
    else
        self.curStep = 1
    end
    return self.curStep
end

function Zstring:getCharacterLength()
    local realByteCount = #self.str
    local curBytePos = 0
    local length = 0

    while (curBytePos < realByteCount) do
        self:getNextStepByPos(curBytePos)
        curBytePos = curBytePos + self.curStep
        length = length + 1
    end
    return length
end

function Zstring:substr(startPos, characterCount)
    local curPos = startPos ~= nil and startPos or self.curPos
    for i = 1, characterCount do
        self:getNextStepByPos(curPos)
        curPos = curPos + self.curStep
        if curPos >= #self.str then
            break
        end
    end
    self.curPos = curPos
    return string.sub(self.str, startPos, curPos)
end

return Zstring