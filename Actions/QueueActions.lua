LFG.Actions.Queue = {};
local tableUtils = LFG.Utils.Table;
local eventUtils = LFG.Utils.Events;

-- add to local queue list
--

function LFG.Actions.Queue.get(request)
end

function LFG.Actions.Queue.create(request)
end

function LFG.Actions.Queue.cancel(name, index)
  local event = LFG.EventScrollFrames.eventList[index];
  event.QTE = nil;
  -- send server cancel request
  LFG.EventScrollFrames.LFGEventItemUpdateButton(name, index)
end

function LFG.Actions.Queue.acceptQueue(name, index)
  local queue = LFG.QueueScrollFrames.queueList[index];
  queue.INV = true;
  --send server cancel request
  LFG.QueueScrollFrames.LFGQueueItemUpdateButton(name, index)
end

function LFG.Actions.Queue.declineQueue(name, index)
  --local queue = LFG.QueueScrollFrames.queueList[index];
  --queue.INV = nil;
  -- send server cancel request
  --LFG.QueueScrollFrames.LFGQueueItemUpdateButton(name, index)
end