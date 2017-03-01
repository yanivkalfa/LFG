LFG.QueueScrollFrames = { 
  queueSelected = { index=0, name='' },
  queueDropDownFocus = { index=0, name='' },
  queueList = {},
};

function LFG.QueueScrollFrames.LFGQueueResetSelected()
  for line=1,LFG.Constants.MAX_QUEUE_PAGE_SIZE do
    getglobal("LFGQueueItem"..line):SetButtonState("NORMAL");
  end
end

function LFG.QueueScrollFrames.LFGQueueOnClick(button)
  --DEFAULT_CHAT_FRAME:AddMessage("aaaaaaa".. self.GetName());
  -- if left we select the row
  if ( button == "LeftButton") then
    LFG.QueueScrollFrames.LFGQueueResetSelected()
    LFG.QueueScrollFrames.queueSelected = { index=this.queueIndex, name=this:GetName() };
    if(not LFG.QueueScrollFrames.queueList[this.queueIndex].INV) then 
      this:SetButtonState("PUSHED", true);
    end
  else
    CloseDropDownMenus()
    LFG.QueueScrollFrames.queueDropDownFocus = { index=this.queueIndex, name=this:GetName() };
    ToggleDropDownMenu(1, nil, LFGQueueDropDownMenu, "cursor")
  end
end

function LFG.QueueScrollFrames.LFGQueueCreateToolTip(index)
  local Owner = LFG.QueueScrollFrames.queueList[index].OR;
  local Class = LFG.QueueScrollFrames.queueList[index].C;
  local Level = LFG.QueueScrollFrames.queueList[index].LVL or "";
  local NotToLeader = LFG.QueueScrollFrames.queueList[index].NTL;
  local timeStamp = LFG.QueueScrollFrames.queueList[index].TS;
  local color = LFG.Constants.RAID_CLASS_COLORS[Class].colorStr;
  
  local toolTop = "|c"..color..Owner..FONT_COLOR_CODE_CLOSE.."\n";
  toolTop = toolTop..NORMAL_FONT_COLOR_CODE.."Level "..tostring(Level).." "..LFG.Constants.CLASS_LIST[Class]..FONT_COLOR_CODE_CLOSE.."\n";
  toolTop = toolTop..GRAY_FONT_COLOR_CODE.."\""..NotToLeader.."\""..FONT_COLOR_CODE_CLOSE.."\n\n";
  
  toolTop = toolTop..NORMAL_FONT_COLOR_CODE.."Queued: "..FONT_COLOR_CODE_CLOSE..HIGHLIGHT_FONT_COLOR_CODE..LFG.Utils.String.getTimeString(timeStamp)..FONT_COLOR_CODE_CLOSE.."\n\n";
  
  return toolTop
end

function LFG.QueueScrollFrames.LFGQueueOnEnter()
  local toolTip = LFG.QueueScrollFrames.LFGQueueCreateToolTip(this.queueIndex);
  GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
  GameTooltip:SetText(toolTip);
end

--[[
function LFG.QueueScrollFrames.LFGQueueOnLoad()
   for i=1,53 do
    LFG.QueueScrollFrames.queueList[i] = {
      I=i,
      OR="Zeeclienth",
      C="HU",
      NTL="What ever mother fucker pick me",
      TS=1485898756 + i*20,
      LVL=30
    };
    if(i == 13  or i==11 or i ==20) then
      LFG.QueueScrollFrames.queueList[i].INV = true;
    end
  end
  LFGQueueScrollFrame:Show()
end
]]--

function LFG.QueueScrollFrames.LFGQueueItemUpdateButton(LFGQueueItemName, index)
  local LFGQueueItemButton, LFGQueueItemButton_Name,
  LFGQueueItemButton_TanksCountTexture, LFGQueueItemButton_HealersCountTexure,  
  LFGQueueItemButton_DPSCountTexture, LFGQueueItemButton_InviteQueue, 
  LFGQueueItemButton_InviteQueueText, LFGQueueItemButton_DeclineQueue, Class, Level;
  
  LFGQueueItemButton = getglobal(LFGQueueItemName);
  LFGQueueItemButton_Name = getglobal(LFGQueueItemName.."Name");
  LFGQueueItemButton_TanksCountTexture = getglobal(LFGQueueItemName.."TanksCountTexture_PIQ");
  LFGQueueItemButton_HealersCountTexure = getglobal(LFGQueueItemName.."HealersCountTexure_PIQ");
  LFGQueueItemButton_DPSCountTexture = getglobal(LFGQueueItemName.."DPSCountTexture_PIQ");
  LFGQueueItemButton_InviteQueue = getglobal(LFGQueueItemName.."InviteQueue");
  LFGQueueItemButton_InviteQueueText = getglobal(LFGQueueItemName.."InviteQueueText");
  LFGQueueItemButton_DeclineQueue = getglobal(LFGQueueItemName.."DeclineQueue");
  
  if(LFG.QueueScrollFrames.queueList[index].INV) then
    LFGQueueItemButton_InviteQueue:Hide();
    LFGQueueItemButton_DeclineQueue:Hide();
    LFGQueueItemButton_InviteQueueText:Show();
    LFGQueueItemButton:SetButtonState("NORMAL");
  else
    LFGQueueItemButton_InviteQueue:Show();
    LFGQueueItemButton_DeclineQueue:Show();
    LFGQueueItemButton_InviteQueueText:Hide();
    if (LFGQueueItemButton.queueIndex == LFG.QueueScrollFrames.queueSelected.index) then
      LFGQueueItemButton:SetButtonState("PUSHED", true);
    else
      LFGQueueItemButton:SetButtonState("NORMAL");
    end
  end
  
  Class = LFG.QueueScrollFrames.queueList[index].C;
  LFGQueueItemButton_Name:SetText(LFG.QueueScrollFrames.queueList[index].OR);
  LFGQueueItemButton_Name:SetTextColor(LFG.Constants.RAID_CLASS_COLORS[Class].r, LFG.Constants.RAID_CLASS_COLORS[Class].g, LFG.Constants.RAID_CLASS_COLORS[Class].b);
end

function LFG.QueueScrollFrames.updateLFGQueue()
  -- 1 through 5 of our window to scroll , an index into our data calculated from the scroll offset
  local line, index, LFGQueueItemButton, LFGQueueItemName, totalResults;
  totalResults = table.getn(LFG.QueueScrollFrames.queueList);
  
  -- hiding tooltips to avoid incorrect data
  GameTooltip:Hide();
  
  FauxScrollFrame_Update(LFGQueueScrollFrame, totalResults, LFG.Constants.MAX_QUEUE_PAGE_SIZE, LFG.Constants.QUEUE_ITEM_HEIGHT);
  for line=1,LFG.Constants.MAX_QUEUE_PAGE_SIZE do
    index = line + FauxScrollFrame_GetOffset(LFGQueueScrollFrame);
    LFGQueueItemName = "LFGQueueItem"..line;
    LFGQueueItemButton = getglobal(LFGQueueItemName);
    
    if (index <= totalResults) then
      LFGQueueItemButton:Show();
      LFGQueueItemButton.queueIndex = index;
      LFG.QueueScrollFrames.LFGQueueItemUpdateButton(LFGQueueItemName, index);
    else
      LFGQueueItemButton.queueIndex = nil;
      LFGQueueItemButton:Hide();
    end
  end
end