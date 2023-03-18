def Fibbonaci_LFSR_Period():
    start_state = 1 << 15 | 1
    lfsr = start_state
    period = 0

    while True:
        #taps: 16 15 13 4; feedback polynomial: x^16 + x^15 + x^13 + x^4 + 1
        bit = (lfsr ^ (lfsr >> 1) ^ (lfsr >> 3) ^ (lfsr >> 12)) & 1
        lfsr = (lfsr >> 1) | (bit << 15)
        period += 1
        if (lfsr == start_state):
            print(period)
            break


def Fibbonaci_LFSR_Rand(start_state):
    lfsr = start_state
    
    #taps: 16 15 13 4; feedback polynomial: x^16 + x^15 + x^13 + x^4 + 1
    bit = (lfsr ^ (lfsr >> 1) ^ (lfsr >> 3) ^ (lfsr >> 12)) & 1
    lfsr = (lfsr >> 1) | (bit << 15)
    return lfsr
       

rndNum = Fibbonaci_LFSR_Rand(32773)
print(rndNum)