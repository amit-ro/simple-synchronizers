The double FF is the most simple synchronizer and it can only be used in limited situations.

In order to use this synchronizer, the input pulse's original clock must be at lease 1.5 time slower than the desired clock.
If this requirement is not met there is a chance that we will lose the pulse. The reason for that will be due to the meta-stable nature of clock domain crossings problems. 
