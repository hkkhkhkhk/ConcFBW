
last_pitch = 0
last_roll = 0
last_slip = 0
last_yaw_rate = 0
last_track = 0
last_hdef = 0

function update()
    if get(DELTA_TIME) ~= 0 then
        -- step 1
        set(pitch_rate, (get(pitch) - last_pitch) / get(DELTA_TIME) ) 
        set(roll_rate, (get(roll) - last_roll) / get(DELTA_TIME) )
        set(slip_rate, (get(slip) - last_slip) / get(DELTA_TIME) )
        set(yaw_jerk, (get(yaw_rate) - last_yaw_rate) / get(DELTA_TIME))
        set(track_rate, compute_yaw_rate(last_track, get(trk)))
        set(hdef_rate, (get(LOC_DEF) - last_hdef) / get(DELTA_TIME))

        --step 2
        last_pitch = get(pitch)
        last_roll = get(roll)
        last_slip = get(slip)
        last_yaw_rate = get(yaw_rate)
        last_track = get(trk)
        last_hdef = get(LOC_DEF)



        -- other values that needs updating
        set(beta, get(hdg) - get(trk))
    end
end