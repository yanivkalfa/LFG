LFG.Utils.String = {};

local function twoDigits(number)
  return number < 10 and '0'..number or number;
end

local function fixNounNames(qty, name)
  return qty == 1 and name or name..'s';
end

function LFG.Utils.String.getTimeStringForPending(diffSeconds)
  local d = math.floor(diffSeconds/86400);
  diffSeconds = mod(diffSeconds, 86400);
  local h = math.floor(diffSeconds/3600);
  diffSeconds  = mod(diffSeconds, 3600);
  local m = math.floor(diffSeconds/60);
  local s  = mod(diffSeconds, 60);
  local timeString = '';

  if(m >= 1) then
    timeString = twoDigits(m) .. ":"
  else
    timeString = "00:"
  end
  
  if(s >= 1) then
    timeString = timeString..twoDigits(s);
  else
    timeString = timeString.."00";
  end
  return timeString;
end

function LFG.Utils.String.getTimeString(expire, now)
  now = now or time();
  local diffSeconds = now - expire;
  local d = math.floor(diffSeconds/86400);
  diffSeconds = mod(diffSeconds, 86400);
  local h = math.floor(diffSeconds/3600);
  diffSeconds  = mod(diffSeconds, 3600);
  local m = math.floor(diffSeconds/60);
  local timeString = '';
  
  if(d >= 1) then
    timeString = timeString ..d.." "..fixNounNames(d, "Day").." ";
  end
  if(h >= 1) then
    timeString = timeString ..h.." "..fixNounNames(h, "Hour").." ";
  end
  if(m >= 1) then
    timeString = timeString ..m.." "..fixNounNames(m, "Minute").." ";
  end
  
  if(string.len(timeString) >= 1) then
    timeString = timeString .. 'ago';
  else
    timeString = "Now"
  end
  return timeString;
end