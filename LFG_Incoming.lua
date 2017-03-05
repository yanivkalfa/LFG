LFG.Incoming = {};



function LFG.Incoming.EQDRQ(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
end


function LFG.Incoming.Q_DECLINE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( sender ~=  LFG_Settings.character.name) then
    local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
      return sender == value.OR;
    end);

    if (foundIndex >= 1) then
      local event = LFG.EventScrollFrames.eventList[foundIndex];
      LFG.Actions.Event.cancelQueue(nil, event, true);
    end
  end
end
function LFG.Incoming.Q_ACCEPT(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8) end
function LFG.Incoming.Q_DELETE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  if ( sender ~=  LFG_Settings.character.name and LFG_Settings.event) then

    local foundIndex = table.findIndex(LFG.QueueScrollFrames.queueList, function(index, value)
      return sender == value.OR;
    end);

    DEFAULT_CHAT_FRAME:AddMessage("foundIndex, ".. tostring(foundIndex));
    if (foundIndex >= 1) then
      Timer.clearTimer(LFG.QueueScrollFrames.queueList[foundIndex].timer);
      LFG.Actions.Queue.delete(foundIndex);
    end
  end

end

function LFG.Incoming.Q_CREATE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( sender ~=  LFG_Settings.character.name and LFG_Settings.event) then

    local foundIndex = table.findIndex(LFG.QueueScrollFrames.queueList, function(index, value)
      return sender == value.OR;
    end);

    if (foundIndex <= 1) then
      payload.OR = sender;
      payload.TS = time();
      payload.timer = Timer.setTimeout(LFG.Constants.QUEUE_TIMEOUT, function()
        local foundIndex = table.findIndex(LFG.QueueScrollFrames.queueList, function(index, value)
          return sender == value.OR;
        end);

        if (foundIndex >= 1) then
          LFG.Actions.Queue.delete(foundIndex);
          LFG.Outgoing:send(LFG.Constants.EVENTS.Q_DECLINE, sender, {});
        end
      end);

      local index, name, level, class = LFG.Utils.Friend.getFriendInfoFromList(sender);
      DEFAULT_CHAT_FRAME:AddMessage("index, name, level, class: "..tostring(index)..", "..tostring(name)..", "..tostring(level)..", "..tostring(class));
      if( index ) then
        payload.C = LFG.Constants.CLASS_LIST_MAP[class];
        payload.LVL = level;
        local pos = table.getn(LFG.QueueScrollFrames.queueList) + 1;
        table.insert(LFG.QueueScrollFrames.queueList, pos, payload);
        LFG.Utils.Table.sort(LFG.QueueScrollFrames.queueList, {OB = "TS"});
        LFG.QueueScrollFrames.updateLFGQueue();
        return;
      end

      LFG.QueueScrollFrames.queueToAdd = payload;
      LFG.Utils.Friend.addFriendCheck(sender);
    end
  end


end
function LFG.Incoming.Q_RESPONSE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8) end
function LFG.Incoming.Q_REQUEST(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8) end






function LFG.Incoming.E_DELETE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
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

function LFG.Incoming.E_UPDATE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  
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

function LFG.Incoming.E_CREATE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
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

function LFG.Incoming.E_RESPONSE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
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

function LFG.Incoming.E_REQUEST(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( sender ~=  LFG_Settings.character.name and LFG_Settings.event) then
    LFG.Outgoing:send(LFG.Constants.EVENTS.E_RESPONSE, sender, LFG_Settings.event);
  end
end

