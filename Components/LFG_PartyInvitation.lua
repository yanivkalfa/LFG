LFG.PartyInvitation = {
  eventOwner = "",
  autoAccept = nil,
  invited = nil,
  timer = nil,
};

function LFG.PartyInvitation.reset()
  if ( LFG.PartyInvitation.timer ) then
    Timer.clearTimer(LFG.PartyInvitation.timer);
  end
  LFG.PartyInvitation.eventOwner = "";
  LFG.PartyInvitation.autoAccept = nil;
  LFGPartyInvitationTitle:SetText("");
  LFGPartyInvitation:Hide();
end

function LFG.PartyInvitation.decline()
  LFG.Outgoing:send(LFG.Constants.EVENTS.P_DECLINE, LFG.PartyInvitation.eventOwner, {});
  LFG.PartyInvitation.reset()
end

function LFG.PartyInvitation.accept()
  LFG.PartyInvitation.autoAccept = true
  LFG.Outgoing:send(LFG.Constants.EVENTS.P_ACCEPT, LFG.PartyInvitation.eventOwner, {});
  LFGPartyInvitation:Hide();
end

function LFG.PartyInvitation.show(event)
  LFG.PartyInvitation.reset();
  LFG.PartyInvitation.eventOwner = event.OR;
  LFGPartyInvitationTitle:SetText("You are being invited to: \n "..GRAY_FONT_COLOR_CODE.."\""..event.TT.."\""..FONT_COLOR_CODE_CLOSE);
  LFG.PartyInvitation.timer = Timer.setTimeout(LFG.Constants.INVITATION_TIMEOUT, LFG.PartyInvitation.reset ),
  LFGPartyInvitation:Show();
end