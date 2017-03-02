LFG.Incoming = {};

function LFG.Incoming.EQDRS(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
end

function LFG.Incoming.EQCRS(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
end

function LFG.Incoming.EQRS(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
end

function LFG.Incoming.EDRQ(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( sender ~=  LFG_Settings.character.name) then
    local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
        return sender == value.OR;
    end);
  
    if (foundIndex >= 1) then
      local event = LFG.EventScrollFrames.eventList[foundIndex];
      LFG.EventScrollFrames.resetSelection(event);
      LFG.RolePicker.reset(event);
      table.remove(LFG.EventScrollFrames.eventList, foundIndex);
      LFG.EventScrollFrames.updateLFGEvent();
      -- update queue status for the "searching eye"
    end
  end
end

function LFG.Incoming.EURS(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  
  if ( sender ~=  LFG_Settings.character.name) then
    local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
        return sender == value.OR;
    end);
  
    if (foundIndex >= 1) then
      LFG.EventScrollFrames.eventList[foundIndex] = LFG.Utils.Table.extend(LFG.EventScrollFrames.eventList[foundIndex], payload);
      LFG.EventScrollFrames.updateLFGEvent();
    end
  end
end

function LFG.Incoming.ECRS(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( sender ~= LFG_Settings.character.name) then
    local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
        return sender == value.OR;
    end)
  
    if (foundIndex <= 0 ) then
      local pos = table.getn(LFG.EventScrollFrames.eventList) + 1;
      payload.OR = sender;
      payload.TS = time();
      table.insert(LFG.EventScrollFrames.eventList, pos, payload);
      LFG.Utils.Table.sort(LFG.EventScrollFrames.eventList, {OB = "TS"});
      LFG.EventScrollFrames.updateLFGEvent();
    else
      LFG.EventScrollFrames.eventList[foundIndex] = LFG.Utils.Table.extend(LFG.EventScrollFrames.eventList[foundIndex], payload);
      LFG.EventScrollFrames.updateLFGEvent();
    end
  end
end

function LFG.Incoming.ERS(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( sender ~=  LFG_Settings.character.name) then
    local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
        return sender == value.OR;
    end)
  
    if (foundIndex <= 0 ) then
      local pos = table.getn(LFG.EventScrollFrames.eventList) + 1;
      payload.OR = sender;
      payload.TS = time();
      table.insert(LFG.EventScrollFrames.eventList, pos, payload);
      LFG.Utils.Table.sort(LFG.EventScrollFrames.eventList, {OB = "TS"});
      LFG.EventScrollFrames.updateLFGEvent();
    end
  end
end

function LFG.Incoming.ERQ(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( sender ~=  LFG_Settings.character.name and LFG_Settings.event) then
    LFG.Outgoing:send(LFG.Constants.EVENTS.ERS, sender, LFG_Settings.event);
  end
end

