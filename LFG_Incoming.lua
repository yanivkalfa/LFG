LFG.Incoming = {};


function LFG.Incoming.P_INVITE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
    return sender == value.OR;
  end);

  if (foundIndex >= 1) then
    LFG.PartyInvitation.show(LFG.EventScrollFrames.eventList[foundIndex]);
  end

end

function LFG.Incoming.P_ACCEPT(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  local foundIndex = table.findIndex(LFG.QueueScrollFrames.queueList, function(index, value)
    return sender == value.OR;
  end);

  local queue = LFG.QueueScrollFrames.queueList[foundIndex];
  if (queue) then
    if(queue.INV and queue.INV.timer) then
      Timer.clearTimer(queue.INV.timer);
    end
    LFG.Actions.Queue.decline(foundIndex);
    local numPartyMembers = GetNumPartyMembers();
    if( numPartyMembers >= 5) then
      ConvertToRaid();
    end
    InviteByName(sender);
    LFG.PartyInvitation.invited = true;
  end

end

function LFG.Incoming.P_DECLINE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  local foundIndex = table.findIndex(LFG.QueueScrollFrames.queueList, function(index, value)
    return sender == value.OR;
  end);

  local queue = LFG.QueueScrollFrames.queueList[foundIndex];
  if (queue) then
    if(queue.INV and queue.INV.timer) then
      Timer.clearTimer(queue.INV.timer);
    end
    LFG.Actions.Queue.decline(foundIndex);
  end

end


function LFG.Incoming.Q_DECLINE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
    return sender == value.OR;
  end);

  if (foundIndex >= 1) then
    local event = LFG.EventScrollFrames.eventList[foundIndex];
    LFG.Actions.Event.cancelQueue(nil, event);
  end
end

function LFG.Incoming.Q_DELETE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if (LFG_Settings.event) then

    local foundIndex = table.findIndex(LFG.QueueScrollFrames.queueList, function(index, value)
      return sender == value.OR;
    end);

    if (foundIndex >= 1) then
      Timer.clearTimer(LFG.QueueScrollFrames.queueList[foundIndex].timer);
      LFG.Actions.Queue.delete(foundIndex);
    end
  end
end

function LFG.Incoming.Q_CREATE_RES(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
    return sender == value.OR;
  end)

  local event = LFG.EventScrollFrames.eventList[foundIndex];
  if (event and event.QTE.requestTimer) then
    Timer.clearTimer(event.QTE.requestTimer);
  end
end

function LFG.Incoming.Q_CREATE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  if ( LFG_Settings.event.ML and LFG_Settings.event.ML >= 1 and LFG_Settings.event.ML > payload.LVL) then
    return false;
  end

  if ( LFG_Settings.event) then

    local foundBlockedUserIndex = table.findIndex(LFG_Settings.eventBlockedUsersList, function(index, username)
      return sender == username;
    end)

    if( foundBlockedUserIndex >= 1 ) then
      return false;
    end

    local foundIndex = table.findIndex(LFG.QueueScrollFrames.queueList, function(index, value)
      return sender == value.OR;
    end);

    if (foundIndex <= 0) then
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
      local pos = table.getn(LFG.QueueScrollFrames.queueList) + 1;
      table.insert(LFG.QueueScrollFrames.queueList, pos, payload);
      LFG.Outgoing:send(LFG.Constants.EVENTS.Q_CREATE_RES, sender, {});
      LFG.Utils.Table.sort(LFG.QueueScrollFrames.queueList, {OB = "TS"});
      LFG.QueueScrollFrames.updateLFGQueue();
    end
  end
end

function LFG.Incoming.Q_REQUEST(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( LFG.Actions.Queue.count >= 1) then
    local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
      return sender == value.OR;
    end)
    local event = LFG.EventScrollFrames.eventList[foundIndex];
    if ( event and event.QTE and event.QTE.queue ) then
      LFG.Outgoing:send(LFG.Constants.EVENTS.Q_CREATE, sender, event.QTE.queue);
    end
  end
end






function LFG.Incoming.E_DELETE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
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

function LFG.Incoming.E_UPDATE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  if ( payload.ML and payload.ML >= 1 and payload.ML > LFG_Settings.character.level) then
    return false;
  end

  local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
    return sender == value.OR;
  end);

  if (foundIndex >= 1) then
    LFG.EventScrollFrames.eventList[foundIndex] = LFG.Utils.Table.extend(LFG.EventScrollFrames.eventList[foundIndex], payload);
    LFG.EventScrollFrames.updateLFGEvent();
  end
end

function LFG.Incoming.E_CREATE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  if ( payload.ML and payload.ML >= 1 and payload.ML > LFG_Settings.character.level) then
    return false;
  end

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

function LFG.Incoming.E_RESPONSE(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)

  if ( payload.ML and payload.ML >= 1 and payload.ML > LFG_Settings.character.level) then
    return false;
  end

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

function LFG.Incoming.E_REQUEST(payload, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  if ( LFG_Settings.event ) then

    local foundIndex = table.findIndex(LFG_Settings.eventBlockedUsersList, function(index, username)
      return sender == username;
    end)

    if( foundIndex >= 1 ) then
      return false;
    end

    LFG.Outgoing:send(LFG.Constants.EVENTS.E_RESPONSE, sender, LFG_Settings.event);
  end
end

