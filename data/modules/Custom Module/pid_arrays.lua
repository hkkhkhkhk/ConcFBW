Pitch_rate_array2 = {
    P=
    {
        {160,0.4},
        {310,0.20},
    }, 
    I=
    {
        {0,0},
        {0,0}
    }, 
    D=
    {
        {160,0.005},
        {310,0.002},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = airspeed
}

Roll_rate_array = 
{
    P={
        {210,0.07},
        {400,0.01},
    }, 
    I={
        {0,0},
        {0,0}
    }, 
    D={
        {210,0},
        {400,0},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = airspeed
}

Trim_array = {
    P={
        {160,0.0036},
        {310,0.003},
    }, 
    I={
        {0,0},
        {0,0}
    }, 
    D={
        {160,0.002},
        {310,0},
    }, 
    BP = 0.0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = airspeed
}

Slip_array = 
{
    P=0.04*2, 
    I=0.0, 
    D=0.004*2, 
    BP = 0.0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = nil
}

VVI_array = 
{
    P={
        {270,1/1000},
        {400,0.1/1000},
    }, 
    I={
        {0,0},
        {0,0}
    }, 
    D={
        {270,1.8/1000},
        {400,0.2/1000},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = airspeed
}

heading_ground_array = 
{
    P={
        {0,1},
        {200,1},
    }, 
    I={
        {0,0.0},
        {0,0.0}
    }, 
    D={
        {0,0.6},
        {200,0.6},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = airspeed
}

loc_tracking_ground_array = 
{
    P={
        {0,1.2},
        {10,1.2},
    }, 
    I={
        {0,0.27},
        {10,0.27}
    }, 
    D={
        {0,7},
        {10,7},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = DME_dist
}

Yaw_rate_to_roll_array = 
{
    P={
        {210,25},
        {400,60},
    }, 
    I={
        {0,0},
        {0,0}
    }, 
    D={
        {170,11},
        {210,7},
        {400,8},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = airspeed
}

LOC_tracking_array = 
{
    P={
        {0,1},
        {10,1},
    }, 
    I={
        {0,0.0},
        {10,0.0}
    }, 
    D={
        {0,20},
        {10,20},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = DME_dist
}

GS_tracking_array = 
{
    P={
        {0,0.25},
        {10,0.35},
    }, 
    I={
        {0,0},
        {0,0}
    }, 
    D={
        {0,8},
        {10,8},
    }, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = DME_dist
}

beta_killer_array = 
{
    P=3/18, 
    I=0.3/19, 
    D=5/6, 
    BP = 0,
    Isum=0, 
    Eprior = 0, 
    Scheduling_variable = nil
}
