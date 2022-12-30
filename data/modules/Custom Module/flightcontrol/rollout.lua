include("pid_arrays.lua")

local yaw_rate_by_rudder_table = {    
    x = 0,
    cut_frequency = 0.2,
}

function CMD_YAW_chase_rwy_course(loc_def)
    local chase_course = 0
    if math.abs(heading_difference(get(trk),get(LOC_course, 1))) < 180 then
        chase_course = get(LOC_course, 1)
    else
        chase_course = flip_heading(get(LOC_course, 1))
    end
    chase_course = chase_course + 17*get(LOC_DEF)
    return chase_course
end

function CMD_YAW_rudder_to_follow_course(crs)
    local rud = pid_bp(heading_ground_array, crs, get(hdg))
    rud = Math_clamp(rud, -1, 1)
    return rud
end
--    function CMD_YAW_yaw_rate_by_rudder(rate)
--        local yaw_rate_tgt = 0
--        yaw_rate_tgt = pid_bp(yaw_rate_ground_array, rate, get(track_rate))
--        yaw_rate_by_rudder_table.x = yaw_rate_tgt
--        yaw_rate_tgt = low_pass_filter(yaw_rate_by_rudder_table)
--        return yaw_rate_tgt
--    end


