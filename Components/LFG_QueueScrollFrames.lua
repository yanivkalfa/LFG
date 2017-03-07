LFG.QueueScrollFrames = { 
  queueSelected = { index=0, name='' },
  queueDropDownFocus = { index=0, name='' },
  queueList = {},
  queueToAdd = {},
  fetchedInitially = nil
};

function LFG.QueueScrollFrames.LFGQueueResetSelected()
  for line=1,LFG.Constants.MAX_QUEUE_PAGE_SIZE do
    getglobal("LFGQueueItem"..line):SetButtonState("NORMAL");
  end
end

function LFG.QueueScrollFrames.LFGQueueOnClick(button)
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

function LFG.QueueScrollFrames.LFGQueueItemUpdateButton(LFGQueueItemName, index)
  local queue, LFGQueueItemButton, LFGQueueItemButton_Name,
  LFGQueueItemButton_TanksTexture, LFGQueueItemButton_HealersTexture,
  LFGQueueItemButton_DPSTexture, LFGQueueItemButton_InviteQueue,
  LFGQueueItemButton_InviteQueueText, LFGQueueItemButton_DeclineQueue, Class, Level;

  queue = LFG.QueueScrollFrames.queueList[index];
  LFGQueueItemButton = getglobal(LFGQueueItemName);
  LFGQueueItemButton_Name = getglobal(LFGQueueItemName.."Name");
  LFGQueueItemButton_TanksTexture = getglobal(LFGQueueItemName.."TanksTexture");
  LFGQueueItemButton_HealersTexture = getglobal(LFGQueueItemName.."HealersTexture");
  LFGQueueItemButton_DPSTexture = getglobal(LFGQueueItemName.."DPSTexture");
  LFGQueueItemButton_InviteQueue = getglobal(LFGQueueItemName.."InviteQueue");
  LFGQueueItemButton_InviteQueueText = getglobal(LFGQueueItemName.."InviteQueueText");
  LFGQueueItemButton_DeclineQueue = getglobal(LFGQueueItemName.."DeclineQueue");

  LFGQueueItemButton_TanksTexture:Hide();
  LFGQueueItemButton_HealersTexture:Hide();
  LFGQueueItemButton_DPSTexture:Hide();
  if(queue.R.T) then
    LFGQueueItemButton_TanksTexture:Show();
  end
  if(queue.R.H) then
    LFGQueueItemButton_HealersTexture:Show();
  end
  if(queue.R.D) then
    LFGQueueItemButton_DPSTexture:Show();
  end

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
  
  Class = queue.C;
  LFGQueueItemButton_Name:SetText(queue.OR);
  LFGQueueItemButton_Name:SetTextColor(LFG.Constants.RAID_CLASS_COLORS[Class].r, LFG.Constants.RAID_CLASS_COLORS[Class].g, LFG.Constants.RAID_CLASS_COLORS[Class].b);
end

function LFG.QueueScrollFrames.updateLFGQueue()
  local line, index, LFGQueueItemButton, LFGQueueItemName, totalResults, LFGQueueItemButton_InviteQueue;
  totalResults = table.getn(LFG.QueueScrollFrames.queueList);
  
  -- hiding tooltips to avoid incorrect data
  GameTooltip:Hide();
  
  FauxScrollFrame_Update(LFGQueueScrollFrame, totalResults, LFG.Constants.MAX_QUEUE_PAGE_SIZE, LFG.Constants.QUEUE_ITEM_HEIGHT);
  for line=1,LFG.Constants.MAX_QUEUE_PAGE_SIZE do
    index = line + FauxScrollFrame_GetOffset(LFGQueueScrollFrame);
    LFGQueueItemName = "LFGQueueItem"..line;
    LFGQueueItemButton = getglobal(LFGQueueItemName);
    LFGQueueItemButton_InviteQueue = getglobal(LFGQueueItemName.."InviteQueue");

    if ( totalResults > LFG.Constants.MAX_QUEUE_PAGE_SIZE ) then
      LFGQueueItemButton:SetWidth(297);
      LFGQueueItemButton_InviteQueue:SetPoint("RIGHT", LFGQueueItemButton, "RIGHT", -35, 0);
    else
      LFGQueueItemButton:SetWidth(314);
      LFGQueueItemButton_InviteQueue:SetPoint("RIGHT", LFGQueueItemButton, "RIGHT", -30, 0);
    end
    
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