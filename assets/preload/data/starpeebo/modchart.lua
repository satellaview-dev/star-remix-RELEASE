function start (song)
  print("Mod Chart script loaded :)")
end


function update (elapsed) -- example https://twitter.com/KadeDeveloper/status/1382178179184422918
	local currentBeat = (songPos / 1000)*(bpm/60)
	
end

function beatHit (beat)
   setCamZoom(1)
end

function keyPressed (key)
	local currentBeat = (songPos / 1000)*(bpm/60)
	camHudAngle = 8 * math.sin((currentBeat))
	setCamZoom(1)
	for i=0,7 do
		_G['strum'..i..'X'] = _G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi)
		_G['strum'..i..'Y'] = _G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi)
	end
end


