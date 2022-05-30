local defaultNotePos = {};
local daThing = false;
local arrowMoveX = 30;
local arrowMoveY = 30;
local turn = 10
local turn2 = 20
local y = 0;
local x = 0;
local canBob = true
local Strums = 'opponentStrums'

function onCreate()
    math.randomseed(os.clock() * 1000);
 
function onSongStart()
    for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
 
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
 
        table.insert(defaultNotePos, {x,y})
    end
end
 
function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60)
    if daThing == true then 
        for i = 0,7 do 
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + arrowMoveX * math.sin((currentBeat + i*0.25) * math.pi))
            
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + arrowMoveY * math.cos((currentBeat + i*0.25) * math.pi))
            
        if mustHitSection == false then
            setProperty('defaultCamZoom',1)
        else
            setProperty('defaultCamZoom',0.7)
        if curStep >= 0 then
            songPos = getSongPosition()
    local currentBeat = (songPos/1000)*(bpm/151)
          doTweenY(dadTweenY, 'dad', -200-50*math.sin((currentBeat*0.25)*math.pi),0.001)
  end

end

function coolresetStrums(time)
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear")
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear")
        noteTweenAngle("movementAngle " .. i, i, 360, time, "linear")
    end
end

function fadeStrums(alpha,time,movebf,movedad)
    if time <= 0 then
        if movebf == true then
            for i = 4,7 do 
                setPropertyFromGroup('strumLineNotes', i, 'alpha', alpha)
            end
        end
        if movedad == true then
            for i = 0,3 do 
                setPropertyFromGroup('strumLineNotes', i, 'alpha', alpha)
            end
        end
    else
        if movebf == true then
            for i = 4,7 do 
                noteTweenAlpha("movementAlpha " .. i, i, alpha, time, "linear")
            end
        end
        if movedad == true then
            for i = 0,3 do 
                noteTweenAlpha("movementAlpha " .. i, i, alpha, time, "linear")
            end
        end
    end
end

stepHitFuncs = {
	[513] = function()
		daThing = true
	end,

	[614] = function()
		daThing = false
	end,

	[615] = function()
		coolresetStrums(2)
		
	end,

	[1013] = function()
		fadeStrums(0,2,true,true)
		
	end
}
function onStepHit()
	if stepHitFuncs[curStep] then
		stepHitFuncs[curStep]()
	end
	
end