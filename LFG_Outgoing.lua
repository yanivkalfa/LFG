LFG.Outgoing = {};


function LFG.Outgoing.P_INVITE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.P_ACCEPT(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.P_DECLINE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end



function LFG.Outgoing.Q_DECLINE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.Q_DELETE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.Q_CREATE_RES(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.Q_CREATE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end


function LFG.Outgoing.Q_REQUEST(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end



function LFG.Outgoing.E_DELETE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end

function LFG.Outgoing.E_UPDATE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end

function LFG.Outgoing.E_CREATE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  local channelId = GetChannelName(LFG.Constants.PUBLIC_CHANNEL);
  SendChatMessage(msg, "CHANNEL", "Common", channelId);
end

function LFG.Outgoing.E_RESPONSE(eventType, to, payLoad, options)
  local tbl = LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options);
  local msg = LFG.Utils.Message:createResponseMsg(tbl);
  SendChatMessage(msg, "WHISPER", "Common", to);
end

function LFG.Outgoing.E_REQUEST(eventType, to, payLoad, options)
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