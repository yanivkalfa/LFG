LFG = CreateFrame("Frame", "LFGEventFrame", UIParent);
LFG.initiated = nil;
LFG.Router = nil;
LFG.Utils = {};
LFG.Ctrls = {};
LFG.Actions = {};
LFG.MinimapIcon = {};
LFG.Tabs = {};
LFG.Constants = {};
LFG.EventScrollFrames = {};
LFG.EventDropDownMenu = {};
LFG.EventSelectMenu = {};
LFG.QueueScrollFrames = {};
LFG.QueueDropDownMenu = {};
LFG.RolePicker = {};
LFG.Whisper = {};

UIPanelWindows["LFGFrame"] = { area = "left",	pushable = 11,	whileDead = 1 };

LFG_Settings = LFG_Settings or {
  minimapPos = -45,
  event = nil,
  eventBlockedUsersList = {},
  queue = {},
  lastRoleSelected = { T = nil, H = nil, D = nil },
  character = {
    race = nil,
    class = nil,
    faction = nil,
    level = nil,
    name = nil
  }
};

function LFG:updateCharacter()
  local faction, level, minLevel;
  faction = UnitFactionGroup("player");
  level = 23; -- UnitLevel("player");
  minLevel = faction == "Alliance" and 17 or 13
  LFG_Settings.character = {
    race = UnitRace("player") ,
    class =  UnitClass("player"),
    faction = faction,
    level = 23,--level,
    name = UnitName("player"),
    isValid = level >= minLevel;
  };
end

function LFG:OnEvent()

  if ( event == "VARIABLES_LOADED") then
    LFG:updateCharacter();
    --LFG_Settings.eventBlockedUsersList = {};
    LFG.MinimapIcon.reposition();
    if (LFG_Settings.character.isValid) then
      LFG.EventSelectMenu:setCurrentPage();
      LFG:init();
    end
  end

  if (not LFG_Settings.character.isValid) then
    return false;
  end

  if ( event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_WHISPER") then
    return LFG.Router:route(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
  end

  if ( event == "PARTY_MEMBERS_CHANGED") then
  end

end

function LFG:initRouter()
  if ( not self.Router ) then
    self.Router = Router.new(self.Incoming);
  end
end

function LFG:init()
  if ( not self.initiated ) then
    self:initRouter();
    --self.Utils.General.hidePrefixedMessages();
    self.Utils.General.joinPublicChannel();
    LFG.init = true;
  end
end

function LFG:bindEvents()
  self:RegisterEvent("CHAT_MSG_CHANNEL");
  self:RegisterEvent("CHAT_MSG_WHISPER");
  self:RegisterEvent("PARTY_MEMBERS_CHANGED");
  self:RegisterEvent("VARIABLES_LOADED");
  self:SetScript("OnEvent", self.OnEvent);
  self:SetScript("OnUpdate", function()  self.MinimapIcon.updateIcon(); end);
end

LFG:bindEvents();

-- FIX People In queue to be members - when soemone join the group it should update  the PIQ value

-- todo: add commend line
-- todo: add invite / accept funtionality
-- todo: add member count update functionality.