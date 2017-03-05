LFG.Whisper = {
  username = nil
};

function LFG.Whisper.show(username)
  LFG.Whisper.username = username;
  LFGWhisper:Show();
end

function LFG.Whisper.send()
  local msg = LFGWhisperEditBox:GetText();

  if (strlen(msg) <= 0 ) then
    return false;
  end

  SendChatMessage(msg, "WHISPER", "Common", LFG.Whisper.username);
  LFG.Whisper.cancel();
end

function LFG.Whisper.cancel()
  LFG.Whisper.username = nil;
  LFGWhisperEditBox:SetText("");
  LFGWhisper:Hide();
end


