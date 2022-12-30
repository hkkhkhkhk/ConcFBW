include("pid_arrays.lua")

function CMD_ROLL_loc_tracking(loc_def)
    local yaw_rate_tgt = 0
    --yaw_rate_tgt = pid_bp(LOC_tracking_array, get(LOC_DEF)/10, -get(hdef_rate))
    yaw_rate_tgt = pid_bp(LOC_tracking_array, 0, -get(LOC_DEF))
    yaw_rate_tgt = Math_clamp(yaw_rate_tgt, -2, 2)
    return yaw_rate_tgt
end

function CMD_YAW_loc_tracking(loc_def) -- rollout only!!!!
    local yaw_rate_tgt = 0
    --yaw_rate_tgt = pid_bp(LOC_tracking_array, get(LOC_DEF)/10, -get(hdef_rate))
    yaw_rate_tgt = pid_bp(loc_tracking_ground_array, 0, -get(LOC_DEF))
    yaw_rate_tgt = Math_clamp(yaw_rate_tgt, -2, 2)
    return yaw_rate_tgt
end