function CMD_ROLL_bank_angle_hold(ang)
    local rrt = Math_clamp((ang-get(roll)), -20, 20)
    return rrt
end