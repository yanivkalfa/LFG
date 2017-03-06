LFG.Actions.Event = {};
local tableUtils = LFG.Utils.Table;
local eventUtils = LFG.Utils.Events;

function LFG.Actions.Event.search()
  if(LFG.EventScrollFrames.searchBouncer) then
    Timer.clearTimer(LFG.EventScrollFrames.searchBouncer);
  end
  
  local text = strlower(LFGEventsViewSearch:GetText());
  if(strlen(text) <= 0) then
    LFG.Actions.Event.clearSearch();
    return false;
  end
  
  LFG.EventScrollFrames.searchBouncer = Timer.setTimeout(1, function()
      LFG.EventScrollFrames.filter = text;
      LFG.EventScrollFrames.updateLFGEvent();
      Timer.clearTimer(LFG.EventScrollFrames.searchBouncer);
  end)
end

function LFG.Actions.Event.clearSearch()
  LFG.EventScrollFrames.filter = nil;
  LFG.EventScrollFrames.updateLFGEvent();
  LFGEventsViewSearch:SetText("");
end

function LFG.Actions.Event.fetch()
  LFG.Outgoing:send(LFG.Constants.EVENTS.E_REQUEST, nil, {});
end

function LFG.Actions.Event.create()
  local event = LFG.Utils.Event.createEvent();
  LFG.Outgoing:send(LFG.Constants.EVENTS.E_CREATE, nil, event);
  LFG.QueueScrollFrames.queueList = {};
  LFG.QueueScrollFrames.updateLFGQueue();
  LFG_Settings.event = event;
  LFG.EventScrollFrames.newEvent = true;
  LFG.Tabs.select("events.viewQueues");
  DEFAULT_CHAT_FRAME:AddMessage("Create");
end

function LFG.Actions.Event.remind()
  if ( LFG_Settings.event ) then
    LFG.Outgoing:send(LFG.Constants.EVENTS.E_CREATE, nil, LFG_Settings.event);
  end
end

function LFG.Actions.Event.update(request)
  local event = LFG.Utils.Event.createEvent();
  DEFAULT_CHAT_FRAME:AddMessage("event.I: ".. tostring(event.I));
  LFG.Outgoing:send(LFG.Constants.EVENTS.E_UPDATE, nil, event);
  LFG_Settings.event = event;
  LFG.Tabs.select("events.viewQueues");
end

function LFG.Actions.Event.delete()
  LFG.Outgoing:send(LFG.Constants.EVENTS.E_DELETE, nil, {});
  LFG.QueueScrollFrames.queueList = {};
  LFG.QueueScrollFrames.updateLFGQueue();
  LFG_Settings.event = nil;
  LFG.Tabs.select("events.view");
end

function LFG.Actions.Event.remove(event)

  if( type(event) ~= "table") then
    return false;
  end

  if (type(event.QTE) == "table" and event.QTE.timer) then
    Timer.clearTimer(event.QTE.timer);
  end

  local foundIndex = table.findIndex(LFG.EventScrollFrames.eventList, function(index, value)
    return event.OR == value.OR;
  end)

  if ( foundIndex ) then
    table.remove(LFG.EventScrollFrames.eventList, foundIndex);
    LFG.EventScrollFrames.updateLFGEvent();
  end

end

function LFG.Actions.Event.cancelQueue(name, event, hideEvent)

  if( type(event) ~= "table") then
    return false;
  end

  if (type(event.QTE) == "table" and event.QTE.timer) then
    Timer.clearTimer(event.QTE.timer);
  end

  event.QTE = nil;

  if (hideEvent) then
    event.hide = true;
    LFG.EventScrollFrames.resetSelection(event);
    LFG.RolePicker.reset(event);
  end

  if (name and not hideEvent) then
    LFG.EventScrollFrames.LFGEventItemUpdateButton(name, event);
  else
    LFG.EventScrollFrames.updateLFGEvent();
  end
end

function LFG.Actions.Event.eventQueueCreate(request)
end

function LFG.Actions.Event.eventQueueDelete(request)
end
