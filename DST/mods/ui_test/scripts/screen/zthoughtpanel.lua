local Widget = require("widgets/widget")
local Text = require("widgets/text")
local Zstring = require("util/zstring")

local Zthoughtpanel = Class(Widget, function(self, owner)
    Widget._ctor(self, "Zthoughtpanel")

    self.parent = owner
    self.open = false
    self.basePos = Vector3(0, -50, 0)
    self.avatarPosOffset = Vector3(-113, 60.5, 0)
    self.barLinePosOffset = Vector3(-87, 60.5, 0)
    self.textLabelPosOffset = Vector3(17, 67, 0)

    self.baseScale = Vector3(2, 1.5, 1)
    self.avatarScale = Vector3(0.5, 0.5, 1)
    self.barLineScale = Vector3(0.5, 0.5, 1)

    self.fontSize = 12
    self.characterWidthOnScreen = 7
    self.characterHeightOnScreen = 9
    self.characterCountInRow = 28
    self.characterByteCountInRow = self.characterCountInRow * 3

    self.bg = self:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    self.avatarBg = self:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
    self.avatarIcon = self:AddChild(Image("images/avatars.xml", "avatar_wilson.tex"))
    self.avatarFrame = self:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
    self.barLine = self:AddChild(Image("images/crafting_menu.xml", "scrollbar_bar.tex"))
    self.textLable = self:AddChild(Text(NEWFONT, self.fontSize, nil, {0, 0, 0 ,1}))

    self:adapterPosition()
    self:adapterScale()
    self:Hide()
end)

function Zthoughtpanel:adapterPosition()
    self.bg:SetPosition(0, 0, 0)
    self.avatarBg:SetPosition((self.basePos+self.avatarPosOffset).x, (self.basePos+self.avatarPosOffset).y, (self.basePos+self.avatarPosOffset).z)
    self.avatarIcon:SetPosition((self.basePos+self.avatarPosOffset).x, (self.basePos+self.avatarPosOffset).y, (self.basePos+self.avatarPosOffset).z)
    self.avatarFrame:SetPosition((self.basePos+self.avatarPosOffset).x, (self.basePos+self.avatarPosOffset).y, (self.basePos+self.avatarPosOffset).z)
    self.barLine:SetPosition((self.basePos+self.barLinePosOffset).x, (self.basePos+self.barLinePosOffset).y, (self.basePos+self.barLinePosOffset).z)
    self.textLable:SetPosition((self.basePos+self.textLabelPosOffset).x, (self.basePos+self.textLabelPosOffset).y, (self.basePos+self.textLabelPosOffset).z)
end

function Zthoughtpanel:adapterScale()
    self.bg:SetScale(self.baseScale.x, self.baseScale.y, self.baseScale.z)
    self.avatarBg:SetScale(self.avatarScale.x, self.avatarScale.y, self.avatarScale.z)
    self.avatarIcon:SetScale(self.avatarScale.x, self.avatarScale.y, self.avatarScale.z)
    self.avatarFrame:SetScale(self.avatarScale.x, self.avatarScale.y, self.avatarScale.z)
    self.barLine:SetScale(self.barLineScale.x, self.barLineScale.y, self.barLineScale.z)
end

function Zthoughtpanel:slideOut()
    if not self.open then
        self.open = true
        self:MoveTo(Vector3(0, 0, 0), self.basePos, .33, nil)
        self:Show()
    end
end

function Zthoughtpanel:slideIn()
    if self.open then
        self.open = false
        self:MoveTo(self.basePos, Vector3(0, 0, 0), .33, nil)
        self:Hide()
    end
end

function Zthoughtpanel:setText(str)
    local text = Zstring(str)
    text:alignByByteCount(self.characterByteCountInRow)
    local textLen = text:getByteLength()
    local showText = ""
    for i=1, textLen/self.characterByteCountInRow do
        showText = showText .. text:substrByByteCount(nil, self.characterByteCountInRow) .. "\n"
    end
    self.textLable:SetString(showText)
    self.textLable:SetRegionSize(self.characterWidthOnScreen*self.characterCountInRow, (textLen/self.characterByteCountInRow)*self.characterHeightOnScreen)
end

return Zthoughtpanel