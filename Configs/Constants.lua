LFG.Constants.MAX_PAGE_SIZE = 10;
--LFG.Constants.SERVER_NAME = "Zeewarrior";
LFG.Constants.EVENT_ITEM_HEIGHT = 34;
LFG.Constants.MAX_QUEUE_PAGE_SIZE = 10;
LFG.Constants.QUEUE_ITEM_HEIGHT = 25;
LFG.Constants.QUEUE_TIMEOUT = 70;
LFG.Constants.QUEUE_REQUEST_TIMEOUT = 4;
LFG.Constants.INVITATION_TIMEOUT = 60;
LFG.Constants.MAX_FRIENDS = 50;
LFG.Constants.MSG_PREFIX = '__LFG__';
LFG.Constants.PUBLIC_CHANNEL = 'LFG_PUBLIC';
LFG.Constants.EVENTS = {
  E_REQUEST = 'E_REQUEST', -- event request
  E_RESPONSE = 'E_RESPONSE', -- event response
  E_CREATE = 'E_CREATE', -- event create
  E_UPDATE = "E_UPDATE", -- event update
  E_DELETE = "E_DELETE", -- event delete


  Q_REQUEST = 'Q_REQUEST', -- queue request
  Q_RESPONSE = 'Q_RESPONSE', -- queue response
  Q_CREATE = 'Q_CREATE', -- queue create
  Q_CREATE_RES = 'Q_CREATE_RES', -- queue create response
  Q_DELETE = "Q_DELETE", -- queue delete
  Q_ACCEPT = "Q_ACCEPT", -- event accept
  Q_DECLINE = "Q_DECLINE", -- event decline

  P_INVITE = "P_INVITE", -- party invite
  P_ACCEPT = "P_ACCEPT", -- party accept
  P_DECLINE = "P_DECLINE", -- party decline

};
LFG.Constants.FACETIONS_LIST = { H=true, A=true };
LFG.Constants.ROLES_LIST = { T=true, H=true, D=true };
LFG.Constants.TABLES_LIST = { D=true, C=true, B=true };

LFG.Constants.ROLE_FOR_CLASS_LIST = {
  Warrior={ T=true, D=true, preset=2 },
  Paladin={ T=true, H=true, D=true, preset=3 },
  Druid={ T=true, H=true, D=true, preset=3 },
  Hunter={ D=true, preset=1 },
  Rogue={ D=true, preset=1 },
  Mage={ D=true, preset=1 },
  Warlock={ D=true, preset=1 },
  Priest={ H=true, D=true, preset=2 },
  Shaman={ H=true, D=true, preset=2 },
};

LFG.Constants.CLASS_LIST = {
  WR = "Warrior",
  PA = "Paladin",
  DR = "Druid",
  HU = "Hunter",
  RO = "Rogue",
  MA = "Mage",
  WA = "Warlock",
  PR = "Priest",
  SH = "Shaman",
};

LFG.Constants.CLASS_LIST_MAP = {
  Warrior = "WR",
  Paladin = "PA",
  Druid = "DR",
  Hunter = "HU",
  Rogue = "RO",
  Mage = "MA",
  Warlock = "WA",
  Priest = "PR",
  Shaman = "SH",
};

LFG.Constants.RAID_CLASS_COLORS = {
  HU = { r = 0.67, g = 0.83, b = 0.45, colorStr = "ffabd473" },
  WA = { r = 0.53, g = 0.53, b = 0.93, colorStr = "ff8788ee" },
  PR = { r = 1.0, g = 1.0, b = 1.0, colorStr = "ffffffff" },
  PA = { r = 0.96, g = 0.55, b = 0.73, colorStr = "fff58cba" },
  MA = { r = 0.25, g = 0.78, b = 0.92, colorStr = "ff3fc7eb" },
  RO = { r = 1.0, g = 0.96, b = 0.41, colorStr = "fffff569" },
  DR = { r = 1.0, g = 0.49, b = 0.04, colorStr = "ffff7d0a" },
  SH = { r = 0.0, g = 0.44, b = 0.87, colorStr = "ff0070de" },
  WR = { r = 0.78, g = 0.61, b = 0.43, colorStr = "ffc79c6e" }
};

LFG.Constants.PVP_LEVELS = {
  a = { minLevel=10, maxLevel=19 },
  b = { minLevel=20, maxLevel=29 },
  c = { minLevel=30, maxLevel=39 },
  d = { minLevel=40, maxLevel=49 },
  e = { minLevel=50, maxLevel=59 },
  f = { minLevel=60, maxLevel=60 }
};

