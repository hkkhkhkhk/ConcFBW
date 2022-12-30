local bgd  =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/arcade_tex/bgd.png")
local yoke  =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/arcade_tex/yoke.png")
local hbar  =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/arcade_tex/bar_h.png")
local vbar  =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/arcade_tex/bar_v.png")
local WHITE  = {1,1,1}
local GREY  = {0.5,0.5,0.5}

function SASL_rotated_center_img_xcenter_aligned(image, x, y, width, height, angle, center_x_offset, center_y_offset, color)
    sasl.gl.drawRotatedTextureCenter (image, angle, x, y, x - width / 2 + center_x_offset, y + center_y_offset, width, height, color)
end

local rubbish_table = {
    {-1, 0},
    {1, 1}
}

local throttle_table = {
    {0, -1},
    {1,1}
}

function draw()
    sasl.gl.drawTexture ( bgd, 0 , 0 , 600 , 600 , WHITE )

    local elevator_drawing_ratio = Table_interpolate(rubbish_table, get(elevator))*0.5+0.7
    SASL_rotated_center_img_xcenter_aligned(yoke, (600-387+25+2), (238+30+53-3), 144*elevator_drawing_ratio, 86*elevator_drawing_ratio, Math_clamp(get(aileron)*90, -90, 90), 0, -53, GREY)
    local pitch_drawing_ratio = (get(stick_pitch)/2 + 1)/2+0.45
    SASL_rotated_center_img_xcenter_aligned(yoke, (600-387+25+2), (238+30+53-3), 144*pitch_drawing_ratio, 86*pitch_drawing_ratio, Math_clamp(get(stick_roll)*90, -90, 90), 0, -53, WHITE)

    sasl.gl.drawTexture ( hbar, 392-30 , (238+30+53-3) - get(pitch_trim)* 115 , 60 , 8 , WHITE )
    sasl.gl.drawTexture ( hbar, 455-30 , (238+30+53-3) + Table_interpolate(throttle_table, get(throttle))* 115 , 60 , 8 , WHITE )

    sasl.gl.drawTexture ( vbar, Math_clamp(300 + get(rudder)*177 - 4, 123, 600-123) , 600-426-30, 8 , 60 , GREY )
    sasl.gl.drawTexture ( vbar, Math_clamp(300 + get(stick_yaw)*177 - 4, 123, 600-123) , 600-426-30, 8 , 60 , WHITE )

end