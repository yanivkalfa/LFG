LFG.QueueDropDownMenu = {};

function LFG.QueueDropDownMenu.OnClick()
  --DEFAULT_CHAT_FRAME:AddMessage("UIDROPDOWNMENU_MENU_VALUE".. UIDROPDOWNMENU_MENU_VALUE);
	local id = this:GetID();
  local name = LFG.QueueScrollFrames.queueDropDownFocus.name;
  local index = LFG.QueueScrollFrames.queueDropDownFocus.index;
  
	if ( id == 1 ) then
    if(this.arg1 == "signup") then
      LFG.RolePicker.Show(name, index);
      
    elseif(this.arg1 == "cancel") then 
      LFG.Actions.Queue.cancel(name, index);
    end
  end
end

function LFG.QueueDropDownMenu.Initialize()
	local index = LFG.QueueScrollFrames.queueDropDownFocus.index;
  local queue = LFG.QueueScrollFrames.queueList[index];
  
	local info = {};
  info.func = LFG.QueueDropDownMenu.OnClick;
  if(not queue or not queue.QTE) then
    info.text = "Sign Up";
    info.arg1 = "signup";
    UIDropDownMenu_AddButton(info);
  end
	
  if(queue and queue.QTE) then
    info.text = "Cancel";
    info.arg1 = "cancel";
    UIDropDownMenu_AddButton(info);
  end
end

function LFG.QueueDropDownMenu.OnLoad()
	UIDropDownMenu_Initialize(this, LFG.QueueDropDownMenu.Initialize, "MENU");
end