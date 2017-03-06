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

  if(msg and type(self.routes[msg.T]) == "function" and sender ~=  LFG_Settings.character.name) then
    return self.routes[msg.T](msg.PL, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8);
  end
  return false;
end

--[[
 function Router:route(message, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8)
  --DEFAULT_CHAT_FRAME:AddMessage("request handle: ".. type(message));
  local msg = LFG.Utils.Message.parseMessage(message);

  if ( not msg or type(msg) ~= "table" ) then
    return false;
  end

  local method = msg.T;

  if ( self.transport ) then
    method = self.transport[msg.T];
  end

  if ( type(self.routes[method]) == "function" ) then
    return self.routes[method](msg.PL, sender, language, channelString, target, flags, arg7, channelNumber, channelName, arg8);
  end

  return false;
end
 ]]