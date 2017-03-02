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
  LFG.Outgoing:send(LFG.Constants.EVENTS.ERQ, nil, {});
end

function LFG.Actions.Event.show(request)
end

function LFG.Actions.Event.create()
  local event = LFG.Utils.Event.createEvent();
  LFG.Outgoing:send(LFG.Constants.EVENTS.ECRS, nil, event);
  LFG.QueueScrollFrames.queueList = {};
  LFG.QueueScrollFrames.updateLFGQueue();
  LFG_Settings.event = event;
  LFG.Tabs.select("events.viewQueues");
  DEFAULT_CHAT_FRAME:AddMessage("Create");
end

function LFG.Actions.Event.update(request)
  local event = LFG.Utils.Event.createEvent();
  DEFAULT_CHAT_FRAME:AddMessage("event.I: ".. tostring(event.I));
  LFG.Outgoing:send(LFG.Constants.EVENTS.EURS, nil, event);
  LFG_Settings.event = event;
  LFG.Tabs.select("events.viewQueues");
end

function LFG.Actions.Event.delete(request)
  LFG.Outgoing:send(LFG.Constants.EVENTS.EDRQ, nil, {});
  LFG.QueueScrollFrames.queueList = {};
  LFG.QueueScrollFrames.updateLFGQueue();
  LFG_Settings.event = nil;
  LFG.Tabs.select("events.view");
end

function LFG.Actions.Event.eventQueueIndex(request)
end

function LFG.Actions.Event.eventQueueCreate(request)
end

function LFG.Actions.Event.eventQueueDelete(request)
end
