# ConcFBW
## A Stability Augmentation and Autonomous Landing Plugin for Concorde
### June 2022 - Jan 2023

This all started when I had a deep interest in control theory, and would like to create a stablisation plugin for the Concorde in the X-Plane 11 Flight Simulator, which was created by developer Colimata.

It introduces a fly-by-wire control onto the flight control architecture, all pilot inputs are post-proccessed before sending onto the control surfaces.

The automatic landing module is an extra experiment on the reliability and stability of my control network, which was tested in extreme conditions with videos below.

It is purely an test in my knowledgebase in cascade control loops, and do not serve any purpose in real life.

All system architectures are designed and drawn by me.

### Controlling by Rates

The first diagram below is an overview of the aircraft's response system. Both stick and autopilot inputs are first processed and then sent into the system, demanding rates on each axis as an input. 
Main components include PID controllers, interpolators, RC filters, etc. 

The output of the system is fed directly into the Elevator and the Trimmable Horizontal Stabliser (THS).

The code representation can be found in Custom Module/flightcontrol/fly_the_airplane.lua

![alt text](https://github.com/hkkhkhkhk/ConcFBW/blob/main/diagrams/flytheairplane.png)

### Designing Yaw Damper and Turn Coordinator

Yaw part was relatively challenging to get right, as a yaw damper and a turn coordinator essentially are opposite in nature. On a roll-in and roll-out onto a turn, a positive rudder is needed to maintain coordinated flight, but the damper will produce negative yaw input to oppose the increasing yaw rate.

Heavy filtering was therefore used, and different gains for each component of the yaw module.

On high gains of turn coordination, if precations are not used the aircraft will misbehave on gusty conditions, where the measured slip is not a smooth but rather spikey signal.

![alt text](https://github.com/hkkhkhkhk/ConcFBW/blob/main/diagrams/yawdamper.png)

### Building the Automatic Landing Module

The landing module is a set of logics driving the rate targets like a human pilot does, just with slightly more complex layers.

Horizontal Law:
Cascade control loop, LOC DEVIATION --> YAW RATE --> ROLL RATE, and then fed into the ailerons.

Vertical Law: 
Feedforward then PID, base vertical speed is computed by trigonometry using ground speed and glideslope angle, then an additional gain is added using the gideslope deviation as a multiplier.

Heading Law:
Identical as normal flight, except decrab and rollout phase where a guidance controller is applied, using Crosstrack Error (XTK) and Track Error (TKE) as proccess variables.

![alt text](https://github.com/hkkhkhkhk/ConcFBW/blob/main/diagrams/autoland.png)




