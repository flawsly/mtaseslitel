local streamedOut = {}

bindKey("5", "down",
	function()
		if getElementData(localPlayer, "loggedin") == 1 then
			if getElementData(localPlayer, "radiofrequency") then
				playSound("voice.mp3")
				setElementData(localPlayer, "talking:radio", not getElementData(localPlayer, "talking:radio"))
				if getElementData(localPlayer, "talking:radio") then
					outputChatBox("[!]#ffffff Telsiz konuşması açıldı.", 0, 255, 0, true)
				else
					outputChatBox("[!]#ffffff Telsiz konuşması kapatıldı.", 0, 255, 0, true)
				end
			end
		end
	end
)
addEventHandler("onClientPreRender", root,
	function ()
        local players = getElementsByType("player", root, true) -- table of sounds which will be transformed into 3D

        for k, v in ipairs(players) do
			local vecSoundPos = v.position
			local vecCamPos = Camera.position
			local fDistance = (vecSoundPos - vecCamPos).length
			local fMaxVol = 5
			local fMinDistance = v:getData("minDist") or 5
			local fMaxDistance = v:getData("maxDist") or 20

			-- Limit panning when getting close to the min distance
			local fPanSharpness = 1.0
			if getElementData(localPlayer, "talking:radio") or getElementData(localPlayer, "activeCalling") then
				fPanSharpness = 1.0
			else
				if (fMinDistance ~= fMinDistance * 2) then
					fPanSharpness = math.max(0, math.min(1, (fDistance - fMinDistance) / ((fMinDistance * 2) - fMinDistance)))
				end
			end

			local fPanLimit = (0.65 * fPanSharpness + 0.35)

			-- Pan
			local vecLook = Camera.matrix.forward.normalized
			local vecSound = (vecSoundPos - vecCamPos).normalized
			local cross = vecLook:cross(vecSound)
			local fPan = math.max(-fPanLimit, math.min(-cross.z, fPanLimit))

			local fDistDiff = fMaxDistance - fMinDistance;

			-- Transform e^-x to suit our sound
			local fVolume
			if (fDistance <= fMinDistance) then
				fVolume = fMaxVol
			elseif (fDistance >= fMaxDistance) then
				fVolume = 0.0
			else
				fVolume = math.exp(-(fDistance - fMinDistance) * (5.0 / fDistDiff)) * fMaxVol
			end
			
			setSoundPan(v, fPan)
			--print(getElementData(v, "phonetarget").." -- "..getElementData(localPlayer, "dbid"))
			if getElementData(localPlayer, "talking:radio") then
				if getElementData(v, "radiofrequency") == getElementData(localPlayer, "radiofrequency") then
					setSoundVolume(v, 100)
				end
			else
				if (tonumber(getElementData(v, "phonetarget")) or 0 == tonumber(getElementData(localPlayer, "dbid")) or 1) and getElementData(localPlayer, "activeCalling") then
					setSoundVolume(v, 100)
				else
					if isLineOfSightClear(localPlayer.position, vecSoundPos, true, true, false, true, false, true, true, localPlayer) then -- line of sight clear
						setSoundVolume(v, fVolume)
						setSoundEffectEnabled(v, "compressor", false)
					else
						local fVolume = fVolume * 0.5 -- reduce volume by half
						local fVolume = fVolume < 0.01 and 0 or fVolume -- treshold of 0.01 (anything below is forced to 0)
						setSoundVolume(v, fVolume)
						setSoundEffectEnabled(v, "compressor", true)
					end
				end
			end
		end
    end
, false)

addEventHandler("onClientElementStreamIn", root,
    function ()
        if source:getType() == "player" then
            triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))
        end
    end
)

addEventHandler("onClientElementStreamOut", root,
    function ()
        if source:getType() == "player" then
            triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true))
            setSoundPan(source, 0)
            setSoundVolume(source, 0)
        end
    end
)

addEventHandler("onClientResourceStart", resourceRoot,
    function ()
        triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player", root, true)) -- request server to start broadcasting voice data once the resource is loaded (to prevent receiving voice data while this script is still downloading)
    end
, false)