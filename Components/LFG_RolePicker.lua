--[[
  fix bug where role selection is not saved
  add a check that at least 1 role is selected
]]--
LFG.RolePicker = {
  name = "",
  index = ""
};

function LFG.RolePicker.reset()
  LFGRolePickerNoteToLeader:SetText("");
  LFGRoleTankCheckButton:SetChecked(false);
  LFGRoleHealCheckButton:SetChecked(false);
  LFGRoleDPSCheckButton:SetChecked(false);
  
  if(LFG_Settings.lastRoleSelected.T) then
    DEFAULT_CHAT_FRAME:AddMessage("T");
    LFGRoleTankCheckButton:SetChecked(true);
  end
  if(LFG_Settings.lastRoleSelected.H) then
    DEFAULT_CHAT_FRAME:AddMessage("H");
    LFGRoleHealCheckButton:SetChecked(true);
  end
  if(LFG_Settings.lastRoleSelected.D) then
    DEFAULT_CHAT_FRAME:AddMessage("D");
    LFGRoleDPSCheckButton:SetChecked(true);
  end
end

function LFG.RolePicker.fixPresets(fames)
  local famesCount = table.getn(fames);
  
  if(famesCount == 3) then
    fames[1]:SetPoint("TOP", LFGRolePicker, -80, -30);
    fames[2]:SetPoint("TOP", LFGRolePicker, 0, -30);
    fames[3]:SetPoint("TOP", LFGRolePicker, 80, -30);
  elseif(famesCount == 2) then
    fames[1]:SetPoint("TOP", LFGRolePicker, -50, -30);
    fames[2]:SetPoint("TOP", LFGRolePicker, 50, -30);
  else
    fames[1]:SetPoint("TOP", LFGRolePicker, 0, -30);
  end
end

function LFG.RolePicker.prepare()
  local roles = {
    { name = "T", frame=LFGRoleTankCheckButtonFrame },
    { name = "H", frame=LFGRoleHealCheckButtonFrame },
    { name = "D", frame=LFGRoleDPSCheckButtonFrame }
  };
  local frames = {};
  
  local class = LFG.Constants.ROLE_FOR_CLASS_LIST[LFG_Settings.character.class], role;
  for i = 1, 3 do
    role = roles[i];
    role.frame:Hide();
    if( class[role.name] ) then
      role.frame:Show();
      table.insert(frames, table.getn(frames) + 1, role.frame);
    end
  end
  
  LFG.RolePicker.fixPresets(frames);
end

function LFG.RolePicker.getRoles()
  return { 
    T = LFGRoleTankCheckButton:GetChecked(),
    H = LFGRoleHealCheckButton:GetChecked(),
    D = LFGRoleDPSCheckButton:GetChecked()
  };
end
function LFG.RolePicker.getNoteToLeader()
  LFGRolePickerNoteToLeader:GetText();
end

function LFG.RolePicker.roleSelected(roles)
  return roles.T or roles.H or roles.D
end

function LFG.RolePicker.signUp()
  local name = LFG.RolePicker.name;
  local index = LFG.RolePicker.index;
  local event = LFG.EventScrollFrames.eventList[index];
  local roles = LFG.RolePicker.getRoles();
  if( not event or not LFG.RolePicker.roleSelected(roles) ) then
    return false;
  end
  local noteToLeader = LFG.RolePicker.getNoteToLeader();
  event.QTE = { expireAt = time() + 300, timer = Timer.setTimeout(299, LFG.Actions.Queue.cancel, { name, index } )};
  -- send server cancel request
  LFG.EventScrollFrames.LFGEventItemUpdateButton(name, index);
  
  LFGRolePicker:Hide();
end

function LFG.RolePicker.cancel()
  LFGRolePicker:Hide();
end

function LFG.RolePicker.Show(name, index)
  LFG.RolePicker.name = name;
  LFG.RolePicker.index = index;
  local event = LFG.EventScrollFrames.eventList[index];
  LFG.RolePicker.reset()
  LFG.RolePicker.prepare()
  LFGRolePicker:Show();
end