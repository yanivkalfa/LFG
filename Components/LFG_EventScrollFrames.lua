LFG.EventScrollFrames = { 
  eventSelected = { event = {}, name = '' },
  eventDropDownFocus = { event = {}, name = '' },
  eventList = {},
  filter = nill,
  searchBouncer = nil,
  fetchedInitially = nil,
  newEvent = nil
};

function LFG.EventScrollFrames.resetSelection(event)

  if( not event ) then
    return false
  end

  if( LFG.EventScrollFrames.eventSelected.event.OR ==  event.OR) then
    LFG.EventScrollFrames.eventSelected = { event = {}, name = '' }
  end

  if(LFG.EventScrollFrames.eventDropDownFocus.event.OR ==  event.OR) then
    LFG.EventScrollFrames.eventDropDownFocus = { event = {}, name = '' };
  end

  LFG.EventScrollFrames.updateLFGEvent();

end

function LFG.EventScrollFrames.LFGEventResetSelected()
  for line=1,LFG.Constants.MAX_PAGE_SIZE do
    getglobal("LFGEventItem"..line):SetButtonState("NORMAL");
  end
end

function LFG.EventScrollFrames.LFGEventOnClick(button)
  -- if left we select the row
  if ( button == "LeftButton") then
    LFG.EventScrollFrames.LFGEventResetSelected()
    LFG.EventScrollFrames.eventSelected = { event = this.event, name = this:GetName() };
    if(not this.event.QTE) then
      this:SetButtonState("PUSHED", true);
    end
  else
    CloseDropDownMenus()
    LFG.EventScrollFrames.eventDropDownFocus = { event = this.event, name = this:GetName() };
    ToggleDropDownMenu(1, nil, LFGEventDropDownMenu, "cursor")
  end
end

function LFG.EventScrollFrames.LFGEventCreateToolTip(event)
  local Owner = event.OR;
  local title = event.TT or "";
  local description = event.DC or "";
  local minLevel = event.ML;
  local timeStamp = event.TS;
  local queueTo = LFG.Constants.EVENT_LIST[event.QT].name or "";
  local PIE = event.PIE or 0;
  local toolTop = HIGHLIGHT_FONT_COLOR_CODE..title..FONT_COLOR_CODE_CLOSE.."\n";
  toolTop = toolTop..NORMAL_FONT_COLOR_CODE..queueTo..FONT_COLOR_CODE_CLOSE.."\n";
  toolTop = toolTop..GRAY_FONT_COLOR_CODE.."\""..description.."\""..FONT_COLOR_CODE_CLOSE.."\n\n";
  toolTop = toolTop..NORMAL_FONT_COLOR_CODE.."Minimum Level Required: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..minLevel..FONT_COLOR_CODE_CLOSE.."\n\n";

  toolTop = toolTop..NORMAL_FONT_COLOR_CODE.."Creator: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..Owner..FONT_COLOR_CODE_CLOSE.."\n";
  toolTop = toolTop..NORMAL_FONT_COLOR_CODE.."Created: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..LFG.Utils.String.getTimeString(timeStamp)..FONT_COLOR_CODE_CLOSE.."\n\n";

  toolTop = toolTop..NORMAL_FONT_COLOR_CODE.."Members: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..PIE..FONT_COLOR_CODE_CLOSE.."\n\n";

  return toolTop
end

function LFG.EventScrollFrames.LFGEventOnEnter()
  local toolTip = LFG.EventScrollFrames.LFGEventCreateToolTip(this.event);
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
  GameTooltip:SetText(toolTip);
end

