LFG.Utils.Event = {};
function LFG.Utils.Event.createEvent()
  local event = {
    TT = LFGEventTitle:GetText(),
    DC = LFGEventDescription:GetText(),
    ML = tonumber(LFGEventMinLevel:GetText()),
    QT = LFG.EventSelectMenu.selected,
    PIE = 0,
  };
  
  return event;
end

function LFG.Utils.Event.validateEventInput()
  return LFG.EventSelectMenu.selected;
end


--[[
function LFG.Utils.Event.createEventTwo(request)
	return { 
    OR=request.sender,
    TT=request.TT,
    DC=request.DC,
    ML=request.ML,
    QT=request.QT,
    TS=time(),
    QCTR=0, -- Queues Counter (number that serves as ID and always increases)
    PIE=0, -- people in event people already got invited
    Q={}
  }
end

function LFG.Utils.Event.createEventResponse(event)

	return {
    I=event.I,
    OR=event.OR,
    TT=event.TT,
    DC=event.DC,
    ML=event.ML,
    QT=event.QT,
    TS=event.TS,
    PIE=event.PIE,
  }
end

function LFG.Utils.Event.validateEvent(event)
  local ML = true;
  if (event.ML and type(tonumber(event.ML)) ~= "number") then
    ML = false;
  end
	return LFG.Constants.EVENT_LIST[event.QT] and ML;
end

function LFG.Utils.Event.createQueue(request)
	return { 
    OR=request.sender,
    LVL=request.LVL,
    C=request.C,
    R=request.R,
    QT=request.QT,
    EI=request.EI,
    TS=time(),
    SU=1,
  }
end

function LFG.Utils.Event.validateQueue(event, queue)
	return LFG.Constants.EVENT_LIST[queue.QT] and queue.LVL >= event.ML 
end

function LFG.Utils.Event.createChunk(tChunk)
  local chunk = { CP = 1, PP=LFG.Constants.MAX_PAGE_SIZE };
  if( type(tChunk) ~= "table") then 
    return chunk;
  end
	return {
    CP = type(tChunk.CP) == "number" and tChunk.CP or 1;
    PP = tChunk.PP and tChunk.CK.PP <= LFG.Constants.MAX_PAGE_SIZE or LFG.Constants.MAX_PAGE_SIZE
  };
end
]]--