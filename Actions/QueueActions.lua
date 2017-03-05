LFG.Actions.Queue = {};
local tableUtils = LFG.Utils.Table;
local eventUtils = LFG.Utils.Events;

-- add to local queue list
--

function LFG.Actions.Queue.get(request)
end

function LFG.Actions.Queue.create()
  local name = LFG.RolePicker.name;
  local event = LFG.RolePicker.event;
  local roles = LFG.RolePicker.getRoles();
  local noteToLeader = LFG.RolePicker.getNoteToLeader();
  event.QTE = { expireAt = time() + LFG.Constants.QUEUE_TIMEOUT, timer = Timer.setTimeout(LFG.Constants.QUEUE_TIMEOUT, LFG.Actions.Queue.cancel, { name, event, true } )};
  LFG.Outgoing:send(LFG.Constants.EVENTS.Q_CREATE, event.OR, { R = roles, NTL = noteToLeader });
  LFG.EventScrollFrames.LFGEventItemUpdateButton(name, event);
end

function LFG.Actions.Queue.cancel(name, event, hideEvent)
  LFG.Actions.Event.cancelQueue(name, event, hideEvent)
  LFG.Outgoing:send(LFG.Constants.EVENTS.Q_DELETE, event.OR, {});
end

function LFG.Actions.Queue.acceptQueue(name, index)
  local queue = LFG.QueueScrollFrames.queueList[index];
  queue.INV = true;
  --send server cancel request
  LFG.QueueScrollFrames.LFGQueueItemUpdateButton(name, index)
end

function LFG.Actions.Queue.delete(index)
  table.remove(LFG.QueueScrollFrames.queueList, index);
  LFG.QueueScrollFrames.updateLFGQueue()
end