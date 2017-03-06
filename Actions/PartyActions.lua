LFG.Actions.Party = {};

function LFG.Actions.Party.invite(name, index)
  local queue = LFG.QueueScrollFrames.queueList[index];
  queue.INV = { timer = Timer.setTimeout(LFG.Constants.INVITATION_TIMEOUT, LFG.Actions.Queue.decline, { index } ) }
  LFG.Outgoing:send(LFG.Constants.EVENTS.P_INVITE, queue.OR, {});
  LFG.QueueScrollFrames.LFGQueueItemUpdateButton(name, index)
end