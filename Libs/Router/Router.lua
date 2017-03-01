Router = {};
Router.__index = Router;
function Router.new(routes)
  local self = setmetatable({}, Router);
  self.routes = routes;
  return self
end

function Router:route(message, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  DEFAULT_CHAT_FRAME:AddMessage("request handle: ".. type(message));
	local msg = LFG.Utils.Message.parseMessage(message);
  
  if(msg and msg.PL and msg.PL.I) then
    --DEFAULT_CHAT_FRAME:AddMessage("msg.PL.I, msg.PL.DC, msg.PL.ML: ".. msg.PL.I..", "..msg.PL.DC..", "..msg.PL.ML);
    DEFAULT_CHAT_FRAME:AddMessage("msg.PL.I: ".. msg.PL.I);
  end
    
	if(msg and type(self.routes[msg.T]) == "function") then
		return self.routes[msg.T](msg.PL, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8);
	end
  return false;
end