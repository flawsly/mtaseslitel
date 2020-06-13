--[[
]]


local screenW,screenH = guiGetScreenSize()
local resW,resH = 1366,768
local x,y =  (screenW/resW), (screenH/resH)



function SimpleStats()
        local Jogador_Falando = getElementData(localPlayer, "Falando_") or false
                                                                                                                                              -- Ativando # = True
        dxDrawText("#00CCFF[Mod]: #FF9900Normal", x*376, y*681, x*460, y*696, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, true, false)		

        if Jogador_Falando == true then                                                                                                      -- Ativando # = True
        dxDrawText("#00CCFF[Konuşma Modu]: #FF9900Normal", x*376, y*662, x*460, y*677, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, true, false)
        else
        	                                                                                                                                     -- Ativando # = True
        dxDrawText("#00CCFF[Konuşma Modu]: #00CCFFNormal", x*376, y*662, x*460, y*677, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, true, false)
    end
end
addEventHandler("onClientRender",getRootElement(),SimpleStats)





addEventHandler ( "onClientPlayerVoiceStart", root, function() 
    if (source and isElement(source) and getElementType(source) == "player") and localPlayer == source then
        setElementData(source, "Falando_", true);
    end 
end );

addEventHandler ( "onClientPlayerVoiceStop", root,function()
    if (source and isElement(source) and getElementType(source) == "player") and localPlayer == source then
        setElementData(source, "Falando_", false);
    end
end);

