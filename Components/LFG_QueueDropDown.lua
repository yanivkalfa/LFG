LFG.QueueDropDownMenu = {};

function LFG.QueueDropDownMenu.OnClick()
  local id = this:GetID();
  local name = LFG.QueueScrollFrames.queueDropDownFocus.name;
  local index = LFG.QueueScrollFrames.queueDropDownFocus.index;
  local queue = LFG.QueueScrollFrames.queueList[index];

  if(this.arg1 == "invite") then
    LFG.Actions.Party.invite(name, index);
  elseif(this.arg1 == "whisperOwner") then
    LFG.Whisper.show(queue.OR);
  end
end


function LFG.QueueDropDownMenu.Initialize()
  local index = LFG.QueueScrollFrames.queueDropDownFocus.index;
  local queue = LFG.QueueScrollFrames.queueList[index];

  local info = {};
  info.func = LFG.QueueDropDownMenu.OnClick;
  if(not queue or not queue.INV) then
    info.text = "Invite";
    info.arg1 = "invite";
    UIDropDownMenu_AddButton(info);
    info.text = "Whisper Player";
    info.arg1 = "whisperOwner";
    UIDropDownMenu_AddButton(info);
  end

  if(queue and queue.INV) then
    info.text = "Whisper Player";
    info.arg1 = "whisperOwner";
    UIDropDownMenu_AddButton(info);
  end
end

function LFG.QueueDropDownMenu.OnLoad()
  UIDropDownMenu_Initialize(this, LFG.QueueDropDownMenu.Initialize, "MENU");
end
