LFG.MinimapIcon = {
  frame = 0,
  frameEnd = 28,
  rate = 0.07,
  counter = 0;
  exclude = { 5, 6, 7, 8, 16 },
  hasTicked = false;
};

function LFG.MinimapIcon.updateIcon()
  
  if(LFG.Actions.Queue.count >= 1) then
    LFG.MinimapIcon.counter = LFG.MinimapIcon.counter + arg1;
    
    if(LFG.MinimapIcon.counter >= LFG.MinimapIcon.rate) then
      LFG.MinimapIcon.hasTicked = true;
      LFG.MinimapIcon.counter = 0;
    end
    
    if(LFG.MinimapIcon.hasTicked) then
      LFG.MinimapIcon.hasTicked = false;
      if(LFG.MinimapIcon.frame >= LFG.MinimapIcon.frameEnd) then
        LFG.MinimapIcon.frame = 0;
      else
        LFG.MinimapIcon.frame = LFG.MinimapIcon.frame+1;
      end
      
      if (table.indexOf(LFG.MinimapIcon.exclude, LFG.MinimapIcon.frame) >= 1) then
        return;
      end
      
      LFG_MinimapButton_Icon:SetTexture('Interface\\AddOns\\LFG\\icons\\frames\\BattlenetWorking'..LFG.MinimapIcon.frame);
    end
  end
end

function LFG.MinimapIcon:resetIcon()
  LFG_MinimapButton:SetTexture("Interface\AddOns\LFG\icons\frames\BattlenetWorking0")
end

function LFG.MinimapIcon.toggle()
  if( LFGFrame:IsVisible() ) then
		HideUIPanel(LFGFrame);
	else
		ShowUIPanel(LFGFrame);
	end
end

function LFG.MinimapIcon.reposition()
	LFG_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(LFG_Settings.minimapPos)),(80*sin(LFG_Settings.minimapPos))-52);
end

function LFG.MinimapIcon.OnUpdate()
	local xpos,ypos = GetCursorPosition();
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();

	xpos = xmin-xpos/UIParent:GetScale()+70;
	ypos = ypos/UIParent:GetScale()-ymin-70;

	LFG_Settings.minimapPos = math.deg(math.atan2(ypos,xpos));
	LFG.MinimapIcon:reposition();
end

function LFG.MinimapIcon.onClick()
end