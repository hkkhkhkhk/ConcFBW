include("pid_arrays.lua")

local roll_rate_output_table = {    
    x = 0,
    cut_frequency = 0.2,
}

function CMD_ROLL_yaw_rate_by_roll(target_trk_rate)


    roll_rate_output = pid_bp(Yaw_rate_to_roll_array, target_trk_rate ,  get(track_rate))
    --print(filtered_track_rate)
    roll_rate_output_table.x = roll_rate_output
    filtered_roll_rate_output = low_pass_filter(roll_rate_output_table)

    roll_rate_output = Math_clamp(filtered_roll_rate_output, -20, 20)
    return roll_rate_output
end