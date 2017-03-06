LFG.Utils.Friend = {
  temp = nill,
  added = nill
};

function LFG.Utils.Friend.getFriendInfoFromList(playerName)
  local maxFriends, name, level, class ;
  maxFriends = LFG.Constants.MAX_FRIENDS;

  for i = 1, maxFriends do
    name, level, class = GetFriendInfo(i);
    if (name == playerName) then
      return i, name, level, class;
    end
  end
end

function LFG.Utils.Friend.reset()
  LFG.Utils.Friend.temp = nill;
  LFG.Utils.Friend.added = nill;
end

function LFG.Utils.Friend.addFriendCheck(playerName)
  local maxFriends, numFriends, index, name, level, class;

  maxFriends = LFG.Constants.MAX_FRIENDS;
  numFriends = GetNumFriends();
  if(numFriends >= maxFriends) then
    LFG.Utils.Friend.temp = GetFriendInfo(maxFriends);
    RemoveFriend(maxFriends);
  end
  AddFriend(playerName);
  LFG.Utils.Friend.added = playerName;
end

function LFG.Utils.Friend.resetFriendCheck(index)
  RemoveFriend(index);
  if (LFG.Utils.Friend.temp) then
    AddFriend(LFG.Utils.Friend.temp);
  end
  LFG.Utils.Friend.reset();
end




