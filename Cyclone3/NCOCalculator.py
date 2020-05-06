#NCO increment calculation
# Calculate for a 64 bit counter incremented at each clock cycle
import sys

if len(sys.argv) <= 1:
    print("Usage: NCOInc rxfrequency")
else:
    Clock = 120000000 # NCO Clock frequency
    print("RX Frequency", sys.argv[1])
    print("NCO Clock is ", Clock)
    increment = pow(2,32) * int(sys.argv[1]) // Clock
    increment2 = pow(2,32) * (int(sys.argv[1])+ 1000) // Clock
    print("NCO increment is ", hex(increment).upper())
    print("NCO additional increment for 9 KHz is ", hex(increment2-increment).upper())
input("Press any key to exit ")
print("End")

