local TEMPLATES = require "widgets/redux/templates"
-- local TestPanel = require "screen/panel"

-- AddClassPostConstruct("screens/playerhud", function(self)
--     function self:ShowPanel()
--         self.testpanel = TestPanel(self.owner)
--         self.testpanel:SetPosition(300,300)
--         TheFrontEnd:PushScreen(self.testpanel)
--         return self.testpanels
--     end
    
--     self.openbutton = self:AddChild(TEMPLATES.StandardButton(function() self:ShowPanel() end, "Open", {100, 50}))
--     self.openbutton:SetPosition(100,100)
-- end
-- )

local function fn(self)
    function self:ShowScreen()
        self.screenroot = TEMPLATES.ScreenRoot()

        function self.screenroot:OnBecomeActive()
            TheSim:SetUIRoot(self.inst.entity)
            if self.last_focus and self.last_focus.inst.entity:IsValid() then
                self.last_focus:SetFocus()
            else
                self.last_focus = nil
                if self.default_focus then
                    self.default_focus:SetFocus()
                end
            end
        end

        function self.screenroot:OnBecomeInactive()
            self.last_focus = self:GetDeepestFocus()
        end

        function self.screenroot:OnUpdate(dt)
            return true
        end
            
        function self.screenroot:OnDestroy()
            self:Kill()
        end

        self.screenroot.bg = self.screenroot:AddChild(TEMPLATES.LoaderBackground("loading_pigking"))
        self.screenroot.closebtn = self.screenroot:AddChild(TEMPLATES.StandardButton(function() TheFrontEnd:PopScreen(self.screenroot) end, "close", {100, 50}))
        TheFrontEnd:PushScreen(self.screenroot)
        return self.screenroot
    end

    self.openbtn = self:AddChild(TEMPLATES.StandardButton(function() self:ShowScreen() end, "open", {100, 50}))
    self.openbtn:SetPosition(100,100)
end

AddClassPostConstruct("screens/playerhud", fn)