local WIDGET = require("widgets/widget")
local Text = require "widgets/text"
local Zstring = require("util/zstring")
local Zthoughtpanel = require("screen/zthoughtpanel")

local vote = function(self)
    function self:OpenVote()
        if self.votewindow then
            self.votewindow.open = true
            self.votewindow:MoveTo(Vector3(0, 0, 0), Vector3(0, -50, 0), .33, nil)
            self.votewindow:Show()
        end
    end

    function self:UpdateHeaderInfo(infotype, dir)
        if infotype == "x" then
            if dir == "add" then
                self.votewindow.textlable_x = self.votewindow.textlable_x+1
            elseif dir == "sub" then
                self.votewindow.textlable_x = self.votewindow.textlable_x-1
            end
        elseif infotype == "y" then
            if dir == "add" then
                self.votewindow.textlable_y = self.votewindow.textlable_y+1
            elseif dir == "sub" then
                self.votewindow.textlable_y = self.votewindow.textlable_y-1
            end
        end
        self.votewindow.label:SetPosition(self.votewindow.textlable_x, self.votewindow.textlable_y, 0)
    end

    function self:GetHeaderInfo()
        print("x: ", self.votewindow.textlable_x, "y: ", self.votewindow.textlable_y)
    end

    self.ztopmiddle_root = self:AddChild(WIDGET("ztopmiddle_root"))
    self.ztopmiddle_root:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.ztopmiddle_root:SetHAnchor(ANCHOR_MIDDLE)
    self.ztopmiddle_root:SetVAnchor(ANCHOR_TOP)
    self.ztopmiddle_root:SetMaxPropUpscale(MAX_HUD_SCALE)
    self.ztopmiddle_root = self.ztopmiddle_root:AddChild(WIDGET("real_ztopmiddle"))

    self.zthoughtpanel = self.ztopmiddle_root:AddChild(Zthoughtpanel(self))
    local testStr = "这是一个文本测试,来自于Z.测试时间:2022年12月25日,星期天.hahahahahahahahahahahha,小赤佬,我是小帅翔,帅翔帅翔帅翔."
    self.zthoughtpanel:setText(testStr)
    
    return self.zthoughtpanel

    -- self.vote_scale_x = 2
    -- self.vote_scale_y = 1.5

    -- self.votewindow = self.ztopmiddle_root:AddChild(Image("images/ui.xml", "votewindow_controller_bottom.tex"))
    -- self.votewindow:SetScale(self.vote_scale_x, self.vote_scale_y, 1)

    -- self.votewindow.header_x = -113
    -- self.votewindow.header_y = 10.5
    -- self.votewindow.header_sx = 0.4
    -- self.votewindow.header_sy = 0.5

    -- self.votewindow.scrollbarline_x = -87
    -- self.votewindow.scrollbarline_y = 10.5
    -- self.votewindow.scrollbarline_sx = 0.2
    -- self.votewindow.scrollbarline_sy = 0.2

    -- self.votewindow.textlable_x = 17
    -- self.votewindow.textlable_y = 17

    -- local letter_w = 7
    -- local letter_h = 9
    -- local row_letter_count = 28
    -- local row_byte_count = row_letter_count * 3

    -- self.votewindow.header_bg = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_bg.tex"))
    -- self.votewindow.header_icon = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_wilson.tex"))
    -- self.votewindow.header_frame = self.votewindow:AddChild(Image("images/avatars.xml", "avatar_frame_white.tex"))
    -- self.votewindow.header_bg:SetPosition(self.votewindow.header_x, self.votewindow.header_y, 0)
    -- self.votewindow.header_bg:SetScale(self.votewindow.header_sx, self.votewindow.header_sy, 0)
    -- self.votewindow.header_icon:SetPosition(self.votewindow.header_x, self.votewindow.header_y, 0)
    -- self.votewindow.header_icon:SetScale(self.votewindow.header_sx, self.votewindow.header_sy, 0)
    -- self.votewindow.header_frame:SetPosition(self.votewindow.header_x, self.votewindow.header_y, 0)
    -- self.votewindow.header_frame:SetScale(self.votewindow.header_sx, self.votewindow.header_sy, 0)

    -- self.votewindow.scrollbarline = self.votewindow:AddChild(Image("images/crafting_menu.xml", "scrollbar_bar.tex"))
    -- self.votewindow.scrollbarline:SetPosition(self.votewindow.scrollbarline_x, self.votewindow.scrollbarline_y, 0)
    -- self.votewindow.scrollbarline:SetScale(self.votewindow.scrollbarline_sx, self.votewindow.scrollbarline_sy, 0)

    -- local labeltext = Zstring("这是一个文本测试,来自于Z.测试时间:2022年12月25日,星期天.hahahahahahahahahahahha,小赤佬,我是小帅翔,帅翔帅翔帅翔.")
    -- labeltext:alignByByteCount(row_byte_count)
    -- local text_len = labeltext:getByteLength()
    -- local show_text = ""
    -- for i=1, text_len/row_byte_count do
    --     show_text = show_text .. labeltext:substrByByteCount(nil, row_byte_count) .. "\n"
    -- end
    -- self.votewindow.label = self.votewindow:AddChild(Text(NEWFONT, 12, show_text, {0, 0, 0 ,1}))
    -- self.votewindow.label:SetPosition(self.votewindow.textlable_x, self.votewindow.textlable_y, 0)
    -- self.votewindow.label:SetRegionSize(letter_w*row_letter_count, (text_len/row_letter_count + 1)*letter_h)

    -- self.votewindow.open = false
    -- self.votewindow:Hide()
    -- return self.votewindow
end

return vote