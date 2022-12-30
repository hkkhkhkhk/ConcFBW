include("pid_arrays.lua")

local vvi_pitch_rate_clamp = {
    {270,1.2},
    {400,0.5},
}

function CMD_PITCH_vs_hold(vs)
    --local alt_tgt = Math_clamp((5000-get(alt))*7, -1500, 1500)
    prt = pid_bp(VVI_array, vs , get(vvi))
    local pr_limit = Table_interpolate(vvi_pitch_rate_clamp, get(airspeed))
    prt = Math_clamp(prt, -pr_limit, pr_limit)
    --print(pr_limit, prt)
    return prt
end

function CMD_PITCH_vs_hold_higher_gain(vs)
    --local alt_tgt = Math_clamp((5000-get(alt))*7, -1500, 1500)
    prt = pid_bp(VVI_array, vs , get(vvi))
    local pr_limit = Table_interpolate(vvi_pitch_rate_clamp, get(airspeed))
    prt = Math_clamp(prt, -3, 3)
    --print(pr_limit, prt)
    return prt
end