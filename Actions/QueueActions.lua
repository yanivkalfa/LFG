LFG.Actions.Queue = {
  count = 0,
};
local tableUtils = LFG.Utils.Table;
local eventUtils = LFG.Utils.Events;


function LFG.Actions.Queue.fetch()
  LFG.Outgoing:send(LFG.Constants.EVENTS.Q_REQUEST, nil, {});
end

function LFG.Actions.Queue.create()
  local name = LFG.RolePicker.name;
  local event = LFG.RolePicker.event;
  local roles = LFG.RolePicker.getRoles();
  local noteToLeader = LFG.RolePicker.getNoteToLeader();
  local queue = {
    OR = event.OR,
    C = LFG.Constants.CLASS_LIST_MAP[LFG_Settings.character.class],
    LVL = LFG_Settings.character.level,
    R = roles,
    NTL = noteToLeader
  };
  event.QTE = {
    expireAt = time() + LFG.Constants.QUEUE_TIMEOUT,
    timer = Timer.setTimeout(LFG.Constants.QUEUE_TIMEOUT, LFG.Actions.Queue.cancel, { name, event, true } ),
    requestTimer = Timer.setTimeout(LFG.Constants.QUEUE_REQUEST_TIMEOUT, LFG.Actions.Event.remove, { event } ),
    queue = queue;
  };
  LFG.Actions.Queue.count = LFG.Actions.Queue.count + 1;
  LFG.Outgoing:send(LFG.Constants.EVENTS.Q_CREATE, event.OR, queue);
  LFG.EventScrollFrames.LFGEventItemUpdateButton(name, event);
end

function LFG.Actions.Queue.cancel(name, event, hideEvent)
  LFG.Actions.Event.cancelQueue(name, event, hideEvent);
  LFG.Actions.Queue.count = LFG.Actions.Queue.count - 1;
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