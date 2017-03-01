LFG.Utils.Message = {};

function LFG.Utils.Message.stringifyMessage(tbl)
	local encodedMessage = Json.stringify(tbl);
	if( type(encodedMessage) == "string") then
		return encodedMessage;
	else
		return false
	end
end

function LFG.Utils.Message.parseMessage(message)
	if(type(message) ~= "string") then
		return false;
	end
	local parts = LFG.Utils.General.explode(LFG.Constants.MSG_PREFIX, message); parsedMessage = {};
	if( parts[2] ) then
		parsedMessage = Json.parse(parts[2]);
		if(type(parsedMessage) == "table") then
			return parsedMessage;
		else
			LFG.Utils.General.log('Could not parse the incoming message');
			return false;
		end
	end
end

function LFG.Utils.Message.createResponseTbl(eventType, to, payLoad, options)
	return { T=eventType, PL=payLoad };
end

function LFG.Utils.Message:createResponseMsg(tbl)
	return LFG.Constants.MSG_PREFIX..self.stringifyMessage(tbl);
end
