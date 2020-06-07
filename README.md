# simple-synchronizers
Here you will find designs of a few simple sinchronizres and how they work. 

The goal is to synchronize a single pulse from two different clock domains, the width of pulse is one clock cycle.

There is at least 100 cycles between input pulses.

Every design will include:
* Block diagram.
* System-Verilog code.
* Testbench.
* Brief explanation.

Please note that in order to simulate meta-stable states I used an uncertainty model. The model in use will be the same throughout the various synchronizers.
The uncertainty model was created by one of my university teachers mr. Refael Gantz.

