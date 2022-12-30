ap_enabled = createGlobalPropertyi("simpleap/enabled", 0, false, true, false)

pitch_rate = createGlobalPropertyf("simpleap/pitch_rate", 0, false, true, false)
roll_rate = createGlobalPropertyf("simpleap/roll_rate", 0, false, true, false)
slip_rate = createGlobalPropertyf("simpleap/slip_rate", 0, false, true, false)
yaw_jerk = createGlobalPropertyf("simpleap/yaw_jerk", 0, false, true, false)
track_rate = createGlobalPropertyf("simpleap/track_rate", 0, false, true, false)
hdef_rate = createGlobalPropertyf("simpleap/hdef_rate", 0, false, true, false)

override_yaw = globalProperty("sim/operation/override/override_joystick_heading")
override_pitch = globalProperty("sim/operation/override/override_joystick_pitch")
override_roll = globalProperty("sim/operation/override/override_joystick_roll")
override_all = globalProperty("sim/operation/override/override_flightcontrol")

elevator = globalProperty("sim/flightmodel2/controls/pitch_ratio")
aileron = globalProperty("sim/flightmodel2/controls/roll_ratio")
rudder = globalProperty("sim/cockpit2/controls/total_heading_ratio")
pitch_trim = globalProperty("sim/flightmodel/controls/elv_trim")
throttle = globalProperty("sim/cockpit2/engine/actuators/throttle_beta_rev_ratio_all")
slip = globalProperty("sim/cockpit2/gauges/indicators/sideslip_degrees")

pitch = globalProperty("sim/cockpit2/gauges/indicators/pitch_AHARS_deg_pilot")
roll = globalProperty("sim/cockpit2/gauges/indicators/roll_AHARS_deg_pilot")

yaw_string = globalProperty("sim/flightmodel2/misc/yaw_string_angle")
side_load = globalProperty("sim/flightmodel/forces/g_side")


DELTA_TIME = globalProperty("sim/operation/misc/frame_rate_period")

target_pitch = createGlobalPropertyf("simpleap/target_pitch", 0, false, true, false)
target_roll = createGlobalPropertyf("simpleap/target_roll", 0, false, true, false)
target_heading = createGlobalPropertyi("simpleap/target_heading", 0, false, true, false)
target_altitude = createGlobalPropertyi("simpleap/target_altitude", 10, false, true, false)
target_speed = createGlobalPropertyf("simpleap/target_speed", 250, false, true, false)


airspeed = globalProperty("sim/cockpit2/gauges/indicators/airspeed_kts_pilot")
true_airspeed = globalProperty("sim/cockpit2/gauges/indicators/true_airspeed_kts_pilot")
ground_speed = globalProperty("sim/flightmodel/position/groundspeed")
alpha = globalProperty("sim/flightmodel/position/alpha")
beta = createGlobalPropertyf("simpleap/beta", 0, false, true, false)
alt = globalProperty("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
rad_alt = globalProperty("sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot")
vvi = globalProperty("sim/cockpit2/gauges/indicators/vvi_fpm_copilot")
hdg = globalProperty("sim/cockpit2/gauges/indicators/heading_AHARS_deg_mag_pilot")
trk = globalProperty("sim/cockpit2/gauges/indicators/ground_track_mag_pilot")
yaw_rate = globalProperty("sim/flightmodel/misc/turnrate_noroll2")

stick_pitch = globalProperty("sim/joystick/joy_mapped_axis_value[1]")
stick_roll = globalProperty("sim/joystick/joy_mapped_axis_value[2]")
stick_yaw = globalProperty("sim/joystick/joy_mapped_axis_value[3]")

animation_pitch = globalProperty("sim/cockpit2/controls/yoke_pitch_ratio")
animation_roll = globalProperty("sim/cockpit2/controls/yoke_roll_ratio")

vs_enabled = createGlobalPropertyi("simpleap/vs_enabled", 0, false, true, false)

nose_on_ground = globalProperty("sim/flightmodel2/gear/on_ground[0]")
mains_on_ground = globalProperty("sim/flightmodel2/gear/on_ground[1]")
paused = globalProperty("sim/time/sim_speed")

colimata_ap_overriding = globalProperty("sim/cockpit2/autopilot/autopilot_on_or_cws")

target_vvi = globalProperty("Colimata/CON_IP_VSI_BUG_1kft_p_min_f")

LOC_DEF = globalProperty("sim/cockpit2/radios/indicators/nav1_hdef_dots_pilot")
GS_DEF = globalProperty("sim/cockpit2/radios/indicators/nav1_vdef_dots_pilot")
DME_dist = globalProperty("sim/cockpit2/radios/indicators/dme_dme_distance_nm")
LOC_course = globalProperty("sim/cockpit2/radios/actuators/nav_course_deg_mag_pilot")

override_brakes = globalProperty("sim/operation/override/override_toe_brakes")
brake_left = globalProperty("sim/flightmodel/controls/l_brake_add")
brake_right = globalProperty("sim/flightmodel/controls/r_brake_add")