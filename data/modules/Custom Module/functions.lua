function Math_clamp(val, min, max)
    if min > max then LogWarning("Min is larger than Max invalid") end
    if val < min then
        return min
    elseif val > max then
        return max
    elseif val <= max and val >= min then
        return val
    end
end

function Math_clamp_lower(val, min)
    if val < min then
        return min
    elseif val >= min then
        return val
    end
end

function Math_clamp_higer(val, max)
    if val > max then
        return max
    elseif val <= max then
        return val
    end
end

function Table_interpolate(tab, x)
    local a = 1
    local b = #tab
    assert(b > 1)

    -- Simple cases
    if x <= tab[a][1] then
        return tab[a][2]
    end
    if x >= tab[b][1] then
        return tab[b][2]
    end

    local middle = 1

    while b-a > 1 do
        middle = math.floor((b+a)/2)
        local val = tab[middle][1]
        if val == x then
            break
        elseif val < x then
            a = middle
        else
            b = middle
        end
    end

    if x == tab[middle][1] then
        -- Found a perfect value
        return tab[middle][2]
    else
        -- (y-y0) / (y1-y0) = (x-x0) / (x1-x0)
        return tab[a][2] + ((x-tab[a][1])*(tab[b][2]-tab[a][2]))/(tab[b][1]-tab[a][1])
    end
end

function Table_extrapolate(tab, x)  -- This works like Table_interpolate, but it estimates the values
    -- even if x < minimum value of x > maximum value according to the
    -- last segment available

local a = 1
local b = #tab

assert(b > 1)

if x < tab[a][1] then
return Math_rescale_no_lim(tab[a][1], tab[a][2], tab[a+1][1], tab[a+1][2], x) 
end
if x > tab[b][1] then
return Math_rescale_no_lim(tab[b][1], tab[b][2], tab[b-1][1], tab[b-1][2], x) 
end

return Table_interpolate(tab, x)

end

function Set_anim_value(current_value, target, min, max, speed)

    if target >= (max - 0.001) and current_value >= (max - 0.01) then
        return max
    elseif target <= (min + 0.001) and current_value <= (min + 0.01) then
        return min
    else
        return current_value + ((target - current_value) * (speed * get(DELTA_TIME)))
    end

end

function Set_anim_value_no_lim(current_value, target, speed)
    return current_value + ((target - current_value) * (speed * get(DELTA_TIME)))
end

function Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function drawTextCentered(font, x, y, string, size, isbold, isitalic, alignment, colour)
    sasl.gl.drawText (font, x, y - (size/3),string, size, isbold, isitalic, alignment, colour)
end

function pid_bp(array, setpoint, current, control_error)

    local pid_gains  = {array.P,array.I,array.D}

    for i=1, 3 do
        if type(pid_gains[i]) == "table" and array.Scheduling_variable ~= nil then
            pid_gains[i] = Table_interpolate(pid_gains[i], get(array.Scheduling_variable))
        elseif type(pid_gains[i]) == "table" and array.Scheduling_variable == nil then
            assert(false, "No Scheduling Variable for PID table have been defined!")
        elseif type(pid_gains[i]) ~= "table" and array.Scheduling_variable ~= nil then
            assert(false, "There is a scheduling variable but the gain is not a table!")
        end
    end

    local error = setpoint - current
    local output = 0

    if get(DELTA_TIME) > 0 then
        output =
        --Proportional Component
        pid_gains[1] * error
        --Integral Component
        +pid_gains[2] * array.Isum
        --Derivative Component
        + pid_gains[3] * (error - array.Eprior)/get(DELTA_TIME)
        array.Isum = array.Isum + error * get(DELTA_TIME)
        array.Eprior = error
    else
        output = 0
    end

    --print(array.Isum)
    return output
end

function low_pass_filter(data)
    local dt = get(DELTA_TIME)
    local RC = 1/(2*math.pi*data.cut_frequency)
    local a = dt / (RC + dt)

    if data.prev_y_value == nil then
        data.prev_y_value = a * data.x
    else
        data.prev_y_value = a * data.x + (1-a) * data.prev_y_value
    end

    return data.prev_y_value
end

function Round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function compute_yaw_rate(prev_theta, theta)
    prev_theta = math.rad(prev_theta)
    theta = math.rad(theta)
    local output = 0
    local pi = math.pi
    if get(DELTA_TIME) > 0 then
        if prev_theta > pi and theta < pi and (prev_theta - theta) > pi then
            output = (2*pi + theta - prev_theta) / get(DELTA_TIME)
        elseif prev_theta < pi and theta > pi and (theta - prev_theta) > pi then
            output = (theta - prev_theta - 2*pi) / get(DELTA_TIME)
        else
            output = (theta - prev_theta) / get(DELTA_TIME)
        end
    end
  output = math.deg(output)
  return output
end


function heading_difference(hdg1,hdg2) -- range -180 to 180, difference between 2 bearings, +ve is right turn, -ve is left.
    local turn = 0
    turn =  (hdg1-hdg2)%360
    turn = turn > 180 and (360-turn) or -turn
    return turn
end

function Math_rescale_no_lim(in1, out1, in2, out2, x)

    if in2 - in1 == 0 then return out1 + (out2 - out1) * (x - in1) end
    return out1 + (out2 - out1) * (x - in1) / (in2 - in1)
end

function predict_yaw_rate(bankangle)
    local buff = 9.81 * math.tan(math.rad(bankangle))
    buff = buff / (get(true_airspeed)*0.5144444)
    buff = math.deg(buff)
    return buff
end

function predict_bank_angle(yaw_rate)
    local buff = math.rad(yaw_rate)
    buff = buff * (get(true_airspeed)*0.5144444)
    buff = buff / 9,81
    buff = math.atan(buff)
    buff = math.deg(buff)
    return buff
end

function flip_heading(hdg)
    return (hdg+180)%360
end