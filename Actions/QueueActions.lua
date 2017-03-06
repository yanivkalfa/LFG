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
    timer = Timer.setTimeout(LFG.Constants.QUEUE_TIMEOUT, LFG.Actions.Queue.cancel, { name, event } ),
    requestTimer = Timer.setTimeout(LFG.Constants.QUEUE_REQUEST_TIMEOUT, LFG.Actions.Event.remove, { event } ),
    queue = queue;
  };
  LFG.Actions.Queue.count = LFG.Actions.Queue.count + 1;
  LFG.Outgoing:send(LFG.Constants.EVENTS.Q_CREATE, event.OR, queue);
  LFG.EventScrollFrames.LFGEventItemUpdateButton(name, event);
end

function LFG.Actions.Queue.cancel(name, event)
  LFG.Actions.Event.cancelQueue(name, event);
  LFG.Outgoing:send(LFG.Constants.EVENTS.Q_DELETE, event.OR, {});
end

function LFG.Actions.Queue.delete(index)
  local queue = LFG.QueueScrollFrames.queueList[index];

  if (queue and queue.OR) then
    local pos = table.getn(LFG_Settings.eventBlockedUsersList) + 1;
    table.insert(LFG_Settings.eventBlockedUsersList, pos, queue.OR);
  end
  table.remove(LFG.QueueScrollFrames.queueList, index);
  LFG.QueueScrollFrames.updateLFGQueue()
end

function LFG.Actions.Queue.decline(index)
  local queue = LFG.QueueScrollFrames.queueList[index];
  LFG.Outgoing:send(LFG.Constants.EVENTS.Q_DECLINE, queue.OR, {});
  LFG.Actions.Queue.delete(index);
end