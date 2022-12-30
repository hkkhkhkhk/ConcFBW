bgd =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/bgd.png")
cmd1 =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/cmd.png")
cmd2 =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/cmd2.png")
cmd3 =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/cmd3.png")
hdg =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/hdg.png")
thr =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/thr.png")
vs =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/vs.png")
local WHITE = {1, 1, 1, 1}
local roboto	= loadFont(getXPlanePath() .. "Resources/fonts/Roboto-Regular.ttf")

local ap_on = false


function onMouseDown ( component , x , y , button , parentX , parentY )
    print(x,y)
    if x > 919 and y > 169 and x < 981 and y < 232 then
        ap_on = not ap_on
        set(ap_enabled, 1 - get(ap_enabled))
    end
    if x > 825 and y > 26 and x < 892 and y < 90 and get(ap_on) then
        set(vs_enabled, 1 - get(vs_enabled))
    end
    if x > 462 and y > 91 and x < 530 and y < 154 then
        set(target_roll, 0)
    end
end

function onMouseWheel(component, x, y, button, parentX, parentY, value)
    --scrolling target speed
    if x > 723 and y > 41 and x < 750 and y < 141 then
        set(target_pitch, get(target_pitch) - value*100)
    end
    if x > 462 and y > 91 and x < 530 and y < 154 then
        set(target_roll, get(target_roll) + value)
    end
    if x > 272 and y > 46 and x < 348 and y < 107 then
        set(target_speed, get(target_speed) + value)
    end
end

function update()
    if not get(ap_enabled) or not ap_on then
        set(vs_enabled, 0)
    end
end

function draw()
    sasl.gl.drawTexture ( bgd, 0 , 0 , 1243 , 275 , WHITE )
    if ap_on then 
        sasl.gl.drawTexture ( cmd1, 0 , 0 , 1243 , 275 , WHITE )
    end
    if get(vs_enabled) == 1 then
        sasl.gl.drawTexture ( vs, 0 , 0 , 1243 , 275 , WHITE )
    end
    drawTextCentered(roboto, 742, 200, get(target_pitch), 25, true, false, TEXT_ALIGN_CENTER, WHITE)
    drawTextCentered(roboto, 498, 200, get(target_roll), 25, true, false, TEXT_ALIGN_CENTER, WHITE)
    drawTextCentered(roboto, 313, 200, get(target_speed), 25, true, false, TEXT_ALIGN_CENTER, WHITE)
end