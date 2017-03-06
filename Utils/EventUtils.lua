LFG.Utils.Event = {};
function LFG.Utils.Event.createEvent()
  local event = {
    TT = LFGEventTitle:GetText(),
    DC = LFGEventDescription:GetText(),
    ML = tonumber(LFGEventMinLevel:GetText()),
    QT = LFG.EventSelectMenu.selected,
    PIE = 0,
  };
  
  return event;
end

function LFG.Utils.Event.validateEventInput()
  return LFG.EventSelectMenu.selected;
end