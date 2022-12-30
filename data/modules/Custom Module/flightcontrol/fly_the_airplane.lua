include("pid_arrays.lua")

local reset_flag = false
local snapshot_flag = true

local snapshot_att = 0
local flaremode_bias = 0
local filtered_slip  = 0

local slip_table = {    
    x = 0,
    cut_frequency = 1,
}
local elev_table = {    
    x = 0,
    cut_frequency = 1,
}
local yaw_demand_table = {    
    x = 0,
    cut_frequency = 1,
}
local slip_rate_table = {    
    x = 0,
    cut_frequency = 1,
}
local ail_table = {    
    x = 0,
    cut_frequency = 1.5,
}
local rud_table = {    
    x = 0,
    cut_frequency = 1,
}
local yaw_jerk_table = {    
    x = 0,
    cut_frequency = 1,
}

local pitch_rate_control_delay_table = {    
    x = 0,
    cut_frequency = 0.8,
}


local function rollout_brakes(steer)
    if steer < 0 then
        set(brake_right, 0)
        set(brake_left, math.abs(steer))
    else
        set(brake_right, math.abs(steer))
        set(brake_left, 0)
    end
end

local function override_everything(bool)
    if bool then
        set(override_yaw, 1)
        set(override_pitch, 1)
        set(override_roll, 1)
        set(override_all, 1)
    else
        set(override_yaw, 0)
        set(override_pitch, 0)
        set(override_roll, 0)
        set(override_all, 0)
    end
end

local function take_snapshot_att()
    if get(vvi) < 400 and get(rad_alt)<60 and get(throttle) < 0.6 and snapshot_flag then
        snapshot_att = get(pitch)
        snapshot_flag = false
        print("snapshot taken, ATT is ".. snapshot_att)
    elseif get(vvi) > 400 or get(rad_alt)>60 or get(throttle) > 0.6 then
        snapshot_flag = true
        snapshot_att = 0
        --print("snapshot cleared")
    end
    --print(snapshot_att)
end

function fly_the_airplane(pitch_rate_cmd, roll_rate_cmd, yaw_cmd, ap_is_on, yaw_damper_bypass, differential_braking, autotrim)
        slip_table.x = get(slip)
    filtered_slip = low_pass_filter(slip_table)

    yaw_jerk_table.x = get(yaw_jerk)
    local filtered_yaw_jerk = low_pass_filter(yaw_jerk_table)

    override_everything(false)
    if (get(airspeed) > 30  or get(mains_on_ground) == 0) and  get(colimata_ap_overriding) == 0 then -- either in manual flight or in AP
        override_everything(true)

        if ap_is_on == false then -- do not do flare mode when ap is on
            if get(vvi) < 150 and get(rad_alt)<60 and get(mains_on_ground) == 0 and get(throttle) < 0.6 then --aircraft is flaring
                flaremode_bias = math.max(get(pitch) - snapshot_att + 0.4, -0)* 1.4
                --print(flaremode_bias)
            elseif get(mains_on_ground) == 1 and get(pitch) > 0.8 and get(throttle) < 0.3 then --aircraft is rolling out
                flaremode_bias = 2 + (get(pitch))/5
                --print(flaremode_bias)
            elseif get(vvi) > 150 or get(rad_alt)>60 or get(throttle) > 0.3 then
                flaremode_bias = 0
            end
        else
            flaremode_bias = 0           
        end

        --print(get(track_rate))
        pitch_rate_control_delay_table.x = pitch_rate_cmd
        pitch_rate_cmd = low_pass_filter(pitch_rate_control_delay_table)

        local pitch_rate_error = 0
        pitch_rate_error = pitch_rate_cmd - get(pitch_rate)

        local elevator_target = pid_bp(Pitch_rate_array2, pitch_rate_cmd- flaremode_bias, get(pitch_rate))
        local aileron_target = pid_bp(Roll_rate_array, roll_rate_cmd, get(roll_rate))

        slip_rate_table.x = get(slip_rate)
        filtered_slip_rate = low_pass_filter(slip_rate_table)

        --print(filtered_yaw_jerk)
        local rudder_target = 0
    
        if get(mains_on_ground) == 0 and yaw_damper_bypass == false then
            yaw_feedforward = pid_bp(Slip_array,  0, filtered_yaw_jerk)
            roll_feedforward_to_yaw = Table_extrapolate({{200, roll_rate_cmd/28}, {350, 0},{99999,0}}, get(airspeed))
            rudder_target =  yaw_cmd + yaw_feedforward + filtered_slip/8  + roll_feedforward_to_yaw
        else
            rudder_target = yaw_cmd
        end




        elev_table.x = elevator_target
        filtered_elev = low_pass_filter(elev_table)

        ail_table.x = aileron_target
        filtered_ail = low_pass_filter(ail_table)
        
        rud_table.x = rudder_target
        filtered_rud = low_pass_filter(rud_table)

        elevator_target = Math_clamp(filtered_elev, -1, 1)
        aileron_target = Math_clamp(filtered_ail, -1, 1)
        rudder_target = Math_clamp(filtered_rud, -1, 1)
        
        --print(get(pitch))
        --print(elevator_target)
        set(elevator, elevator_target)
        set(aileron, aileron_target)
        set(rudder, rudder_target)

        if differential_braking then
            rollout_brakes(rudder_target)
            set(override_brakes, 1)
        else
            set(override_brakes, 0)
        end


        if flaremode_bias == 0 then
            local trim_additive = pitch_rate_error * get(DELTA_TIME) * 5
            trim_additive = Math_clamp(trim_additive, -0.001, 0.001)
            set(pitch_trim, Math_clamp( get(pitch_trim) + trim_additive       ,-0.49 ,0.49) )
        end
        reset_flag = not reset_flag
    elseif get(airspeed) < 100 then
        override_everything(false)
        reset_flag = not reset_flag
    elseif not reset_flag then
        override_everything(true)
        set(roll, 0)
        set(pitch, 0)
        set(pitch_trim, 0)
        set(rudder, 0)
        reset_flag = true
    end

    ---- essential loops
    take_snapshot_att()
end