
--include("flightcontrol/alt_hold.lua")
include("flightcontrol/fly_the_airplane.lua")
include("flightcontrol/vs_hold.lua")
include("flightcontrol/manual_flight.lua")
include("flightcontrol/yaw_rate_by_roll.lua")
include("flightcontrol/loc_tracking.lua")
include("flightcontrol/bank_angle_hold.lua")
include("flightcontrol/glideslope_tracking.lua")
include("flightcontrol/beta_killer.lua")
include("flightcontrol/rollout.lua")

local function CMD_PITCH_autoland_pitch()
    local pitch_target = 0
    if get(mains_on_ground) == 0 then
        local loc_vs_gain = 0.6 - 1.712573e-7*get(rad_alt) - 1.706865e-7*get(rad_alt)^2 + 5.708577e-10*get(rad_alt)^3
        loc_vs_gain = Math_clamp(loc_vs_gain, 0, 1) * 1000
        local gs_vs_offset = loc_vs_gain*get(GS_DEF)
        local gs_chaser = -1200-(get(rad_alt) < 430 and gs_vs_offset/2 or gs_vs_offset)
        local flare_chaser = math.min((get(rad_alt)+25)*-14.2559+ 285.7, -130)
        --print(gs_chaser, flare_chaser)
        local target_vs = math.max(gs_chaser, flare_chaser)
        target_vs = Math_clamp(target_vs, -2500, -80)
        pitch_target =CMD_PITCH_vs_hold_higher_gain(target_vs)
    else
        if get(nose_on_ground) == 0 then
            pitch_target = Math_clamp(- get(pitch)/4, -99999, -1)
        else
            pitch_target = -99
        end
    end
    return pitch_target
end

local function CMD_ROLL_autoland_roll()
    local roll_target = CMD_ROLL_yaw_rate_by_roll(CMD_ROLL_loc_tracking(get(LOC_DEF)))
    return roll_target
end

function update()

    set(override_brakes, 0)  -- clear the brakes if none of the autoflight modules are running, otherwise it will still be overwritten even after the module goes offlineafter landing.
    set(brake_right, 0)
    set(brake_left, 0)

    -- PITCH, ROLL AND YAW COMMANDS BECOMES PITCH OR ROLL RATE TARGETS
    if get(ap_enabled) == 0 then
        a,b,c = CMD_manual_flight()
        fly_the_airplane(a, b, c, false, false, true, false)
    else
        --pitch_target  = CMD_PITCH_glideslope_tracking(get(GS_DEF))

        --- roll_target = CMD_ROLL_yaw_rate_by_roll(CMD_ROLL_loc_tracking(get(LOC_DEF)))
        --roll_target = CMD_ROLL_bank_angle_hold(get(stick_roll)*20)
        --roll_target = CMD_ROLL_bank_angle_hold(predict_bank_angle(CMD_ROLL_loc_tracking(get(LOC_DEF))))
        

        --print(CMD_ROLL_loc_tracking(get(LOC_DEF)), get(track_rate))
        --print(get(hdef_rate))
        local yaw_input = 0
        --print(get(rad_alt) < 15, get(mains_on_ground) == 0)
        if get(rad_alt) < 13 or get(mains_on_ground) == 1 then -- flaring
            yaw_input = CMD_YAW_rudder_to_follow_course(CMD_YAW_chase_rwy_course(get(LOC_DEF)))
        end
        fly_the_airplane(CMD_PITCH_autoland_pitch(), CMD_ROLL_autoland_roll(), yaw_input, true, get(rad_alt) < 13, true, true)
    end
    ---- animations
    if get(ap_enabled) == 0 then
        set(animation_pitch, get(stick_pitch))
        set(animation_roll, get(stick_roll))
    else
        set(animation_pitch, get(elevator))
        set(animation_roll, get(aileron))
    end

end



