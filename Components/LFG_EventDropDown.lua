LFG.EventDropDownMenu = {};

function LFG.EventDropDownMenu.OnClick()
	local id = this:GetID();
  local name = LFG.EventScrollFrames.eventDropDownFocus.name;
  local event = LFG.EventScrollFrames.eventDropDownFocus.event;
  
	if ( id == 1 ) then
    if(this.arg1 == "signup") then
      LFG.RolePicker.Show(name, event);
      
    elseif(this.arg1 == "cancel") then 
      LFG.Actions.Queue.cancel(name, event);
    end
  end
end

function LFG.EventDropDownMenu.Initialize()
  local event = LFG.EventScrollFrames.eventDropDownFocus.event;

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