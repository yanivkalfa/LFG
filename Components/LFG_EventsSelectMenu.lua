LFG.EventSelectMenu = {
  currentPage = 6,
  perPage = 11,
  totalEvents = 30;
  last = nil,
  first = nil,
  selected = nil;
  maxWidth = 0;
};

local function findCurrentPageFromLevel(level)
  local faction, factionEventList, found, minLevel, eventName, totalEvents;
  found = 0;
  faction = LFG_Settings.character.faction == "Alliance" and "A" or "H";
  factionEventList = LFG.Constants["EVENT_LIST_HASH_"..faction];
  totalEvents = table.getn(factionEventList);


  for i = 1, totalEvents do
    eventName = factionEventList[i];
    minLevel = LFG.Constants.EVENT_LIST[eventName].minLevel;

    if ( found >= 1 and level < minLevel) then
      return found - 5 >= 6 and found - 5 or 6;
    end

    if ( i == totalEvents ) then
      return i - 5;
    end

    if (level >= minLevel) then
      found = i;
    end

  end
end

function LFG.EventSelectMenu:setCurrentPage(level)
  self.currentPage = level or findCurrentPageFromLevel(LFG_Settings.character.level);
  self.first = self.currentPage <= 6 ;
  self.last = self.currentPage >= self.totalEvents - 6;
end

function LFG.EventSelectMenu.hideAllMenus()
  local button, dropDownList;
  for i = 1, UIDROPDOWNMENU_MAXLEVELS, 1 do
    dropDownList = getglobal("DropDownList"..i);
    if ( i >= UIDROPDOWNMENU_MENU_LEVEL or frame:GetName() ~= UIDROPDOWNMENU_OPEN_MENU ) then
      dropDownList.numButtons = 0;
      dropDownList.maxWidth = 0;
      for j=1, UIDROPDOWNMENU_MAXBUTTONS, 1 do
        button = getglobal("DropDownList"..i.."Button"..j);
        button:Hide();
      end
    end
  end
end

function LFG.EventSelectMenu:refreshMenu()
  self.hideAllMenus();
  self:renderMenuPage();
end

function LFG.EventSelectMenu.resetSelected()
	UIDropDownMenu_SetSelectedID(LFGEventSelectMenu, 0);
end

function LFG.EventSelectMenu.setText(text)
  if(strlen(text) > 33) then
    text = strsub(text, 1, 30).."...";
  end
  UIDropDownMenu_SetText(text, LFGEventSelectMenu);
end

function LFG.EventSelectMenu.OnClick()
  local id, Self, prevPage, nextPage, checkImage, text;
  id = this:GetID();
  Self = LFG.EventSelectMenu;
  
  checkImage = getglobal("DropDownList1Button"..id.."Check");
  if ( this.arg1 == "prev" ) then
    prevPage = Self.currentPage - Self.perPage >= 6 and Self.currentPage - Self.perPage or 6;
    
    Self.resetSelected();
    LFG.EventSelectMenu:setCurrentPage(prevPage);
    LFG.EventSelectMenu:refreshMenu()
    checkImage:SetWidth(0.1);
    checkImage:SetHeight(0.1);
  elseif( this.arg1 == "next" ) then
    nextPage = Self.currentPage + Self.perPage <= (Self.totalEvents-5) and Self.currentPage + Self.perPage or Self.totalEvents - 5;
    
    Self.resetSelected();
    LFG.EventSelectMenu:setCurrentPage(nextPage);
    LFG.EventSelectMenu:refreshMenu()
    checkImage:SetWidth(0.1);
    checkImage:SetHeight(0.1);
  else
    Self.selected = this.arg1;
    LFGEventsCreateButton:Enable();
    --UIDropDownMenu_SetSelectedID(LFGEventSelectMenu, this:GetID());
    text =  LFG.Constants.EVENT_LIST[this.arg1].name;
    LFG.EventSelectMenu.setText(text);
  end
end

