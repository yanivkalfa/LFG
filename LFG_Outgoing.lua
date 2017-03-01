LFG.Outgoing = {};

function LFG.Outgoing.EQDRQ(eventType, to, payLoad, options)
	payload.sender = sender;
	LFG.Ctrls.Events.eventQueueDelete(payload);
end

function LFG.Outgoing.EQCRQ(eventType, to, payLoad, options)
  DEFAULT_CHAT_FRAME:AddMessage("got to EQCRQ, "..type(payload));
	payload.sender = sender;
	LFG.Ctrls.Events.eventQueueCreate(payload);
end

function LFG.Outgoing.EQRQ(eventType, to, payLoad, options)
	local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.EDRQ(eventType, to, payLoad, options)
	local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end

function LFG.Outgoing.EURS(eventType, to, payLoad, options)
	local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end

function LFG.Outgoing.ECRS(eventType, to, payLoad, options)
	local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end

function LFG.Outgoing.ERS(eventType, to, payLoad, options)
	local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.ERQ(eventType, to, payLoad, options)
	local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end

function LFG.Outgoing:send(eventType, to, payLoad, options)
	if(type(self[eventType]) == "function" and payLoad) then
		self[eventType](eventType, to, payLoad, options);
	end
end