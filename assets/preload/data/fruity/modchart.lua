local lockzoom = false
local swayingsmall = false
local swayinglarge = false
local swayingbigger = false
local swayingbiggest = false
local swayingbiggest2 = false
local gfAscend = false
local gfBack = false
local background = nil

function update (elapsed)
	local currentBeat = (songPos / 1000)*(bpm/60)
	hudX = getHudX()
    hudY = getHudY()
	gfA = getActorAlpha('girlfriend')


	if lockzoom then
		setCamZoom(1)
	end
	
	if shakenote then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 3 * math.sin((currentBeat * 10 + i*0.25) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 3 * math.cos((currentBeat * 10 + i*0.25) * math.pi) + 10, i)
		end
	end

	if shakehud then
		for i=0,7 do
			setHudPosition(5 * math.sin((currentBeat * 5 + i*0.25) * math.pi), 5 * math.cos((currentBeat * 5 + i*0.25) * math.pi))
			setCamPosition(-5 * math.sin((currentBeat * 5 + i*0.25) * math.pi), -5 * math.cos((currentBeat * 5 + i*0.25) * math.pi))
		end
	end

	if sustainshake then
		for i=0,7 do
			setHudPosition(1 * math.sin((currentBeat * 1 + i*0.25) * math.pi), 1 * math.cos((currentBeat * 1 + i*0.25) * math.pi))
		end
	end

	if finalshake then
		for i=0,7 do
			setHudPosition(8 * math.sin((currentBeat * 15 + i*0.25) * math.pi), 8 * math.cos((currentBeat * 15 + i*0.25) * math.pi))
			setCamPosition(8 * math.sin((currentBeat * 15 + i*0.25) * math.pi), 8 * math.cos((currentBeat * 15 + i*0.25) * math.pi))
		end
	end

    if slowsway then
        camHudAngle = 2 * math.sin((currentBeat))
    end
	
	if sway then
        camHudAngle = 8 * math.sin((currentBeat))
    end

	if fastsway then
        camHudAngle = 12 * math.sin((currentBeat))
    end

	if hudup then
		setHudPosition(0, hudY - 1)
	end
	
	if huddown then
		setHudPosition(0, hudY + 1)
	end

	if swayingsmall then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 25 * math.sin((currentBeat + i*0)), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 25,i)
		end
	end
	if swayinglarge then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin((currentBeat + i*0)) + 350, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 64 * math.cos((currentBeat + i*5) * math.pi) + 10,i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin((currentBeat + i*0)) - 275, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*5) * math.pi) + 10,i)
		end
	end
	if swayingbigger then
		for i=0,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0) * math.pi), i)
			setActorY(_G['defaultStrum'..i..'Y'] + 10 * math.cos((currentBeat + i*5) * math.pi) + 10 ,i)
		end
	end
	if swayingbiggest then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin((currentBeat + i*0)) + 350, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 64 * math.cos((currentBeat + i*5) * math.pi) + 10,i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin((currentBeat + i*0)) - 275, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*5) * math.pi) + 10,i)
		end
	end
	if swayingbiggest2 then
		for i=0,3 do
			setActorX(_G['defaultStrum'..i..'X'] - 300 * math.sin(currentBeat) + 350, i)
			setActorY(_G['defaultStrum'..i..'Y'] + 64 * math.cos((currentBeat + i*5) * math.pi) + 10,i)
		end
		for i=4,7 do
			setActorX(_G['defaultStrum'..i..'X'] + 300 * math.sin(currentBeat) - 275, i)
			setActorY(_G['defaultStrum'..i..'Y'] - 64 * math.cos((currentBeat + i*5) * math.pi) + 10,i)
		end
	end
end

function beatHit (beat)
	local currentBeat = (songPos / 1000)*(bpm/60)
	for i=4,7 do
		setActorX(_G['defaultStrum'..i..'X'] - 250 * math.sin((currentBeat + i*0)) - 225, i)
		setActorY(_G['defaultStrum'..i..'Y'] - 15 * math.cos((currentBeat + i*5) * math.pi) + 10,i)
		camHudAngle = 4 * math.sin((currentBeat))
	end
end

function stepHit (step)
	if curStep >= 0 then
		showOnlyStrums = true
		for i=0,3 do
			tweenFadeIn(i,0,0.6)
		end
	end
end