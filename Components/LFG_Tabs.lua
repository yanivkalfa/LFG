LFG.Tabs = {
  active = "events.view"
};

function LFG.Tabs.update()
  LFGFrameTopLeft:Show();
  LFGFrameTopRight:Show();
  LFGFrameBotLeft:Show();
  LFGFrameBotRight:Show();

  if(not LFG_Settings.character.isValid and LFG.Tabs.active ~= "invalidUser") then
    LFG.Tabs.select("invalidUser");
    return;
  end

  if(LFG.Tabs.active == "events.view") then

    LFGEventsView_Tab:Show();
    LFGEventsCreate_Tab:Hide();
    LFGEventsViewQueues_Tab:Hide();
    LFGInvalidUser_Tab:Hide();
    LFGCTitleText:SetText("LFG - Custom Events");
    LFGFrameBotLeft:SetTexture("Interface\\TalentFrame\\UI-TalentFrame-BotLeft");
    LFGFrameBotRight:SetTexture("Interface\\TalentFrame\\UI-TalentFrame-BotRight");
    LFGQueueFrameTexture:Hide();

  elseif(LFG.Tabs.active == "events.create") then

    if(LFG_Settings.event) then
      LFG.Tabs.select("events.viewQueues");
      return;
    end

    LFG.EventSelectMenu.selected = nil;
    LFG.EventSelectMenu.setText('');
    LFGEventTitle:SetText("");
    LFGEventDescription:SetText("");
    LFGEventMinLevel:SetText("");

    LFGEventsView_Tab:Hide();
    LFGEventsCreate_Tab:Show();
    LFGEventsCreateButton:SetText('Create');
    LFGEventSelectMenuButton:Enable()
    LFGEventsViewQueues_Tab:Hide();
    LFGInvalidUser_Tab:Hide();
    LFGCTitleText:SetText("LFG - Create New Custom Events");
    LFGFrameBotLeft:SetTexture("Interface\\PaperDollInfoFrame\\SkillFrame-BotLeft");
    LFGFrameBotRight:SetTexture("Interface\\PaperDollInfoFrame\\SkillFrame-BotRight");
    LFGQueueFrameTexture:Hide();

  elseif(LFG.Tabs.active == "events.edit") then

    if(not LFG_Settings.event) then
      LFG.Tabs.select("events.view");
      return;
    end

    LFG.EventSelectMenu.selected = LFG_Settings.event.QT;
    local text =  LFG.Constants.EVENT_LIST[LFG_Settings.event.QT].name;
    LFG.EventSelectMenu.setText(text);
    LFGEventTitle:SetText(LFG_Settings.event.TT or "");
    LFGEventDescription:SetText(LFG_Settings.event.DC or "");
    LFGEventMinLevel:SetText(LFG_Settings.event.ML or "");

    LFGEventsView_Tab:Hide();
    LFGEventsCreate_Tab:Show();
    LFGEventsCreateButton:SetText('Update');
    LFGEventSelectMenuButton:Disable()
    LFGEventsViewQueues_Tab:Hide();
    LFGInvalidUser_Tab:Hide();
    LFGCTitleText:SetText("LFG - Edit My Custom Events");
    LFGFrameBotLeft:SetTexture("Interface\\PaperDollInfoFrame\\SkillFrame-BotLeft");
    LFGFrameBotRight:SetTexture("Interface\\PaperDollInfoFrame\\SkillFrame-BotRight");
    LFGQueueFrameTexture:Hide();

  elseif(LFG.Tabs.active == "events.viewQueues") then

    if(not LFG_Settings.event) then
      LFG.Tabs.select("events.create");
      return;
    end

    LFGEventsView_Tab:Hide();
    LFGEventsCreate_Tab:Hide();
    LFGEventsViewQueues_Tab:Show();
    LFGInvalidUser_Tab:Hide();
    LFGCTitleText:SetText("LFG - Custom Event: Queues");
    LFGQueueFrameTexture:Show();
    LFGFrameTopLeft:Hide();
    LFGFrameTopRight:Hide();
    LFGFrameBotLeft:Hide();
    LFGFrameBotRight:Hide();


    local title = LFG_Settings.event.TT or "";
    local description = LFG_Settings.event.DC or "";
    local minLevel = LFG_Settings.event.ML
    local minLevel = minLevel and minLevel >= 1 and " ("..minLevel..")" or "";
    local queueTo = LFG.Constants.EVENT_LIST[LFG_Settings.event.QT].name or "";
    LFGEventsViewQueuesEventTitle:SetTextHeight(15);
    LFGEventsViewQueuesEventTitle:SetText(title);
    LFGEventsViewQueuesEventQueueToAndDescription:SetText(HIGHLIGHT_FONT_COLOR_CODE..queueTo..minLevel..FONT_COLOR_CODE_CLOSE..GRAY_FONT_COLOR_CODE.." - \""..description.."\""..FONT_COLOR_CODE_CLOSE);


  elseif(LFG.Tabs.active == "invalidUser") then
    LFGEventsView_Tab:Hide();
    LFGEventsCreate_Tab:Hide();
    LFGEventsViewQueues_Tab:Hide();
    LFGInvalidUser_Tab:Show();
    LFGCTitleText:SetText("LFG - Invalid user");
    LFGFrameBotLeft:SetTexture("Interface\\TaxiFrame\\UI-TaxiFrame-BotLeft");
    LFGFrameBotRight:SetTexture("Interface\\TaxiFrame\\UI-TaxiFrame-BotRight");
    LFGQueueFrameTexture:Hide();
  --[[
  elseif(LFG.Tabs.active == "queue") then
    LFGEventsView_Tab:Hide();
    LFGEventsCreate_Tab:Hide();
    LFGEventsViewQueues_Tab:Hide();
    --LFGInvalidUser_Tab:Show();
    LFGCTitleText:SetText("LFG - Dungeons Finder");
    LFGFrameBotLeft:SetTexture("Interface\\TaxiFrame\\UI-TaxiFrame-BotLeft");
    LFGFrameBotRight:SetTexture("Interface\\TaxiFrame\\UI-TaxiFrame-BotRight");
    LFGQueueFrameTexture:Hide();
    ]]--
  end
end

function LFG.Tabs.select(tabName)
  LFG.Tabs.active = tabName;
  LFG.Tabs.update();
end