function LFG.EventScrollFrames.LFGEventItemUpdateButton(LFGEventItemName, event)
  local LFGEventItemButton, LFGEventItemButton_Title, LFGEventItemButton_QueueTo,
  LFGEventItemButton_EventMembersCount, LFGEventItemButton_PendingText,
  LFGEventItemButton_PendingTexture, LFGEventItemButton_PendingCancel;

  LFGEventItemButton = getglobal(LFGEventItemName);
  LFGEventItemButton_Title = getglobal(LFGEventItemName.."Title");
  LFGEventItemButton_QueueTo = getglobal(LFGEventItemName.."QueueTo");
  LFGEventItemButton_EventMembersCount = getglobal(LFGEventItemName.."EventMembersCount");
  LFGEventItemButton_PendingText = getglobal(LFGEventItemName.."PendingText");
  LFGEventItemButton_PendingTexture = getglobal(LFGEventItemName.."PendingTexture");
  LFGEventItemButton_PendingCancel = getglobal(LFGEventItemName.."PendingCancel");

  if(event.QTE) then
    LFGEventItemButton_EventMembersCount:Hide();
    LFGEventItemButton_PendingText:Show();
    LFGEventItemButton_PendingTexture:Show();
    LFGEventItemButton_PendingCancel:Show();
    LFGEventItemButton:SetButtonState("NORMAL");
  else
    LFGEventItemButton_EventMembersCount:Show();
    LFGEventItemButton_PendingText:Hide();
    LFGEventItemButton_PendingTexture:Hide();
    LFGEventItemButton_PendingCancel:Hide();
    if (LFGEventItemButton.event.OR == LFG.EventScrollFrames.eventSelected.event.OR) then
      LFGEventItemButton:SetButtonState("PUSHED", true);
    else
      LFGEventItemButton:SetButtonState("NORMAL");
    end
  end

  LFGEventItemButton_Title:SetText(event.TT);
  LFGEventItemButton_QueueTo:SetText(LFG.Constants.EVENT_LIST[event.QT].name);
  LFGEventItemButton_EventMembersCount:SetText(event.PIE);
end

local function filter(index, value)
  if (value.hide) then
    return true;
  end

  local text = LFG.EventScrollFrames.filter;

  if (not text) then
    return false;
  end

  local title = strlower(value.TT);
  local description = strlower(value.DC);
  local queueTo = strlower(LFG.Constants.EVENT_LIST[value.QT].name);

  local inTitle = string.find(title, text) or title == text;
  local inDescription = string.find(description, text) or description == text;
  local inQueueTo = string.find(queueTo, text) or queueTo == text;
  local InLevel = string.find(value.ML, text) or value.ML == text;

  if(not inTitle and not inDescription and not inQueueTo and not InLevel ) then
    return true;
  end
  return false;
end

function LFG.EventScrollFrames.updateLFGEvent()
  -- 1 through 5 of our window to scroll , an index into our data calculated from the scroll offset
  local line, index, LFGEventItemButton, LFGEventItemName, totalResults, eventList, LFGEventItemButton_EventMembersCount;
  eventList = table.filter(LFG.EventScrollFrames.eventList, filter);
  totalResults = table.getn(eventList);

  -- hiding tooltips to avoid incorrect data
  GameTooltip:Hide();

  FauxScrollFrame_Update(LFGEventScrollFrame, totalResults, LFG.Constants.MAX_PAGE_SIZE, LFG.Constants.EVENT_ITEM_HEIGHT);
  for line=1,LFG.Constants.MAX_PAGE_SIZE do
    index = line + FauxScrollFrame_GetOffset(LFGEventScrollFrame);
    LFGEventItemName = "LFGEventItem"..line;
    LFGEventItemButton = getglobal(LFGEventItemName);
    LFGEventItemButton_EventMembersCount = getglobal(LFGEventItemName.."EventMembersCount");

    if ( totalResults > LFG.Constants.MAX_PAGE_SIZE ) then
      LFGEventItemButton:SetWidth(297);
      LFGEventItemButton_EventMembersCount:SetPoint("LEFT", 275, 0);
    else
      LFGEventItemButton:SetWidth(316);
      LFGEventItemButton_EventMembersCount:SetPoint("LEFT", 295, 0);
    end

    if (index <= totalResults) then
      LFGEventItemButton:Show();
      LFGEventItemButton.event = eventList[index];
      LFG.EventScrollFrames.LFGEventItemUpdateButton(LFGEventItemName, LFGEventItemButton.event);
    else
      LFGEventItemButton.event = {};
      LFGEventItemButton:Hide();
    end
  end
end

