LFG.EventDropDownMenu = {};

function LFG.EventDropDownMenu.OnClick()
  --DEFAULT_CHAT_FRAME:AddMessage("UIDROPDOWNMENU_MENU_VALUE".. UIDROPDOWNMENU_MENU_VALUE);
	local id = this:GetID();
  local name = LFG.EventScrollFrames.eventDropDownFocus.name;
  local index = LFG.EventScrollFrames.eventDropDownFocus.index;
  
	if ( id == 1 ) then
    if(this.arg1 == "signup") then
      LFG.RolePicker.Show(name, index);
      
    elseif(this.arg1 == "cancel") then 
      LFG.Actions.Queue.cancel(name, index);
    end
  end
end

function LFG.EventDropDownMenu.Initialize()
	local index = LFG.EventScrollFrames.eventDropDownFocus.index;
  local event = LFG.EventScrollFrames.eventList[index];
  
	local info = {};
  info.func = LFG.EventDropDownMenu.OnClick;
  if(not event or not event.QTE) then
    info.text = "Sign Up";
    info.arg1 = "signup";
    UIDropDownMenu_AddButton(info);
  end
	
  if(event and event.QTE) then
    info.text = "Cancel";
    info.arg1 = "cancel";
    UIDropDownMenu_AddButton(info);
  end
end

function LFG.EventDropDownMenu.OnLoad()
	UIDropDownMenu_Initialize(this, LFG.EventDropDownMenu.Initialize, "MENU");
end