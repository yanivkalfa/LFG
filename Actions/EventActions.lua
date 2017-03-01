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
  
  DEFAULT_CHAT_FRAME:AddMessage("text: "..text);
  
  LFG.EventScrollFrames.searchBouncer = Timer.setTimeout(1, function()
      DEFAULT_CHAT_FRAME:AddMessage("executing searchBouncer: ");
      if ( type(LFG.EventScrollFrames.eventListBackup) == "table" ) then
        LFG.EventScrollFrames.eventList = LFG.EventScrollFrames.eventListBackup;
      end
      LFG.EventScrollFrames.eventListBackup = LFG.EventScrollFrames.eventList;
      LFG.EventScrollFrames.eventList = table.filter(LFG.EventScrollFrames.eventList, function(index, value)
          DEFAULT_CHAT_FRAME:AddMessage("in filter: "..index);
          local title = strlower(value.TT);
          local description = strlower(value.DC);
          local queueTo = strlower(LFG.Constants.EVENT_LIST[value.QT].name);
          
          local inTitle = string.find(title, text) or title == text;
          local inDescription = string.find(description, text) or description == text;
          local inQueueTo = string.find(queueTo, text) or queueTo == text;
          local InLevel = string.find(value.ML, text) or value.ML == text;
          
          DEFAULT_CHAT_FRAME:AddMessage("inTitle, inDescription, inQueueTo, InLevel: "..tostring(inTitle)..", "..tostring(inDescription)..", "..tostring(inQueueTo)..", "..tostring(InLevel));
          if(not inTitle and not inDescription and not inQueueTo and not InLevel ) then
            return true;
          end
          return false;
      end)
      LFG.EventScrollFrames.updateLFGEvent();
  end)
  DEFAULT_CHAT_FRAME:AddMessage("LFG.EventScrollFrames.searchBouncer: "..LFG.EventScrollFrames.searchBouncer);
end

function LFG.Actions.Event.clearSearch()
  if ( type(LFG.EventScrollFrames.eventListBackup) == "table" ) then
    LFG.EventScrollFrames.eventList = LFG.EventScrollFrames.eventListBackup;
    LFG.EventScrollFrames.eventListBackup = nil;
    LFG.EventScrollFrames.updateLFGEvent();
    LFGEventsViewSearch:SetText("");
  end
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
