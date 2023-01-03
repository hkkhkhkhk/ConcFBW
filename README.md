# ConcFBW
## A Stability Augmentation and Autonomous Landing Plugin for Concorde
### June 2022 - Jan 2023

This all started when I had a deep interest in control theory, and would like to create a stablisation plugin for the Concorde in the X-Plane 11 Flight Simulator, which was created by developer Colimata.

It introduces a fly-by-wire control onto the flight control architecture, all pilot inputs are post-proccessed before sending onto the control surfaces.

The automatic landing module is an extra experiment on the reliability and stability of my control network, which was tested in extreme conditions with videos below.

It is purely an test in my knowledgebase in cascade control loops, and do not serve any purpose in real life.

Enjoy the description below.

### Controlling by Rates

The first diagram below is an overview of the aircraft's response system. Both stick and autopilot inputs are first processed and then sent into the system, demanding rates on each axis as an input. 
Main components include PID controllers, interpolators, RC filters, etc. 

The output of the system is fed directly into the Elevator and the Trimmable Horizontal Stabliser (THS).

The code representation can be found in Custom Module/flightcontrol/fly_the_airplane.lua

![alt text](https://github.com/hkkhkhkhk/ConcFBW/blob/main/diagrams/flytheairplane.png)

### Designing Yaw Damper and Turn Coordinator

![alt text](https://github.com/hkkhkhkhk/ConcFBW/blob/main/diagrams/yawdamper.png)

### Building the Automatic Landing Module

![alt text](https://github.com/hkkhkhkhk/ConcFBW/blob/main/diagrams/autoland.png)




