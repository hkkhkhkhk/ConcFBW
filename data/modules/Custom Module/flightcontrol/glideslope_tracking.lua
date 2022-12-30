include("pid_arrays.lua")

function CMD_PITCH_glideslope_tracking(gs_def)
    prt = pid_bp(GS_tracking_array, 0, gs_def)
    return prt
end