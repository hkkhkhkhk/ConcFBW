local stick_to_pitch_rate = {
    {-1, -7},
    {0,0},
    {1, 7}
}

local stick_to_roll_rate = {
    {-1, -40},
    {0,0},
    {1, 40}
}

function CMD_manual_flight()
    local feed_pitch = 0
    if get(airspeed) > 120 then
        feed_pitch = Table_interpolate(stick_to_pitch_rate, get(stick_pitch))
    else
        feed_pitch = -1
    end
    local feed_roll = Table_interpolate(stick_to_roll_rate, get(stick_roll))
    local feed_yaw = get(stick_yaw)
    return feed_pitch, feed_roll, feed_yaw
end