function LFG.EventSelectMenu:renderMenuPage()
  local info, startMenuPos, endMenuPos, event, eventName, faction, listFrameName, button, normalText, width;
  faction = LFG_Settings.character.faction == "Alliance" and "A" or "H";
  startMenuPos = self.currentPage - 5;
  endMenuPos = self.currentPage + 5;
  listFrameName = getglobal("DropDownList1"):GetName();
  
  info = {};
  if( self.first ) then
    info.disabled = true;
  end
  info.text = "<<= PREVIUS EVENTS";
  info.arg1 = "prev";
  info.textR = 0.1294;
  info.textG = 1;
  info.textB = 0.1294;
  info.keepShownOnClick = true;
  info.func = LFG.EventSelectMenu.OnClick;
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.text = "PVE Events: ".. self.currentPage-5 .. " - " .. self.currentPage + 5;
  info.isTitle = true;
  UIDropDownMenu_AddButton(info);
  
  for i = startMenuPos, endMenuPos do
    eventName = LFG.Constants["EVENT_LIST_HASH_"..faction][i];
    event = LFG.Constants.EVENT_LIST[eventName] ;
    info = {};
    info.text = event.name;
    info.arg1 = eventName;
    info.justifyH = "LEFT";
    if(self.selected == eventName) then
      info.checked = true;
    end
    info.func = LFG.EventSelectMenu.OnClick;
    UIDropDownMenu_AddButton(info);
    
    
    button = getglobal(listFrameName.."Button"..i+2);
    normalText = getglobal(button:GetName().."NormalText");
    width = normalText:GetWidth() + 60;
    if ( width > self.maxWidth ) then
      self.maxWidth = width;
    end
  end
  
  for i=1, UIDROPDOWNMENU_MAXBUTTONS do
    button = getglobal(listFrameName.."Button"..i);
    button:SetWidth(self.maxWidth);
  end
  getglobal(listFrameName):SetWidth(self.maxWidth+15);
  
  info = {};
  if( self.last ) then
    info.disabled = true;
  end
  info.text = "NEXT EVENTS =>>";
  info.arg1 = "next";
  info.textR = 0.1294;
  info.textG = 1;
  info.textB = 0.1294;
  info.keepShownOnClick = true;
  info.func = LFG.EventSelectMenu.OnClick;
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.text = "";
  info.notClickable = true;
  info.notCheckable = true;
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.text = "PVP Events: ";
  info.isTitle = true;
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.func = LFG.EventSelectMenu.OnClick;
  info.text = LFG.Constants.EVENT_LIST.WG.name;
  info.arg1 = "WG";
  if(self.selected == "WG") then
    info.checked = true;
  end
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.func = LFG.EventSelectMenu.OnClick;
  info.text = LFG.Constants.EVENT_LIST.AB.name;
  info.arg1 = "AB";
  if(self.selected == "AB") then
    info.checked = true;
  end
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.func = LFG.EventSelectMenu.OnClick;
  info.text = LFG.Constants.EVENT_LIST.AV.name;
  info.arg1 = "AV";
  if(self.selected == "AV") then
    info.checked = true;
  end
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.text = "";
  info.notClickable = true;
  info.notCheckable = true;
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.text = "Custom Event: ";
  info.isTitle = true;
  UIDropDownMenu_AddButton(info);
  
  info = {};
  info.func = LFG.EventSelectMenu.OnClick;
  info.text = LFG.Constants.EVENT_LIST.CUS.name;
  info.arg1 = "CUS";
  if(self.selected == "CUS") then
    info.checked = true;
  end
  UIDropDownMenu_AddButton(info);
    
end

function LFG.EventSelectMenu.Initialize()
  LFG.EventSelectMenu.resetSelected()
  LFG.EventSelectMenu:setCurrentPage();
  LFG.EventSelectMenu:renderMenuPage()
end


function LFG.EventSelectMenu.OnLoad()
  UIDropDownMenu_Initialize(LFGEventSelectMenu, LFG.EventSelectMenu.Initialize);
  UIDropDownMenu_SetWidth(270);
  local text = getglobal(LFGEventSelectMenu:GetName().."Text");
  text:SetJustifyH("LEFT");
end