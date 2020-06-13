local aInfosSF =
{
    { vecPos = {1182.542, -1311.16, 13.571 }, sText = "Informação"};
    
}

local infoPickup01 = createPickup(1182.542, -1311.16, 13.571 , 3, 1239, 0)
--local infoPickup02 = createPickup(-2427.622, 2313.555, 4.5, 3, 1239, 0)

local GUIEditor = {
    edit = {},
    gridlist = {},
    label = {},
    window = {},
    button = {},
    staticimage = {},
    memo = {}
}

function startSF()

              GUIEditor.window[1] = guiCreateWindow(0.34, 0.35, 0.27, 0.42, "Anadolu Roleplay - Discord ", true)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.staticimage[1] = guiCreateStaticImage(0.27, 0.14, 0.47, 0.32, ":discord/Arquivos/dci.png", true, GUIEditor.window[1])
        BTlink = guiCreateButton(0.03, 0.55, 0.93, 0.12, "Linki Kopyala", true, GUIEditor.window[1])
        guiSetProperty(BTlink, "NormalTextColour", "FF14EF0F")
        BTfechar = guiCreateButton(0.04, 0.77, 0.93, 0.12, "Kapat", true, GUIEditor.window[1])
        guiSetProperty(BTfechar, "NormalTextColour", "FFF40909")    
                addEventHandler ("onClientGUIClick", BTfechar, voltar, false )
                addEventHandler ("onClientGUIClick", BTlink, clickedButton1, false )
 
  
    --------------------------------------------------------


    guiSetVisible(GUIEditor.window[1], false)
    guiSetVisible(GUIEditor.window[1], false)
end
addEventHandler( "onClientResourceStart", getRootElement(), startSF)



function info(thePlayer)
	enabled = not enabled
	if enabled then
	guiSetVisible(GUIEditor.window[1], true)
	showCursor(true)
	else
	guiSetVisible(GUIEditor.window[1], false)
            showCursor(false)
    end
    end
addCommandHandler("discord", info)
--addEventHandler("onClientPickupHit", infoPickup02, info)

function voltar()
    showCursor(false)
    guiSetVisible(GUIEditor.window[1], false)
end

function xyiSF()
    for _, Data in pairs( aInfosSF ) do

        local cx,cy,cz = getCameraMatrix()
        local px,py,pz = unpack(Data.vecPos);
        local distance = getDistanceBetweenPoints3D(cx,cy,cz,px,py,pz)
        local posx,posy = getScreenFromWorldPosition(px,py,pz+0.025*distance+0.40)
        if posx and distance <= 15 then
            dxDrawBorderedText(Data.sText,posx-(0.5),posy-(20),posx-(0.5),posy-(20),tocolor(255,175,0,255),1,1,"default-bold","center","top",false,false,false)
        end
    end
end
function dxDrawBorderedText(text,left,top,right,bottom,color,scale,outlinesize,font,alignX,alignY,clip,wordBreak,postGUI,colorCoded)
    local outlinesize = math.min(scale,outlinesize)
    if outlinesize > 0 then
        for offsetX=-outlinesize,outlinesize,outlinesize do
            for offsetY=-outlinesize,outlinesize,outlinesize do
                if not (offsetX == 0 and offsetY == 0) then
                    dxDrawText(text:gsub("#%x%x%x%x%x%x",""), left+offsetX, top+offsetY, right+offsetX, bottom+offsetY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
                end
            end
        end
    end
    dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
end
addEventHandler("onClientRender", root, xyiSF)

function clickedButton1()
        setClipboard("https://discord.gg/BV4kP5v")
        outputChatBox("#6A5ACD[ •DISCORD• ] #228B22• Bağlantı başarıyla kopyalandı. • ", 40,160,220,true)
end

