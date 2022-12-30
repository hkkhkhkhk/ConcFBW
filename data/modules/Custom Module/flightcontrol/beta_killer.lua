include("pid_arrays.lua")

local beta_killer_output_table = {    
    x = 0,
    cut_frequency = 0.2,
}

function CMD_YAW_beta_killer()
    local yaw_target = pid_bp(beta_killer_array, 0 ,  get(beta))
    beta_killer_output_table.x = yaw_target
    yaw_target = low_pass_filter(beta_killer_output_table)
    return yaw_target
end