LFG.Constants.EVENT_LIST = {
  RFC		= { id = "RFC", name="Ragefire Chasm", faction="h", active=true, players=5, minLevel=13, maxLevel=18, evenType="D"},
  WC		= { id = "WC", name="Wailing Caverns", faction="b", active=true, players=5, minLevel=17, maxLevel=24, evenType="D"},
  DM		= { id = "DM", name="The Deadmines", faction="b", active=true, players=5, minLevel=17, maxLevel=26, evenType="D"},
  SFK		= { id = "SFK", name="Shadowfang Keep", faction="b", active=true, players=5, minLevel=22, maxLevel=30, evenType="D"},
  BFD 	= { id = "BFD", name="Blackfathom Deeps", faction="b", active=true, players=5, minLevel=24, maxLevel=32, evenType="D"},
  STDE 	= { id = "STDE", name="The Stockade", faction="a", active=true, players=5, minLevel=24, maxLevel=32, evenType="D"},
  GRG 	= { id = "GRG", name="Gnomeregan", faction="b", active=true, players=5, minLevel=29, maxLevel=38, evenType="D"},
  RFK 	= { id = "RFK", name="Razorfen Kraul", faction="b", active=true, players=5, minLevel=29, maxLevel=38, evenType="D"},
  SMG 	= { id = "SMG", name="Scarlet Monastery - The Graveyard", faction="b", active=true, players=5, minLevel=30, maxLevel=36, evenType="D"},
  SML 	= { id = "SML", name="Scarlet Monastery - The Library", faction="b", active=true, players=5, minLevel=32, maxLevel=38, evenType="D"},
  SMA 	= { id = "SMA", name="Scarlet Monastery - The Armory", faction="b", active=true, players=5, minLevel=33, maxLevel=40, evenType="D"},
  SMC 	= { id = "SMC", name="Scarlet Monastery - The Cathedral", faction="b", active=true, players=5, minLevel=36, maxLevel=44, evenType="D"},
  RFD 	= { id = "RFD", name="Razorfen Downs", faction="b", active=true, players=5, minLevel=37, maxLevel=46, evenType="D"},
  UL		= { id = "UL", name="Uldaman", faction="b", active=true, players=5, minLevel=41, maxLevel=51, evenType="D"},
  ZF		= { id = "ZF", name="Zul'Farrak", faction="b", active=true, players=5, minLevel=42, maxLevel=46, evenType="D"},
  MD		= { id = "MD", name="Maraudon", faction="b", active=true, players=5, minLevel=46, maxLevel=55, evenType="D"},
  ST		= { id = "ST", name="Sunken Temple", faction="b", active=true, players=5, minLevel=50, maxLevel=56, evenType="D"},
  BRD		= { id = "BRD", name="Blackrock Depths", faction="b", active=true, players=5, minLevel=52, maxLevel=60, evenType="D"},
  LBRS	= { id = "LBRS", name="Lower Blackrock Spire", faction="b", active=true, players=5, minLevel=55, maxLevel=60, evenType="D"},
  UBRS	= { id = "UBRS", name="Upper Blackrock Spire", faction="b", active=true, players=10, minLevel=55, maxLevel=60, evenType="D"},
  DMW		= { id = "DMW", name="Dire Maul - Warpwood", faction="b", active=true, players=5, minLevel=55, maxLevel=60, evenType="D"},
  DME		= { id = "DME", name="Dire Maul - East", faction="b", active=true, players=5, minLevel=55, maxLevel=60, evenType="D"},
  STRTU	= { id = "STRTU", name="Stratholme - Undead", faction="b", active=true, players=5, minLevel=58, maxLevel=60, evenType="D"},
  STRTL	= { id = "STRTL", name="Stratholme - Live", faction="b", active=true, players=5, minLevel=58, maxLevel=60, evenType="D"},
  SH		= { id = "SH", name="Scholomance", faction="b", active=true, players=5, minLevel=58, maxLevel=60, evenType="D"},
  ONY		= { id = "ONY", name="Onyxia's Lair", active=true, players=40, minLevel=60, maxLevel=60, evenType="R"},
  MC		= { id = "MC", name="Molten Core", active=true, players=40, minLevel=60, maxLevel=60, evenType="R"},
  ZG		= { id = "ZG", name="Zul'Gurub", active=false, players=20, minLevel=60, maxLevel=60, evenType="R"},
  BWL		= { id = "BWL", name="Blackwing Lair", active=false, players=40, minLevel=60, maxLevel=60, evenType="R"},
  RAQ		= { id = "RAQ", name="Ruins of Ahn'Qiraj", active=false, players=20, minLevel=60, maxLevel=60, evenType="R"},
  TAQ		= { id = "TAQ", name="Temple of Ahn'Qiraj", active=false, players=40, minLevel=60, maxLevel=60, evenType="R"},
  NAX		= { id = "NAX", name="Naxxramas", active=false, players=40, minLevel=60, maxLevel=60, evenType="R"},
  WG		= { id = "WG", name="Warsong Gulch", active=true, players=10, minLevel="any", evenType="R"},
  AB 		= { id = "AB", name="Arathi Basin", active=true, players=15, minLevel="any", evenType="R"},
  AV 		= { id = "AV", name="Alterac Valley", active=false, players=40, minLevel="any", evenType="R"},
  CUS		= { id = "CUS", name="Custom", active=true, players=nil, minLevel="any", evenType="R"}
};

LFG.Constants.EVENT_LIST_HASH_A = {
  "WC", "DM", "SFK", "BFD", "STDE", "GRG", "RFK", "SMG", "SML", "SMA", "SMC", "RFD",
  "UL", "ZF", "MD", "ST", "BRD", "LBRS", "UBRS", "DMW", "DME", "STRTU", "STRTL", "ONY", "MC",
  "ZG", "BWL", "RAQ", "TAQ", "NAX"
};
LFG.Constants.EVENT_LIST_HASH_H = {
  "RFC", "WC", "DM", "SFK", "BFD", "GRG", "RFK", "SMG", "SML", "SMA", "SMC", "RFD",
  "UL", "ZF", "MD", "ST", "BRD", "LBRS", "UBRS", "DMW", "DME", "STRTU", "STRTL", "ONY", "MC",
  "ZG", "BWL", "RAQ", "TAQ", "NAX"
};

-- greenItem = cff00ff00/
-- white = cffffffff
--{ name = "|cff9d9d9d"..POOR },
--{ name = "|cffffffff"..COMMON },
--{ name = "|cff1eff00"..UNCOMMON },
--{ name = "|cff0070dd"..RARE },
--{ name = "|cffa335ee"..EPIC },
--{ name = "|cffff8000"..LEGENDARY },
-- cff40ffc0 -- very light blue
--cffaaaaaa -- gray
--cFFFFFF00 -- yellow
