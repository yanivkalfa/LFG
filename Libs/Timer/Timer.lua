local f =  CreateFrame("Frame","TimerFrame",UIParent);
Timer = {};
Timer.timers = {};
Timer.loopStarted = false;

local function calcExpireAt(interval)
	return time() + interval;
end

local function isItTime(expireAt)
	return time() >= expireAt;
end

local function onUpdate()
	for index,timer in pairs(Timer.timers) do
		if(isItTime(timer.expireAt)) then
			if(timer.isInterval) then
				timer.expireAt = calcExpireAt(timer.interval);
        if(timer.argTable) then
          timer.callback(unpack(timer.argTable));
        else
          timer.callback();
        end
			else
				if(timer.argTable) then
          timer.callback(unpack(timer.argTable));
        else
          timer.callback();
        end
				Timer.clearTimer(index);
			end
		end
	end;
end

local function startLoop()
	if (Timer.loopStarted) then
		return false;
	end
	f:SetScript("OnUpdate", onUpdate);
	Timer.loopStarted = true;
end

local function endLoop()
	if (Timer.loopStarted ~= true) then
		return false;
	end
	f:SetScript("OnUpdate", nil);
	Timer.loopStarted = false;
end

local function haveTimers()
	return table.getn(Timer.timers) > 0;
end

local function checkForTimers()
	if (haveTimers()) then
		startLoop();
	else
		endLoop();
	end
end

local function createTableTimer(expireAt, interval, isInterval, callback, argTable)
	return { expireAt=expireAt; interval=interval; isInterval=isInterval; callback=callback; argTable=argTable };
end

-- public functions
function Timer.setInterval(interval, callback, argTable)
	if(type(interval)~="number" or type(callback)~="function") then
		return false;
	end
	local expireAt = calcExpireAt(interval);
	local timer = createTableTimer(expireAt, interval, true, callback, argTable);
	local index = table.getn(Timer.timers)+1;
	table.insert(Timer.timers, index, timer);
	checkForTimers();
	return index;
end

function Timer.setTimeout(interval, callback, argTable)
	if(type(interval)~="number" or type(callback)~="function") then
		return false;
	end
	local expireAt = calcExpireAt(interval);
	local timer = createTableTimer(expireAt, interval, false, callback, argTable);
	local index = table.getn(Timer.timers)+1;
	table.insert(Timer.timers, index, timer);
	checkForTimers();
	return index;
end

function Timer.clearTimer(timerId)
	table.remove(Timer.timers, timerId)
	checkForTimers();
end
