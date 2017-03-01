LFG.EventScrollFrames = { 
  eventSelected = { index=0, name='' },
  eventDropDownFocus = { index=0, name='' },
  eventList = {},
  eventListBackup = nil,
  searchBouncer = nil,
  fatchedInitially = nil
};

function LFG.EventScrollFrames.LFGEventQueueToEvent(name, index)
  
end

function LFG.EventScrollFrames.LFGEventUnQueueToEvent(name, index)
  
end


function LFG.EventScrollFrames.LFGEventResetSelected()
  for line=1,LFG.Constants.MAX_PAGE_SIZE do
    getglobal("LFGEventItem"..line):SetButtonState("NORMAL");
  end
end

function LFG.EventScrollFrames.LFGEventOnClick(button)
  --DEFAULT_CHAT_FRAME:AddMessage("aaaaaaa".. self.GetName());
  -- if left we select the row
  if ( button == "LeftButton") then
    LFG.EventScrollFrames.LFGEventResetSelected()
    LFG.EventScrollFrames.eventSelected = { index=this.eventIndex, name=this:GetName() };
    if(not LFG.EventScrollFrames.eventList[this.eventIndex].QTE) then 
      this:SetButtonState("PUSHED", true);
    end
  else
    CloseDropDownMenus()
    LFG.EventScrollFrames.eventDropDownFocus = { index=this.eventIndex, name=this:GetName() };
    ToggleDropDownMenu(1, nil, LFGEventDropDownMenu, "cursor")
  end
end

function LFG.EventScrollFrames.LFGEventCreateToolTip(index)
  local Owner = LFG.EventScrollFrames.eventList[index].OR;
  local title = LFG.EventScrollFrames.eventList[index].TT or "";
  local description = LFG.EventScrollFrames.eventList[index].DC or "";
  local minLevel = LFG.EventScrollFrames.eventList[index].ML;
  local timeStamp = LFG.EventScrollFrames.eventList[index].TS;
  local queueTo = LFG.Constants.EVENT_LIST[LFG.EventScrollFrames.eventList[index].QT].name or "";
  local PIE = LFG.EventScrollFrames.eventList[index].PIE or 0;
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
  local toolTip = LFG.EventScrollFrames.LFGEventCreateToolTip(this.eventIndex);
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
  GameTooltip:SetText(toolTip);
end

--[[
function LFG.EventScrollFrames.LFGEventOnLoad()
   for i=1,53 do
    LFG.EventScrollFrames.eventList[i] = {
      I=i,
      OR="Zeeclienth",
      TT="Some Title_"..i,
      DC="Some Description_"..i,
      F="H",
      ML="25",
      QT="ONY",
      TS=1485898756 + i*20,
      PIQ={ T=1, H=1, D=3, TT=5 }
    };
    if(i == 13  or i==11 or i ==20) then
      LFG.EventScrollFrames.eventList[i].QTE = true;
    end
  end
  LFGEventScrollFrame:Show()
end
]]--

function LFG.EventScrollFrames.LFGEventItemUpdateButton(LFGEventItemName, index)
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
  
  if(LFG.EventScrollFrames.eventList[index].QTE) then
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
    if (LFGEventItemButton.eventIndex == LFG.EventScrollFrames.eventSelected.index) then
      LFGEventItemButton:SetButtonState("PUSHED", true);
    else
      LFGEventItemButton:SetButtonState("NORMAL");
    end
  end
  
  LFGEventItemButton_Title:SetText(LFG.EventScrollFrames.eventList[index].TT);
  LFGEventItemButton_QueueTo:SetText(LFG.Constants.EVENT_LIST[LFG.EventScrollFrames.eventList[index].QT].name);
  LFGEventItemButton_EventMembersCount:SetText(LFG.EventScrollFrames.eventList[index].PIE);
end

function LFG.EventScrollFrames.updateLFGEvent()
  -- 1 through 5 of our window to scroll , an index into our data calculated from the scroll offset
  local line, index, LFGEventItemButton, LFGEventItemName, totalResults;
  totalResults = table.getn(LFG.EventScrollFrames.eventList);
  
  -- hiding tooltips to avoid incorrect data
  GameTooltip:Hide();
  
  FauxScrollFrame_Update(LFGEventScrollFrame, totalResults, LFG.Constants.MAX_PAGE_SIZE, LFG.Constants.EVENT_ITEM_HEIGHT);
  for line=1,LFG.Constants.MAX_PAGE_SIZE do
    index = line + FauxScrollFrame_GetOffset(LFGEventScrollFrame);
    LFGEventItemName = "LFGEventItem"..line;
    LFGEventItemButton = getglobal(LFGEventItemName);
    
    if (index <= totalResults) then
      LFGEventItemButton:Show();
      LFGEventItemButton.eventIndex = index;
      LFG.EventScrollFrames.LFGEventItemUpdateButton(LFGEventItemName, index);
    else
      LFGEventItemButton.eventIndex = nil;
      LFGEventItemButton:Hide();
    end
  end
end

