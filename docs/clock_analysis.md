# Clock Analysis

System PLL and PIO divider derivation for 48.000 kHz LRCK / 3.072 MHz BCK.
**Record the failed attempts too** â€” the derivation is the interesting part.

## Requirement

LRCK = 48.000 kHz, BCK = 48000 x 32 bits x 2 channels = 3.072 MHz

## Derivation (by hand, before implementing)

## Measured LRCK

| Attempt | sysclk | PIO divider | Predicted LRCK | Measured | Error (ppm) | Error (cents) |
|---|---|---|---|---|---|---|
| | | | | | | |

## Clock-domain resolution (Week 2)

Options tested:
- (a) XO -> PCM1808 SCKI, PCM1808 as I2S master, RP2040 slaving
- (b) XO -> RP2040 CLK_GPIN0 (GP20), RP2040 as master
- (c) Two domains, DAC only

Outcome and rejected options:
