# Design Decisions â€” FORGE v2

The portfolio centerpiece. One polished paragraph per entry stating **what I chose, what
the alternatives were, why I chose it, and what tradeoff I accepted.**

Written the week each decision is made. Reconstructed reasoning reads as reconstructed.

â˜… marks the four that carry the strongest interview material.

---

## 1: Overall architecture
**Chosen:** Two boards, defined 16-pin interface
**Alternative:** Single integrated board
**Week:** 0 **Status:** [ ] not written

> 

## 2: Controller
**Chosen:** RP2040 (Pico module)
**Alternative:** STM32H5, ESP32
**Week:** 7 **Status:** [ ] not written

> 

## 3: Pad sensing
**Chosen:** FSR resistive (Alpha MF01A-N-221-A01) 
**Alternative:** Piezo, load cell, capacitive
**Week:** 3 **Status:** [ ] not written

> 

## 4: Pad multiplexing
**Chosen:** CD74HC4067 16:1 
**Alternative:** 16 discrete ADC channels
**Week:** 7 **Status:** [ ] not written

> 

## 5: FSR readout topology
**Chosen:** Voltage divider 
**Alternative:** Direct resistance measurement
**Week:** 7 **Status:** [ ] not written

> 

## 6: FSR filter corner
**Chosen:** 10 nF (1.59 kHz) 
**Alternative:** 100 nF (159 Hz) â€” Defect 1
**Week:** 3 **Status:** [ ] not written

> 

## 7: Divider excitation rail
**Chosen:** Separate isolated LDO 
**Alternative:** Shared digital 3V3
**Week:** 7 **Status:** [ ] not written

> 

## 8: Velocity detection
**Chosen:** Adaptive peak, timeout backstop 
**Alternative:** Fixed 10 ms window â€” Defect 2
**Week:** 3 **Status:** [ ] not written

> 

## 9: Velocity curve
**Chosen:** Logarithmic 
**Alternative:** Linear, piecewise LUT
**Week:** 3 **Status:** [ ] not written

> 

## 10: FSR grade and calibration
**Chosen:** [decide after M-SYS-02]
**Alternative:** Matched premium sensors
**Week:** 14 **Status:** [ ] not written

> 

## 11: DAC
**Chosen:** PCM5102A 
**Alternative:** Integrated codec (WM8731, TLV320AIC3204)
**Week:** 4 **Status:** [ ] not written

> 

## 12: ADC
**Chosen:** PCM1808 
**Alternative:** Same integrated codec
**Week:** 5 **Status:** [ ] not written

> 

## 13: Anti-alias filter
**Chosen:** Single-pole RC 
**Alternative:** Multi-pole active
**Week:** 5 **Status:** [ ] not written

> 

## 14: Headphone amplifier
**Chosen:** Dual audio op-amp, SOIC-8 generic footprint 
**Alternative:** Single supply + coupling caps; integrated DirectPath part
**Week:** 4 **Status:** [ ] not written

> 

## 15: Negative rail
**Chosen:** TPS60403 charge pump 
**Alternative:** Single supply, or boost+LDO
**Week:** 3 **Status:** [ ] not written

> 

## 16: Analog LDO
**Chosen:** LP5907 
**Alternative:** Generic LDO (MCP1700)
**Week:** 4 **Status:** [ ] not written

> 

## 17: Clock architecture
**Chosen:** Jumper-selectable internal-derived vs. external XO
**Alternative:** Pick one
**Week:** 2 **Status:** [ ] not written

> 

## 18: Sample rate
**Chosen:** 48 kHz 
**Alternative:** 44.1 kHz
**Week:** 1 **Status:** [ ] not written

> 

## 19: Sample storage
**Chosen:** W25Q128JV external SPI flash
**Alternative:** Pico internal flash; SD card
**Week:** 2 **Status:** [ ] not written

> 

## 20: Audio buffer depth
**Chosen:** [empirically floored M-SYS-08] 
**Alternative:** 256 frames
**Week:** 16 **Status:** [ ] not written

> 

## 21: Core partitioning
**Chosen:** Core 0 control, Core 1 audio 
**Alternative:** Single core with ISR
**Week:** 19 **Status:** [ ] not written

> 

## 22: PAD stackup
**Chosen:** 2-layer + bottom GND plane
**Alternative:** 4-layer
**Week:** 7 **Status:** [ ] not written

> 

## 23: AUDIO stackup
**Chosen:** 4-layer, L2 solid GND 
**Alternative:** 2-layer
**Week:** 4 **Status:** [ ] not written

> 

## 24: Ground strategy
**Chosen:** Single unbroken plane, partitioned by placement 
**Alternative:** Split analog/digital planes
**Week:** 6 **Status:** [ ] not written

> Include the explicit MSB 27A comparison: same principle (control return current),
> different aggressor. Tested by M-SYS-05.

## 25: Board interconnect
**Chosen:** 2x8 header, six ground pins 
**Alternative:** 8-pin minimum, or FFC
**Week:** 5 **Status:** [ ] not written

> 

## 26: USB device class
**Chosen:** Composite MIDI + CDC 
**Alternative:** MIDI only
**Week:** 7 **Status:** [ ] not written

> 

## 27: Pico mounting
**Chosen:** Socketed on female headers 
**Alternative:** Soldered; bare RP2040
**Week:** 7 **Status:** [ ] not written

> 

## 28: Output cap fallback
**Chosen:** Footprints + 0 ohm bypass 
**Alternative:** Commit to DC coupling
**Week:** 4 **Status:** [ ] not written

> 

## 29: Pad mechanical stack
**Chosen:** [decide Week 7] 
**Alternative:** Bare FSR, no force-spreading disc
**Week:** 7 **Status:** [ ] not written

> Force-spreading disc, pad durometer, and pitch. Measure velocity variance across the
> pad surface with and without the disc.
