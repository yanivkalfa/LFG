LFG.QueueDropDownMenu = {};

function LFG.QueueDropDownMenu.OnClick()
  local id = this:GetID();
  local name = LFG.QueueScrollFrames.queueDropDownFocus.name;
  local index = LFG.QueueScrollFrames.queueDropDownFocus.index;
  local queue = LFG.QueueScrollFrames.queueList[index];

  if(this.arg1 == "signup") then
    LFG.RolePicker.Show(name, index);
  elseif(this.arg1 == "whisperOwner") then
    LFG.Whisper.show(queue.OR);
  elseif(this.arg1 == "cancel") then
    LFG.Actions.Queue.cancel(name, index);
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
    info.text = "Whisper Player";
    info.arg1 = "whisperOwner";
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