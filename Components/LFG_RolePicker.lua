LFG.RolePicker = {
  name = "",
  event = nil
};

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

  local frames, class, role;
  frames = {};
  class = LFG.Constants.ROLE_FOR_CLASS_LIST[LFG_Settings.character.class];
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
  return LFGRolePickerNoteToLeader:GetText();
end

function LFG.RolePicker.roleSelected(roles)
  return roles.T or roles.H or roles.D
end

function LFG.RolePicker.signUp()
  local event = LFG.RolePicker.event;
  local roles = LFG.RolePicker.getRoles();
  if( not event or not LFG.RolePicker.roleSelected(roles) ) then
    return false;
  end
  LFG.Actions.Queue.create();
  LFGRolePicker:Hide();
end

function LFG.RolePicker.reset(event)
  if ( event and LFG.RolePicker.event and LFG.RolePicker.event.OR == event.OR) then
    LFG.RolePicker.cancel()
  end
end

function LFG.RolePicker.cancel()
  LFGRolePicker:Hide();
  LFG.RolePicker.name = "";
  LFG.RolePicker.name = nil;
  LFGRolePickerNoteToLeader:SetText("");
  LFGRoleTankCheckButton:SetChecked(false);
  LFGRoleHealCheckButton:SetChecked(false);
  LFGRoleDPSCheckButton:SetChecked(false);

  if(LFG_Settings.lastRoleSelected.T) then
    LFGRoleTankCheckButton:SetChecked(true);
  end
  if(LFG_Settings.lastRoleSelected.H) then
    LFGRoleHealCheckButton:SetChecked(true);
  end
  if(LFG_Settings.lastRoleSelected.D) then
    LFGRoleDPSCheckButton:SetChecked(true);
  end
end

function LFG.RolePicker.Show(name, event)
  LFG.RolePicker.cancel()
  LFG.RolePicker.name = name;
  LFG.RolePicker.event = event;
  LFG.RolePicker.prepare()
  LFGRolePicker:Show();
end