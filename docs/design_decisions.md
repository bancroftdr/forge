# Design Decisions â€” FORGE v2

The portfolio centerpiece. One polished paragraph per entry stating **what I chose, what
the alternatives were, why I chose it, and what tradeoff I accepted.**

Written the week each decision is made. Reconstructed reasoning reads as reconstructed.

â˜… marks the four that carry the strongest interview material.

---

## 1 â€” Overall architecture
**Chosen:** Two boards, defined 16-pin interface Â· **Alternative:** Single integrated board
**Week:** 0 Â· **Status:** [ ] not written

> 

## 2 â€” Controller
**Chosen:** RP2040 (Pico module) Â· **Alternative:** STM32H5, ESP32
**Week:** 7 Â· **Status:** [ ] not written

> 

## 3 â€” Pad sensing
**Chosen:** FSR resistive (Alpha MF01A-N-221-A01) Â· **Alternative:** Piezo, load cell, capacitive
**Week:** 3 Â· **Status:** [ ] not written

> 

## 4 â€” Pad multiplexing
**Chosen:** CD74HC4067 16:1 Â· **Alternative:** 16 discrete ADC channels
**Week:** 7 Â· **Status:** [ ] not written

> 

## 5 â€” FSR readout topology
**Chosen:** Voltage divider Â· **Alternative:** Direct resistance measurement
**Week:** 7 Â· **Status:** [ ] not written

> 

## 6 â€” FSR filter corner â˜…
**Chosen:** 10 nF (1.59 kHz) Â· **Alternative:** 100 nF (159 Hz) â€” Defect 1
**Week:** 3 Â· **Status:** [ ] not written

> 

## 7 â€” Divider excitation rail
**Chosen:** Separate isolated LDO Â· **Alternative:** Shared digital 3V3
**Week:** 7 Â· **Status:** [ ] not written

> 

## 8 â€” Velocity detection â˜…
**Chosen:** Adaptive peak, timeout backstop Â· **Alternative:** Fixed 10 ms window â€” Defect 2
**Week:** 3 Â· **Status:** [ ] not written

> 

## 9 â€” Velocity curve
**Chosen:** Logarithmic Â· **Alternative:** Linear, piecewise LUT
**Week:** 3 Â· **Status:** [ ] not written

> 

## 10 â€” FSR grade and calibration
**Chosen:** [decide after M-SYS-02] Â· **Alternative:** Matched premium sensors
**Week:** 14 Â· **Status:** [ ] not written

> 

## 11 â€” DAC
**Chosen:** PCM5102A Â· **Alternative:** Integrated codec (WM8731, TLV320AIC3204)
**Week:** 4 Â· **Status:** [ ] not written

> 

## 12 â€” ADC
**Chosen:** PCM1808 Â· **Alternative:** Same integrated codec
**Week:** 5 Â· **Status:** [ ] not written

> 

## 13 â€” Anti-alias filter
**Chosen:** Single-pole RC Â· **Alternative:** Multi-pole active
**Week:** 5 Â· **Status:** [ ] not written

> 

## 14 â€” Headphone amplifier
**Chosen:** Dual audio op-amp, SOIC-8 generic footprint Â· **Alternative:** Single supply + coupling caps; integrated DirectPath part
**Week:** 4 Â· **Status:** [ ] not written

> 

## 15 â€” Negative rail
**Chosen:** TPS60403 charge pump Â· **Alternative:** Single supply, or boost+LDO
**Week:** 3 Â· **Status:** [ ] not written

> 

## 16 â€” Analog LDO
**Chosen:** LP5907 Â· **Alternative:** Generic LDO (MCP1700)
**Week:** 4 Â· **Status:** [ ] not written

> 

## 17 â€” Clock architecture â˜…
**Chosen:** Jumper-selectable internal-derived vs. external XO Â· **Alternative:** Pick one
**Week:** 2 Â· **Status:** [ ] not written

> 

## 18 â€” Sample rate
**Chosen:** 48 kHz Â· **Alternative:** 44.1 kHz
**Week:** 1 Â· **Status:** [ ] not written

> 

## 19 â€” Sample storage
**Chosen:** W25Q128JV external SPI flash Â· **Alternative:** Pico internal flash; SD card
**Week:** 2 Â· **Status:** [ ] not written

> 

## 20 â€” Audio buffer depth
**Chosen:** [empirically floored â€” M-SYS-08] Â· **Alternative:** 256 frames
**Week:** 16 Â· **Status:** [ ] not written

> 

## 21 â€” Core partitioning
**Chosen:** Core 0 control, Core 1 audio Â· **Alternative:** Single core with ISR
**Week:** 19 Â· **Status:** [ ] not written

> 

## 22 â€” PAD stackup
**Chosen:** 2-layer + bottom GND plane Â· **Alternative:** 4-layer
**Week:** 7 Â· **Status:** [ ] not written

> 

## 23 â€” AUDIO stackup
**Chosen:** 4-layer, L2 solid GND Â· **Alternative:** 2-layer
**Week:** 4 Â· **Status:** [ ] not written

> 

## 24 â€” Ground strategy â˜…
**Chosen:** Single unbroken plane, partitioned by placement Â· **Alternative:** Split analog/digital planes
**Week:** 6 Â· **Status:** [ ] not written

> Include the explicit MSB 27A comparison: same principle (control return current),
> different aggressor. Tested by M-SYS-05.

## 25 â€” Board interconnect
**Chosen:** 2x8 header, six ground pins Â· **Alternative:** 8-pin minimum, or FFC
**Week:** 5 Â· **Status:** [ ] not written

> 

## 26 â€” USB device class
**Chosen:** Composite MIDI + CDC Â· **Alternative:** MIDI only
**Week:** 7 Â· **Status:** [ ] not written

> 

## 27 â€” Pico mounting
**Chosen:** Socketed on female headers Â· **Alternative:** Soldered; bare RP2040
**Week:** 7 Â· **Status:** [ ] not written

> 

## 28 â€” Output cap fallback
**Chosen:** Footprints + 0 ohm bypass Â· **Alternative:** Commit to DC coupling
**Week:** 4 Â· **Status:** [ ] not written

> 

## 29 â€” Pad mechanical stack
**Chosen:** [decide Week 7] Â· **Alternative:** Bare FSR, no force-spreading disc
**Week:** 7 Â· **Status:** [ ] not written

> Force-spreading disc, pad durometer, and pitch. Measure velocity variance across the
> pad surface with and without the disc.
